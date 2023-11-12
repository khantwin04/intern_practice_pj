import 'package:flutter/material.dart';
import 'package:kkm/api.dart';
import 'package:kkm/models/post_model.dart';
import 'package:kkm/ui/comment_list.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  late Api api;
  late Future<List<PostModel>> futurePost;

  @override
  void initState() {
    api = Api();
    futurePost = api.fetchPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post API Test'),
      ),
      body: Center(
        child: FutureBuilder<List<PostModel>>(
            future: futurePost,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (content, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentList(
                                  id: snapshot.data![index].id,
                                ),
                              ));
                        },
                        child: Card(
                          color: index % 2 == 0 ? Colors.yellow : Colors.white,
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 30, 15, 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.search),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: Text(
                                              snapshot.data![index].title,
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text('September 7, 2023')
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(snapshot.data![index].body),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // child: ListTile(
                          //   title: Text(snapshot.data![index].title),
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(10)),
                          //   subtitle: Text(snapshot.data![index].body),
                          // ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
