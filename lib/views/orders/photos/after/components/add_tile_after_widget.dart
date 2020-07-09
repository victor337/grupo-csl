import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_after_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class AddTileWidget extends StatelessWidget {

  final String os;
  final String token;

  const AddTileWidget(this.os, this.token,);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoAfterController>(
      builder: (photoAfterController){
        Future<void> saveImage(PickedFile pickedFile)async{
          final File file = File(pickedFile.path);
            final bool sucess = await GallerySaver.saveImage(file.path);
            if(sucess){
              final File file = File(pickedFile.path);
              final String base64Image = base64Encode(file.readAsBytesSync());
              final String fileName = file.path.split("/").last;
              photoAfterController.sendImage(
                token: token,
                os: os,
                image: base64Image,
                tipo: '2',
                name: fileName,
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
              photoAfterController.addImage(file.path);
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

                          try {
                            final PickedFile pickedFile = 
                            await picker.getImage(source: ImageSource.camera);
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
                            saveImage(pickedFile);
                          } catch (e) {
                             Get.snackbar('Erro', 'Não foi possível salvar a imagem');
                          }
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
                              ),
                            );
                            return;
                          }
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