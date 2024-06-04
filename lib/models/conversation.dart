class Conversation {
  final int? id;
  final String title;

  Conversation({
    this.id,
    required this.title,
  });

  factory Conversation.fromMap(Map<String, dynamic> json) => Conversation(
    id: json['id'],
    title: json['title'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}