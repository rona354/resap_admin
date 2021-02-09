import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resap_admin/modelsfromjson/Stores.dart';
import 'package:resap_admin/screen/checkin_detail/check_in_detail_screen.dart';
import 'package:resap_admin/size_config.dart';

class StoreCardItem extends StatelessWidget {
  final int index;
  final Stores stores;
  final String contract;

  const StoreCardItem(
      {Key key,
      @required this.stores,
      @required this.index,
      @required this.contract})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 15),
      child: AspectRatio(
        aspectRatio: 5 / 1,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200, width: 1.0))),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 2 / 2,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(10)),
                  child: Image.network(
                    stores.absolutepath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              AspectRatio(
                aspectRatio: 9 / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stores.locname,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      stores.fulladdress,
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Text(
                      "Dist : ${(stores.distance).toStringAsFixed(2)} Km",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => CheckInDetailScreen(
                                contract: contract,
                                args: stores,
                              )));
                },
                icon: Icon(
                  Icons.check_circle_outline_outlined,
                  color: Colors.green,
                  size: 28,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
