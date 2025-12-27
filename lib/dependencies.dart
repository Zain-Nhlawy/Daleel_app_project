import 'package:daleel_app_project/controllers/apartment_controller.dart';
import 'package:daleel_app_project/controllers/comment_controller.dart';
import 'package:daleel_app_project/controllers/contract_controller.dart';
import 'package:daleel_app_project/controllers/edit_contract_controller.dart';
import 'package:daleel_app_project/controllers/review_controller.dart';
import 'package:daleel_app_project/services/apartment_service.dart';
import 'package:daleel_app_project/services/comment_service.dart';
import 'package:daleel_app_project/services/contract_service.dart';
import 'package:daleel_app_project/services/edit_contract_service.dart';
import 'package:daleel_app_project/services/notification_service.dart';
import 'package:daleel_app_project/services/review_service.dart';
import 'package:flutter/material.dart';
import 'core/storage/secure_storage.dart';
import 'core/network/dio_client.dart';
import 'services/user_service.dart';
import 'controllers/user_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final AppSecureStorage appStorage = AppSecureStorage();
final DioClient dioClient = DioClient(storage: appStorage);
String language = 'en';
String appTheme = "light";
final UserService userService = UserService(
  apiClient: dioClient,
  storage: appStorage,
);
final UserController userController = UserController(
  userService: userService,
  storage: appStorage,
);
final ApartmentService apartmentService = ApartmentService(
  apiClient: dioClient,
);
final ApartmentController apartmentController = ApartmentController(
  apartmentService: apartmentService,
);

final EditContractService editContractService = EditContractService(
  apiClient: dioClient,
);
final EditContractController editContractController = EditContractController(
  editContractService: editContractService,
);

final CommentService commentService = CommentService(apiClient: dioClient);
final CommentController commentController = CommentController(
  commentService: commentService,
);

final ReviewService reviewService = ReviewService(apiClient: dioClient);
final ReviewController reviewController = ReviewController(
  reviewService: reviewService,
);

final ContractService contractService = ContractService(apiClient: dioClient);
final ContractController contractController = ContractController(
  contractService: contractService,
);

final NotificationService notificationService = NotificationService(
  apiClient: dioClient,
);

final String baseUrl = dotenv.env['BASE_URL'] ?? '';
