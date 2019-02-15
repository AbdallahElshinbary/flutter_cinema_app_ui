import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieCast extends StatelessWidget {
  final List<Map<String, String>> cast;
  final bool showName;

  const MovieCast({Key key, this.cast, this.showName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: showName ? 100 : 60,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200.0),
                  child: CachedNetworkImage(
                    imageUrl: cast[index].values.elementAt(0),
                    fadeInCurve: Curves.easeIn,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Visibility(
                visible: showName,
                child: Text(cast[index].keys.elementAt(0), textAlign: TextAlign.center,),
              ),
            ],
          );
        },
      ),
    );
  }
}
