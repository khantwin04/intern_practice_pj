class commentModel {
  final int? postId;
  final int id;
  final String name;
  final String email;
  final String body;

  commentModel({
    this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory commentModel.fromJson(Map<String, dynamic> json) {
    return commentModel(
      postId: json['postId'] as int?,
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );
  }
}
