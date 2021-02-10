import 'package:flutter/material.dart';
import 'package:resap_admin/constant.dart';

class CarouselSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // _gotoLocation(lat,long);
      },
      child: Container(
        margin: EdgeInsets.only(right: kDefaultPadding / 1.5),
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 5.0,
              borderRadius: BorderRadius.circular(15),
              shadowColor: Color(0x802196F3),
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 1.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // TODO: ini profile picture card-nya
                    CircleAvatar(
                      backgroundColor: Colors.grey[700],
                      backgroundImage:
                          AssetImage("assets/images_sample_chat/person7.jpg"),
                    ),
                    // TODO: ini detail card-nya
                    SizedBox(
                      width: 8,
                    ),
                    myDetailsContainer1("Joko Susilo"),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

// TODO: ini detail card-nya
Widget myDetailsContainer1(String restaurantName) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        child: Text(
          restaurantName,
          style: TextStyle(
            color: Color(0xff6200ee),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 5.0),
      Container(
        child: Text(
          "100 stockist",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 8,
          ),
        ),
      ),
      SizedBox(height: 5.0),
      Container(
        child: Text(
          "50 attendance",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
