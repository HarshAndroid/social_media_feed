import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/feed.dart';

class FeedRepository {
  // For accessing Firestore database
  static get postsCollection => FirebaseFirestore.instance.collection('posts');

  static Future<bool> addPost(FeedModel feed) async {
    try {
      final docRef = await postsCollection.add(feed.toMap());
      log('Post added with ID: ${docRef.id}');
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
  static Future<bool> addLike(String postId, String userId) async {
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
  static Future<void> removeLike(String postId, String userId) async {
    try {
      final postRef = postsCollection.doc(postId);

      await postRef.update({
        'likesCount': FieldValue.increment(-1),
        'likedByUsers': FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      log('Error removing like: $e');
    }
  }

  static Future<void> addComment(String postId, CommentModel comment) async {
    try {
      DocumentReference postRef = postsCollection.doc(postId);
      CollectionReference commentsRef = postRef.collection('comments');

      // Add the comment to the comments sub-collection
      await commentsRef.add(comment.toMap());

      await postRef.update({
        'commentsCount': FieldValue.increment(1),
      });
    } catch (e) {
      log('Error adding comment: $e');
    }
  }

  static Future<List<CommentModel>> getComments(String postId) async {
    try {
      final postRef = postsCollection.doc(postId);
      final commentsRef = postRef.collection('comments');

      QuerySnapshot snapshot = await commentsRef.get();
      final comments = snapshot.docs
          .map((doc) =>
              CommentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return comments;
    } catch (e) {
      log('Error fetching comments: $e');
      return [];
    }
  }
}
