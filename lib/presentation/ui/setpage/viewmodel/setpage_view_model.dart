import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/pages/setpage_one_nickname.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/pages/setpage_two_ai_type.dart';

class SetPageState {
  int previousPage;
  int currentPage;
  String? nickname;

  List<Widget> pages;

  SetPageState(this.previousPage, this.currentPage, this.pages, this.nickname);

  SetPageState copyWith({
    int? previousPage,
    int? currentPage,
    List<Widget>? pages,
    String? nickname,
  }) =>
      SetPageState(previousPage ?? this.previousPage,
          currentPage ?? this.currentPage, pages ?? this.pages, nickname ?? this.nickname);
}

class SetpageViewModel extends AutoDisposeNotifier<SetPageState> {
  @override
  SetPageState build() {
    List<Widget> pages = [SetpageOneNickname(), SetpageTwoAiType()];

    return SetPageState(0, 0, pages, null);
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
  void setNickName(String name){
    state.nickname = name;
  }
}

final setPageViewModelProvider =
    AutoDisposeNotifierProvider<SetpageViewModel, SetPageState>(() {
  return SetpageViewModel();
});
