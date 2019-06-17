import 'package:firebase/firestore.dart' ;
import 'package:firebase/firebase.dart' as fb;
class TrackRepository{
  CollectionReference _collectionReference;
  TrackRepository(){
    _collectionReference =  fb.firestore().collection('tracks') ;
  }

  Stream<QuerySnapshot> getTracks (){
    return _collectionReference.onSnapshot;
  }

}