import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/pages/setpage_four_welcome.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/pages/setpage_one_nickname.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/pages/setpage_three_generate.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/pages/setpage_two_ai_type.dart';

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
    List<Widget> pages = [SetpageOneNickname(), SetpageTwoAiType(), SetpageThreeGenerate(), SetpageFourWelcome()];
    List<String> aiTags = [
      '친절함',
      '유머러스',
      '논리적',
      '감성적',
      '직설적',
      '창의적',
      '긍정적',
      '열정적',
      '공감적',
      '냉소적',
      '조용함',
      '고급스러움',
      '대중적',
      '낭만적',
      '스포티함',
      '전문적',
      '귀여움',
      '차가움',
      '빈티지',
      '트렌디',
      '성숙함',
      '팬심',
      '논쟁적',
      '홍보적',
      '서포터',
      '조언자'
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
  void setProfile(){
    
  }
}

final setPageViewModelProvider =
    AutoDisposeNotifierProvider<SetpageViewModel, SetPageState>(() {
  return SetpageViewModel();
});
