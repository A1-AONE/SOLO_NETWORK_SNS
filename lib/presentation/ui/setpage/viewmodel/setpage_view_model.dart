import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/pages/setpage_four_welcome.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/pages/setpage_one_nickname.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/pages/setpage_three_generate.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/pages/setpage_two_ai_type.dart';
import 'package:solo_network_sns/presentation/viewmodel/user_id.dart';

class SetPageState {
  int previousPage;
  int currentPage;
  String? nickname;
  List<String> aiTags;
  Set<int> selectTags;

  List<Widget> pages;

  SetPageState(this.previousPage, this.currentPage, this.pages, this.nickname,
      this.aiTags, this.selectTags);

  SetPageState copyWith({
    int? previousPage,
    int? currentPage,
    List<Widget>? pages,
    String? nickname,
    List<String>? aiTags,
    Set<int>? selectTags,
  }) =>
      SetPageState(
          previousPage ?? this.previousPage,
          currentPage ?? this.currentPage,
          pages ?? this.pages,
          nickname ?? this.nickname,
          aiTags ?? this.aiTags,
          selectTags ?? this.selectTags);
}

class SetpageViewModel extends AutoDisposeNotifier<SetPageState> {
  @override
  SetPageState build() {
    List<Widget> pages = [
      SetpageOneNickname(),
      SetpageTwoAiType(),
      SetpageThreeGenerate(),
      SetpageFourWelcome()
    ];
    List<String> aiTags = [
      '상냥함',
      '유머러스',
      '논리적',
      '감성적',
      '직설적',
      '긍정적',
      '열정적',
      '공감적',
      '조용함',
      '낭만적',
      '전문적',
      '귀여움',
      '차가움',
      '논쟁적',
    ];

    return SetPageState(0, 0, pages, null, aiTags, {});
  }

  /// 다음 페이지 이동
  void nextPage() {
    int previousPage = state.currentPage;
    int currentPage = previousPage + 1;

    if (currentPage >= state.pages.length) {
      return;
    } else {
      state =
          state.copyWith(previousPage: previousPage, currentPage: currentPage);
    }
  }

  /// 이전 페이지 이동
  void beforePage() {
    int previousPage = state.currentPage;
    int currentPage = previousPage - 1;

    if (currentPage < 0) {
      return;
    } else {
      state =
          state.copyWith(previousPage: previousPage, currentPage: currentPage);
    }
  }

  /// 닉네임 설정
  void setNickName(String name) {
    state.nickname = name;
  }

  /// AI태그 클릭
  void selectCilck(int index) {
    Set<int> selectTags = Set<int>.from(state.selectTags);
    if (selectTags.contains(index)) {
      selectTags.remove(index);
    } else {
      selectTags.add(index);
    }

    state = state.copyWith(selectTags: selectTags);
  }

  /// 프로필 설정
  Future<void> setProfile() async {
    final String uid = ref.read(userViewModelProvider.notifier).getUserId();

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference userDoc = firebaseFirestore.collection('User').doc(uid);

    List<String> selectTags;

    if (state.selectTags.isEmpty) {
      int rnd = Random().nextInt(state.aiTags.length);
      selectTags = [state.aiTags[rnd]];
    } else {
      selectTags = List.from(state.selectTags).map(
        (e) {
          return state.aiTags[e];
        },
      ).toList();
    }

    Map<String, dynamic> data = {
      "AITag": selectTags,
      "Nickname": state.nickname,
    };

    await userDoc.update(data);
  }
}

final setPageViewModelProvider =
    AutoDisposeNotifierProvider<SetpageViewModel, SetPageState>(() {
  return SetpageViewModel();
});
