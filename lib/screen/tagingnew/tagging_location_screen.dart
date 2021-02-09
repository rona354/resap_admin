import 'package:flutter/material.dart';
import 'package:resap_admin/screen/tagingnew/components/body.dart';

// class TaggingLocationScreen extends StatelessWidget {
//   static String routeName = "/tagginglocation";
//   @override
//   Widget build(BuildContext context) {
// return Scaffold(
//   appBar: AppBar(
//     title: Text("Tagging Location"),
//     centerTitle: true,
//   ),
//   body: Body(),
// );
//   }
// }
class TaggingLocationScreen extends StatefulWidget {
  static String routeName = "/tagginglocation";
  @override
  _TaggingLocationScreenState createState() => _TaggingLocationScreenState();
}

class _TaggingLocationScreenState extends State<TaggingLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Tagging Location"),
        centerTitle: true,
      ),
      body: Body(
        contract: "TEST",
      ),
    );
  }
}
