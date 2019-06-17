import 'package:firebase/firebase.dart' ;
class AuthState {
  final User firebaseUser;
  final String error;

  AuthState({this.error, this.firebaseUser});


  AuthState copyWith({
    User firebaseUser,
    String error
  }) {
    return AuthState(
      firebaseUser: firebaseUser ?? this.firebaseUser,
      error: error,
    );
  }
}