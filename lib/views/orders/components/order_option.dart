import 'package:flutter/material.dart';
import 'package:grupocsl/model/order_service/order_service.dart';


class OrderOption extends StatelessWidget {

  final OrderService orderService;
  const OrderOption(this.orderService);

  @override
  Widget build(BuildContext context) {

    Color setColor(int status){
      if(status == 0) {
        return Colors.red;
      } else if(status == 1){
        return Colors.green;
      } else{
        return Colors.yellow;
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
              'OS ${orderService.id}',
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
              orderService.hour.substring(0, 5),
              style: const TextStyle(
                color: Colors.white
              ),
            ),
          ],
        ),
        subtitle: Text(
          orderService.clientName,
          style: TextStyle(
            color: Colors.grey[400]
          ),
        ),
        trailing: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: setColor(int.parse(orderService.status)),
          ),
        ),
      ),
    );
  }
}