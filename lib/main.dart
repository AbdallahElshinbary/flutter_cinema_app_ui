import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'model.dart';
import 'details.dart';
import 'widgets/movie_details.dart';
import 'widgets/movie_cast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cinema App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int index = 0;

  AnimationController _animationController;
  Animation<double> _animationOpacity;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400))
      ..addListener(() {
        setState(() {});
      });

    _animationOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(movies[index].poster),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.white.withOpacity(0.1)),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: Container(
              width: 350,
              height: MediaQuery.of(context).size.height / 1.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Opacity(
                opacity: _animationOpacity.value,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 130.0,),
                    Hero(
                      tag: movies[index].backdrop,
                      child: MovieDetails(
                        movie: movies[index],
                        alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    MovieCast(
                      cast: movies[index].cast,
                      showName: false,
                    ),
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                          return Details(movie: movies[index]);
                        }));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            height: MediaQuery.of(context).size.height / 1.7,
            child: Swiper(
              onIndexChanged: (idx) {
                setState(() {
                  index = idx;
                  _animationController.forward(from: 0.0);
                });
              },
              itemCount: 3,
              viewportFraction: 0.8,
              itemBuilder: (BuildContext context, int index) {
                return Hero(
                  tag: movies[index].poster,
                  child: Container(
                    margin: EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image:
                          DecorationImage(image: CachedNetworkImageProvider(movies[index].poster), fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 5.0),
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
