import 'package:daleel_app_project/models/user.dart';

const me = User(
  userId: 1,
  firstName: 'Zain Nhalwy',
  lastName: 'aaa',
  profileImage: 'assets/images/user.png', 
  personIdImage: 'assets/images/user.png', 
  phone: '0985587575', 
  location: {
    'governorate': 'Damascus Governorate',
    'city': 'Al-Mazza Municipality',
    'district': 'Rabwa Neighborhood',
    'street': 'Unknown street :(',
  },
  password: "123123",
  email: 'zain@gmail.com', 
  birthdate: '2000-5-5',
);

const baseURL = "http://192.168.137.97:8000";
const token = "1|m6rcv4FDwBM3IpQGvu2PJPbpwDVtTNz10QyBdyyb986ec20c";
