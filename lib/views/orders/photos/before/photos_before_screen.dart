import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_before_controller.dart';
import 'package:grupocsl/views/orders/photos/before/components/add_tile_before_widget.dart';
import 'package:grupocsl/views/orders/photos/before/components/list_before_images.dart';


class PhotoBeforeScreen extends StatefulWidget {

  final String os;
  final String token;
  const PhotoBeforeScreen(this.os, this.token);

  @override
  _PhotoBeforeScreenState createState() => _PhotoBeforeScreenState();
}

class _PhotoBeforeScreenState extends State<PhotoBeforeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoBeforeController>(
      init: PhotoBeforeController(),
      builder: (photoBeforeController){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                if(photoBeforeController.images.isEmpty){
                  Get.dialog(
                    AlertDialog(
                      title: const Text('Aviso'),
                      content: const Text(
                        'Você deve adicionar ao menos uma imagem!'
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: (){
                            Get.back();
                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  );
                } else {
                  Get.dialog(
                    AlertDialog(
                      title: const Text('Aviso'),
                      content: const Text(
                        'Você não conseguirá alterar essas imagens depois!'
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: (){
                            Get.back();
                            Get.back();
                          },
                          child: const Text('Ok', style: TextStyle(color: Colors.red),),
                        ),
                        FlatButton(
                          onPressed: (){
                            Get.back();
                          },
                          child: const Text('Enviar mais fotos'),
                        ),
                      ],
                    ),
                  );
                }
              }
            ),
            title: const Text(
              'Adicionar fotos'
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(5),
            child: WillPopScope(
              onWillPop: (){
                if(photoBeforeController.images.isEmpty){
                  return Get.dialog(
                    AlertDialog(
                      title: const Text('Aviso'),
                      content: const Text(
                        'Você deve adicionar ao menos uma imagem!'
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: (){
                            Get.back();
                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Get.dialog(
                    AlertDialog(
                      title: const Text('Aviso'),
                      content: const Text(
                        'Você não conseguirá alterar essas imagens depois!'
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: (){
                            Get.back();
                            Get.back();
                          },
                          child: const Text('Ok', style: TextStyle(color: Colors.red),),
                        ),
                        FlatButton(
                          onPressed: (){
                            Get.back();
                          },
                          child: const Text('Enviar mais fotos'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: ListView(
                children: <Widget>[
                  StaggeredGridView.countBuilder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    itemCount: photoBeforeController.images.length + 1,
                    itemBuilder: (ctx, index){
                      if(index < photoBeforeController.images.length){
                        return ListImages(photoBeforeController.images[index], index);
                      } else{
                        return AddTileWidget(widget.os, widget.token,);
                      }
                    },
                    staggeredTileBuilder: (index){
                      return StaggeredTile.count(
                        2,
                        index.isEven ? 2 : 1,
                      );
                    },
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  const SizedBox(height: 15),
                  Visibility(
                    visible: photoBeforeController.isLoading,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  RaisedButton(
                    onPressed: photoBeforeController.images.isEmpty ? null :
                    (){
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Aviso'),
                          content: const Text(
                            'Você não conseguirá alterar essas imagens depois!'
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: (){
                                Get.back();
                                Get.back();
                              },
                              child: const Text('Ok', style: TextStyle(color: Colors.red),),
                            ),
                            FlatButton(
                              onPressed: (){
                                Get.back();
                              },
                              child: const Text('Enviar mais fotos'),
                            ),
                          ],
                        ),
                      );
                    },
                    color: Theme.of(context).primaryColor,
                    child: const Text('Ok', style: TextStyle(color: Colors.white,),)
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}