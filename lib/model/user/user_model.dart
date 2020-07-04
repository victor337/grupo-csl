class UserModel {

  String id;
  String idAux;
  String nome;
  String tipo;
  String idFunc;
  String token;
  String franquia;

  UserModel.fromMap(Map<String, dynamic> data){
    id = data['id'] as String;
    idAux = data['idAux'] as String;
    nome = data['nome'] as String;
    tipo = data['tipo'] as String;
    idFunc = data['idFunc'] as String;
    token = data['token'] as String;
    franquia = data['franquia'] as String;
  }
}