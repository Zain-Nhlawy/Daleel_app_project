import 'package:daleel_app_project/models/apartments.dart';
import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../services/comment_service.dart';

class CommentController extends ChangeNotifier {
  final CommentService commentService;

  CommentController({required this.commentService});

  List<Comment?> getComments(Apartments2 apartment) => apartment.comments;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchComments(int departmentId, Apartments2 apartment) async {
    _isLoading = true;
    notifyListeners();

    try {
      final responseComments = await commentService.getComments(departmentId);
      if (responseComments != null) {
        apartment.comments = responseComments;
      }
    } catch (e) {}

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addComment(int departmentId, Apartments2 apartment, String content) async {
    if (content.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newComment = await commentService.addComment(departmentId, content);
      if (newComment != null) {
        apartment.comments.add(newComment);
        notifyListeners();
      }
    } catch (e) {}

    _isLoading = false;
    notifyListeners();
  }
}
