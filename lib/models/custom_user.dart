class CustomUser {
  String? id;
  String? firstName;
  String? lastName;
  String? displayName;
  String? email;
  bool? donator;
  String? description;
  String? location;
  String? password;
  String? phoneNumber;

  Map<String, dynamic> toProfileJson() {
    return {
      "description": description ??= "na",
      "phone_number": phoneNumber ??= "na",
      "donator": donator ??= false,
    };
  }

  CustomUser fromProfileJson(Map<String, dynamic> json) {
    description = json['description'];
    phoneNumber = json['phone_number'];
    donator = json['donator'];

    return this;
  }
}
