import 'package:daleel_app_project/controllers/apartment_controller.dart';
import 'package:daleel_app_project/controllers/comment_controller.dart';
import 'package:daleel_app_project/controllers/contract_controller.dart';
import 'package:daleel_app_project/services/apartment_service.dart';
import 'package:daleel_app_project/services/comment_service.dart';
import 'package:daleel_app_project/services/contract_service.dart';
import 'core/storage/secure_storage.dart';
import 'core/network/dio_client.dart';
import 'services/user_service.dart';
import 'controllers/user_controller.dart';

final AppSecureStorage appStorage = AppSecureStorage();
final DioClient dioClient = DioClient(storage: appStorage);


final UserService userService = UserService(
  apiClient: dioClient,
  storage: appStorage,
);
final UserController userController = UserController(
  userService: userService,
  storage: appStorage,
);


/*
final RentService rentService = RentService(
  apiClient: dioClient
);
final RentController rentController = RentController(
  rentService: rentService,
);
*/


final ApartmentService apartmentService = ApartmentService(
  apiClient: dioClient
);
final ApartmentController apartmentController = ApartmentController(
  apartmentService: apartmentService
);



final CommentService commentService = CommentService(
  apiClient: dioClient,
);
final CommentController commentController = CommentController(
  commentService: commentService,
);


final ContractService contractService = ContractService(
  apiClient: dioClient,
);
final ContractController contractController = ContractController(
  contractService: contractService,
);

