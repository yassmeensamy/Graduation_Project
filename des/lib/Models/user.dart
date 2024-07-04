class User {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? dob;
  bool? isEmailVerified;
  String? image;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.dob,
    this.isEmailVerified,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      gender: json['gender'],
      dob: json['birthdate'],
      isEmailVerified: json['is_verified'],
      image: json['image'],
    );
  }
}
