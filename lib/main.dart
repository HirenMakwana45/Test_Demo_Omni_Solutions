import 'package:flutter/material.dart';
import 'package:testapp/bloc/comment_block_bloc.dart';
import 'package:testapp/bloc/comment_block_event.dart';

import 'bloc/comment_block_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: CommentSection(),
    );
  }
}

class CommentSection extends StatefulWidget {
  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final CommentBloc _bloc = CommentBloc();
  final TextEditingController _controller = TextEditingController();
  int? replyToCommentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TEST OMNI SOLUTION APP')),
      body: Column(
        children: [
          Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNWWaC1PxK5LCGPm6kRRe0n_wNL5r-nANNFP17EaGTLx0uz54XnIK5fxt9HbNa8mFy-F4&usqp=CAU",
              height: 150),
          Expanded(
            child: ListView.builder(
              itemCount: _bloc.comments.length,
              itemBuilder: (context, index) {
                final comment = _bloc.comments[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(comment.username + ": " + comment.content),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == "Delete") {
                            setState(() {
                              _bloc.mapEventToState(DeleteComment(comment.id));
                            });
                          } else if (value == "Reply") {
                            setState(() {
                              replyToCommentId = comment.id;
                              _controller.text =
                                  "Replying to ${comment.username}: ";
                            });
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: "Reply",
                            child: Text("Reply"),
                          ),
                          const PopupMenuItem<String>(
                            value: "Delete",
                            child: Text("Delete"),
                          ),
                        ],
                      ),
                    ),
                    for (final reply in comment.replies)
                      ListTile(
                        leading: Icon(Icons.reply),
                        title: Text(reply.username + ": " + reply.content),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _bloc.mapEventToState(
                                  DeleteReply(comment.id, reply.id));
                            });
                          },
                        ),
                      )
                  ],
                );
              },
            ),
          ),
          if (replyToCommentId != null)
            Text(
                "Replying to ${_bloc.comments.firstWhere((c) => c.id == replyToCommentId).username}"),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (replyToCommentId != null) {
                    setState(() {
                      _bloc.mapEventToState(AddReply(
                          replyToCommentId!, "Hiren", _controller.text));
                      _controller.clear();
                      replyToCommentId = null;
                    });
                  } else {
                    setState(() {
                      _bloc.mapEventToState(
                          AddComment("Omni Solutions", _controller.text));
                      _controller.clear();
                    });
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
