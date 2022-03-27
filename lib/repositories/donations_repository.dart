class Donation {
  String? userId;
  String? title;
  String? description;
  String? location;
  String? quantity;
  bool? available = true;
  String? fromDate;
  String? toDate;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'quantity': quantity,
      'available': available,
      'from_date': fromDate,
      'to_date': toDate
    };
  }
}

class DonationsRepository {}
