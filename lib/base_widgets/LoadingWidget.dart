import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stroktrail/resources/resources.dart';

final Widget loadingWidget = Container(
  decoration: BoxDecoration(color: const Color(0x80969696), borderRadius: BorderRadius.circular(20)),
  child: Lottie.asset(
    loadingLottie,
    width: 100,
    height: 100
  ),
);
