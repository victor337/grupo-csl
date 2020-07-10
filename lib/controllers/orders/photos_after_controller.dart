import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:grupocsl/repository/api.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class PhotoAfterController extends GetxController {

  final ImagePicker picker = ImagePicker();
  List<File> images = [];

  bool isLoading = false;

  void addImage(File file){
    images.add(file);
    update();
  }

  void removerImage(int index){
    images.removeAt(index);
    update();
  }

  void clearList(){
    images.clear();
    update();
  }

  Future<void> getImage(BuildContext context, {
    @required String type,
    @required int typePicker,
    @required Function onSucess,
    @required Function(String) onFail,
    @required Function onFailPermission,
    @required Function failSaveImage,
    @required Function imageNull,
    @required String token,
    @required String os
  })async{

    isLoading = true;
    update();

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
        onFailPermission();
        isLoading = false;
        update();
    } else {
      PickedFile pickedFile;
      if(typePicker == 1){
        pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 40);
        update();
      } else {
        pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 40);
        update();
      }

      if(pickedFile == null){
        imageNull();
        isLoading = false;
        update();
      } else{
        final File file = File(pickedFile.path);
        final bool sucess = await GallerySaver.saveImage(file.path);
        if(sucess){
          final String base64Image = base64Encode(file.readAsBytesSync());
          final String fileName = file.path.split("/").last;
          try {
            await sendImage(
              token: token,
              os: os,
              image: base64Image,
              tipo: type,
              name: '$type - $os - $fileName',
              onSucess: onSucess,
              onFail: onFail,
            ).then((_){
              addImage(file);
              isLoading = false;
              update();
            });
          } catch (e) {
            onFail(e.toString());
            isLoading = false;
            update();
          }
        } else {
          failSaveImage();
          isLoading = false;
          update();
        }
      }
    }    
  }

  Future<void> sendImage({
    @required String token,
    @required String os,
    @required String image,
    @required String tipo,
    @required String name,
    @required Function onSucess,
    @required Function(String) onFail,
  })async{
    final response = await http.post(
      '$urlBase/api/fotosOS.php',
      body: {
         'token': token,
         'os': os,
         'image': image,
         'tipo': tipo,
         'name': name,
      }
    );
    final responseData = json.decode(response.body);
    if(!responseData.toString().contains('errors')){
      onSucess();
      update();
    } else {
      onFail(responseData['errors']['title'] as String);
      update();
    }
  }


}