import '../core/network/dio_client.dart';
import '../models/comment.dart';

class ReviewService {
  final DioClient apiClient;

  ReviewService({required this.apiClient});
  Future<Comment?> addReview(int departmentId, int rate) async {
    try {
      final response = await apiClient.dio.post(
        'auth/departments/$departmentId/reviews',
        data: {'rating': rate},
      );

      if (response.statusCode == 201) {
        final data = response.data['data'];
        return Comment.fromJson(data);
      } else {}
    } catch (e) {}

    return null;
  }
}
