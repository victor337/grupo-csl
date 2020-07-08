
class SetStatus {

  String setStatusAtt(int status){
    if(status == 0) {
      return 'Aguardando aceite';
    } else if(status == 1) {
      return 'Aceitar atendimento OS';
    } else if(status == 2) {
      return 'A caminho';
    } else if(status == 3) {
      return 'Iniciando atendimento';
    } else if(status == 4) {
      return 'Foto antes e problemas';
    } else if(status == 5) {
      return 'Realizar procedimento';
    } else if(status == 6) {
      return 'Foto depois do processo';
    } else if(status == 7) {
      return 'Aceite do cliente';
    } else if(status == 8) {
      return 'Pagamento';
    } else if(status == 9) {
      return 'Procedimento de saida e limpeza do ambiente.';
    } else if(status == 10){
      return 'Fechar OS';
    } else {
      return null;
    }

  }
  


}