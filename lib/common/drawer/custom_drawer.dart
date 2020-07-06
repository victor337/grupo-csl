import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/common/drawer/components/drawer_option.dart';
import 'package:grupocsl/constants/size_screen.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:grupocsl/model/drawer/drawer_option_model.dart';


class CustomDrawer extends StatefulWidget {

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final SizeScreen sizeScreen = SizeScreen();

  final List<DrawerOptionModel> orders = [
    DrawerOptionModel('Listar OS', 0),
    DrawerOptionModel('Perfil', 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.fromLTRB(20, 40, 10, 40),
            width: sizeScreen.getWidthScreen(context),
            child: GetBuilder<UserController>(
              builder: (userController){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userController.user.nome,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25
                      ),
                    ),
                    Text(
                      userController.user.franquia,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 11, 48, 71),
              child: ListView(
                shrinkWrap: true,
                children: orders.map((order){
                  return Column(
                    children: <Widget>[
                      DrawerOption(order),
                      const SizedBox(height: 8),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          GetBuilder<UserController>(
            builder: (userController){
              return GestureDetector(
                onTap: (){
                  userController.deleteUserData();
                  Get.offAllNamed('/login');
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 25),
                  color: const Color.fromARGB(255, 11, 48, 71),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.white
                      ),
                      const Text(
                        'Sair',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}