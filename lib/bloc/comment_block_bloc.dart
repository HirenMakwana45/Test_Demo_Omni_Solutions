import 'package:testapp/comment_model.dart';

import 'comment_block_event.dart';

class CommentBloc {
  List<Comment> comments = [];
  int commentIdCounter = 1;

  void mapEventToState(CommentEvent event) {
    if (event is AddComment) {
      comments.add(Comment(commentIdCounter++, event.username, event.content));
    } else if (event is AddReply) {
      var target = comments.firstWhere(
          (comment) => comment.id == event.commentId,
          orElse: () => null!);
      if (target != null) {
        target.replies
            .add(Comment(commentIdCounter++, event.username, event.content));
      }
    } else if (event is DeleteComment) {
      comments.removeWhere((comment) => comment.id == event.commentId);
    } else if (event is DeleteReply) {
      var target = comments.firstWhere(
          (comment) => comment.id == event.commentId,
          orElse: () => null!);
      if (target != null) {
        target.replies.removeWhere((reply) => reply.id == event.replyId);
      }
    }
  }
}
