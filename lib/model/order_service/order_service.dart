
import 'package:grupocsl/model/order_service/services_model.dart';

class OrderService {

  String id;
  String adress;
  String paymentForm;
  String descripton;
  String observation;
  String statusDesc;
  String statusAttendanceDesc;
  String statusAttendance;
  String status;
  List<Services> services;
  String value;
  String numInstallments;
  String typePayment;
  String dateOrder;
  String hour;
  String clientName;
  String clientPhone;
  String clientCel;
  String clientEmail;
  String clientObservation;


  OrderService.fromMap(Map<String, dynamic> data){
    id = data["id"] as String;
    adress = data["endereco"] as String;
    paymentForm = data["formaPagamento"] as String;
    descripton = data["descricao"] as String;
    observation = data["observacao"] as String;
    statusDesc = data["statusDesc"] as String;
    statusAttendanceDesc = data["statusAtendimentoDesc"] as String;
    statusAttendance = data["statusAtendimento"] as String;
    status = data["status"] as String;
    services = Services.fromMap(data["servicos"] as Map<String, dynamic>) as List<Services>;
    value = data["valor"] as String;
    numInstallments = data["numParcelas"] as String;
    typePayment = data["tipoPagamento"] as String;
    dateOrder = data["dataPedido"] as String;
    hour = data["horario"] as String;
    clientName = data["clienteNome"] as String;
    clientPhone = data["clienteTelefone"] as String;
    clientCel = data["clienteCelular"] as String;
    clientEmail = data["clienteEmail"] as String;
    clientObservation = data["clienteObservacao"] as String;
  }

  

}