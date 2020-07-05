import 'package:flutter/material.dart';


class DetailOption extends StatelessWidget {

  final String title;
  final String information;

  const DetailOption({
    @required this.title,
    @required this.information,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600]
                ),
              ),
              Text(
                information,
                style: const TextStyle(
                  fontSize: 22
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}