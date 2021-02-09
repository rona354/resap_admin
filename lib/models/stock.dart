import 'package:flutter/material.dart';

class Stock {
  final String title, description, avatarpath, storename;
  final int idtenant,
      idstock,
      jmlactual,
      jmlbalance,
      jmlsold,
      jmldecreas,
      idstore;
  final double rating, price;
  final bool isFavorite, isPopular;

  Stock( 
      {@required this.title,
      @required this.description,
      @required this.avatarpath,
      @required this.rating,
      @required this.price,
      @required this.isFavorite,
      @required this.isPopular,
      @required this.idtenant,
      @required this.idstock,
      @required this.jmlactual,
      @required this.jmlbalance,
      @required this.jmlsold,
      @required this.jmldecreas,
      @required this.idstore,
      @required this.storename,});
}
