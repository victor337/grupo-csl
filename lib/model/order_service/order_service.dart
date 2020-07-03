
import 'package:flutter/material.dart';
import 'package:grupocsl/model/adress/adress_model.dart';

class OrderService {

  String number;
  String value;
  String hour;
  String client;
  int status;
  String date;
  bool paid;
  String type;
  String tel;
  String phone;
  Adress adress;
  String observation;
  bool parceled;



  OrderService({
    @required this.number,
    @required this.hour,
    @required this.client,
    @required this.status,
    @required this.date,
    @required this.paid,
    @required this.type,
    @required this.tel,
    @required this.phone,
    @required this.adress,
    @required this.observation,
    @required this.parceled,
    @required this.value,
  });

}