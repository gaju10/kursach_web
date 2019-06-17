import 'package:kursach_web/track/model/track.dart';

abstract class TrackEvent{}

class InitBloc extends TrackEvent{

}
class LoadTracks extends TrackEvent{
  final List<Track> tracks;

  LoadTracks({this.tracks});
}