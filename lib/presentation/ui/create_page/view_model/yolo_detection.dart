import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:yolo_helper/yolo_helper.dart';

class YoloDetection {
  int? _numClasses;
  List<String>? _labels;
  Interpreter? _interpreter;

  String label(int index) => _labels?[index] ?? '';

  bool get isInitialized => _interpreter != null && _labels != null;

  // 1. 모델 불러오기
  Future<void> initialize() async {
    _interpreter = await Interpreter.fromAsset('assets/yolo/yolov8n.tflite');
    final labelAsset = await rootBundle.loadString('assets/yolo/labels.txt');
    _labels = labelAsset.split('\n');
    _numClasses = _labels!.length;
  }

  // 2. 이미지 입력받아서 추론
  bool runInference(Image image) {
    if (!isInitialized) {
      throw Exception('The model must be initialized');
    }

    // 3. 이미지를 YOLO v8 input 에 맞게 640x640 사이즈로 변환
    final imgResized = copyResize(image, width: 640, height: 640);

    // 4. 변환된 이미지 픽셀 nomalize(정규화)
    final imgNormalized = List.generate(
      640,
      (y) => List.generate(
        640,
        (x) {
          final pixel = imgResized.getPixel(x, y);
          return [pixel.rNormalized, pixel.gNormalized, pixel.bNormalized];
        },
      ),
    );

    final output = [
      List<List<double>>.filled(4 + _numClasses!, List<double>.filled(8400, 0))
    ];
    _interpreter!.run([imgNormalized], output);

    // 감지된 객체 리스트
    final detectedObjects =
        YoloHelper.parse(output[0], image.width, image.height);

    // 디버깅용 출력: 감지된 객체 확인
    log('qqqqqqqqqqqqqqqq');
    for (var obj in detectedObjects) {
      log('Detected score:${obj.score}');
      log('Detected label: ${_labels![obj.labelIndex]}');
    }

    // 'person' 클래스가 있는지 확인
    bool personDetected = false; // 초기값 설정
    for (final obj in detectedObjects) {
      String className = _labels![obj.labelIndex].trim();
      if (className == 'person') {
        personDetected = true; // 'person'이 감지되면 true로 설정
        break; // 더 이상 확인할 필요 없으므로 반복 종료
      }
    }

    // 'person'이 있으면 false, 없으면 true 리턴
    return !personDetected;
  }
}
