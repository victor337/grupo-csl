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

        String setDate(String date){
          final String year = date.substring(0, 4);
          final String month = date.substring(6, 7);
          final String day = date.substring(9, 10);
          return '$day/$month/$year';
        }

        void snackBar(String title, String message, Color color){
          Get.snackbar(
            title,
            message,
            backgroundColor:color,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: Container(),
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
            child: GetBuilder<UserController>(
              builder: (userController){
                if(paymentController.snapshot != null){
                  if(paymentController.snapshot['pagamento'] == '1'){
                      return ListView(
                        children: <Widget>[
                          Card(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  const Text(
                                    'Pago',
                                    style: TextStyle(
                                      fontSize: 22
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        'ID do pagamento: ',
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                      Text(
                                        paymentController.snapshot
                                        ['pagamentos']['idPagamento'] as String,
                                        style: const TextStyle(
                                          fontSize: 18
                                        )
                                      ),
                                    ]
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        'Data do pagamento: ',
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                      Text(
                                        setDate(paymentController.snapshot['pagamentos']
                                        ['dataPagamento'] as String),
                                        style: const TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        'Valor: ',
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                      Text(
                                        paymentController.snapshot['pagamentos']
                                        ['valor'] as String,
                                        style: const TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          RaisedButton(
                            color: const Color(0xff48c2e7),
                            onPressed: (){
                              Get.dialog(
                                AlertDialog(
                                  content: const Text(
                                    "Você será redirecionado para tela anterior"
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: (){
                                        Future.delayed(
                                          const Duration(
                                            seconds: 3
                                          )
                                        ).then((value){
                                          Get.back(closeOverlays: true);
                                          Get.back(closeOverlays: true);
                                        });
                                      },
                                      child: const Text(
                                        'Ok'
                                      ),
                                    ),
                                  ],
                                )
                              );
                            },
                            child: const Text(
                              'Ok',
                              style: TextStyle(
                                color: Colors.white
                              )
                            ),
                          ),
                        ],
                      );
                    } else {
                      return ListView(
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
                                    init: PaymentController(),
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
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter.digitsOnly,
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
                                        idPay: paymentController.snapshot['pagamentos']['idPagamento'] as String,
                                        onSucess: (){
                                          snackBar(
                                            'Sucesso',
                                            'Pagamento enviado com sucesso',
                                            Colors.green
                                          );
                                          Future.delayed(const Duration(
                                            seconds: 3)).then((value){
                                              Navigator.of(context).pop();
                                          });
                                        },
                                        onFail: (e){
                                          snackBar(
                                            'Falha',
                                            e,
                                            Colors.red
                                          );
                                          Future.delayed(const Duration(
                                            seconds: 3)).then((value){
                                              Navigator.of(context).pop();
                                          });
                                        }
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
                      );
                    }
                }

                return FutureBuilder(
                  future: paymentController.verifypayment(
                    token: userController.user.token,
                    os: orderService.id
                  ),
                  builder: (ctx, snapshot){
                    if(snapshot == null || snapshot.connectionState == ConnectionState.waiting){
                      return Column(
                        children: const <Widget>[
                          Text('Buscando dados', style: TextStyle(color: Colors.white),),
                          SizedBox(height: 15,),
                          Center(child: CircularProgressIndicator(),)
                        ],
                      );
                    }
                    else if(snapshot.data[0]['pagamento'] == '1'){
                      return ListView(
                        children: <Widget>[
                          Card(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  const Text(
                                    'Pago',
                                    style: TextStyle(
                                      fontSize: 22
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        'ID do pagamento: ',
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[0]
                                        ['pagamentos']['idPagamento'] as String,
                                        style: const TextStyle(
                                          fontSize: 18
                                        )
                                      ),
                                    ]
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        'Data do pagamento: ',
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                      Text(
                                        setDate(snapshot.data[0]['pagamentos']
                                        ['dataPagamento'] as String),
                                        style: const TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        'Valor: ',
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[0]['pagamentos']
                                        ['valor'] as String,
                                        style: const TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          RaisedButton(
                            color: const Color(0xff48c2e7),
                            onPressed: (){
                              Get.back();
                            },
                            child: const Text(
                              'Ok',
                              style: TextStyle(
                                color: Colors.white
                              )
                            ),
                          ),
                        ],
                      );
                    } else {
                      return ListView(
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
                                    init: PaymentController(),
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
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter.digitsOnly,
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
                                        idPay: snapshot.data[0]['pagamentos']['idPagamento'] as String,
                                        onSucess: (){
                                          snackBar(
                                            'Sucesso',
                                            'Pagamento enviado com sucesso',
                                            Colors.green
                                          );
                                          Future.delayed(const Duration(
                                            seconds: 3)).then((value){
                                              Navigator.of(context).pop();
                                          });
                                        },
                                        onFail: (e){
                                          snackBar(
                                            'Falha',
                                            e,
                                            Colors.red
                                          );
                                          Future.delayed(const Duration(
                                            seconds: 3)).then((value){
                                              Navigator.of(context).pop();
                                          });
                                        }
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
                      );
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}