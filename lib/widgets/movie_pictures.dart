import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MoviePictures extends StatelessWidget {
  final List<String> pictures;

  const MoviePictures({Key key, this.pictures}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(16.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pictures.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: pictures[index],
                fadeInCurve: Curves.easeIn,
              ),
            ),
          );
        },
      ),
    );
  }
}
