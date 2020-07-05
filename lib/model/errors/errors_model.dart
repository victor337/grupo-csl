
class Error {

  int status;
  String code;
  String title;

  Error.fromMap(Map<String, dynamic> data){
    status = data['status'] as int;
    code = data['code'] as String;
    title = data['title'] as String;
  }


}