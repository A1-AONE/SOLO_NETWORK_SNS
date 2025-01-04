import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/setpage_one_nickname.dart';
import 'package:solo_network_sns/presentation/ui/setpage/widgets/setpage_two_ai_type.dart';

class SetPageState {
  int previousPage;
  int currentPage;

  List<Widget> pages;

  SetPageState(this.previousPage, this.currentPage, this.pages);

  SetPageState copyWith({
    int? previousPage,
    int? currentPage,
    List<Widget>? pages,
  }) =>
      SetPageState(previousPage ?? this.previousPage,
          currentPage ?? this.currentPage, pages ?? this.pages);
}

class SetpageViewModel extends AutoDisposeNotifier<SetPageState> {
  @override
  SetPageState build() {
    List<Widget> pages = [SetpageOneNickname(), SetpageTwoAiType()];

    return SetPageState(0, 0, pages);
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
}

final setPageViewModelProvider =
    AutoDisposeNotifierProvider<SetpageViewModel, SetPageState>(() {
  return SetpageViewModel();
});
