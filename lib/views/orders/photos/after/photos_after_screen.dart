import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_after_controller.dart';
import 'package:grupocsl/views/orders/photos/after/components/add_tile_after_widget.dart';
import 'package:grupocsl/views/orders/photos/after/components/list_after_images.dart';



class PhotoAfterScreen extends StatefulWidget {

  final String token;
  final String os;

  const PhotoAfterScreen(this.token, this.os);

  @override
  _PhotoAfterScreenState createState() => _PhotoAfterScreenState();
}

class _PhotoAfterScreenState extends State<PhotoAfterScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoAfterController>(
      init: PhotoAfterController(),
      builder: (photoAfterController){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                if(photoAfterController.images.isEmpty){
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
                if(photoAfterController.images.isEmpty){
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
                    itemCount: photoAfterController.images.length + 1,
                    itemBuilder: (ctx, index){
                      if(index < photoAfterController.images.length){
                        return ListImages(photoAfterController.images[index], index);
                      } else{
                        return AddTileWidget(widget.os, widget.token);
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
                    visible: photoAfterController.isLoading,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  RaisedButton(
                    onPressed: photoAfterController.images.isEmpty ? null :
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
                ]
              ),
            ),
          ),
        );
      },
    );
  }
}