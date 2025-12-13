class User {
  final String firstName;
  final String lastName;
  final String profileImage;
  final String personIdImage;
  final String phone;
  final String email;
  final String birthdate;
  final Map<String, dynamic>? location;
  final String password;
  final String? verificationState;
  final String? token;

  const User({
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.personIdImage,
    required this.phone,
    required this.email,
    required this.birthdate,
    required this.location,
    required this.password,
    this.verificationState,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json, {String? token}) {
    return User(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profileImage: json['profileImage'] ?? '',
      personIdImage: json['personIdImage'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      birthdate: json['birthdate'] ?? '',
      location: json['location'] != null
          ? Map<String, dynamic>.from(json['location'])
          : null,
      password: json['password'] ?? '',
      verificationState: json['verificationState'],
      token: token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
      'personIdImage': personIdImage,
      'phone': phone,
      'email': email,
      'birthdate': birthdate,
      'location': location,
      'password': password,
      'verificationState': verificationState,
      'token': token,
    };
  }
}
