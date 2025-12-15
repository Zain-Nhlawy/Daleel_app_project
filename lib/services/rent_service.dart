import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../models/rent.dart';

class RentService {
    final DioClient apiClient;

    RentService({required this.apiClient});

    Future<Rent?> createRent(Map<String, dynamic> data) async {
    try {
        final response = await apiClient.dio.post(
        'rents',
        data: data,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
        final rentData = response.data['data']['rent'];
        return Rent.fromJson(rentData);
        } else {
        print('Error creating rent: ${response.data}');
        }
    } on DioException catch (e) {
        print('DioException in createRent: $e');
        if (e.response != null) {
        print('Status code: ${e.response!.statusCode}');
        print('Data: ${e.response!.data}');
        }
    } catch (e) {
        print('Other error in createRent: $e');
    }
    return null;
    }
}
