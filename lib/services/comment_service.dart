import '../core/network/dio_client.dart';
import '../models/comment.dart';

class CommentService {
  final DioClient apiClient;

  CommentService({required this.apiClient});

  Future<List<Comment>?> getComments(int departmentId) async {
    try {
      final response = await apiClient.dio.get(
        'auth/departments/$departmentId/comments',
        queryParameters: {'with': 'user'},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
//         return List<Comment>.from(
//   data.map((c) => Comment.fromJson(c)),
// );
      return data.map<Comment>((c) => Comment.fromJson(c)).toList();
      }
    } catch (e) {}
    return null;
  }

  Future<Comment?> addComment(int departmentId, String content) async {
    try {
      final response = await apiClient.dio.post(
        'auth/departments/$departmentId/comments',
        data: {'content': content},
      );

      if (response.statusCode == 201) {
        final data = response.data['data'];
        return Comment.fromJson(data);
      } else {}
    } catch (e) {}

    return null;
  }
}
