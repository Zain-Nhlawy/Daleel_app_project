import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../services/comment_service.dart';

class CommentController extends ChangeNotifier {
  final CommentService commentService;

  CommentController({required this.commentService});

  List<Comment> _comments = [];
  List<Comment> get comments => _comments;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchComments(int departmentId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final responseComments = await commentService.getComments(departmentId);
      if (responseComments != null) {
        _comments = responseComments;
      }
    } catch (e) {
      print("Error fetching comments: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addComment(int departmentId, String content) async {
    if (content.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newComment = await commentService.addComment(departmentId, content);
      if (newComment != null) {
        _comments.add(newComment);
        notifyListeners();
      }
    } catch (e) {
      print("Error adding comment: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
