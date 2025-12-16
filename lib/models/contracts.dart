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
      startRent: DateTime.parse(json['startRent']),
      endRent: DateTime.parse(json['endRent']),
      rentFee: json['rentFee'] != null
        ? double.tryParse(json['rentFee'].toString()) ?? 0.0
        : 0.0,
      rentStatus: rentStatusFromString(json['status']),
      user: User.fromJson(json['user']),
      contractApartment: Apartments2.fromJson(json['department']),
    );
  }
}

