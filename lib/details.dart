import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'widgets/movie_details.dart';
import 'widgets/movie_cast.dart';
import 'widgets/movie_pictures.dart';
import 'widgets/movie_book.dart';
import 'model.dart';

class Details extends StatefulWidget {
  final Movie movie;

  const Details({Key key, this.movie}) : super(key: key);

  @override
  DetailsState createState() {
    return new DetailsState();
  }
}

class DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  Movie movie;
  bool booking = false;
  double posterTop = 170;
  double trailerHeight = 240;
  double containerTop = 220;

  AnimationController _animationController;
  Animation<double> _animationPosition;

  @override
  void initState() {
    super.initState();
    movie = widget.movie;
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    _animationPosition = Tween<double>(begin: -50.0, end: 15.0)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            height: trailerHeight,
            width: double.infinity,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(movie.backdrop),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: booking ? 10.0 : 0.0, sigmaY: booking ? 10.0 : 0.0),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.black.withOpacity(0.1)),
                child: booking
                    ? Container()
                    : Center(
                        child: IconButton(
                          icon: Icon(Icons.play_circle_outline),
                          iconSize: 60.0,
                          color: Colors.white,
                          tooltip: "Play",
                          onPressed: () {
                            FlutterYoutube.playYoutubeVideoByUrl(
                              apiKey: "<YOUR_API_KEY>",
                              videoUrl: "https://www.youtube.com/watch?v=${movie.trailerId}",
                              autoPlay: true,
                              fullScreen: true,
                            );
                          },
                        ),
                      ),
              ),
            ),
          ),
          AnimatedContainer(
            margin: EdgeInsets.only(top: containerTop),
            height: MediaQuery.of(context).size.height - containerTop,
            width: double.infinity,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              color: Colors.white,
            ),
            child: ListView(
              children: <Widget>[
                Hero(
                  tag: movie.backdrop,
                  child: MovieDetails(
                    movie: movie,
                    alignment: Alignment.topRight,
                  ),
                ),
                AnimatedCrossFade(
                  crossFadeState: booking ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 300),
                  firstChild: MovieBook(),
                  secondChild: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                          child: Text(
                            "Story Line",
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          movie.story,
                          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15.0),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                          child: Text(
                            "The cast",
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                      ),
                      MovieCast(
                        cast: movie.cast,
                        showName: true,
                      ),
                      SizedBox(height: 15.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Pictures",
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                      ),
                      MoviePictures(
                        pictures: movie.pictures,
                      ),
                      SizedBox(height: 60.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            left: 20.0,
            top: posterTop,
            duration: Duration(milliseconds: 200),
            child: Hero(
              tag: movie.poster,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: CachedNetworkImageProvider(movie.poster), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: _animationPosition.value,
            left: 10.0,
            right: 10.0,
            child: RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  booking
                      ? Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: booking ? 40.0 : 0.0),
                      child: Text(
                        booking ? "PAY" : "BOOK",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 12.0),
              shape: StadiumBorder(),
              color: Color(0xFF79CB8C),
              onPressed: () {
                setState(() {
                  if (booking) {
                    posterTop = 170;
                    trailerHeight = 240;
                    containerTop = 220;
                  } else {
                    posterTop = 40;
                    trailerHeight = 100;
                    containerTop = 80;
                  }
                  booking = !booking;
                });
                _animationController.forward(from: -50.0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
