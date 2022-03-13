// import 'package:food_donor/models/custom_user.dart';

// abstract class UserRepository {
//   static UserRepository get instance => FakeUserRepository();

//   CustomUser? getUserByEmailAndPassword(String? email, String? password);

//   CustomUser addUser(CustomUser user);
// }

// class FakeUserRepository extends UserRepository {
//   static final List<CustomUser> _users = [];

//   @override
//   CustomUser addUser(CustomUser user) {
//     user.id = '${_users.length + 1}';
//     _users.add(user);
//     return user;
//   }

//   @override
//   CustomUser? getUserByEmailAndPassword(String email, String password) {
//     CustomUser? user;
//     try {
//       user = _users.firstWhere(
//           (element) => element.email == email && element.password == password);
//     } catch (e) {}
//     return user;
//   }
// }
