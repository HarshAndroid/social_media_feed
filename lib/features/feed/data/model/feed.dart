class FeedModel {
  String postId; //also being used as timestamp
  String content;
  String userId;
  String username;
  String userImage;
  int likesCount;
  int commentsCount;
  List<String> likedByUsers;

  FeedModel({
    required this.postId,
    required this.content,
    required this.userId,
    required this.username,
    required this.userImage,
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
      userImage: json['userImage'] ?? '',
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
      'userImage': userImage,
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

  CommentModel({
    required this.commentId,
    required this.userId,
    required this.username,
    required this.commentText,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'] ?? '',
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      commentText: json['commentText'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'userId': userId,
      'username': username,
      'commentText': commentText,
    };
  }
}
