class Voluntario {
  String? id;
  String? email;
  String? senha;
  String? cpf;
  String? dtNascimento;
  String? nome;
  String? telefone;
  String? endereco;
  String? tipoUsuario;
  String? vinculoOng;
  bool admin = false;

  //construtor
  Voluntario({
    this.id,
    this.email,
    this.senha,
    this.cpf,
    this.dtNascimento,
    this.nome,
    this.telefone,
    this.endereco,
    this.tipoUsuario,
    this.vinculoOng,
  });

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
      'tipoUsuario': tipoUsuario,
      'vinculoOng': vinculoOng,
    };
  }
}
