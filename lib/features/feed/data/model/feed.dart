class FeedModel {
  String postId; //also being used as timestamp
  String content;
  String userId;
  String username;
  int likesCount;
  int commentsCount;
  List<String> likedByUsers;

  FeedModel({
    required this.postId,
    required this.content,
    required this.userId,
    required this.username,
    required this.likesCount,
    required this.commentsCount,
    required this.likedByUsers,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      postId: json['postId'] ?? '',
      content: json['content'] ?? '',
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      likedByUsers: List<String>.from(json['likedByUsers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'content': content,
      'userId': userId,
      'username': username,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'likedByUsers': likedByUsers,
    };
  }
}

class CommentModel {
  String commentId;
  String userId;
  String username;
  String commentText;
  String timestamp;

  CommentModel({
    required this.commentId,
    required this.userId,
    required this.username,
    required this.commentText,
    required this.timestamp,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'] ?? '',
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      commentText: json['commentText'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'userId': userId,
      'username': username,
      'commentText': commentText,
      'timestamp': timestamp,
    };
  }
}
