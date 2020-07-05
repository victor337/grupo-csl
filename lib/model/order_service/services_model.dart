class Services {

  String id;
  String name;
  String value;
  String type;
  String quantity;
  int t;

  Services.fromMap(Map<String, dynamic> data){
    id = data["id"].toString();
    name = data["nome"] as String;
    value = data["valor"] as String;
    type = data["tipo"] as String;
    quantity = data["quantidade"] as String;
    t = data["t"] as int;
  }

}