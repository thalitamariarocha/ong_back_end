import 'package:flutter_application_1/models/animal/animal.dart';
import 'package:flutter_application_1/models/usuarios/adotante.dart';
import 'package:intl/intl.dart';

class Adocao {
  String? id;
  Animal? animal = Animal();
  Adotante? adotante = Adotante();
  String? status = 'Pendente';
  String? dataDeAdocao = DateTime.now().toString();

  Adocao({
    this.id,
    this.animal,
    this.adotante,
    this.status,
    this.dataDeAdocao,
  });

//Adocao adocao = Adocao();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'animal': {
        'nome': animal!.nome,
        'especie': animal!.especie,
        'sexo': animal!.sexo,
        'porte': animal!.porte,
        //'dtNascimento': adocao.animal.dtNascimento,
        //'vacina': animal!.vacina,
        //'castrado': animal!.castrado,
        'observacao': animal!.observacao,
        //'image': animal!.image,
        'vinculoOng': animal!.vinculoOng,
        //'adotado': adocao.animal.adotado,
      },
      'adotante': {
        'nome': adotante!.nome,
        'cpf': adotante!.cpf,
        //'dtNascimento': adotante!.dtNascimento,
        'email': adotante!.email,
        'telefone': adotante!.telefone,
        'endereco': adotante!.endereco,
        'renda': adotante!.renda,
        'tipoMoradia': adotante!.tipoMoradia,
      },
      'status': status,
      'dataDeAdocao': dataDeAdocao,
    };
  }

  Map<String, dynamic> toJsonid() {
    return {
      'id': id,
    };
  }
}
