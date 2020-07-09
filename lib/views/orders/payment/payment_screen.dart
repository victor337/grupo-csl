import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/orders/payment_controller.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:grupocsl/model/order_service/order_service.dart';



class PaymentScreen extends StatelessWidget {

  final OrderService orderService;
  PaymentScreen(this.orderService);
  final FocusNode valueFocus = FocusNode();

  final SizeScreen sizeScreen = SizeScreen();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      init: PaymentController(),
      builder: (paymentController){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                if(!paymentController.isValid){
                  Get.dialog(
                    AlertDialog(
                      title: const Text('Aviso'),
                      content: const Text(
                        'Você deve preencher e enviar os dados para sair dessa tela'
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: (){
                            Get.back();
                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  );
                }
              }
            ),
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
                          'Parcelas: ${orderService.numInstallments}x',
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
                        GetBuilder<PaymentController>(
                          builder: (paymentController){
                            return Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).primaryColor
                              ),
                              child: TextFormField(
                                focusNode: valueFocus,
                                onChanged: (v){
                                  paymentController.setValue(v);
                                },
                                onFieldSubmitted: (v){
                                  valueFocus.unfocus();
                                },
                                keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true
                                ),
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  RealInputFormatter(centavos: true)
                                ],
                                style: const TextStyle(
                                  color: Colors.white
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Valor pago',
                                  hintStyle: TextStyle(color: Colors.white),
                                  icon: Icon(Icons.attach_money, color: Colors.white),
                                  border: InputBorder.none
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            );
                          },
                        ),
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
                            return Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                color: const Color(0xff196ca1),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: DropdownButton<String>(
                                dropdownColor: const Color(0xff196ca1),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                underline:  Visibility(
                                  visible: false,
                                  child: Container()
                                ),
                                icon: Icon(Icons.expand_more, color: Colors.white,),
                                items: paymentController.options.map((
                                  String dropDownStringItem){
                                    return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem),
                                    );
                                  }).toList(),
                                  onChanged: (String newValue){
                                  paymentController.setOption(newValue);
                                },
                                value: paymentController.optionSelect,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10,),
                        const Text('Data do pagamento'),
                        GetBuilder<PaymentController>(
                          builder: (paymentController){
                            return Text(
                              paymentController.date??'Nenhuma data selecionada'
                            );
                          },
                        ),
                        const SizedBox(height: 10,),
                        GetBuilder<PaymentController>(
                          init: PaymentController(),
                          builder: (paymentController){
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Outra data',
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: const Color(0xff48c2e7),
                                  ),
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
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                GetBuilder<PaymentController>(
                  builder: (paymentController){
                    return GetBuilder<UserController>(
                      builder: (userController){
                        return RaisedButton(
                          color: const Color(0xff48c2e7),
                          onPressed: paymentController.isValid ? (){
                            paymentController.sendPayment(
                              token: userController.user.token,
                              os: orderService.id,
                            );
                          } : null,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: paymentController.isLoading ? const Center(
                              child: CircularProgressIndicator(),
                            ) : Text(
                              'Enviar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: paymentController.isValid ? Colors.white : Colors.black
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}