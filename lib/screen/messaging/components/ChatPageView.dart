import 'package:flutter/material.dart';
import 'package:resap_admin/constant.dart';

import 'ReceiveMessageWidget.dart';
import 'SendedMessageWidget.dart';

class ChatPageView extends StatefulWidget {
  final String username;

  const ChatPageView({
    Key key,
    this.username,
  }) : super(key: key);

  @override
  _ChatPageViewState createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  TextEditingController _text = new TextEditingController();
  ScrollController _scrollController = ScrollController();
  var childList = <Widget>[];

  @override
  void initState() {
    super.initState();
    childList.add(Align(
        alignment: Alignment(0, 0),
        child: Container(
          margin: const EdgeInsets.only(top: 5.0),
          height: 25,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              )),
          child: Center(
              child: Text(
            "Today",
            style: TextStyle(fontSize: 11),
          )),
        )));
    childList.add(Align(
      alignment: Alignment(1, 0),
      child: SendedMessageWidget(
        content: 'Hello',
        time: '21:36 PM',
        isImage: false,
      ),
    ));
    childList.add(Align(
      alignment: Alignment(1, 0),
      child: SendedMessageWidget(
        content: 'How are you? What are you doing?',
        time: '21:36 PM',
        isImage: false,
      ),
    ));
    childList.add(Align(
      alignment: Alignment(-1, 0),
      child: ReceivedMessageWidget(
        content: 'Hello, Mohammad.I am fine. How are you?',
        time: '22:40 PM',
        isImage: false,
      ),
    ));
    childList.add(Align(
      alignment: Alignment(1, 0),
      child: SendedMessageWidget(
        content:
            'I am good. Can you do something for me? I need your help my bro.',
        time: '22:40 PM',
        isImage: false,
      ),
    ));
    childList.add(Align(
      alignment: Alignment(-1, 0),
      child: ReceivedMessageWidget(
        content: 'this is fun 😂',
        time: '22:57 PM',
        isImage: true,
        imageAddress: 'assets/images_sample_chat/fun.jpg',
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
              contentPadding: EdgeInsets.all(0),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.grey[200],
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                      child: Container(
                        color: Colors.grey[50],
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.grey[700],
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget.username ?? "Jimi Cooke",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 16),
                                ),
                                Text(
                                  "online".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 10),
                                ),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                              child: Container(
                                child: ClipRRect(
                                  child: Container(
                                      child: SizedBox(
                                        child: Image.asset(
                                          "assets/images_sample_chat/person1.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      color: Colors.orange),
                                  borderRadius: new BorderRadius.circular(50),
                                ),
                                height: 55,
                                width: 55,
                                padding: const EdgeInsets.all(0.0),
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //       color: Colors.black26,
                                  //       blurRadius: 5.0,
                                  //       spreadRadius: -1,
                                  //       offset: Offset(0.0, 5.0))
                                  // ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Divider(
                    //   height: 0,
                    //   color: Colors.black54,
                    // ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                            controller: _scrollController,
                            // reverse: true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: childList,
                            )),
                      ),
                    ),
                    // Divider(height: 0, color: Colors.black26),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 8,
                      ),
                      height: 60,
                      // color: Colors.white,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.photo),
                            iconSize: 25,
                            color: Colors.grey,
                            onPressed: () {},
                          ),
                          Expanded(
                            child: TextField(
                              controller: _text,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                hintText: "Send a message...",
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            iconSize: 25,
                            color: kPrimaryColor,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
