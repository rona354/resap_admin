import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/models/message_model.dart';
import 'package:resap_admin/modelsfromjson/Messages.dart';
import 'package:resap_admin/screen/messaging/components/ChatListViewItem.dart';
import 'package:resap_admin/services/ServiceAuthentication.dart';
import 'package:resap_admin/services/ServiceMessaging.dart';
import 'package:resap_admin/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   ScrollController _scrollController;
//   int _counter = 20;
//   Timer _timer;
//   bool isListening = false;
//   TextEditingController _controller;
//   final _formKey = GlobalKey<FormState>();
//   final List<String> errors = [];
//   List<Message> massages = [];
//   List<Messages> lmessages = [];
//   String tokenShared = "";
//   String idAdmin = "0";
//   String messageText;

//   _chatBubbleMessage(Messages message, bool isMe) {
//     // print("############ Message dari server ${isMe}");
//     if (isMe) {
//       return Column(
//         children: [
//           Container(
//             alignment: Alignment.topRight,
//             child: Container(
//               constraints: BoxConstraints(
//                   maxWidth: MediaQuery.of(context).size.width * 0.80),
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey.withOpacity(0.7),
//                         spreadRadius: 2,
//                         blurRadius: 5)
//                   ],
//                   color: Colors.orangeAccent,
//                   borderRadius: BorderRadius.circular(15)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(message.body),
//                   Text(
//                     "${message.datemessage.weekday}/${message.datemessage.month} ${message.datemessage.hour}:${message.datemessage.minute}",
//                     style: TextStyle(fontSize: 8),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       );
//     } else {
//       return Column(
//         children: [
//           Container(
//             alignment: Alignment.topLeft,
//             child: Container(
//               constraints: BoxConstraints(
//                   maxWidth: MediaQuery.of(context).size.width * 0.80),
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(boxShadow: [
//                 BoxShadow(
//                     color: Colors.grey.withOpacity(0.7),
//                     spreadRadius: 2,
//                     blurRadius: 5)
//               ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(message.body),
//                   Text(
//                     "${message.datemessage.weekday}/${message.datemessage.month} ${message.datemessage.hour}:${message.datemessage.minute}",
//                     style: TextStyle(fontSize: 8),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       );
//     }
//   }

//   void _startListening() {
//     _counter = 20;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         isListening = true;
//         if (_counter > 0) {
//           _counter--;
//           print("################ Timer $_counter");
//         } else {
//           isListening = false;
//           // print("################ Reset Timer and fetch $_counter");
//           _timer.cancel();
//           ServiceMessaging.getMessageClientbyToken(tokenShared).then((value) {
//             var _value = value;
//             // print("#################### Message : ${_value.length}");
//             if (_value.length > 0) {
//               setState(() {
//                 lmessages = _value;
//                 // EasyLoading.dismiss();
//                 _startListening();
//               });
//               _scrollController.animateTo(
//                   _scrollController.position.maxScrollExtent,
//                   duration: Duration(milliseconds: 500),
//                   curve: Curves.fastOutSlowIn);
//             }
//           });
//           // _counter = 20;
//         }
//       });
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _scrollController = ScrollController();
//     _controller = new TextEditingController();
//     EasyLoading.instance
//       ..contentPadding = EdgeInsets.all(5)
//       ..maskType = EasyLoadingMaskType.custom
//       ..maskColor = Colors.green
//       ..displayDuration = const Duration(milliseconds: 1000)
//       ..indicatorType = EasyLoadingIndicatorType.circle
//       ..loadingStyle = EasyLoadingStyle.custom
//       ..indicatorSize = 35.0
//       ..backgroundColor = kPrimaryColor
//       ..radius = 100.0
//       ..indicatorColor = Colors.yellow
//       ..textColor = Colors.yellow
//       ..maskColor = Colors.blue.withOpacity(0.5)
//       ..userInteractions = false;
//     EasyLoading.show();
//     getPreferences().then(updateuserprofile);
//     // sleep(const Duration(seconds: 5));
//     print("################ Scroll bawah");
//     // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
//     //     duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     EasyLoading.dismiss();
//     _timer.cancel();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FlutterEasyLoading(
//       child: Padding(
//         padding: const EdgeInsets.all(1.0),
//         child: Column(
//           children: [
//             Expanded(
//                 child: ListView.builder(
//                     controller: _scrollController,
//                     itemCount: this.lmessages.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final Messages messageItem = this.lmessages[index];
//                       final bool isMe =
//                           messageItem.idtowhom == idAdmin ? true : false;
//                       return _chatBubbleMessage(messageItem, isMe);
//                     })),
//             _sendMessageArea()
//           ],
//         ),
//       ),
//     );
//   }

//   TextFormField buildEmailFormField() {
//     return TextFormField(
//         controller: _controller,
//         keyboardType: TextInputType.text,
//         onSaved: (newValue) => messageText = newValue,
//         onChanged: (value) {
//           if (value.isNotEmpty && errors.contains(kNamelocNullError)) {
//             setState(() {
//               errors.remove(kNamelocNullError);
//             });
//           } else if (errors.contains(kNamelocNullError)) {
//             setState(() {
//               errors.remove(kNamelocNullError);
//             });
//           }
//           return null;
//         },
//         validator: (value) {
//           if (value.isEmpty && !errors.contains(kNamelocNullError)) {
//             setState(() {
//               errors.add(kNamelocNullError);
//             });
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//             labelStyle: TextStyle(fontSize: getProportionateScreenWidth(14)),
//             hintText: "Send messages.."));
//   }

//   _sendMessageArea() {
//     return Form(
//       key: _formKey,
//       child: Container(
//         height: 70,
//         color: Colors.white,
//         child: Row(
//           children: [
//             IconButton(
//               icon: Icon(Icons.photo),
//               onPressed: () {},
//               iconSize: 25,
//               color: kPrimaryColor,
//             ),
//             Expanded(
//               child: buildEmailFormField(),
//             ),
//             IconButton(
//               icon: Icon(Icons.send_outlined),
//               onPressed: () {
//                 if (_formKey.currentState.validate()) {
//                   print("################ Error ${errors.length}");
//                   int jmlError = errors.length;
//                   if (jmlError < 1) {
//                     print("################ ${isListening}");
//                     if (isListening) _timer.cancel();
//                     EasyLoading.show();
//                     _formKey.currentState.save();
//                     print("################ Message ${messageText}");
//                     ServiceMessaging.sendTextMessageClientbyToken(
//                             tokenShared, messageText, idAdmin)
//                         .then((value) {
//                       var _value = value;
//                       setState(() {
//                         _controller.clear();
//                         lmessages = _value;
//                         EasyLoading.dismiss();
//                         _startListening();
//                       });
//                       Timer(
//                           Duration(milliseconds: 300),
//                           () => _scrollController.jumpTo(
//                               _scrollController.position.maxScrollExtent));
//                     });
//                   } else {
//                     print("################ Ngga bisa di Error $jmlError");
//                   }
//                 }
//               },
//               iconSize: 25,
//               color: kPrimaryColor,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<String> getPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString("token");
//     // print("Get Userpreference $token");
//     return token;
//   }

//   void updateuserprofile(String token) {
//     setState(() {
//       this.tokenShared = token;
//     });
//     ServiceAuthentication.getAdminByToken(token).then((value) {
//       var _adminValue = value;
//       setState(() {
//         idAdmin = _adminValue.id;
//       });
//       ServiceMessaging.getMessageClientbyToken(tokenShared).then((value) {
//         var _value = value;
//         print("#################### Message by token : ${_value.length}");
//         if (_value.length > 0) {
//           setState(() {
//             lmessages = _value;
//             _startListening();
//           });
//           Timer(
//               Duration(milliseconds: 300),
//               () => _scrollController
//                   .jumpTo(_scrollController.position.maxScrollExtent));
//           print("#################### admin id : ${idAdmin}");
//         }
//         EasyLoading.dismiss();
//       });
//     });
//   }
// }

class BodyChatViewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(15.0),
          //   topRight: Radius.circular(15.0),
          // ),
        ),
        child: ListView(
          children: <Widget>[
            ChatListViewItem(
              hasUnreadMessage: true,
              image: AssetImage('assets/images_sample_chat/person1.jpg'),
              lastMessage:
                  "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
              name: "Bree Jarvis",
              newMesssageCount: 8,
              time: "19:27 PM",
            ),
            ChatListViewItem(
              hasUnreadMessage: true,
              image: AssetImage('assets/images_sample_chat/person2.png'),
              lastMessage:
                  "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
              name: "Alex",
              newMesssageCount: 5,
              time: "19:27 PM",
            ),
            ChatListViewItem(
              hasUnreadMessage: false,
              image: AssetImage('assets/images_sample_chat/person3.jpg'),
              lastMessage:
                  "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
              name: "Carson Sinclair",
              newMesssageCount: 0,
              time: "19:27 PM",
            ),
            // ChatListViewItem(
            //   hasUnreadMessage: false,
            //   image: AssetImage('assets/images/person4.png'),
            //   lastMessage:
            //       "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
            //   name: "Lucian Guerra",
            //   newMesssageCount: 0,
            //   time: "19:27 PM",
            // ),
            // ChatListViewItem(
            //   hasUnreadMessage: false,
            //   image: AssetImage('assets/images/person5.jpg'),
            //   lastMessage:
            //       "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
            //   name: "Sophia-Rose Bush",
            //   newMesssageCount: 0,
            //   time: "19:27 PM",
            // ),
            // ChatListViewItem(
            //   hasUnreadMessage: false,
            //   image: AssetImage('assets/images/person6.jpg'),
            //   lastMessage:
            //       "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
            //   name: "Mohammad",
            //   newMesssageCount: 0,
            //   time: "19:27 PM",
            // ),
            // ChatListViewItem(
            //   hasUnreadMessage: false,
            //   image: AssetImage('assets/images/person7.jpg'),
            //   lastMessage:
            //       "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
            //   name: "Jimi Cooke",
            //   newMesssageCount: 0,
            //   time: "19:27 PM",
            // ),
          ],
        ),
      ),
    );
  }
}
