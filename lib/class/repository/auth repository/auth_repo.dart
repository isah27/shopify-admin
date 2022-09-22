import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopify_admin/class/model/models.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChange => _auth.authStateChanges();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

// login method, it takes email and password as a parameter
  Future<void> login({required String email, required String pasaword}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: pasaword);
  }

  Future<void> signUp({required Users users}) async {
    await _auth
        .createUserWithEmailAndPassword(
            email: users.email!, password: users.password!)
        .then((value) async {
      users.uid = currentUser!.uid;
      await firebaseFirestore
          .collection("users")
          .doc(currentUser!.uid)
          .set(users.toJson());
    });
  }

// logout
  void signOut() async {
    await _auth.signOut();
  }

  // String current() {
  //   _auth.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       return "out";
  //     } else {
  //       return "in";
  //     }
  //   });
  // }

  String errorMessage(error) {
    // Handling possible errors
    switch (error) {
      case 'email-already-in-use':
        return "Email already in used";

      case 'network-request-failed':
        return "No internet connection";

      case 'user-not-found':
        return "Incorrect email";

      case 'wrong-password':
        return "Wrong Password";

      case 'too-many-requests':
        return "Too many request, wait for 30 seconds and try again";
      default:
        return "Unknown error, make sure you have internet connection.";
    }
  }
}
