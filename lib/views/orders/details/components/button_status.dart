import 'package:flutter/material.dart';
import 'package:grupocsl/views/orders/details/components/set_status.dart';


class ButtonStatus extends StatelessWidget {

  final Function(int) onPressed;
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
    return RaisedButton(
      color: const Color(0xff48c2e7),
      onPressed: (){
        onPressed(setStatus+1);
      },
      child: Text(
        setStatusFunc.setStatusAtt(setStatus+1),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}