class Adotante {
  String? id;
  String? email;
  String? senha;
  String? cpf;
  String? dtNascimento;
  String? nome;
  String? telefone;
  String? endereco;
  String? renda;
  String? tipoMoradia;
  String? image;
  String aprovado = "pendente";

  //construtor
  Adotante(
      {this.id,
      this.email,
      this.senha,
      this.cpf,
      this.dtNascimento,
      this.nome,
      this.telefone,
      this.endereco,
      this.renda,
      this.tipoMoradia,
      this.image,
      this.aprovado = "pendente"});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'senha': senha,
      'cpf': cpf,
      'dtNascimento': dtNascimento,
      'nome': nome,
      'telefone': telefone,
      'endereco': endereco,
      'renda': renda,
      'tipoMoradia': tipoMoradia,
      'image': image,
      'aprovado': aprovado
    };
  }
}
