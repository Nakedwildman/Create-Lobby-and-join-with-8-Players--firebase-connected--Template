import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:core';

enum CardSide { FrontSide, BackSide }

typedef TapCallback = void Function(CardSide side);

class FlipCard extends StatefulWidget {
  FlipCard(
      {Key ?key,
        required this.frontImage,
        required this.backImage,
        this.radius = 12,
        this.side = CardSide.FrontSide,
        required this.onTap})
      : super(key: key);
  final Image frontImage;
  final Image backImage;
  final double radius;
  final CardSide side;
  final TapCallback onTap;

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  late CardSide _currentSide;

  @override
  void initState() {
    super.initState();

    _currentSide = widget.side;
    _animationController = AnimationController(
        value: widget.side == CardSide.FrontSide ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 350),
        vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _currentSide = CardSide.BackSide;
        } else if (status == AnimationStatus.completed) {
          _currentSide = CardSide.FrontSide;
        }
      });
  }

  @override
  void didUpdateWidget(FlipCard oldWidget) {
    if (widget.side != _currentSide) {
      flip();
    }
    super.didUpdateWidget(oldWidget);
  }

  void flip() {
    if (_animationStatus == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  double shadowFactor() {
    return cos(_animationController.value * pi).abs();
  }

  double distanceFactor() {
    return 1 - shadowFactor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 200,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(
                  0, 0, 0, (-0.3 + 0.90 * shadowFactor()).clamp(0.0, 1.0)),
              blurRadius: 5 + 15 * distanceFactor(),
              spreadRadius: -1 - 30 * distanceFactor(),
              offset:
              Offset(1 + 15 * distanceFactor(), 3 + 15 * distanceFactor()))
        ],
      ),
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0007)
          ..rotateY(_animationController.value < 0.5
              ? pi * _animationController.value
              : pi + pi * _animationController.value),
        child: GestureDetector(
          onTap: () => widget.onTap(_currentSide),
          child: _animationController.value <= 0.5
              ? ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius),
              child: widget.backImage)
              : ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius),
              child: widget.frontImage),
        ),
      ),
    );
  }
}