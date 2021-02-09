import 'package:flutter/material.dart';
import 'package:resap_admin/models/nodestore.dart';
import 'package:resap_admin/modelsfromjson/Stores.dart';
import 'package:resap_admin/screen/components/menucardnode.dart';
import 'package:resap_admin/screen/components/storecarditem.dart';

class ListStores extends StatelessWidget {
  final String contract;
  // final List<NodeStore> nodes;
  final List<Stores> listStores;

  const ListStores(
      {Key key,
      @required this.contract,
      // @required this.nodes,
      @required this.listStores})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: listStores.length,
      itemBuilder: (context, index) {
        Stores store = listStores[index];
        return StoreCardItem(
          contract: contract,
          index: index,
          stores: store,
        );
      },
    ));
  }
}
