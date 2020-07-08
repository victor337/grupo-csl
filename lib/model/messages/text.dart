class TextMessage {

  String title;
  String description;

  TextMessage.fromMap(Map<String, dynamic> data){
    title = data["title"] as String;
    description = data["descricao"] as String;
  }

}