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
