import 'package:flutter/material.dart';
import 'package:resap_admin/models/nodestore.dart';
import 'package:resap_admin/screen/components/menucardnode.dart';

class ListNodeWgt extends StatelessWidget {
  final String contract;

  const ListNodeWgt({Key key, this.contract}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AllControlCheckin(contract: this.contract);
  }
}

class AllControlCheckin extends StatefulWidget {
  final String contract;

  const AllControlCheckin({Key key, this.contract}) : super(key: key);
  @override
  _AllControlCheckinState createState() => _AllControlCheckinState();
}

class _AllControlCheckinState extends State<AllControlCheckin> {
  List<NodeStore> nodes;
  String contractwg = "234234234234234";
  @override
  void initState() {
    super.initState();
    print("Initial List Node.... ");
    getAllNodes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: nodes.length,
      itemBuilder: (context, index) {
        NodeStore nodestore = nodes[index];
        return MenuCardNode(
          index: nodestore.idnode,
          nodename: nodestore.nodename,
          nodeaddress: nodestore.address,
          nodedistance: nodestore.ndistance,
          latitude: nodestore.latitude,
          longitude: nodestore.longitude,
          contract: "TAI",
          avatarpath: null,
        );
      },
    ));
  }

  getAllNodes() {
    print("################## dapet dari atas " + widget.contract);
    setState(() {
      nodes = liststores;

      // contractwg = widget.contract;
    });
  }
}
