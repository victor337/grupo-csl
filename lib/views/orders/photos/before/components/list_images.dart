import 'package:flutter/material.dart';


class ListImages extends StatelessWidget {

  final String path;
  const ListImages(this.path);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
    );
  }
}