import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/base/base_controller.dart';
import 'package:grupocsl/model/drawer/drawer_option_model.dart';


class DrawerOption extends StatelessWidget {

  final DrawerOptionModel drawerOptionModel;
  const DrawerOption(this.drawerOptionModel);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseController>(
      init: BaseController(),
      builder: (baseController){
        return Container(
          color: baseController.page == drawerOptionModel.page ?
          const Color.fromARGB(150, 255, 255, 255) : Colors.transparent,
          child: ListTile(
            onTap: (){
              baseController.setPage(drawerOptionModel.page);
            },
            title: Text(
              drawerOptionModel.title,
              style: TextStyle(
                color:  baseController.page == drawerOptionModel.page ?
                Theme.of(context).primaryColor : Colors.white
              ),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: Colors.white,
            )
          ),
        );
      },
    );
  }
}