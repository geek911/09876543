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

  Map<String, dynamic > toProfile(){
    return {
      "description": description ??= "na",
      "phone_number": phoneNumber ??= "na",
      "donator": donator ??= false,
    };
  }
}
