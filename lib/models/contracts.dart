
import 'package:daleel_app_project/models/apartments2.dart';

enum RentStatus { cancelled, completed, pending, onRent }

class Contracts {
  const Contracts({
    required this.startRent,
    required this.endRent,
    required this.rentFee,
    required this.rentStatus,
    required this.renterName,
    required this.renterNumber,
    required this.tenantName,
    required this.tenantNumber,
    required this.contractDescreption,
    required this.contractApartment,
  });
  
  final Apartments2 contractApartment;
  final RentStatus rentStatus;
  final DateTime startRent;
  final DateTime endRent;
  final int rentFee;
  final String tenantName;
  final String tenantNumber;
  final String renterName;
  final String renterNumber;
  final String contractDescreption;
}
