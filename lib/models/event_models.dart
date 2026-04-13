class Event {
  final int id;
  final String name;
  final String date;
  final String desc;
  final String tag;
  final String image;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.desc,
    required this.tag,
    required this.image,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['title'] ?? '',
      date: json['event_date'] ?? '',
      desc: json['description'] ?? '',
      tag: json['tag'] ?? 'EVENT',
      image: json['image'] ?? '',
    );
  }
}
