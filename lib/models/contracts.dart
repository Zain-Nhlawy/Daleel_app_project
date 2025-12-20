import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/models/user.dart';

enum RentStatus { cancelled, completed, pending, onRent }

RentStatus rentStatusFromString(String status) {
  switch (status.toLowerCase()) {
    case 'cancelled':
      return RentStatus.cancelled;
    case 'completed':
      return RentStatus.completed;
    case 'pending':
      return RentStatus.pending;
    case 'onrent':
      return RentStatus.onRent;
    default:
      return RentStatus.pending; 
  }
}

class Contracts {
  const Contracts({
    required this.startRent,
    required this.endRent,
    required this.rentFee,
    required this.rentStatus,
    required this.contractApartment,
    required this.user,
  });

  final Apartments2 contractApartment;
  final RentStatus rentStatus;
  final DateTime startRent;
  final DateTime endRent;
  final double  rentFee;
  final User user;

  factory Contracts.fromJson(Map<String, dynamic> json) {
  return Contracts(
    startRent: json['startRent'] != null
        ? DateTime.parse(json['startRent'])
        : DateTime.now(),

    endRent: json['endRent'] != null
        ? DateTime.parse(json['endRent'])
        : DateTime.now(),

    rentFee: json['rentFee'] != null
        ? double.tryParse(json['rentFee'].toString()) ?? 0.0
        : 0.0,

    rentStatus: json['status'] != null
        ? rentStatusFromString(json['status'])
        : RentStatus.pending,

    user: User.fromJson(json['user']),

    contractApartment: json['department'] != null
        ? Apartments2.fromJson(json['department'])
        : Apartments2(
            id: 0,
            user: User.empty(),
            images: [],
          ),
  );
}

}

