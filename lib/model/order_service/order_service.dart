
import 'package:flutter/material.dart';

class OrderService {

  String number;
  String hour;
  String client;
  int status;
  String date;

  OrderService({
    @required this.number,
    @required this.hour,
    @required this.client,
    @required this.status,
    @required this.date
  });

}