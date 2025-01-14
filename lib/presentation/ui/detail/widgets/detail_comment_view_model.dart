import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/comment_entity.dart';
import 'package:solo_network_sns/presentation/ui/detail/detail_provider.dart';

class DetailCommentViewModel extends AutoDisposeNotifier<List<CommentEntity>?>{
  @override
  List<CommentEntity>? build() {
    // fetchComments();
    streamComments();
    return [];
  }

  Future<void> fetchComments() async{
    state = await ref.read(fetchCommentUsecaseProvider).fetchCommentsExecute();
  }

  void streamComments() {
    log('Comments stream start');
    final stream = ref.read(fetchCommentUsecaseProvider).streamCommentsExecute();
    final streamSubscription = stream.listen((e){
      state = e;
    });
    ref.onDispose((){
      log('Comments stream cancel');
      streamSubscription.cancel();
    });
  }
}

final detailCommentsViewModel = AutoDisposeNotifierProvider<DetailCommentViewModel, List<CommentEntity>?>(
() => DetailCommentViewModel()
);