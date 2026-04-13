class GivingRecord {
  final int id;
  final String category;
  final double amount;
  final String date;
  final String status;
  final String description;

  GivingRecord({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.status,
    required this.description,
  });

  factory GivingRecord.fromJson(Map<String, dynamic> json) {
    return GivingRecord(
      id: int.tryParse(json['id'].toString()) ?? 0,
      category: json['category'] ?? 'General',
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      date: json['date_created'] ?? DateTime.now().toString(),
      status: json['status'] ?? 'Completed',
      description: json['description'] ?? 'Sunday Service',
    );
  }
}
