import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart';
import 'package:kursach_web/track/model/iteration.dart';
class CreateTrackRepository{
  Firestore firestore = fb.firestore();
  
  addTrack(String description,String difficult,String trackName, int trackTime, String trackImageUrl, List<Iteration> iterations)async{
   await firestore.collection('tracks').add({
      'description' : description,
      'difficult' : difficult,
     'trackName' : trackName,
     'trackTime' : trackTime,
     'trackImageUrl' : trackImageUrl,
     'iteration' : iterations.map((iteration){
       return iteration.toJson();
     }).toList(),
    });
  }
}