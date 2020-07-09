import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_before_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class AddTileWidget extends StatelessWidget {
  final String os;
  final String token;
  const AddTileWidget(this.os, this.token);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoBeforeController>(
      builder: (photoBeforeScreen){        
        Future<void> saveImage(PickedFile pickedFile)async{
          final File file = File(pickedFile.path);
          final bool sucess = await GallerySaver.saveImage(file.path);
          if(sucess){
            final String base64Image = base64Encode(file.readAsBytesSync());
            final String fileName = file.path.split("/").last;
            photoBeforeScreen.sendImage(
              token: token,
              os: os,
              image: base64Image,
              tipo: '1',
              name: '1 - $fileName',
              onSucess: (){
                Get.snackbar(
                  'Sucesso',
                  'Foto enviada com sucesso',
                  colorText: Colors.white,
                  backgroundColor: Colors.green
                );
              },
              onFail: (e){
                Get.snackbar(
                  'Falha',
                  e,
                  colorText: Colors.white,
                  backgroundColor: Colors.red
                );
              }
            );
            photoBeforeScreen.addImage(file.path);
          } else {
            Get.snackbar(
              'Erro',
              'Não foi possível salvar a imagem',
              colorText: Colors.white,
              backgroundColor: Colors.red
            );
          }
        }

        return GestureDetector(
          onTap: (){
            Get.bottomSheet(
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      // ignore: void_checks
                      onPressed: () async{

                        await PermissionHandler().requestPermissions([
                          PermissionGroup.camera,
                          PermissionGroup.storage,
                        ]);

                        final PermissionStatus permissionStorage = await PermissionHandler()
                          .checkPermissionStatus(PermissionGroup.storage);
                        
                        final PermissionStatus permissionCamera = await PermissionHandler()
                          .checkPermissionStatus(PermissionGroup.camera);

                        if(permissionStorage != PermissionStatus.granted||
                          permissionCamera != PermissionStatus.granted){
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                content: const Text(
                                  'Permita para poder tirar a foto'
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              )
                            );
                            return;
                        } else {
                          final picker = ImagePicker();
                          final PickedFile pickedFile = 
                          await picker.getImage(source: ImageSource.camera);
                          if(pickedFile == null){
                            return showDialog(
                              context: context,
                              child: AlertDialog(
                                content: const Text(
                                  'Nenhuma imagem selecionada'
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              )
                            );
                          }
                          photoBeforeScreen.addImage(pickedFile.path);
                          saveImage(pickedFile);
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_album),
                      onPressed: ()async{
                        
                        await PermissionHandler().requestPermissions([
                          PermissionGroup.camera,
                          PermissionGroup.storage,
                        ]);

                        final PermissionStatus permissionStorage = await PermissionHandler()
                          .checkPermissionStatus(PermissionGroup.storage);
                        
                        final PermissionStatus permissionCamera = await PermissionHandler()
                          .checkPermissionStatus(PermissionGroup.camera);

                        if(permissionStorage != PermissionStatus.granted||
                          permissionCamera != PermissionStatus.granted){
                          showDialog(
                            context: context,
                            child: AlertDialog(
                              content: const Text(
                                'Permita para poder tirar a foto'
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            )
                          );
                          return;
                        } else {
                          final picker = ImagePicker();
                          final PickedFile pickedFile = 
                          await picker.getImage(source: ImageSource.gallery);
                          if(pickedFile == null){
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                content: const Text(
                                  'Nenhuma imagem selecionada'
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              )
                            );
                            return;
                          }
                          photoBeforeScreen.addImage(pickedFile.path);
                          saveImage(pickedFile);
                        }
                      },
                    ),
                  ],
                ),
              )
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(Icons.add, color: Colors.white,),
          ),
        );
      },
    );
  }
}