import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../size_config.dart';

class StatusJobs extends StatelessWidget {
  const StatusJobs({
    Key key,
    @required this.greating,
    @required this.userfullname,
    @required this.jobstatus,
    @required this.contract,
  }) : super(key: key);
  final String greating;
  final String userfullname;
  final bool jobstatus;
  final String contract;
  @override
  Widget build(BuildContext context) {
    return formPanel(greating, userfullname, jobstatus, contract);
  }
}

class formPanel extends StatefulWidget {
  final String greating;
  final String userfullname;
  final bool jobstatus;
  final String contract;

  formPanel(this.greating, this.userfullname, this.jobstatus, this.contract);

  @override
  _formPanelState createState() =>
      new _formPanelState(greating, userfullname, jobstatus, contract);
}

class _formPanelState extends State<formPanel> {
  String greating;
  String userfullname;
  bool jobstatus;
  String contract;

  _formPanelState(
      String greeting, String userfullname, bool jobstatus, String contract) {
    this.greating = greeting;
    this.userfullname = userfullname;
    this.jobstatus = jobstatus;
    this.contract = contract;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(15)),
        width: double.infinity,
        // height: 90,
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(greating,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text(userfullname,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(this.contract,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent)),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    print("Change State now");
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  color: kPrimaryColor,
                  child: Container(
                    padding: EdgeInsets.all(1.0),
                    child: const Text('Rra1l', style: TextStyle(fontSize: 16)),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
