import 'package:firebase/firebase.dart' ;
class AuthRepository {
  final Auth _firebaseAuth =  auth();
  final GoogleAuthProvider googleAuthProvider  = GoogleAuthProvider() ;
  AuthRepository(){
    googleAuthProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  }
  Future<User> signInWithCredentials(String email, String password)async {
   var userCred =  await _firebaseAuth.signInWithEmailAndPassword(email, password);
   return userCred.user;
  }
  Future<User> signUpWithGoogle() async {
    User user;
    await _firebaseAuth.signInWithPopup(googleAuthProvider).then((result) {
      user = result.user;
    });
    return user;
  }
  Future<User> signUp({String email, String password}) async {
    var userCred =  await _firebaseAuth.createUserWithEmailAndPassword(email, password);
    return userCred.user;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<User> getUser() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser;
  }

}