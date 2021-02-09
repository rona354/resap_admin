import 'package:flutter/material.dart';
import 'package:resap_admin/models/history_step_model.dart';
import 'package:resap_admin/screen/components/historycardlist.dart';

class ListHistories extends StatelessWidget {
  final List<HistoryStepModel> hitories;
  const ListHistories({Key key, @required this.hitories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
          itemCount: this.hitories.length,
          itemBuilder: (context, index) {
            HistoryStepModel historyStepModel = hitories[index];
            return HistoryCardList(
              index: index,
              name: historyStepModel.name,
              isFinished: historyStepModel.isFinished,
              longDescription: historyStepModel.longDescription,
              shortDescription: historyStepModel.shortDescription,
              time: historyStepModel.time,
            );
          }),
    );
  }
}
