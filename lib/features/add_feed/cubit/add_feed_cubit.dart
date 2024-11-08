import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show TextEditingController, showDialog;

import '../../../service/dialog_x.dart';
import '../../auth/service/auth_service.dart';
import '../../feed/data/feed_repository.dart';
import '../../feed/data/model/feed.dart';
import '../widget/add_feed_dialog.dart';

class AddFeedCubit extends Cubit<Null> {
  final contentC = TextEditingController();

  AddFeedCubit() : super(null);

  void showFeedDialog(BuildContext context) {
    showDialog(
        context: context,
        useSafeArea: false,
        barrierDismissible: false,
        builder: (_) => const AddFeedDialog());
  }

  Future<void> postFeed(final BuildContext context) async {
    DialogX.showProgressBar(context);

    final result = await _addFeed();

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

      contentC.text = '';
      Navigator.pop(context);
    }
  }

  Future<bool?> _addFeed() async {
    contentC.text = contentC.text.trim();

    //
    final user = AuthService.auth.currentUser;

    log('display name: ${user?.displayName}');
    if (contentC.text.isEmpty || user == null) return null;

    //

    final feed = FeedModel(
        postId: DateTime.now().millisecondsSinceEpoch.toString(),
        content: contentC.text,
        userId: user.email.toString(),
        username: user.displayName ?? '',
        likesCount: 0,
        commentsCount: 0,
        userImage: user.photoURL ?? '',
        likedByUsers: []);

    //add feed
    return await FeedRepository.addPost(feed);
  }
}
