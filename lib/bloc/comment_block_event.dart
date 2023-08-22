abstract class CommentEvent {}

class AddComment extends CommentEvent {
  final String username;
  final String content;

  AddComment(this.username, this.content);
}

class AddReply extends CommentEvent {
  final int commentId;
  final String username;
  final String content;

  AddReply(this.commentId, this.username, this.content);
}

class DeleteComment extends CommentEvent {
  final int commentId;

  DeleteComment(this.commentId);
}

class DeleteReply extends CommentEvent {
  final int commentId;
  final int replyId;

  DeleteReply(this.commentId, this.replyId);
}
