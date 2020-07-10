import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_after_controller.dart';


class ListImagesAfter extends StatelessWidget {

  final File path;
  final int index;
  const ListImagesAfter(this.path, this.index);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoAfterController>(
      builder: (photoAfterController){
        return GestureDetector(
          onLongPress: (){
            showDialog(
              context: context,
              child: AlertDialog(
                title: const Text('Tem certeza?'),
                content: const Text('Realmente deseja remover a imagem?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancelar'
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      photoAfterController.removerImage(index);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Remover',
                      style: TextStyle(
                        color: Colors.red
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Image.file(
            path,
            fit: BoxFit.cover,
          ),
        );
      }
    );
  }
}