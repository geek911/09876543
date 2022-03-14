class CustomUser {
  String? id;
  String? displayName;
  String? email;
  bool? donator;
  String? description;
  String? location;
  String? password;
  String? phoneNumber;

  Map<String, dynamic > toProfile(){
    return {
      "id": id ??= "Not Set",
      "description": description ??= "",
      "phone_number": phoneNumber ??= "",
      "donator": donator ??= false,
    };
  }
}
