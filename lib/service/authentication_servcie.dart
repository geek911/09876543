import 'package:food_donor/repositories/user_repository.dart';
import 'package:food_donor/models/user.dart';

abstract class AuthenictionService {
  final UserRepository _userRepository = UserRepository.instance;

  bool login(User user);
  bool register(User user);

  static AuthenictionService get instance => AuthenictionServiceImpl();

  User get currentUser;
}

class AuthenictionServiceImpl extends AuthenictionService {
  static User _currentUser = User();

  @override
  bool login(User user) {
    var temp =
        _userRepository.getUserByEmailAndPassword(user.email, user.password);
    _currentUser = user;

    if (_isNotNull(temp)) {
      _currentUser = user;
      return true;
    }
    return false;
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

  @override
  User get currentUser => _currentUser;
}
