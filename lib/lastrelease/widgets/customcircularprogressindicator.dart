

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:win/lastrelease/costanti/coloriestili.dart';

class CustomCircularProgressIndicator extends CustomPainter {

  //
  Color defaultCircleColor;
  Color percentageCompletedCircleColor;
  double completedPercentage;
  double circleWidth;

  CustomCircularProgressIndicator(
      {this.defaultCircleColor,
        this.percentageCompletedCircleColor,
        this.completedPercentage,
        this.circleWidth});

  getPaint(Color color) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultCirclePaint = getPaint(defaultCircleColor);
    Paint progressCirclePaint = getPaint(percentageCompletedCircleColor);

    Offset center = Offset(size.width / 4, size.height / 2);

    Offset center2 = Offset(size.width*3 / 4, size.height / 2);
    double radius = min(size.width / 3.5, size.height / 3.5);
    double arcAngle = 2 * pi * (completedPercentage / 100);
 //   canvas.drawCircle(center, radius, defaultCirclePaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 2,
        arcAngle, false, defaultCirclePaint);


    canvas.drawArc(Rect.fromCircle(center: center2, radius: radius), -pi / 2,
        arcAngle, false, progressCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }

}


class WinIndicator extends StatefulWidget{
  @override
  WinIndicatorState createState() {
     return WinIndicatorState();
  }

}


class WinIndicatorState extends State<WinIndicator> with SingleTickerProviderStateMixin {
  //
  double _percentage;
  double _nextPercentage;
  Timer _timer;
  AnimationController _progressAnimationController;
  bool _progressDone;

  @override
  initState() {
    super.initState();
    _percentage = 0.0;
    _nextPercentage = 0.0;
    _timer = null;
    _progressDone = false;
    initAnimationController();
    startProgress();
  }




  initAnimationController() {
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..addListener(
          () {
        setState(() {
          _percentage = lerpDouble(_percentage, _nextPercentage,
              _progressAnimationController.value);
        });
      },
    );
  }

  start() {
    Timer.periodic(Duration(milliseconds: 5), handleTicker);
  }

  handleTicker(Timer timer) {
    _timer = timer;
    if (_nextPercentage < 100) {
      publishProgress();
    } else if(_nextPercentage >= 100){
      _nextPercentage = 0;
      publishProgress();
    }else if(_progressDone){
      timer.cancel();
    }
  }

  startProgress() {
    if (null != _timer && _timer.isActive) {
      _timer.cancel();
    }
    setState(() {
      _percentage = 0.0;
      _nextPercentage = 0.0;
      _progressDone = false;
      start();
    });
  }

  publishProgress() {
    setState(() {
      _percentage = _nextPercentage;
      _nextPercentage += 0.5;
      if (_nextPercentage > 100.0) {
        _percentage = 0.0;
        _nextPercentage = 0.0;
      }
      _progressAnimationController.forward(from: 0.0);
    });
  }

  getDoneImage() {
    return Image.asset(
      "logowinb.png",
      width: 50,
      height: 50,
    );
  }

  getProgressText() {
    return Text(
      _nextPercentage == 0 ? '' : '${_nextPercentage.toInt()}',
      style: TextStyle(
          fontSize: 40, fontWeight: FontWeight.w800, color: Colors.green),
    );
  }

  progressView() {
    return CustomPaint(
      child: Center(
      //  child: _progressDone ? getDoneImage() : getProgressText(),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.01)),

        )
      ),
      foregroundPainter: CustomCircularProgressIndicator(
          defaultCircleColor: azzurrochiaro,
          percentageCompletedCircleColor: azzurroscuro,
          completedPercentage: _percentage,
          circleWidth: 10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.01)),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300.0,
              width: 300.0,
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(30.0),
              child: progressView(),
            ),
          ],
        ),
      );
  }


  @override
  void dispose() {
    _progressDone = true;
    _timer.cancel();
    _progressAnimationController.dispose();
    super.dispose();
  }

}