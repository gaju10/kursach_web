import 'package:kursach_web/track/model/track.dart';

class TrackState{
  final List<Track> tracks;

  TrackState({this.tracks});

  TrackState copyWith({List<Track> tracks}){
    return TrackState(tracks: tracks ?? this.tracks);
  }
}