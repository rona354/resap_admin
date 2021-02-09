import 'package:flutter/material.dart';

class NodeStoreInfo {
  final int idnode;
  final String nodename,
      address,
      latitude,
      longitude,
      avatarpath,
      ndistance,
      contract;

  NodeStoreInfo(
      {@required this.idnode,
      @required this.nodename,
      @required this.address,
      @required this.latitude,
      @required this.longitude,
      @required this.avatarpath,
      @required this.ndistance,
      @required this.contract});
}
