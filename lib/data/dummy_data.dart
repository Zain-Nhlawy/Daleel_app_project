import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/models/contracts.dart';

final List<Apartments> apartmentsList = [
  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic1.png",

  //   apartmentHeadDescripton: "Cozy apartment",

  //   apartmentPictures: [
  //     "assets/images/pic1_1.jpg",
  //     "assets/images/pic1_2.jpg",
  //     "assets/images/pic1_3.jpg",
  //     "assets/images/pic1_4.jpg",
  //     "assets/images/pic1_5.jpg",
  //     "assets/images/pic1_6.jpg",
  //     "assets/images/pic1_7.jpg",
  //   ],
  //   apartmentRate: 4.5,
  //   rentFee: 1100,
  //   floor: 2,
  //   bedrooms: 2,
  //   bathrooms: 1,
  //   area: 85,
  //   description:
  //       "A cozy apartment located in the heart of Amman, close to shops and public transport. Perfect for small families or couples.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic2.png",

  //   apartmentHeadDescripton: "Luxury villa",

  //   apartmentPictures: [
  //     "assets/images/pic2_1.jpg",
  //     "assets/images/pic2_2.jpg",
  //     "assets/images/pic2_3.jpg",
  //     "assets/images/pic2_4.jpg",
  //   ],
  //   apartmentRate: 5.0,
  //   rentFee: 800,
  //   floor: 1,
  //   bedrooms: 4,
  //   bathrooms: 3,
  //   area: 250,
  //   description:
  //       "Luxury villa with private pool and garden, located in a prime area of Dubai. Perfect for a lavish vacation stay.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic3.png",

  //   apartmentHeadDescripton: "Sea view apartment",

  //   apartmentPictures: [
  //     "assets/images/pic3_1.jpg",
  //     "assets/images/pic3_2.jpg",
  //     "assets/images/pic3_3.jpg",
  //     "assets/images/pic3_4.jpg",
  //   ],

  //   apartmentRate: 4.7,
  //   rentFee: 700,
  //   floor: 7,
  //   bedrooms: 3,
  //   bathrooms: 2,
  //   area: 140,
  //   description:
  //       "Apartment with stunning sea views and modern interior. Near restaurants and local attractions.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic4.png",

  //   apartmentPictures: [
  //     "assets/images/pic4_1.jpg",
  //     "assets/images/pic4_2.jpg",
  //     "assets/images/pic4_3.jpg",
  //     "assets/images/pic4_4.jpg",
  //     "assets/images/pic4_5.jpg",
  //     "assets/images/pic4_6.jpg",
  //     "assets/images/pic4_7.jpg",
  //   ],
  //   apartmentHeadDescripton: "Sunny flat ",

  //   apartmentRate: 4.2,
  //   rentFee: 1200,
  //   floor: 5,
  //   bedrooms: 2,
  //   bathrooms: 1,
  //   area: 90,
  //   description:
  //       "A bright and sunny flat with balcony, located near the city center and cultural attractions.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic5.png",

  //   apartmentPictures: [
  //     "assets/images/pic5_1.jpg",
  //     "assets/images/pic5_2.jpg",
  //     "assets/images/pic5_3.jpg",
  //     "assets/images/pic5_4.jpg",
  //     "assets/images/pic5_5.jpg",
  //     "assets/images/pic5_6.jpg",
  //   ],
  //   apartmentHeadDescripton: "Charming studio",

  //   apartmentRate: 4.8,
  //   rentFee: 600,
  //   floor: 3,
  //   bedrooms: 1,
  //   bathrooms: 1,
  //   area: 55,
  //   description:
  //       "A charming studio in Paris with elegant design, close to cafes and public transport.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic5.png",

  //   apartmentPictures: ["assets/images/pic5.png", "assets/images/pic3.png"],
  //   apartmentHeadDescripton: "Elegant apartment",

  //   apartmentRate: 4.6,
  //   rentFee: 300,
  //   floor: 4,
  //   bedrooms: 3,
  //   bathrooms: 2,
  //   area: 130,
  //   description:
  //       "Elegant apartment with spacious rooms and classic design, located near Rome's main attractions.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic2.png",

  //   apartmentPictures: ["assets/images/pic2.png", "assets/images/pic4.png"],
  //   apartmentHeadDescripton: "Modern loft",

  //   apartmentRate: 4.4,
  //   rentFee: 300,
  //   floor: 6,
  //   bedrooms: 2,
  //   bathrooms: 1,
  //   area: 100,
  //   description:
  //       "Modern loft in the heart of Berlin, close to nightlife and shops. Minimalist and stylish design.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic1.png",

  //   apartmentPictures: ["assets/images/pic1.png", "assets/images/pic2.png"],
  //   apartmentHeadDescripton: "Cozy studio",

  //   apartmentRate: 4.3,
  //   rentFee: 300,
  //   floor: 2,
  //   bedrooms: 1,
  //   bathrooms: 1,
  //   area: 45,
  //   description:
  //       "A small but cozy studio, perfect for solo travelers, near metro and shopping areas.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic3.png",

  //   apartmentPictures: ["assets/images/pic3.png", "assets/images/pic5.png"],
  //   apartmentHeadDescripton: "Canal-side apartment",

  //   apartmentRate: 4.9,
  //   rentFee: 300,
  //   floor: 4,
  //   bedrooms: 2,
  //   bathrooms: 1,
  //   area: 85,
  //   description:
  //       "Beautiful canal-side apartment with modern interiors. Walking distance to restaurants and shops.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic2.png",

  //   apartmentPictures: ["assets/images/pic2.png", "assets/images/pic4.png"],
  //   apartmentHeadDescripton: "Mountain view chalet",

  //   apartmentRate: 4.8,
  //   rentFee: 300,
  //   floor: 1,
  //   bedrooms: 3,
  //   bathrooms: 2,
  //   area: 160,
  //   description:
  //       "Chalet with breathtaking mountain views, perfect for winter and summer holidays.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],  ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic5.png",

  //   apartmentPictures: ["assets/images/pic5.png", "assets/images/pic1.png"],
  //   apartmentHeadDescripton: "Premium flat",

  //   apartmentRate: 4.5,
  //   rentFee: 300,
  //   floor: 8,
  //   bedrooms: 3,
  //   bathrooms: 2,
  //   area: 150,
  //   description:
  //       "Premium flat with modern amenities and city view, ideal for business travelers.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic1.png",

  //   apartmentPictures: [
  //     "assets/images/pic1.png",
  //     "assets/images/pic2.png",
  //     "assets/images/pic3.png",
  //   ],
  //   apartmentHeadDescripton: "Luxury residence",

  //   apartmentRate: 5.0,
  //   rentFee: 1000,
  //   floor: 10,
  //   bedrooms: 4,
  //   bathrooms: 3,
  //   area: 220,
  //   description:
  //       "Luxury residence in the heart of Doha with modern design and premium facilities.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic4.png",

  //   apartmentPictures: ["assets/images/pic4.png", "assets/images/pic5.png"],
  //   apartmentHeadDescripton: "Nile view apartment",

  //   apartmentRate: 4.1,
  //   rentFee: 300,
  //   floor: 9,
  //   bedrooms: 3,
  //   bathrooms: 2,
  //   area: 140,
  //   description:
  //       "Apartment with stunning Nile views, modern interior and central location.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic4.png",

  //   apartmentPictures: ["assets/images/pic4.png", "assets/images/pic2.png"],
  //   apartmentHeadDescripton: "Spacious condo",

  //   apartmentRate: 4.7,
  //   rentFee: 300,
  //   floor: 15,
  //   bedrooms: 2,
  //   bathrooms: 2,
  //   area: 120,
  //   description:
  //       "Spacious condo in the heart of New York, close to metro and main attractions.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),

  // Apartments(
  //   governorate: Governorate.Damascus,
  //   city: City.OldCity,
  //   isAvailable: true, 
  //   apartmentPicture: "assets/images/pic2.png",

  //   apartmentPictures: ["assets/images/pic2.png", "assets/images/pic3.png"],
  //   apartmentHeadDescripton: "Modern apartment",

  //   apartmentRate: 4.6,
  //   rentFee: 300,
  //   floor: 11,
  //   bedrooms: 2,
  //   bathrooms: 2,
  //   area: 110,
  //   description:
  //       "Modern apartment with minimalist design, near downtown and transportation.",
  //   publisher: me,
  //   comments: [
  //     Comment(user: me, text: "Amazing luxury feeling!"),
  //     Comment(user: me, text: "The pool area is fantastic."),
  //     Comment(user: me, text: "Very clean and modern."),
  //   ],
  // ),
];

