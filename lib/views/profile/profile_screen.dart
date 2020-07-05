import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/common/drawer/custom_drawer.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:grupocsl/views/profile/components/detail_option.dart';


class ProfileScreen extends StatelessWidget {

  final SizeScreen sizeScreen = SizeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: GetBuilder<UserController>(
        init: UserController(),
        builder: (userController){
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
            height: sizeScreen.getHeightScreenWidthAppBar(context, AppBar()),
            width: sizeScreen.getWidthScreen(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
                  Color(0xff196ca1),
                  Color(0xff48c2e7),
                ]
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.assignment_ind,
                        color: Colors.white,
                        size: 90,
                      ),
                      SelectableText(
                        userController.user.nome,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 33
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: DetailOption(
                      title: 'Franquia',
                      information: userController.user.franquia
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DetailOption(
                        title: 'Id',
                        information: userController.user.id
                      ),
                      DetailOption(
                        title: 'Id Aux',
                        information: userController.user.idAux
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DetailOption(
                        title: 'Id Func',
                        information: userController.user.idFunc
                      ),
                      DetailOption(
                        title: 'Tipo',
                        information: userController.user.tipo,
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}