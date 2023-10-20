import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class Animal {
  String? id; //
  String? especie; //ok
  String? sexo; //ok
  String? porte; //ok
  String? dtNascimento; //ok
  String? nome; //ok
  String? vacina; //
  String? castrado; //ok
  String? observacao; //ok
  String? image; //ok
  String? vinculoOng;
  String? adotado = "false";

  //construtor
  Animal({
    this.id,
    this.especie,
    this.sexo,
    this.porte,
    this.dtNascimento,
    this.nome,
    this.vacina,
    this.castrado,
    this.observacao,
    this.image,
    this.vinculoOng,
    this.adotado,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'especie': especie,
      'sexo': sexo,
      'porte': porte,
      'dtNascimento': dtNascimento,
      'nome': nome,
      'vacina': vacina,
      'castrado': castrado,
      'observacao': observacao,
      'image': image,
      'vinculoOng': vinculoOng,
      'adotado': adotado,
    };
  }

  Map<String, dynamic> toJsonid() {
    return {
      'id': id,
    };
  }

  Map<String, dynamic> toJsonimage(image) {
    return {
      'image': image,
    };
  }
}