final List<Contracts> contractsData = [
  // Contracts(
  //   contractApartment: apartmentsList[0],
  //   startRent: DateTime(2026, 1, 5),
  //   endRent: DateTime(2026, 2, 5),
  //   rentFee: 350,
  //   rentStatus: RentStatus.completed,
  //   renterName: "Omar Khaled",
  //   renterNumber: "0791234567",
  //   tenantName: "Ahmad Saleh",
  //   tenantNumber: "0789876543",
  //   contractDescreption: "Monthly rental for a furnished studio apartment.",
  // ),

  // Contracts(
  //   contractApartment: apartmentsList[1],
  //   startRent: DateTime(2026, 3, 1),
  //   endRent: DateTime(2026, 3, 30),
  //   rentFee: 420,
  //   rentStatus: RentStatus.onRent,
  //   renterName: "Sara Yassin",
  //   renterNumber: "0794567890",
  //   tenantName: "Lina Khalil",
  //   tenantNumber: "0785566778",
  //   contractDescreption: "Short-term rent for a 1-bedroom apartment.",
  // ),

  // Contracts(
  //   contractApartment: apartmentsList[2],
  //   startRent: DateTime(2026, 2, 10),
  //   endRent: DateTime(2026, 4, 10),
  //   rentFee: 800,
  //   rentStatus: RentStatus.pending,
  //   renterName: "Fadi Ahmad",
  //   renterNumber: "0791122334",
  //   tenantName: "Yousef Al-Din",
  //   tenantNumber: "0787788991",
  //   contractDescreption:
  //       "Two-month contract for a family apartment — awaiting approval.",
  // ),

  // Contracts(
  //   contractApartment: apartmentsList[0],
  //   startRent: DateTime(2026, 1, 20),
  //   endRent: DateTime(2026, 2, 20),
  //   rentFee: 300,
  //   rentStatus: RentStatus.cancelled,
  //   renterName: "Marwan Odeh",
  //   renterNumber: "0793344556",
  //   tenantName: "Nour Hamdan",
  //   tenantNumber: "0786655443",
  //   contractDescreption: "Contract was cancelled due to renter request.",
  // ),

  // Contracts(
  //   contractApartment: apartmentsList[5],
  //   startRent: DateTime(2026, 4, 5),
  //   endRent: DateTime(2026, 5, 5),
  //   rentFee: 500,
  //   rentStatus: RentStatus.onRent,
  //   renterName: "Khaled Ali",
  //   renterNumber: "0799988776",
  //   tenantName: "Bashar Al-Haj",
  //   tenantNumber: "0781122112",
  //   contractDescreption: "One-month rent for a serviced apartment.",
  // ),

  // Contracts(
  //   contractApartment: apartmentsList[5],
  //   startRent: DateTime(2026, 2, 1),
  //   endRent: DateTime(2026, 3, 1),
  //   rentFee: 370,
  //   rentStatus: RentStatus.completed,
  //   renterName: "Rana Hussein",
  //   renterNumber: "0795566778",
  //   tenantName: "Maya Jaber",
  //   tenantNumber: "0782233445",
  //   contractDescreption: "Completed rental period — no issues reported.",
  // ),

  // Contracts(
  //   contractApartment: apartmentsList[3],
  //   startRent: DateTime(2026, 5, 10),
  //   endRent: DateTime(2026, 6, 10),
  //   rentFee: 450,
  //   rentStatus: RentStatus.pending,
  //   renterName: "Hani Barakat",
  //   renterNumber: "0796655778",
  //   tenantName: "Samir Najjar",
  //   tenantNumber: "0788899001",
  //   contractDescreption: "Awaiting payment confirmation from the renter.",
  // ),

  // Contracts(
  //   contractApartment: apartmentsList[1],
  //   startRent: DateTime(2027, 1, 1),
  //   endRent: DateTime(2027, 12, 31),
  //   rentFee: 5000,
  //   rentStatus: RentStatus.onRent,
  //   renterName: "Mahmoud Zain",
  //   renterNumber: "0791332445",
  //   tenantName: "Alaa Qassem",
  //   tenantNumber: "0786600998",
  //   contractDescreption: "Full-year rent for a large family apartment.",
  // ),

  // Contracts(
  //   contractApartment: apartmentsList[0],
  //   startRent: DateTime(2026, 3, 15),
  //   endRent: DateTime(2026, 4, 15),
  //   rentFee: 390,
  //   rentStatus: RentStatus.completed,
  //   renterName: "Dina Farah",
  //   renterNumber: "0797788990",
  //   tenantName: "Jad Mahmoud",
  //   tenantNumber: "0783344556",
  //   contractDescreption: "Short stay for a business trip.",
  // ),

  // Contracts(
  //   contractApartment: apartmentsList[4],
  //   startRent: DateTime(2026, 6, 1),
  //   endRent: DateTime(2026, 7, 1),
  //   rentFee: 480,
  //   rentStatus: RentStatus.pending,
  //   renterName: "Rami Salem",
  //   renterNumber: "0799900112",
  //   tenantName: "Omar Najm",
  //   tenantNumber: "0785500778",
  //   contractDescreption: "Contract pending due to missing documents.",
  // ),
];
