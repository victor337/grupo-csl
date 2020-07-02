
import 'package:flutter/material.dart';

class Adress {

  String street;
  int number;
  String complement;
  String neighborhood;
  String city;
  String state;

  Adress({
    @required this.street,
    @required this.number,
    this.complement,
    @required this.neighborhood,
    @required this.city,
    @required this.state,
  });

}