import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:screenshot/screenshot.dart';
import 'package:signature/signature.dart';


class SignatureScreen extends StatefulWidget {
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
                      child: IconButton(
                        icon: const Icon(Icons.check),
                        color: Colors.white,
                        onPressed: () async {
                          if(_controller.isNotEmpty) {
                            screenshotController.capture().then((image){
                              try {
                                GallerySaver.saveImage(image.path);
                                Get.dialog(
                                  AlertDialog(
                                    content: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const<Widget>[
                                          Text('Salvo na galeria'),
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
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                          SystemChrome.setPreferredOrientations([
                                            DeviceOrientation.portraitUp,
                                            DeviceOrientation.portraitDown,
                                          ]);
                                          Navigator.of(context).pop();
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
                      ),
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