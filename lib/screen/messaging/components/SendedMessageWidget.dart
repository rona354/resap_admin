import 'package:flutter/material.dart';
import '../../../constant.dart';

class SendedMessageWidget extends StatelessWidget {
  final String content;
  final String imageAddress;
  final String time;
  final bool isImage;
  const SendedMessageWidget({
    Key key,
    this.content,
    this.time,
    this.imageAddress,
    this.isImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          right: kDefaultPadding / 2,
          left: kDefaultPadding * 3,
          top: kDefaultPadding / 4,
          bottom: kDefaultPadding / 3,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Container(
            color: Colors.orange[100],
            // margin: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                !isImage
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding / 1.75,
                          vertical: kDefaultPadding / 3,
                        ),
                        child: Text(
                          content,
                          style: TextStyle(color: Colors.black87),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding / 1.75,
                          vertical: kDefaultPadding / 3,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              child: Image.asset(
                                imageAddress,
                                height: 130,
                                width: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              content,
                              style: TextStyle(color: Colors.black87),
                            )
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: kDefaultPadding / 4,
                    right: kDefaultPadding / 1.75,
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
