

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedFloatingActionButton extends StatefulWidget {

  final FloatingActionButton child;
  final Color color1;
  final Color color2;

  AnimatedFloatingActionButton({this.child,this.color1,this.color2});

  @override
  AnimatedFloatingActionButtonState createState() {
    return AnimatedFloatingActionButtonState();
  }


}

class AnimatedFloatingActionButtonState extends State<AnimatedFloatingActionButton> with TickerProviderStateMixin{

  double percentage = 0.0;
  double newPercentage = 0.0;
  AnimationController percentageAnimationController;


  @override
  void initState() {
    super.initState();
    setState(() {
      percentage = 0.0;
    });
    percentageAnimationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 1000)
    )
      ..addListener((){
        setState(() {
          percentage = lerpDouble(percentage,newPercentage,percentageAnimationController.value);
        });
      });


  }
  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
          foregroundPainter: new CircularPainter(
              lineColor: widget.color1,
              completeColor: widget.color2,
              completePercent: percentage,
              width: 3.0
          ),
          child: new Padding(
            padding: const EdgeInsets.all(2.0),
            child: widget.child
          ),
      );
  }




}



class CircularPainter extends CustomPainter{
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  CircularPainter({this.lineColor,this.completeColor,this.completePercent,this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center  = new Offset(size.width/2, size.height/2);
    double radius  = min(size.width/2,size.height/2);

    RRect rrect =  RRect.fromRectAndCorners(Rect.fromCenter(center: center,width: size.width,height: size.height),topLeft: Radius.circular(30),
        topRight: Radius.circular(30),bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30));

    canvas.drawRRect(
        rrect,
        line
    );
    double arcAngle = 2*pi* (completePercent/100);


    canvas.drawArc(
        new Rect.fromCircle(center: center,radius: radius),
        -pi/2,
        arcAngle,
        false,
        complete
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}