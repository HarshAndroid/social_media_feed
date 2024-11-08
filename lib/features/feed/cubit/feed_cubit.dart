import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../service/dialog_x.dart';
import '../../auth/service/auth_service.dart';
import '../data/feed_repository.dart';
import '../data/model/feed.dart';
import '../widget/feed_details_dialog.dart';

class FeedCubit extends Cubit<FeedModel> {
  FeedCubit(super.initialState);

  String get userId => AuthService.auth.currentUser?.email ?? '';

  late final isLiked = state.likedByUsers.contains(userId);

  void handleLike() {
    isLiked
        ? FeedRepository.removeLike(postId: state.postId, userId: userId)
        : FeedRepository.addLike(postId: state.postId, userId: userId);
  }

  void showFeedDetailsDialog(BuildContext context) {
    showDialog(
        context: context,
        useSafeArea: false,
        barrierDismissible: false,
        builder: (_) => FeedDetailsDialog(c: this));
  }

  Future<void> postComment(
      final BuildContext context, final TextEditingController t) async {
    DialogX.showProgressBar(context);

    final result = await _addComment(t.text.trim());

    //
    if (context.mounted) {
      Navigator.pop(context);

      if (result == null) {
        DialogX.info(
            msg: 'Looks like your feed is empty. Fill it with some content!');
        return;
      }

      if (result == false) {
        DialogX.error();
        return;
      }

      t.text = '';
      FocusScope.of(context).requestFocus(FocusNode()); //hide keyboard
    }
  }

  Future<bool?> _addComment(final String s) async {
    //
    final user = AuthService.auth.currentUser;

    if (s.isEmpty || user == null) return null;

    final comment = CommentModel(
      commentId: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      username: user.displayName ?? '',
      commentText: s,
      userImage: user.photoURL ?? '',
    );
    //add feed
    return await FeedRepository.addComment(
        postId: state.postId, comment: comment);
  }


   String formatTime(String time) {
    DateTime postTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    Duration difference = DateTime.now().difference(postTime);

    if (difference.inDays >= 1) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
