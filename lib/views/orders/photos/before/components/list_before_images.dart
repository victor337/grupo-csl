import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_before_controller.dart';


class ListImages extends StatelessWidget {

  final String path;
  final int index;
  const ListImages(this.path, this.index);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoBeforeController>(
      builder: (photoBeforeController){
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
                      photoBeforeController.removerImage(index);
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
          child: Image.asset(
            path,
            fit: BoxFit.cover,
          ),
        );
      }
    );
  }
}