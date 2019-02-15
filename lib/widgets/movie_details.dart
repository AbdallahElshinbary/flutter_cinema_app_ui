import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../model.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;
  final Alignment alignment;

  const MovieDetails({Key key, this.movie, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 180.0,
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        alignment: alignment,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              movie.title,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SmoothStarRating(
                  rating: movie.rating / 2,
                  color: Color(0xFFFECD4D),
                  borderColor: Colors.grey[300],
                ),
                SizedBox(width: 10.0),
                Text(
                  "${movie.rating}",
                  style: TextStyle(color: Colors.yellow[600], fontSize: 20.0),
                ),
              ],
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.watch_later, color: Colors.grey[700]),
                SizedBox(width: 5.0),
                Text("${movie.duration} min", style: TextStyle(color: Colors.grey[800])),
                SizedBox(width: 25.0),
                Icon(Icons.date_range, color: Colors.grey[700]),
                SizedBox(width: 5.0),
                Text("Mar 23, 2019", style: TextStyle(color: Colors.grey[800])),
              ],
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 15.0,
              children: movie.geners
                  .map(
                    (item) => Chip(
                          label: Text(
                            item,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green[400],
                        ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
