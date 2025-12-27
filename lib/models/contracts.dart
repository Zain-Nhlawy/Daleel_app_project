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
    required this.id,
    required this.startRent,
    required this.endRent,
    required this.rentFee,
    required this.rentStatus,
    required this.contractApartment,
    required this.user,
    required this.departmentRents,
  });

  final int id;
  final Apartments2 contractApartment;
  final RentStatus rentStatus;
  final DateTime startRent;
  final DateTime endRent;
  final double rentFee;
  final User user;
  final List<Contracts> departmentRents;


  Contracts copyWith({
    RentStatus? rentStatus,
    DateTime? startRent,
    DateTime? endRent,
    double? rentFee,
    User? user,
    Apartments2? contractApartment,
    List<Contracts>? departmentRents,
  }) {
    return Contracts(
      id: id, 
      rentStatus: rentStatus ?? this.rentStatus,
      startRent: startRent ?? this.startRent,
      endRent: endRent ?? this.endRent,
      rentFee: rentFee ?? this.rentFee,
      user: user ?? this.user,
      contractApartment:
          contractApartment ?? this.contractApartment,
      departmentRents:
          departmentRents ?? this.departmentRents,
    );
  }

  factory Contracts.fromJson(Map<String, dynamic> json) {
    Apartments2? apartment;
    if (json['department'] != null) {
      apartment = Apartments2.fromJson(json['department']);
    }

    List<Contracts> deptRents = [];
    if (json['department'] != null && json['department']['rents'] != null) {
      final rentsList = json['department']['rents'] as List;
      deptRents = rentsList.map((e) {
        return Contracts(
          id: e['id'] ?? 0,
          startRent: e['startRent'] != null
              ? DateTime.parse(e['startRent'])
              : DateTime.now(),
          endRent: e['endRent'] != null
              ? DateTime.parse(e['endRent'])
              : DateTime.now(),
          rentFee: e['rentFee'] != null
              ? double.tryParse(e['rentFee'].toString()) ?? 0.0
              : 0.0,
          rentStatus: e['status'] != null
              ? rentStatusFromString(e['status'])
              : RentStatus.pending,
          user: e['user'] != null ? User.fromJson(e['user']) : User.empty(),
          contractApartment: apartment ?? Apartments2.empty(),
          departmentRents: [], 
        );
      }).toList();
    }

    return Contracts(
      id: json['id'] ?? 0,
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
      contractApartment: apartment ?? Apartments2.empty(),
      departmentRents: deptRents,
    );
  }
}
