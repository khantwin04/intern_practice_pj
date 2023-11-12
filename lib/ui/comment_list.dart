import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kkm/api.dart';
import 'package:kkm/models/comment_model.dart';

class CommentList extends StatefulWidget {
  final int id;
  const CommentList({super.key, required this.id});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  late Api api;
  late Future<List<commentModel>> futureComment;

  @override
  void initState() {
    api = Api();
    futureComment = api.fetchComments(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment Ui'),
      ),
      body: Center(
        child: FutureBuilder<List<commentModel>>(
            future: futureComment,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: index % 2 == 0 ? Colors.yellow : Colors.white,
                        elevation: 5,
                        margin: EdgeInsets.all(5),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      snapshot.data![index].name,
                                      style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      snapshot.data![index].email,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(snapshot.data![index].body),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
