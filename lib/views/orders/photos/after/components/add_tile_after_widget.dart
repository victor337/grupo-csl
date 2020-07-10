import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_after_controller.dart';


class AddTileWidget extends StatelessWidget {

  final String os;
  final String token;

  const AddTileWidget(this.os, this.token,);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoAfterController>(
      builder: (photoAfterController){
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
                        try {
                          await photoAfterController.getImage(
                            context,
                            type: '2',
                            typePicker: 1,
                            onSucess: (){
                              Get.snackbar(
                                'Sucesso', 'Foto enviada',
                                backgroundColor: Colors.green,
                                colorText: Colors.white
                              );
                            },
                            onFail: (e){
                              Get.snackbar(
                                'Falha', e,
                                backgroundColor: Colors.red,
                                colorText: Colors.white
                              );
                            },
                            onFailPermission: (e){
                              Get.snackbar(
                                'Falha', 'Você precisa permirtir para enviar as fotos',
                                backgroundColor: Colors.red,
                                colorText: Colors.white
                              );
                            },
                            failSaveImage: (){
                              Get.snackbar(
                                'Falha', 'Falha ao salvar imagem',
                                backgroundColor: Colors.red,
                                colorText: Colors.white
                              );
                            },
                            imageNull: (){
                              Get.snackbar(
                                'Falha', 'Nenhuma imagem selecionada',
                                backgroundColor: Colors.red,
                                colorText: Colors.white
                              );
                            },
                            token: token,
                            os: os
                          );
                        } catch (e) {
                          Get.snackbar(
                            'Falha', 'Um erro inesperado aconteceu',
                            backgroundColor: Colors.red,
                            colorText: Colors.white
                          );
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_album),
                      onPressed: ()async{
                        await photoAfterController.getImage(
                          context,
                          type: '2',
                          typePicker: 2,
                          onSucess: (){
                            Get.snackbar(
                              'Sucesso', 'Foto enviada',
                              backgroundColor: Colors.green,
                              colorText: Colors.white
                            );
                          },
                          onFail: (e){
                            Get.snackbar(
                              'Falha', e,
                              backgroundColor: Colors.red,
                              colorText: Colors.white
                            );
                          },
                          onFailPermission: (e){
                            Get.snackbar(
                              'Falha', 'Você precisa permirtir para enviar as fotos',
                              backgroundColor: Colors.red,
                              colorText: Colors.white
                            );
                          },
                          failSaveImage: (){
                            Get.snackbar(
                              'Falha', 'Falha ao salvar imagem',
                              backgroundColor: Colors.red,
                              colorText: Colors.white
                            );
                          },
                          imageNull: (){
                            Get.snackbar(
                              'Falha', 'Nenhuma imagem selecionada',
                              backgroundColor: Colors.red,
                              colorText: Colors.white
                            );
                          },
                          token: token,
                          os: os
                        );
                        Navigator.of(context).pop();
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