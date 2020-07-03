import 'package:compressimage/compressimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_before_controller.dart';
import 'package:image_picker/image_picker.dart';


class AddTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoBeforeController>(
      init: PhotoBeforeController(),
      builder: (photoBeforeScreen){
        return GestureDetector(
          onTap: (){
            Get.bottomSheet(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    onPressed: ()async{
                      Navigator.of(context).pop();
                      final picker = ImagePicker();

                      final PickedFile pickedFile = 
                      await picker.getImage(source: ImageSource.camera);
                      await CompressImage.compress(
                        imageSrc: pickedFile.path,
                        desiredQuality: 80
                      );
                      photoBeforeScreen.addImage(pickedFile);
                    },
                  )
                ],
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