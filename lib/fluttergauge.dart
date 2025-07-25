// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gauge/handpainter.dart';
import 'package:flutter_gauge/linepainter.dart';
import 'package:rxdart/rxdart.dart';

import 'flutter_gauge.dart';
import 'gaugetextpainter.dart';

class FlutterGaugeMain extends StatefulWidget {
  int? start;
  int? end;
  double? highlightStart;
  double? highlightEnd;
  String fontFamily;
  double widthCircle;
  double percentage;
  double percentageIndicator;
  PublishSubject<double>? eventObservable;
  Number number;
  CounterAlign counterAlign;
  Hand hand;
  bool isCircle;
  Map? isMark;
  double handSize;
  SecondsMarker secondsMarker;
  double shadowHand;
  Color circleColor;
  Color handColor;
  Color backgroundColor;
  Color indicatorColor;
  double paddingHand;
  double width;
  double? height;
  NumberInAndOut? numberInAndOut;
  TextStyle? titleStyle;
  TextStyle? subtitleStyle;
  EdgeInsets? padding;
  Color? inactiveColor;
  Color? activeColor;
  String titleText;
  String? subtitle;
  Duration? animationDuration;

  FlutterGaugeMain({
    this.inactiveColor,
    this.activeColor,
    this.subtitleStyle,
    this.titleStyle,
    this.numberInAndOut,
    required this.width,
    this.paddingHand = 30.0,
    this.circleColor = Colors.cyan,
    this.handColor = Colors.black,
    this.backgroundColor = Colors.cyan,
    this.indicatorColor = Colors.black,
    this.shadowHand = 4.0,
    this.counterAlign = CounterAlign.bottom,
    this.number = Number.all,
    this.isCircle = true,
    this.hand = Hand.long,
    this.secondsMarker = SecondsMarker.all,
    this.isMark,
    this.handSize = 30,
    this.start,
    this.end,
    this.highlightStart,
    this.highlightEnd,
    this.eventObservable,
    required this.fontFamily,
    required this.widthCircle,
    required this.titleText,
    this.subtitle,
    required this.animationDuration,
    required this.percentage,
    required this.percentageIndicator,
  }) {
    padding = EdgeInsets.all(widthCircle);
    double heigthMultiplier = 1.0;
    if (!this.isCircle) {
      heigthMultiplier = 0.8;
    }
    height = width * heigthMultiplier;
  }

  @override
  _FlutterGaugeMainState createState() => new _FlutterGaugeMainState(
        this.start,
        this.end,
        this.highlightStart,
        this.highlightEnd,
        this.percentage,
        this.percentageIndicator,
        this.animationDuration,
        this.eventObservable,
      );
}

