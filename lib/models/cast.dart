class Cast {
  late int id;
  late int order;
  late String name;
  late String? profilePath;

  Cast(
      {required this.id,
      required this.order,
      required this.name,
      required this.profilePath});

  Cast.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? 0 : json['id'].toInt();
    order = json['order'].toInt();
    name = json['name'] ?? "";
    profilePath = json['profile_path'];
  }

}
