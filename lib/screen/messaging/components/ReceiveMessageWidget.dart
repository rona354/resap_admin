import 'package:flutter/material.dart';
import '../../../constant.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final String content;
  final String imageAddress;
  final String time;
  final bool isImage;
  const ReceivedMessageWidget({
    Key key,
    this.content,
    this.time,
    this.isImage,
    this.imageAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          left: kDefaultPadding / 2,
          right: kDefaultPadding * 3,
          top: kDefaultPadding / 4,
          bottom: kDefaultPadding / 3,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    left: kDefaultPadding / 1.75,
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
