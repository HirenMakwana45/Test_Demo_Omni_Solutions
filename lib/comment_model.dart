class Comment {
  final int id;
  final String username;
  final String content;
  List<Comment> replies = [];

  Comment(this.id, this.username, this.content);
}
