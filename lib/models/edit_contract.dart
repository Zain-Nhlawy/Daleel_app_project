import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/models/user.dart';

class EditContract {
  int? id;
  DateTime? endRent;
  DateTime? startRent;
  String? status;
  String? rentFee;
  Contracts? originalRent;
  User? user;
  Apartments2? department;

  EditContract({
    this.id,
    this.endRent,
    this.startRent,
    this.status,
    this.rentFee,
    this.originalRent,
    this.user,
    this.department,
  });

  EditContract.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    endRent =
        json['endRent'] != null ? DateTime.tryParse(json['endRent']) : null;
    startRent =
        json['startRent'] != null ? DateTime.tryParse(json['startRent']) : null;
    status = json['status'];
    rentFee = json['rentFee'];
    originalRent = json['original_rent'] != null
        ? Contracts.fromJson(json['original_rent'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    department = json['department'] != null
        ? Apartments2.fromJson(json['department'])
        : null;
  }
}
