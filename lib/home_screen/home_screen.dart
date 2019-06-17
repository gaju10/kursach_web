import 'package:flutter_web/material.dart';
import 'package:kursach_web/auth_screen/auth_bloc/auth_bloc.dart';
import 'package:kursach_web/auth_screen/auth_bloc/auth_event.dart';
import 'package:kursach_web/auth_screen/auth_bloc/auth_state.dart';
import 'package:kursach_web/blocprovider/bloc_builder.dart';
import 'package:kursach_web/blocprovider/bloc_provider.dart';
import 'package:kursach_web/auth_screen/auth_screen.dart';
import 'package:kursach_web/create_new_track/create_new_track.dart';
import 'package:kursach_web/track/bloc/track_bloc.dart';
import 'package:kursach_web/track/bloc/track_event.dart';
import 'package:kursach_web/track/bloc/track_state.dart';
import 'package:kursach_web/track/model/track.dart';
import 'package:kursach_web/track/widget/track_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthBloc _authBloc;
  final TrackBloc trackBloc = TrackBloc();

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    trackBloc.dispatch(InitBloc());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text('Vasya'), accountEmail: Text(_authBloc.currentState.firebaseUser?.email ?? 'null')),
            RaisedButton(
              onPressed: () {
                _authBloc.dispatch(LogOut());
              },
              child: Text('logout'),
            ),
          ],
        ),
      ),
      body: BlocBuilder(
        bloc: trackBloc,
        builder: (context, TrackState state) {
          if (state.tracks == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: getTracks(state.tracks),
          );
        },
      ),
    );
  }

  List<Widget> getTracks(List<Track> tracks, {VoidCallback onTap}){
    List<Widget> list = [];
    list = tracks.map<Widget>((track) {
      return Container(
        width: MediaQuery.of(context).size.width/4,
        child: TrackCard(
          track: track,
        ),
      );
    }).toList();
    list.add(Padding(
      padding:  EdgeInsets.all(16.0),
      child: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewTrack()));
      },),
    ),);
    return list;
  }
}
