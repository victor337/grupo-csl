import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:signature/signature.dart';

void main() => runApp(Teste());

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  SizeScreen sizeScreen = SizeScreen();

  Function pop;

  @override
  Widget build(BuildContext context) {

    Future<bool> setpop(){
      return showDialog(
        context: context,
        child: AlertDialog(
          title: const Text('Cancelado'),
          content: const Text('Operação cancelada, você voltará para a tela anterior'),
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
            )
          ],
        ),
      );
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
              Signature(
                controller: _controller,
                height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()) -
                sizeScreen.getHeightScreenWidthAppBar(context, AppBar()) / 6,
                backgroundColor: Colors.white,
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
                          if (_controller.isNotEmpty) {
                            final data = await _controller.toPngBytes();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      title: const Text('Assinatura')
                                    ),
                                    body: Center(
                                      child: Container(
                                        color: Colors.red,
                                        child: Image.memory(data)
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
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