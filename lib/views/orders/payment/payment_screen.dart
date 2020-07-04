import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/orders/payment_controller.dart';
import 'package:grupocsl/model/order_service/order_service.dart';



class PaymentScreen extends StatelessWidget {

  final OrderService orderService;
  PaymentScreen(this.orderService);
  final FocusNode valueFocus = FocusNode();

  final SizeScreen sizeScreen = SizeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Pagamento OS ${orderService.id}',
          style: const TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()),
        width: sizeScreen.getWidthScreen(context),
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            Card(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Parcelado: ${orderService.numInstallments}',
                      style: const TextStyle(
                        fontSize: 25
                      ),
                    ),
                    Text(
                      'Valor a pagar: R\$${orderService.value}',
                      style: const TextStyle(
                        fontSize: 25
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Card(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Text(
                          'Valor',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor
                      ),
                      child: TextFormField(
                        onChanged: (v){},
                        onFieldSubmitted: (v){},
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Valor pago',
                          hintStyle: TextStyle(color: Colors.white),
                          icon: Icon(Icons.attach_money, color: Colors.white),
                          border: InputBorder.none
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    Visibility(
                      visible: int.parse(orderService.numInstallments) > 1,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 10,),
                          const Text(
                            'Parcelamento',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey
                            ),
                          ),
                          GetBuilder<PaymentController>(
                            init: PaymentController(),
                            builder: (paymentController){
                              return DropdownButton<String>(
                                items: paymentController.parcelaments.map((
                                  String dropDownStringItem){
                                    return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem),
                                    );
                                  }).toList(),
                                  onChanged: (String newValue){
                                  paymentController.setParcelament(newValue);
                                },
                                value: paymentController.parcelamentSelected,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'Outra data',
                      style: TextStyle(
                        fontSize: 15
                      ),
                    ),
                    const SizedBox(height: 10,),
                    GetBuilder<PaymentController>(
                      init: PaymentController(),
                      builder: (paymentController){
                        return IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: (){
                            showDatePicker(
                              context: context,
                              initialDate: paymentController.dateNotFormated,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year, DateTime.now().month,
                                DateTime.now().day + 1)
                            ).then((date){
                              if(date == null){
                                return;
                              } else{
                                paymentController.setDate(date);
                              }
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'Tipo',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey
                      ),
                    ),
                    const SizedBox(height: 10,),
                    GetBuilder<PaymentController>(
                      init: PaymentController(),
                      builder: (paymentController){
                        return DropdownButton<String>(
                          items: paymentController.types.map((
                            String dropDownStringItem){
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String newValue){
                            paymentController.setType(newValue);
                          },
                          value: paymentController.typeSelected,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: (){

              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}