import 'package:compressimage/compressimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_before_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class AddTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoBeforeController>(
      init: PhotoBeforeController(),
      builder: (photoBeforeScreen){
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
                                  'Permirta para poder tirar a foto'
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
                          Navigator.of(context).pop();
                          final picker = ImagePicker();

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
                          await CompressImage.compress(
                            imageSrc: pickedFile.path,
                            desiredQuality: 80
                          );
                          photoBeforeScreen.addImage(pickedFile);
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
                          Get.dialog(
                            const Text('Erro de permissão')
                          );
                          return;
                        } else {
                          Navigator.of(context).pop();
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
                          await CompressImage.compress(
                            imageSrc: pickedFile.path,
                            desiredQuality: 50
                          );
                          photoBeforeScreen.addImage(pickedFile);
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