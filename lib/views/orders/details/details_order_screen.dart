import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/model/order_service/order_service.dart';
import 'package:grupocsl/views/orders/payment/payment_screen.dart';
import 'package:grupocsl/views/orders/photos/before/photos_before_screen.dart';
import 'package:grupocsl/views/orders/signature/signature_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailOrderScreen extends StatefulWidget {

  final OrderService orderService;
  const DetailOrderScreen(this.orderService);

  @override
  _DetailOrderScreenState createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {

  final SizeScreen sizeScreen = SizeScreen();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Detalhes da OS Nº${widget.orderService.id}',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
        height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()),
        width: sizeScreen.getWidthScreen(context),
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            Card(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 25, 10, 25),
                width: sizeScreen.getWidthScreen(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Ordem de Serviço: ${widget.orderService.id}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Status: ${widget.orderService.status}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Pago: ${widget.orderService.statusDesc}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Tipo de pagamento: ${widget.orderService.typePayment}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Card(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 25, 10, 25),
                width: sizeScreen.getWidthScreen(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Cliente: ${widget.orderService.clientName}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Telefone: ${widget.orderService.clientPhone}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Celular: ${widget.orderService.clientCel}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Endereço: ${widget.orderService.adress},'
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Data do Pedido: ${widget.orderService.dateOrder}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Horário: ${widget.orderService.hour}',
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 25, 10, 25),
                width: sizeScreen.getWidthScreen(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Observação: ${widget.orderService.observation??''}',
                    ),
                    const SizedBox(height: 5,),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.orderService.services.length,
                      itemBuilder: (ctx, index){
                        return Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Código: ${widget.orderService.services[index].id.toString()}: '
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Serviço: ${widget.orderService.services[index].name.toString()}',
                                    textAlign: TextAlign.center
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                    'Quantidade: ${widget.orderService.services[index].quantity.toString()}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                    'Valor: R\$${widget.orderService.services[index].value}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            const Divider()
                          ],
                        );
                      }
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Tipo: ${widget.orderService.typePayment}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Valor total R\$${widget.orderService.value}'
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Data do Pedido: ${widget.orderService.dateOrder}',
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      'Horário: ${widget.orderService.hour}',
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: (){
                launch(
                  'https://www.google.com/maps/place/${widget.orderService.adress}'
                );
              },
              child: const Text('Abrir no Maps'),
            ),
            RaisedButton(
              onPressed: (){
                Get.to(SignatureScreen());
              },
              child: const Text('Abrir canvas'),
            ),
            RaisedButton(
              onPressed: (){
                Get.to(PaymentScreen(widget.orderService));
              },
              child: const Text('Abrir pagamento'),
            ),
            RaisedButton(
              onPressed: (){
                Get.to(PhotoBeforeScreen());
              },
              child: const Text('Fotos antes'),
            ),
          ],
        ),
      ),
    );
  }

}
