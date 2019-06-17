import 'package:bloc/bloc.dart';
import 'package:kursach_web/auth_screen/auth_bloc/auth_event.dart';
import 'package:kursach_web/auth_screen/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  @override
  // TODO: implement initialState
  AuthState get initialState => AuthState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignIn) {
      await _authRepository.signInWithCredentials(event.email, event.password).catchError((e){
        dispatch(Error(
          error: e.message,
        ));
      });
      var user = await _authRepository.getUser();
      print(user.email);
      yield currentState.copyWith(firebaseUser: user);
    } else if (event is SignUp) {
      await _authRepository.signUp(email: event.email, password: event.password).catchError((e){
        dispatch(Error(
          error: e.message,
        ));
      });
      var user = await _authRepository.getUser();
      yield currentState.copyWith(firebaseUser: user);
    }  else if (event is LogOut) {
      await _authRepository.signOut();
      yield AuthState();
    } else if (event is Error) {
      yield currentState.copyWith(error: event.error);
    } else if (event is CompleteError) {
      yield currentState.copyWith(error: null);
    } else if(event is SignUpWithGoogle){
      var user = await _authRepository.signUpWithGoogle().catchError((e){
        dispatch(Error(
          error: e.message,
        ));
      });
      yield currentState.copyWith(firebaseUser: user);
    }
  }
}