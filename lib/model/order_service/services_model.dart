
class Services {

  String id;
  String name;
  String value;
  String type;
  String quantity;
  String t;

  Services.fromMap(Map<String, dynamic> data){
    id = data["id"] as String;
    name = data["name"] as String;
    value = data["value"] as String;
    type = data["type"] as String;
    quantity = data["quantity"] as String;
    t = data["t"] as String;
  }

}