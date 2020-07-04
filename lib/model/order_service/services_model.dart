class Services {

  String id;
  String name;
  String value;
  String type;
  String quantity;
  int t;

  Services.fromMap(Map<String, dynamic> data){
    id = data["id"].toString();
    name = data["name"] as String;
    value = data["value"] as String;
    type = data["type"] as String;
    quantity = data["quantity"] as String;
    t = data["t"] as int;
  }

}