import 'package:flutter/material.dart';

class HistoryStepModel {
  final String name, shortDescription, longDescription, time;
  final int number;
  final bool isFinished;
  HistoryStepModel(
      {@required this.name,
      @required this.shortDescription,
      @required this.longDescription,
      @required this.time,
      @required this.number,
      @required this.isFinished});
}
