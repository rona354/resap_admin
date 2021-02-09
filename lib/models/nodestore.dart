import 'package:flutter/material.dart';

class NodeStore {
  final int idnode;
  final String nodename, address, latitude, longitude, avatarpath, ndistance;

  NodeStore(
      {@required this.idnode,
      @required this.nodename,
      @required this.address,
      @required this.latitude,
      @required this.longitude,
      @required this.avatarpath,
      @required this.ndistance});
}

List<NodeStore> liststores = [
  NodeStore(
      idnode: 1,
      nodename: "Alfa 1 Cikeas",
      address: "Cikeas 01",
      latitude: "-6.3822648",
      longitude: "106.9374824",
      avatarpath: "https://resap.kmselaras.com/images/stores/SAT.png",
      ndistance: "1.2 Km"),
  NodeStore(
      idnode: 2,
      nodename: "Indomart 1 Cikeas",
      address: "Cikeas 02",
      latitude: "-6.382264799999999",
      longitude: "106.93748239999998",
      avatarpath: "https://resap.kmselaras.com/images/stores/IDM.png",
      ndistance: "1.2 Km"),
  NodeStore(
      idnode: 3,
      nodename: "Mall 2 Cibubur City",
      address: "C Cit 01",
      latitude: "-6.3822661",
      longitude: "106.9374809",
      avatarpath: "https://resap.kmselaras.com/images/stores/Pepito.png",
      ndistance: "1.2 Km"),
  NodeStore(
      idnode: 4,
      nodename: "Mall 3 Cibubur City",
      address: "C Cit 02",
      latitude: "-6.3822661",
      longitude: "106.9374809",
      avatarpath: "https://resap.kmselaras.com/images/stores/Pepito.png",
      ndistance: "1.2 Km"),
  NodeStore(
      idnode: 5,
      nodename: "Mall 4 Cibubur City",
      address: "C Cit 03",
      latitude: "-6.3822661",
      longitude: "106.9374809",
      avatarpath: "https://resap.kmselaras.com/images/stores/Pepito.png",
      ndistance: "1.2 Km"),
  NodeStore(
      idnode: 6,
      nodename: "Mall 5 Cibubur City",
      address: "C Cit 04",
      latitude: "-6.3822661",
      longitude: "106.9374809",
      avatarpath: "https://resap.kmselaras.com/images/stores/Pepito.png",
      ndistance: "1.2 Km"),
  NodeStore(
      idnode: 7,
      nodename: "Mall 6 Cibubur City",
      address: "C Cit 05",
      latitude: "-6.3822661",
      longitude: "106.9374809",
      avatarpath: "https://resap.kmselaras.com/images/stores/Pepito.png",
      ndistance: "1.2 Km"),
  NodeStore(
      idnode: 8,
      nodename: "Mall 7 Cibubur City",
      address: "C Cit 06",
      latitude: "-6.3822661",
      longitude: "106.9374809",
      avatarpath: "https://resap.kmselaras.com/images/stores/Pepito.png",
      ndistance: "1.2 Km"),
  NodeStore(
      idnode: 9,
      nodename: "Mall 8 Cibubur City",
      address: "C Cit 07",
      latitude: "-6.3822661",
      longitude: "106.9374809",
      avatarpath: "https://resap.kmselaras.com/images/stores/Pepito.png",
      ndistance: "1.2 Km"),
  NodeStore(
      idnode: 10,
      nodename: "Mall 9 Cibubur City",
      address: "C Cit 08",
      latitude: "-6.3822661",
      longitude: "106.9374809",
      avatarpath: "https://resap.kmselaras.com/images/stores/Pepito.png",
      ndistance: "1.2 Km"),
  NodeStore(
      idnode: 11,
      nodename: "Mall 10 Cibubur City",
      address: "C Cit 05",
      latitude: "-6.3822661",
      longitude: "106.9374809",
      avatarpath: "https://resap.kmselaras.com/images/stores/Pepito.png",
      ndistance: "1.2 Km"),
  NodeStore(
      idnode: 12,
      nodename: "Mall 11 Cibubur City",
      address: "C Cit 05",
      latitude: "-6.3822661",
      longitude: "106.9374809",
      avatarpath: "https://resap.kmselaras.com/images/stores/Pepito.png",
      ndistance: "1.2 Km"),
];
