import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../global.dart';
import '../../../widget/profile_avatar.dart';
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            _FeedCard(c: widget.c),

            //divider
            const Divider(color: Color.fromARGB(255, 195, 195, 195), height: 0),

            const Padding(
              padding: EdgeInsets.only(top: 20, left: 8),
              child: Text(
                'Comments',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            //comments
            Expanded(
              child: FirestorePagination(
                query: FeedRepository.postsCollection
                    .doc(widget.c.state.postId)
                    .collection('comments')
                    .orderBy('commentId', descending: true),

                //
                isLive: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: mq.height * .1),
                // separatorBuilder: (_, __) => const Divider(
                //     color: Color.fromARGB(255, 195, 195, 195), height: 0),
                initialLoader: loading,
                bottomLoader: loading,
                itemBuilder: (context, docs, index) {
                  final model = CommentModel.fromJson(
                      docs[index].data() as Map<String, dynamic>);

                  return ListTile(
                    //profile
                    leading: ProfileAvatar(
                      avatar: model.userImage,
                      size: 30,
                    ),
                    onTap: () {},
                    dense: true,
                    //title
                    title: Text(model.commentText),

                    //subtitle
                    subtitle: Text(model.userId),

                    trailing: Text(
                      widget.c.formatTime(model.commentId),
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColorLight),
                    ),
                  );
                  // return FeedCard(feed: feed);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedCard extends StatelessWidget {
  final FeedCubit c;

  const _FeedCard({required this.c});

  @override
  Widget build(BuildContext context) {
    final sColor = Theme.of(context).primaryColorLight; //secondary

    return Padding(
      padding:
          EdgeInsets.only(left: 8, right: 8, top: mq.height * .03, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          ProfileAvatar(avatar: c.state.userImage),

          // adding some space
          SizedBox(width: mq.width * .04),

          //
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    //username
                    Text(
                      c.state.username.isEmpty ? 'Unknown' : c.state.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    //user id or email
                    Text(
                      ' | ${c.userId}',
                      style: TextStyle(fontSize: 13, color: sColor),
                    ),
                  ],
                ),

                const SizedBox(height: 2),

                //time
                Text(
                  c.formatTime(c.state.postId),
                  style: TextStyle(
                    fontSize: 12,
                    color: sColor,
                  ),
                ),

                // content
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(c.state.content),
                ),

                // like & comments
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //like button
                    TextButton.icon(
                      style: const ButtonStyle(
                        shape: WidgetStatePropertyAll(StadiumBorder()),
                      ),
                      onPressed: null,
                      icon: Icon(
                        c.isLiked
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: c.isLiked ? Colors.pink : sColor,
                        size: 20,
                      ),

                      //
                      label: Text(
                        '${c.state.likesCount}',
                        style: TextStyle(
                          color: c.isLiked ? Colors.red : sColor,
                        ),
                      ),
                    ),

                    //comment button
                    TextButton.icon(
                      style: const ButtonStyle(
                        shape: WidgetStatePropertyAll(StadiumBorder()),
                      ),
                      onPressed: null,
                      icon: Icon(
                        CupertinoIcons.bubble_right,
                        color: sColor,
                        size: 19,
                      ),

                      //
                      label: Text(
                        '${c.state.commentsCount}',
                        style: TextStyle(
                          color: c.state.commentsCount > 0 ? null : sColor,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
