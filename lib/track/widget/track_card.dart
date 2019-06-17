import 'package:flutter_web/material.dart';
import 'package:kursach_web/track/model/track.dart';

class TrackCard extends StatefulWidget {
  final Track track;

  TrackCard({Key key, this.track}) : super(key: key);

  @override
  _TrackCardState createState() => _TrackCardState();
}

class _TrackCardState extends State<TrackCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      elevation: 0.0,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        widget.track.trackImageUrl,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(child: Text('Training name: ${widget.track.trackName}')),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text('Best score: ${80}')),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text('Training difficult: ${widget.track.difficult}')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
