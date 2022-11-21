class Contacts {
  String uid;
  String firstName;
  String lastName;
  String profileUrl;

  Contacts({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.profileUrl
  });

  factory Contacts.fromJson(dynamic json) {
    return Contacts(
      uid: json["uid"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      profileUrl: json["profile_picture_url"]
    );
  }

  @override
  String toString() {
    return '{ $uid, $firstName, $lastName, $profileUrl }';
  }
}
