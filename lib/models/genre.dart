class Genre {
  late int id;
  late String name;

  Genre({
    required this.id,
    required this.name,
  });

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? 0 : json['id'].toInt();
    name = json['name'] ?? "";
  }
}
