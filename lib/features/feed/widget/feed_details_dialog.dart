import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../global.dart';
import '../cubit/feed_cubit.dart';
import '../data/feed_repository.dart';
import '../data/model/feed.dart';

class FeedDetailsDialog extends StatefulWidget {
  final FeedCubit c;

  const FeedDetailsDialog({super.key, required this.c});

  @override
  State<FeedDetailsDialog> createState() => _FeedDetailsDialogState();
}

class _FeedDetailsDialogState extends State<FeedDetailsDialog> {
  final _node = FocusNode();
  final _commentC = TextEditingController();

  @override
  void dispose() {
    _commentC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const loading = Center(child: CircularProgressIndicator(strokeWidth: 1));

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_node),
      child: Scaffold(
        appBar: AppBar(
          //
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),

          //
          title: Text(widget.c.userId),
          actions: const [],
        ),

        //fab
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _commentC,
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                        CupertinoIcons.bubble_left_bubble_right,
                        size: 24),
                    hintText: 'Comment...',
                    suffixIcon: IconButton(
                        onPressed: () =>
                            widget.c.postComment(context, _commentC),
                        icon: const Icon(
                          Icons.send_rounded,
                          color: pColor,
                          size: 26,
                        ))),
              ),
            )),

        //body
        body: FirestorePagination(
          query: FirebaseFirestore.instance
              .doc(widget.c.state.postId)
              .collection('comments'),
          // .orderBy('commentId', descending: true),

          //
          isLive: true,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: mq.height * .1),
          separatorBuilder: (_, __) => const Divider(
              color: Color.fromARGB(255, 195, 195, 195), height: 0),
          initialLoader: loading,
          bottomLoader: loading,
          itemBuilder: (context, docs, index) {
            final model = CommentModel.fromJson(
                docs[index].data() as Map<String, dynamic>);

            return ListTile(
              title: Text(model.commentText),
            );
            // return FeedCard(feed: feed);
          },
        ),
      ),
    );
  }
}
