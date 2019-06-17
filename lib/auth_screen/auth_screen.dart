import 'dart:async';
import 'package:flutter_web/material.dart';
import 'package:kursach_web/auth_screen/auth_bloc/auth_bloc.dart';
import 'package:kursach_web/auth_screen/auth_bloc/auth_event.dart';
import 'package:kursach_web/blocprovider/bloc_builder.dart';
import 'package:kursach_web/blocprovider/bloc_provider.dart';
import 'package:kursach_web/home_screen/home_screen.dart';

import 'auth_bloc/auth_state.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthBloc _authBloc;
  bool _isSecured;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    emailController.text = '222@gmail.com';
    passwordController.text = 'qwe123321';
    _isSecured = true;
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _subscription = _authBloc.state.listen((state) {
      if (state.error != null) {
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialogContent(error: state.error);
            });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _authBloc,
        builder: (context, AuthState state) {
         if(state.firebaseUser != null){
           print(_authBloc.currentState.firebaseUser == null);
           return HomeScreen();
         }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Smart drum training',
                style: TextStyle(fontSize: 20.0),
              ),
              centerTitle: true,
              actions: <Widget>[],
            ),
            body: Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                              labelText: 'Login or email',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: _isSecured,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    _isSecured = !_isSecured;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: RaisedButton(
                                  child: Text(
                                    'Sign IN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    print('sign In');
                                    _authBloc.dispatch(
                                      SignIn(
                                        password: passwordController.text,
                                        email: emailController.text,
                                      ),
                                    );
                                  },
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: RaisedButton(
                                  child: Text(
                                    'Sign UP',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () => _authBloc.dispatch(SignUp(
                                        password: passwordController.text,
                                        email: emailController.text,
                                      )),
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                child: Text('Sign up with google',style: TextStyle(color: Colors.white),),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                onPressed: (){
                                  _authBloc.dispatch(SignUpWithGoogle());
                                },
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Forgot password? ",
                            style: TextStyle(color: Colors.black, fontSize: 18.0),
                            children: [
                              TextSpan(
                                text: " Recover here",
                                style:
                                    TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 18.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class ErrorDialogContent extends StatefulWidget {
  final String error;

  const ErrorDialogContent({
    Key key,
    this.error,
  }) : super(key: key);

  @override
  _ErrorDialogContentState createState() => _ErrorDialogContentState();
}

class _ErrorDialogContentState extends State<ErrorDialogContent> {
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(widget.error),
      title: Text('Something went wrong'),
      actions: <Widget>[
        RaisedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _authBloc.dispatch(CompleteError());
    super.dispose();
  }
}
