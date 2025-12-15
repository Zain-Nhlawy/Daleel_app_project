import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/models/user.dart';

enum RentStatus { cancelled, completed, pending, onRent }

RentStatus rentStatusFromString(String status) {
  switch (status) {
    case 'cancelled':
      return RentStatus.cancelled;
    case 'completed':
      return RentStatus.completed;
    case 'pending':
      return RentStatus.pending;
    case 'onRent':
      return RentStatus.onRent;
    default:
      throw Exception('Unknown rent status: $status');
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
  final int rentFee;
  final User user;

  factory Contracts.fromJson(Map<String, dynamic> json) {
    return Contracts(
      startRent: DateTime.parse(json['startRent']),
      endRent: DateTime.parse(json['endRent']),
      rentFee: double.parse(json['rentFee']).toInt(), 
      rentStatus: rentStatusFromString(json['status']),
      user: User.fromJson(json['user']),
      contractApartment: Apartments2.fromJson(json['department']),
    );
  }
}

