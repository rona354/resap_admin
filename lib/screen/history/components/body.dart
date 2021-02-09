import 'package:flutter/material.dart';
import 'package:resap_admin/models/history_step_model.dart';
import 'package:resap_admin/screen/history/components/listhistories.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<HistoryStepModel> histories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(">>>>>>>>>>>> Initial History Page");
    setState(() {
      histories = [
        HistoryStepModel(
          name: "Login",
          time: "08:30:00",
          isFinished: true,
          number: 1,
          shortDescription: "Accepted",
          longDescription: "Login Application",
        ),
        HistoryStepModel(
          name: "Reveral Request",
          time: "08:31:00",
          isFinished: true,
          number: 2,
          shortDescription: "Contract Accepted",
          longDescription: "Request Reveral",
        ),
        HistoryStepModel(
          name: "Tagging",
          time: "08:33:00",
          isFinished: true,
          number: 3,
          shortDescription: "Tagging New Location",
          longDescription: "Tagging Success",
        ),
        HistoryStepModel(
          name: "Tagging",
          time: "08:34:00",
          isFinished: true,
          number: 4,
          shortDescription: "Tagging New Location",
          longDescription: "Tagging Success",
        ),
        HistoryStepModel(
          name: "Tagging",
          time: "08:35:00",
          isFinished: true,
          number: 5,
          shortDescription: "Tagging New Location",
          longDescription: "Tagging Success",
        ),
        HistoryStepModel(
          name: "Tagging",
          time: "09:33:00",
          isFinished: false,
          number: 6,
          shortDescription: "Tagging New Location",
          longDescription: "Tagging Success",
        ),
      ];
    });
  }

  String searchString;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [new Expanded(child: ListHistories(hitories: this.histories))],
    );
  }
}
