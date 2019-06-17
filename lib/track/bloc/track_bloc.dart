import 'package:bloc/bloc.dart';
import 'package:kursach_web/track/bloc/track_event.dart';
import 'package:kursach_web/track/bloc/track_state.dart';
import 'package:kursach_web/track/model/track.dart';
import 'package:kursach_web/track/repository/track_repository.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  final TrackRepository _trackRepository = TrackRepository();

  @override
  // TODO: implement initialState
  TrackState get initialState => TrackState();

  @override
  Stream<TrackState> mapEventToState(TrackEvent event) async* {
    if(event is InitBloc){
      _trackRepository.getTracks().listen((snapshot) {
        dispatch(
          LoadTracks(
            tracks: Track.listFromDocuments(snapshot.docs),
          ),
        );
      });
      yield currentState;
    }
    if (event is LoadTracks) {
      print(event.tracks);
      yield currentState.copyWith(tracks: event.tracks);
    }
  }
}