import 'package:flutter/material.dart';
import 'package:grupocsl/model/order_service/order_service.dart';


class OrderOption extends StatelessWidget {

  final OrderService orderService;
  const OrderOption(this.orderService);

  @override
  Widget build(BuildContext context) {

    Color setColor(int status){
      if(status == 0) {
        return Colors.green;
      } else if(status == 1){
        return Colors.yellow;
      } else{
        return Colors.red;
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Text(
              'OS ${orderService.number}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            const Text(
              ' - ',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            Text(
              orderService.hour,
              style: const TextStyle(
                color: Colors.white
              ),
            ),
          ],
        ),
        subtitle: Text(
          orderService.client,
          style: TextStyle(
            color: Colors.black
          ),
        ),
        trailing: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: setColor(orderService.status)
          ),
        ),
      ),
    );
  }
}