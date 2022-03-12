import 'package:food_donor/repositories/user_repository.dart';
import 'package:food_donor/models/user.dart';

abstract class AuthenictionService {
  final UserRepository _userRepository = UserRepository.instance;
  static bool _loginStatus = false;
  static bool get loginStatus => _loginStatus;

  bool login(User user);
  bool register(User user);

  static AuthenictionService get instance => AuthenictionServiceImpl();
}

class AuthenictionServiceImpl extends AuthenictionService {
  @override
  bool login(User user) {
    var temp =
        _userRepository.getUserByEmailAndPassword(user.email, user.password);

    return _isNotNull(temp);
  }

  @override
  bool register(User newUser) {
    var temp = _userRepository.addUser(newUser);
    return _isNotNull(temp);
  }

  bool _isNotNull(User? temp) {
    // ignore: unnecessary_null_comparison
    return temp == null ? false : true;
  }
}
