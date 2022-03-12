import 'package:food_donor/models/user.dart';

abstract class UserRepository {
  static UserRepository get instance => FakeUserRepository();

  User getUserByEmailAndPassword(String? email, String? password);

  User addUser(User user);
}

class FakeUserRepository extends UserRepository {
  static final List<User> _users = [];

  @override
  User addUser(User user) {
    user.id = '${_users.length + 1}';
    _users.add(user);
    return user;
  }

  @override
  User getUserByEmailAndPassword(String? email, String? password) {
    return _users.firstWhere(
        (element) => element.email == email && element.password == password);
  }
}
