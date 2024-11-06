import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';

import '../data/feed_repository.dart';
import '../data/model/feed.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return FirestorePagination(
      query: FeedRepository.postsCollection.orderBy(
        'postId',
        descending: true,
      ),
      isLive: true,
      itemBuilder: (context, docs, index) {
        final feed =
            FeedModel.fromJson(docs[index].data() as Map<String, dynamic>);

        return ListTile(
          title: Text(feed.content),
        );
      },
    );
  }
}
