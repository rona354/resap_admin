// import 'package:flutter/material.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/screen/messaging/components/body.dart';

import 'package:flutter/material.dart';
// import 'package:simple_chat_application/Global/Colors.dart' as MyColors;
// import 'package:simple_chat_application/Widget/ChatListViewItem.dart';
// import 'package:simple_chat_application/Widget/Loading.dart';
// import 'package:simple_chat_application/Global/Settings.dart' as Settings;

class MessagingScreen extends StatelessWidget {
  static String routeName = "/messagingscreen";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          // elevation: 0,
          // centerTitle: true,
          elevation: 2,
          // iconTheme: IconThemeData(
          //   color: Colors.white,
          // ),
          // title: Text(
          //   'chats',
          //   style: TextStyle(color: Colors.white, fontSize: 18),
          // ),
          title: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(children: [
              TextSpan(
                  text: "Supervisor\n",
                  style: TextStyle(color: Colors.black54, fontSize: 16)),
              TextSpan(
                  text: "Online",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 11,
                  )),
            ]),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BodyChatViewList(),
      ),
    );
  }
}

// class MessagingScreen extends StatelessWidget {
//   static String routeName = "/messagingscreen";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF6F6F6),
//       appBar: AppBar(
//         brightness: Brightness.dark,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: RichText(
//           textAlign: TextAlign.center,
//           text: TextSpan(children: [
//             TextSpan(
//                 text: "Supervisor\n",
//                 style: TextStyle(color: Colors.black45, fontSize: 16)),
//             TextSpan(
//                 text: "Online",
//                 style: TextStyle(color: Colors.black45, fontSize: 11)),
//           ]),
//         ),
//         centerTitle: true,
//         elevation: 2,
//       ),
//       body: Body(),
//     );
//   }
// }
