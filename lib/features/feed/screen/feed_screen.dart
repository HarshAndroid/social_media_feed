import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';

import '../../../global.dart';
import '../data/feed_repository.dart';
import '../data/model/feed.dart';
import '../widget/feed_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    const loading = Center(child: CircularProgressIndicator(strokeWidth: 1));
    return FirestorePagination(
      query: FeedRepository.postsCollection.orderBy('postId', descending: true),

      //
      isLive: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: mq.height * .1),
      separatorBuilder: (_, __) =>
          const Divider(color: Color.fromARGB(255, 195, 195, 195), height: 0),
      initialLoader: loading,
      bottomLoader: loading,
      itemBuilder: (context, docs, index) {
        final feed =
            FeedModel.fromJson(docs[index].data() as Map<String, dynamic>);

        return FeedCard(feed: feed);
      },
    );
  }
}


