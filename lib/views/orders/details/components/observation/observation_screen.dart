import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/obs_controller.dart';
import 'package:grupocsl/model/order_service/order_service.dart';


class ObservationScreen extends StatelessWidget {

  final OrderService orderService;
  final String token;

  const ObservationScreen(this.orderService, this.token);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Observações da OS ${orderService.id}'
        ),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GetBuilder<ObsController>(
          init: ObsController(),
          builder: (obsController){
            if(obsController.initalObs != null){
              return ListView(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(200, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      onChanged: (text){
                        obsController.setObs(text);
                      },
                      initialValue: obsController.initalObs == 'Escreva a descrição' ? '' : obsController.initalObs,
                      decoration: InputDecoration(
                        icon: Icon(Icons.list),
                        border: InputBorder.none,
                        hintText: 'Escreva aqui as observações'
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: (){
                          obsController.sendObservation(
                            token: token,
                            os: orderService.id,
                            setObs: obsController.obs,
                            onSucess: (){
                              Get.snackbar(
                                'Enviado',
                                'Observação enviada com sucesso',
                                backgroundColor: Colors.green,
                                colorText: Colors.white
                              );
                            },
                            onFail: (e){
                              Get.snackbar(
                                'Falha',
                                'Observaçãonão enviada',
                                backgroundColor: Colors.red,
                                colorText: Colors.white
                              );
                            }
                          );
                        },
                        color: const Color(0xff48c2e7),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: obsController.isLoading ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                            ) : const Text(
                            'Enviar',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return FutureBuilder(
                future: obsController.getObs(
                  token: token,
                  os: orderService.id,
                  onSucess: (){
                    Get.snackbar(
                      'Sucesso',
                      'Dados buscados',
                      backgroundColor: Colors.green,
                      colorText: Colors.white
                    );
                  },
                  onFail: (e){
                    Get.snackbar(
                      'Sucesso',
                      e as String,
                      backgroundColor: Colors.green,
                      colorText: Colors.white
                    );
                  }
                ),
                builder: (ctx, snapshot){
                  if(snapshot == null || obsController.initalObs == null){
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    );
                  } else {
                    return ListView(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          height: 200,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(200, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            initialValue: snapshot.data['success']['observacoes'] as String??'',
                            decoration: InputDecoration(
                              icon: Icon(Icons.list),
                              border: InputBorder.none,
                              hintText: 'Escreva aqui as observações'
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: (){},
                              color: const Color(0xff48c2e7),
                              child: const Text(
                                'Enviar',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}