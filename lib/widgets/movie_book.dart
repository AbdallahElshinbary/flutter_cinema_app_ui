import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovieBook extends StatefulWidget {
  @override
  _MovieBookState createState() => _MovieBookState();
}

class _MovieBookState extends State<MovieBook> with SingleTickerProviderStateMixin {
  var chairs = [
    [0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0],
    [0, 0, 1, 1, 3, 3, 3, 0, 0, 0, 0],
    [0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
    [1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
  ];

  int amount = 0;

  //#####################################################################################################################//

  Widget _buildSquare(int i, int j) {
    Color color;
    if (chairs[i][j] == 0)
      color = Color(0xAADDDDDD);
    else if (chairs[i][j] == 1)
      color = Color(0xFF52555D);
    else if (chairs[i][j] == 2)
      color = Color(0xFF6EBF8D);
    else if (chairs[i][j] == 3) color = Colors.transparent;

    return InkWell(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        width: 23,
        height: 23,
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onTap: chairs[i][j] == 1 || chairs[i][j] == 3
          ? null
          : () {
              if (chairs[i][j] == 1) return;
              setState(() {
                if (chairs[i][j] == 0)
                  amount++;
                else
                  amount--;
                chairs[i][j] = 2 - chairs[i][j];
              });
            },
    );
  }

  //#####################################################################################################################//

  Widget _buildRow(int i) {
    List<Widget> children = [];

    int offset = 1;
    for (int j = 0; j < 14; j++) {
      if (j == 0) {
        children.add(
          Padding(
            padding: EdgeInsets.only(right: 3),
            child: Text(
              String.fromCharCode("A".codeUnitAt(0) + i),
              style: TextStyle(color: Colors.grey),
              textScaleFactor: 1.1,
            ),
          ),
        );
      } else if (j == 5 || j == 9) {
        offset++;
        children.add(SizedBox(
          width: 15.0,
        ));
        continue;
      } else
        children.add(_buildSquare(i, j - offset));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  //#####################################################################################################################//

  Widget _buildTitle(Color color, String text) {
    return Row(
      children: <Widget>[
        Container(
          width: 25,
          height: 25,
          margin: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        SizedBox(width: 5),
        Text(text),
      ],
    );
  }

  //#####################################################################################################################//

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    //#####################################################################################################################//

    children.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildTitle(Color(0xAADDDDDD), "Available"),
          _buildTitle(Color(0xFF52555D), "Booked"),
          _buildTitle(Color(0xFF6EBF8D), "Your Seats"),
        ],
      ),
    );
    children.add(SizedBox(height: 20.0));
    children.add(
      CustomPaint(
        painter: MyPainter(),
        child: Container(
          width: double.infinity,
          height: 50.0,
        ),
      ),
    );

    //#####################################################################################################################//

    int offset = 0;
    for (int i = 0; i < 9; i++) {
      if (i == 4) {
        offset++;
        children.add(
          SizedBox(height: 10.0),
        );
        continue;
      }
      children.add(_buildRow(i - offset));
    }
    children.add(SizedBox(height: 15.0));

    //#####################################################################################################################//

    children.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 23),
              Icon(FontAwesomeIcons.ticketAlt, color: Color(0xFF4D5257), size: 27.0),
              Text("  x $amount", style: TextStyle(color: Color(0xFF4D5257), fontSize: 20.0)),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text("\$ ${amount*12}", style: TextStyle(color: Color(0xFF4D5257), fontSize: 20.0))),
        ],
      ),
    );
    children.add(SizedBox(height: 100.0));

    //#####################################################################################################################//

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}

//#####################################################################################################################//

class MyPainter extends CustomPainter {
  final painter = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.green
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 4.0;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height), -pi + 0.4, pi - 0.8, false, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
