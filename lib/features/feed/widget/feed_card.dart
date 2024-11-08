import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../global.dart';
import '../../../widget/profile_avatar.dart';
import '../cubit/feed_cubit.dart';
import '../data/model/feed.dart';

class FeedCard extends StatelessWidget {
  final FeedModel feed;

  const FeedCard({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    final c = FeedCubit(feed);
    final sColor = Theme.of(context).primaryColorLight; //secondary

    return InkWell(
      onTap: () => c.showFeedDetailsDialog(context),
      child: Padding(
        padding:
            EdgeInsets.only(left: 8, right: 8, top: mq.height * .03, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            ProfileAvatar(avatar: feed.userImage),

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
                        feed.username.isEmpty ? 'Unknown' : feed.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      //user id or email
                      Text(
                        ' | ${feed.userId}',
                        style: TextStyle(fontSize: 13, color: sColor),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  //time
                  Text(
                    c.formatTime(feed.postId),
                    style: TextStyle(
                      fontSize: 12,
                      color: sColor,
                    ),
                  ),

                  // content
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(feed.content),
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
                        onPressed: c.handleLike,
                        icon: Icon(
                          c.isLiked
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          color: c.isLiked ? Colors.pink : sColor,
                          size: 20,
                        ),

                        //
                        label: Text(
                          '${feed.likesCount}',
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
                        onPressed: () => c.showFeedDetailsDialog(context),
                        icon: Icon(
                          CupertinoIcons.bubble_right,
                          color: sColor,
                          size: 19,
                        ),

                        //
                        label: Text(
                          '${feed.commentsCount}',
                          style: TextStyle(
                            color: feed.commentsCount > 0 ? null : sColor,
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
      ),
    );
  }


}
