class CommentItem {
  int id;
  String content;
  List<CommentItem> replies;

  CommentItem(this.id, this.content, this.replies);
}

class Reply {
  int id;
  String content;

  Reply(this.id, this.content);
}

class CommentState {
  List<CommentItem> comments;
  CommentItem? replyTarget;

  CommentState(this.comments, this.replyTarget);
}
