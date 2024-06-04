class Pass {
  final int? id;
  final String data;
  final String title;
  final int format;

  Pass({
    this.id,
    required this.data,
    required this.title,
    required this.format,
  });

  factory Pass.fromMap(Map<String, dynamic> json) => Pass(
    id: json['id'],
    title: json['title'],
    data: json['data'],
    format: json['format'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'data': data,
      'format': format,
    };
  }
}