class _FlutterGaugeMainState extends State<FlutterGaugeMain>
    with TickerProviderStateMixin {
  int? start;
  int? end;
  double? highlightStart;
  double? highlightEnd;
  PublishSubject<double>? eventObservable;
  Duration duration = Duration(seconds: 3);
  double? val = 0.0;
  double? valIndicator = 0.0;
  double? newVal;
  double? percentage;
  double? percentageIndicator;
  late AnimationController percentageAnimationController;
  late AnimationController percentageIndicatorAnimationController;
  StreamSubscription<double>? subscription;

  @override
  void dispose() {
    percentageAnimationController.dispose();
    percentageIndicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _FlutterGaugeMainState(
      int? start,
      int? end,
      double? highlightStart,
      double? highlightEnd,
      double? percentage,
      double? percentageIndicator,
      Duration? duration,
      PublishSubject<double>? eventObservable) {
    this.start = start;
    this.end = end;
    this.highlightStart = highlightStart;
    this.highlightEnd = highlightEnd;
    this.eventObservable = eventObservable;
    this.percentage = percentage;
    this.percentageIndicator = percentageIndicator;
    if (duration != null) {
      this.duration = duration;
    }
  }

  @override
  initState() {
    super.initState();
    percentageAnimationController =
        new AnimationController(vsync: this, duration: this.duration)
          ..addListener(() {
            setState(() {
              val = lerpDouble(
                  val, widget.percentage, percentageAnimationController.value);
            });
          });
    percentageIndicatorAnimationController =
        new AnimationController(vsync: this, duration: this.duration)
          ..addListener(() {
            setState(() {
              valIndicator = lerpDouble(
                  valIndicator,
                  widget.percentageIndicator,
                  percentageIndicatorAnimationController.value);
            });
          });
    subscription = this.eventObservable!.listen((value) {
      (value >= this.end!)
          ? reloadData(this.end!.toDouble())
          : reloadData(value);
    });
  }

  reloadData(double value) {
    newVal = widget.percentage;
    this.end = widget.end;
    percentageAnimationController.forward(from: 0.0);
    percentageIndicatorAnimationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return new Container(
          height: widget.height,
          width: widget.width,
          alignment: Alignment.center,
          child: new Stack(fit: StackFit.expand, children: <Widget>[
            widget.isCircle == true
                ? new Container(
                    height: constraints.maxWidth,
                    width: constraints.maxWidth,
                    padding: widget.padding,
                    child: new CustomPaint(
                      foregroundPainter: new LinePainter(
                        lineColor: this.widget.backgroundColor,
                        completeColor: this.widget.circleColor,
                        startValue: this.start,
                        endValue: this.end,
                        startPercent: this.widget.highlightStart,
                        endPercent: this.widget.highlightEnd,
                        width: this.widget.widthCircle,
                        value: this.val,
                        percentage:
                            end! > 100 ? (this.val! / end! * 100) : this.val,
                      ),
                    ),
                  )
                : SizedBox(),
            widget.hand == Hand.none || widget.hand == Hand.short
                ? SizedBox()
                : new Center(
                    child: new Container(
                      width: widget.handSize,
                      height: widget.handSize,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: this.widget.indicatorColor,
                      ),
                    ),
                  ),
            Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              padding: EdgeInsets.only(
                top: widget.hand == Hand.short
                    ? widget.widthCircle
                    : widget.widthCircle,
                bottom: widget.widthCircle,
                right: widget.widthCircle,
                left: widget.widthCircle,
              ),
              child: new CustomPaint(
                  painter: new GaugeTextPainter(
                      numberInAndOut: widget.numberInAndOut,
                      secondsMarker: widget.secondsMarker,
                      number: widget.number,
                      inactiveColor: widget.inactiveColor,
                      activeColor: widget.activeColor!,
                      start: this.start,
                      end: this.end,
                      value: this.val,
                      fontFamily: widget.fontFamily,
                      widthCircle: widget.widthCircle,
                      textStyle: widget.subtitleStyle == null
                          ? TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontFamily: widget.fontFamily)
                          : widget.subtitleStyle)),
            ),
            widget.hand != Hand.none
                ? new Center(
                    child: new Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    padding: EdgeInsets.all(widget.hand == Hand.short
                        ? widget.widthCircle / 1.5
                        : widget.paddingHand),
                    child: new CustomPaint(
                      painter: new HandPainter(
                          shadowHand: widget.shadowHand,
                          hand: widget.hand,
                          value: valIndicator,
                          start: this.start,
                          end: this.end,
                          color: this.widget.handColor,
                          handSize: widget.handSize),
                    ),
                  ))
                : SizedBox(),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: widget.counterAlign != CounterAlign.none
                  ? new CustomPaint(
                      painter: new GaugeTextCounter(
                          start: this.start,
                          width: widget.widthCircle,
                          height: widget.height,
                          widthCircle: widget.widthCircle,
                          counterAlign: widget.counterAlign,
                          end: this.end,
                          title: widget.titleText,
                          subtitle: widget.subtitle,
                          fontFamily: widget.fontFamily,
                          titleStyle: widget.titleStyle == null
                              ? TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  fontFamily: widget.fontFamily)
                              : widget.titleStyle,
                          subtitleStyle: widget.subtitleStyle))
                  : SizedBox(),
            )
          ]),
        );
      }),
    );
  }
}
