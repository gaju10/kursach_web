import 'package:flutter_web/material.dart';
import 'package:kursach_web/auth_screen/auth_bloc/auth_bloc.dart';
import 'package:kursach_web/home_screen/home_screen.dart';
import 'auth_screen/auth_screen.dart';
import 'blocprovider/bloc_provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final AuthBloc authBloc = AuthBloc();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: authBloc,
      child: MaterialApp(
        routes: {'home_screen': (context)=>HomeScreen()},
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthScreen(),
      ),
    );
  }
}
