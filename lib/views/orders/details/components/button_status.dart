import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/user/user_controller.dart';
import 'package:grupocsl/views/orders/details/components/set_status.dart';


class ButtonStatus extends StatelessWidget {

  final VoidCallback onPressed;
  final Function onAction;
  final int setStatus;

  ButtonStatus({
    @required this.onPressed,
    @required this.onAction,
    @required this.setStatus,
  });

  final SetStatus setStatusFunc = SetStatus();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController){
        return RaisedButton(
          color: const Color(0xff48c2e7),
          onPressed: (){
            onAction();
            onPressed();
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: userController.textIsLoading ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )) : Text(
              setStatusFunc.setStatusAtt(setStatus+1),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}