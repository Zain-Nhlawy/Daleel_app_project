/*class Rent {
  final int id;
  final int departmentId;
  final String startRent;
  final String endRent;

  Rent({
    required this.id,
    required this.departmentId,
    required this.startRent,
    required this.endRent,
  });

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
      id: json['id'],
      departmentId: json['department_id'],
      startRent: json['startRent'],
      endRent: json['endRent'],
    );
  }
}
*/

class Rent {
  final int id;
  final String startRent;
  final String? endRent;
  final String status;
  final double rentFee;

  Rent({
    required this.id,
    required this.startRent,
    this.endRent,
    required this.status,
    required this.rentFee,
  });

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
      id: json['id'],
      startRent: json['startRent'],
      endRent: json['endRent'],
      status: json['status'],
      rentFee: double.tryParse(json['rentFee'].toString()) ?? 0,
    );
  }
}
