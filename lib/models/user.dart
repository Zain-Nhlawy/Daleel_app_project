/*class User {
  final String name;
  final String profileImage;
  final String personIdImage;
  final String phone;
  final String email;
  final String birthdate;
  const User({
    required this.name, 
    required this.profileImage, 
    required this.personIdImage, 
    required this.phone, 
    required this.email, 
    required this.birthdate
  });
}*/

class User {
  final String firstName;
  final String lastName;
  final String profileImage;
  final String personIdImage;
  final String phone;
  final String email;
  final String birthdate;
  final String? verificationState;

  const User({
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.personIdImage,
    required this.phone,
    required this.email,
    required this.birthdate,
    this.verificationState,
  });
}