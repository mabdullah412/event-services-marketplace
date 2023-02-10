import '../../data/repositories/user_repository.dart';

class UserDataProvider {
  /// Provides user data where ever needed in the application.
  late UserRepository userRepository;

  UserDataProvider({
    required this.userRepository,
  });

  String getId() {
    return userRepository.getId();
  }

  String getName() {
    return userRepository.getName();
  }
}
