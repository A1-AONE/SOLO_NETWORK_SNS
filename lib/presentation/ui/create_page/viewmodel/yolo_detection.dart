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

  // 모델 초기화
  Future<void> initialize() async {
    _interpreter = await Interpreter.fromAsset('assets/yolov8n.tflite');
    final labelAsset = await rootBundle.loadString('assets/labels.txt');
    _labels = labelAsset.split('\n');
    _numClasses = _labels!.length;
  }

  // YOLO를 사용해 사람 감지
  Future<bool> detectPerson(Image image) async {
    if (!isInitialized) {
      throw Exception('The model must be initialized');
    }

    // 이미지 리사이즈 및 정규화
    final imgResized = copyResize(image, width: 640, height: 640);
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

    // YOLO 결과 분석
    final detectedObjects =
        YoloHelper.parse(output[0], image.width, image.height);

    // "person" 클래스가 포함되어 있는지 확인
    final personDetected = detectedObjects.any((obj) {
      final classIndex = obj.labelIndex;
      return _labels![classIndex] == 'person'; // 사람 클래스 필터
    });

    return personDetected;
  }
}
