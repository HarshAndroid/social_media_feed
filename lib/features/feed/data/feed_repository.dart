import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/feed.dart';

class FeedRepository {
  static CollectionReference<Map<String, dynamic>> get postsCollection =>
      FirebaseFirestore.instance.collection('posts');

  static Future<bool> addPost(FeedModel feed) async {
    try {
      await postsCollection.doc(feed.postId).set(feed.toMap());
      log('Post added with ID: ${feed.postId}');
      return true;
    } catch (e) {
      log('Error adding post: $e');
      return false;
    }
  }

  static Future<FeedModel?> getPost(String postId) async {
    try {
      final doc = await postsCollection.doc(postId).get();
      if (doc.exists) {
        return FeedModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        log('Post not found');
        return null;
      }
    } catch (e) {
      log('Error fetching post: $e');
      return null;
    }
  }

  // Fetch all posts with pagination
  static Future<List<FeedModel>> getPosts(
      {int limit = 10, DocumentSnapshot? lastVisible}) async {
    try {
      Query query =
          postsCollection.orderBy('timestamp', descending: true).limit(limit);

      if (lastVisible != null) query = query.startAfterDocument(lastVisible);

      final snapshot = await query.get();
      final posts = snapshot.docs
          .map((doc) => FeedModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return posts;
    } catch (e) {
      log('Error fetching posts: $e');
      return [];
    }
  }

  // Add a like to a post
  static Future<bool> addLike({
    required String postId,
    required String userId,
  }) async {
    try {
      final postRef = postsCollection.doc(postId);

      await postRef.update({
        'likesCount': FieldValue.increment(1),
        'likedByUsers': FieldValue.arrayUnion([userId]),
      });
      return true;
    } catch (e) {
      log('Error adding like: $e');
      return false;
    }
  }

  // Remove a like from a post
  static Future<bool> removeLike({
    required String postId,
    required String userId,
  }) async {
    try {
      final postRef = postsCollection.doc(postId);

      await postRef.update({
        'likesCount': FieldValue.increment(-1),
        'likedByUsers': FieldValue.arrayRemove([userId]),
      });

      return true;
    } catch (e) {
      log('Error removing like: $e');
      return false;
    }
  }

  static Future<bool> addComment(
      {required String postId, required CommentModel comment}) async {
    try {
      DocumentReference postRef = postsCollection.doc(postId);
      CollectionReference commentsRef = postRef.collection('comments');

      // Add the comment to the comments sub-collection
      await commentsRef.doc(comment.commentId).set(comment.toMap());

      await postRef.update({
        'commentsCount': FieldValue.increment(1),
      });
      return true;
    } catch (e) {
      log('Error adding comment: $e');
      return false;
    }
  }
}
