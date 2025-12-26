import 'dart:convert';

import 'package:daleel_app_project/core/network/dio_client.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/contracts.dart';
import 'package:dio/dio.dart';

class ContractService {
  final DioClient apiClient;
  ContractService({required this.apiClient});

  Future<List<Contracts>?> showContractsScreen(int page) async {
    try {
      final response = await dioClient.dio.get(
        "/auth/rents?page=${page}",
        queryParameters: {
          "with":
              "user,department,department.rents,department.user,department.images",
        },
      );

      if (response.statusCode == 200) {
        final List rents = response.data['data'];
        return rents.map((json) => Contracts.fromJson(json)).toList();
      }
    } catch (e) {}
    return null;
  }

  Future<List<Contracts>?> showContractsHistory(int page) async {
    try {
      final response = await dioClient.dio.get(
        "/auth/rents-history?page=${page}",
        queryParameters: {
          "with":
              "user,department,department.rents,department.user,department.images",
        },
      );

      if (response.statusCode == 200) {
        final List rents = response.data['data'];
        return rents.map((json) => Contracts.fromJson(json)).toList();
      }
    } catch (e) {}
    return null;
  }

  Future<Contracts> createContract({
    required int departmentId,
    required DateTime start,
    required DateTime end,
    required double rentFee,
  }) async {
    try {
      final response = await apiClient.dio.post(
        "/auth/rents",
        data: {
          "department_id": departmentId,
          "startRent": start.toIso8601String().split('T').first,
          "endRent": end.toIso8601String().split('T').first,
          "rentFee": rentFee,
        },
      );
      final data = response.data;
      if (data == null) {
        throw Exception('Invalid response from server');
      }

      final status = data['status'];
      final message = data['message'];

      if (status == 'error') {
        throw Exception(message ?? 'Booking failed');
      }

      final rentData = data['data'];
      if (rentData == null || rentData is! Map<String, dynamic>) {
        throw Exception('Invalid response structure');
      }

      return Contracts.fromJson(rentData);
    } on DioException catch (e) {
      throw e;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Contracts?> updateContract({
    required int rentId,
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      final response = await apiClient.dio.put(
        "/auth/rents/$rentId",
        data: {
          "startRent": start.toIso8601String().split('T').first,
          "endRent": end.toIso8601String().split('T').first,
        },
      );

      final dynamic rawData = response.data;
      if (rawData == null) {
        throw Exception('Empty response from server');
      }

      final Map<String, dynamic> data = rawData is String
          ? jsonDecode(rawData)
          : Map<String, dynamic>.from(rawData);

      if (data['status'] != 'success') {
        throw Exception(data['message'] ?? 'Update failed');
      }

      final dynamic responseData = data['data'];

      if (responseData == null) {
        throw Exception('No data returned from server');
      }

      if (data['message'].toString().contains('approve the update')) {
        return null;
      }

      if (responseData is Map<String, dynamic>) {
        return Contracts.fromJson(Map<String, dynamic>.from(responseData));
      }

      throw Exception('Unexpected response format');
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ?? e.message ?? 'Network error',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Contracts> approveRent({required int rentId}) async {
    try {
      final response = await apiClient.dio.post("/auth/rents/$rentId/approve");

      final dynamic rawData = response.data;
      if (rawData == null) {
        throw Exception('Empty response from server');
      }

      final Map<String, dynamic> data = rawData is String
          ? jsonDecode(rawData)
          : Map<String, dynamic>.from(rawData);

      if (data['status'] != 'success') {
        throw Exception(data['message'] ?? 'Approve failed');
      }

      final dynamic rentData = data['data'];
      if (rentData == null || rentData is! Map<String, dynamic>) {
        throw Exception('Invalid rent data');
      }

      return Contracts.fromJson(Map<String, dynamic>.from(rentData));
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ?? e.message ?? 'Network error',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Contracts> rejectRent({required int rentId}) async {
    try {
      final response = await apiClient.dio.post("/auth/rents/$rentId/reject");

      final data = response.data;
      if (data == null) {
        throw Exception('Empty response from server');
      }

      if (data['status'] != 'success') {
        throw Exception(data['message'] ?? 'Reject failed');
      }

      return Contracts.fromJson(Map<String, dynamic>.from(data['data']));
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ?? e.message ?? 'Network error',
      );
    }
  }

  Future<bool> deleteContract({required int rentId}) async {
    try {
      final response = await apiClient.dio.delete("/auth/rents/$rentId");

      final data = response.data;
      if (data == null) {
        throw Exception('Empty response from server');
      }

      if (data['status'] != 'success') {
        throw Exception(data['message'] ?? 'Delete failed');
      }

      return true;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ?? e.message ?? 'Network error',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
