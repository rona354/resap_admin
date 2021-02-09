import 'dart:ui';

import 'package:flutter/material.dart';

class HistoryCardList extends StatelessWidget {
  final int index;
  final String name;
  final String shortDescription;
  final String longDescription;
  final String time;
  final int number;
  final bool isFinished;
  const HistoryCardList(
      {Key key,
      @required this.index,
      this.name,
      this.shortDescription,
      this.longDescription,
      this.time,
      this.number,
      this.isFinished})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(this.name),
            subtitle: Text('Action on - ${this.time}'),
            trailing: Checkbox(
              value: this.isFinished,
              tristate: true,
            ),
          ),
          Divider(
            height: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text(
              "Feedback",
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(this.shortDescription),
          )
        ],
      ),
    );
  }
}
