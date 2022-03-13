// import 'package:food_donor/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

// abstract class AuthenictionService {
//   bool login(User user);
//   @override
//   Future<void> register(
//       {required fullName, required String email, required String password});

//   static AuthenictionService get instance => AuthenictionServiceImpl();

//   User get currentUser;
// }

class AuthenictionService {
  var _firebase = FirebaseAuth.instance;

  @override
  Future<void> login({required String email, required String password}) async {
    await _firebase.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> register(
      {required fullName,
      required String email,
      required String password}) async {
    var userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: email, password: password);
    await userCredentials.user?.updateDisplayName(fullName);
  }
}
