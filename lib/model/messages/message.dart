import 'package:grupocsl/model/messages/text.dart';

class Message {

  TextMessage text;

  Message.fromMap(Map<String, dynamic> data){
    text = TextMessage.fromMap(data["texto"] as Map<String, dynamic>);
  }
  
}