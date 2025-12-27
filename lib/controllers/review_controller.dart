import 'package:daleel_app_project/services/review_service.dart';
import 'package:flutter/material.dart';

class ReviewController extends ChangeNotifier {
  final ReviewService reviewService;
  ReviewController({required this.reviewService});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> addReview(int departmentId, int rate) async {
    _isLoading = true;
    notifyListeners();
    try {
      await reviewService.addReview(departmentId, rate);
    } catch (e) {}
    _isLoading = false;
    notifyListeners();
  }
}
