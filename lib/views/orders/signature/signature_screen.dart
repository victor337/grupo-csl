import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/orders/signature_controller_send.dart';
import 'package:screenshot/screenshot.dart';
import 'package:signature/signature.dart';


class SignatureScreen extends StatefulWidget {

  final String token;
  final String os;
  const SignatureScreen(this.os, this.token);

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  SizeScreen sizeScreen = SizeScreen();
  ScreenshotController screenshotController = ScreenshotController(); 


  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    Future<bool> setpop(){
      return showDialog(
        context: context,
        child: AlertDialog(
          title: const Text('Aviso'),
          content: const Text('Você não pode voltar!'),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();                
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: setpop,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Text('Assinatura do cliente'),
          centerTitle: true,
        ),
        body: Container(
          height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()),
          color: const Color.fromARGB(100, 30, 30, 30),
          child: Column(
            children: <Widget>[
              //SIGNATURE CANVAS
              Screenshot(
                controller: screenshotController,
                  child: Signature(
                  controller: _controller,
                  height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()) -
                  sizeScreen.getHeightScreenWidthAppBar(context, AppBar()) / 6,
                  backgroundColor: Colors.white,
                ),
              ),
              //OK AND CLEAR BUTTONS
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //SHOW EXPORTED IMAGE IN NEW ROUTE
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GetBuilder<SignatureControllerSend>(
                        init: SignatureControllerSend(),
                        builder: (singnatureControllerSend){
                          return IconButton(
                            icon: const Icon(Icons.check),
                            color: Colors.white,
                            onPressed: () async {
                              if(_controller.isNotEmpty) {
                                screenshotController.capture().then((image){
                                  try {
                                    final File file = File(image.path);
                                    final String base64Image = base64Encode(file.readAsBytesSync());
                                    final String fileName = file.path.split("/").last;
                                    singnatureControllerSend.sendImage(
                                      token: widget.token,
                                      os: widget.os,
                                      image: base64Image,
                                      tipo: '3',
                                      name: '3 - $fileName',
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
                                    Get.dialog(
                                      AlertDialog(
                                        content: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const<Widget>[
                                              Text('Enviando para o servidor'),
                                              Text(
                                                'Você será redirecionado para a tela anterior',
                                                style: TextStyle(
                                                  fontSize: 22
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: ()async{
                                              Get.back(closeOverlays: true);
                                              await SystemChrome.setPreferredOrientations([
                                                DeviceOrientation.portraitUp,
                                                DeviceOrientation.portraitDown,
                                              ]);
                                              Get.back(closeOverlays: true);
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                      barrierDismissible: false
                                    );
                                  } catch (e) {
                                    Get.dialog(
                                      AlertDialog(
                                        content: const Text('Erro ao salvar'),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: (){
                                              Get.back();
                                            },
                                            child: const Text('Ok')
                                          )
                                        ],
                                      )
                                    );
                                  }
                                });
                              }
                            },
                          );
                        },
                      )
                    ),
                    //CLEAR CANVAS
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        color: Colors.white,
                        onPressed: () {
                          setState(() => _controller.clear());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}