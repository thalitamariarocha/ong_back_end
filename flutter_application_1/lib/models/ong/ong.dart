class Ong {
  String? id;
  String? nome;
  String? cnpj;
  String? telefone;
  String? endereco;
  String? email;

  //construtor
  Ong({
    this.id,
    this.nome,
    this.cnpj,
    this.telefone,
    this.endereco,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'telefone': telefone,
      'endereco': endereco,
      'email': email,
    };
  }

  Map<String, dynamic> toJsonid() {
    return {
      'id': id,
    };
  }
}
