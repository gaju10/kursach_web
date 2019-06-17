import 'package:flutter_web/material.dart';
import 'package:kursach_web/auth_screen/auth_bloc/auth_bloc.dart';
import 'package:kursach_web/auth_screen/auth_bloc/auth_event.dart';
import 'package:kursach_web/blocprovider/bloc_provider.dart';
import 'package:kursach_web/create_new_track/iteration_field.dart';
import 'package:kursach_web/create_new_track/repository.dart';
import 'package:kursach_web/track/bloc/track_event.dart';
import 'package:kursach_web/track/model/iteration.dart';

class CreateNewTrack extends StatefulWidget {
  @override
  _CreateNewTrackState createState() => _CreateNewTrackState();
}

class _CreateNewTrackState extends State<CreateNewTrack> {
  final CreateTrackRepository createTrackRepository = CreateTrackRepository();
  final TextEditingController description = TextEditingController();
  final TextEditingController difficult = TextEditingController();
  final TextEditingController trackAuthor = TextEditingController();
  final TextEditingController trackImageUrl = TextEditingController();
  final TextEditingController trackName = TextEditingController();
  final TextEditingController trackTime = TextEditingController();
  List<TextEditingController> drumTypeControllers = [];
  List<TextEditingController> startDurationControllers = [];
  AuthBloc _authBloc;
  List<Widget> list;
  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    list = [    Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextField(
        controller: trackName,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          labelText: 'Track name',
        ),
      ),
    ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextField(
          controller: difficult,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            labelText: 'Difficult',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextField(
          controller: description,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            labelText: 'Description',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextField(
          controller: trackImageUrl,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            labelText: 'Track image url',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextField(
          controller: trackTime,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            labelText: 'Track duration',
          ),
        ),
      ),
    ];

  }

  @override
  Widget build(BuildContext context) {
    print(list);
    return Scaffold(
      appBar: AppBar(
        title: Text('New track creation'),
        centerTitle: true,
      ),
      floatingActionButton: RaisedButton(
        color: Colors.blue,
        onPressed: (){
          int  index = -1;
          List<Iteration> iterations= drumTypeControllers.map((textEdit){
            ++index;
            return Iteration(
              drumTypes: [textEdit.text],
              pause: Duration(seconds: 1),
              start: Duration(seconds: int.parse(startDurationControllers[index].text)),
            );
          }).toList();
          createTrackRepository.addTrack(description.text, difficult.text, trackName.text, int.parse(trackTime.text),trackImageUrl.text, iterations );
          Navigator.pop(context);
      },child: Text('Create track',style: TextStyle(color: Colors.white,),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text('Vasya'), accountEmail: Text(_authBloc.currentState.firebaseUser?.email ?? 'null')),
            RaisedButton(
              onPressed: () {
                _authBloc.dispatch(LogOut());
                WidgetsBinding.instance.addPostFrameCallback((_){
                  Navigator.popUntil(context, (_)=>!Navigator.canPop(context));
                });
              },
              child: Text('logout'),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context,index){
        if(index == list.length){
          return FloatingActionButton(child: Icon(Icons.add),onPressed: (){
            addIteration();
          },);
       }
        return list[index];
      },itemCount: list.length+1,),
    );
  }

  addIteration(){
    var drumTypeController = TextEditingController();
    var startDurationController = TextEditingController();
    list.add(IterationField(drumTypeController: drumTypeController,startDurationController: startDurationController,),);
    drumTypeControllers.add(drumTypeController);
    startDurationControllers.add(startDurationController);
    setState(() {


    });
  }
}
