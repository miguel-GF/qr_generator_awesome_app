import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_assets.dart';

class LottieWidget extends StatefulWidget {
  const LottieWidget({
    super.key,
    this.urlAsset,
    this.seconds = 2,
    this.numberRepeat = 2,
  });
  final String? urlAsset;
  final int seconds;
  final int numberRepeat;

  @override
  State<LottieWidget> createState() => _LottieWidgetState();
}

class _LottieWidgetState extends State<LottieWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _countRepeat = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.seconds),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _countRepeat++;
          if (_countRepeat < widget.numberRepeat) {
            _controller.reset();
            _controller.forward();
          }
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.urlAsset ?? AppAssets.animationSuccess,
      controller: _controller,
    );
  }
}
