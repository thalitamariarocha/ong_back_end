import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/usuarios/adotante.dart';
import 'package:flutter_application_1/pages/aprovacao/aprov_cadastro.dart';
import 'package:flutter_application_1/services/users/users_services.dart';

class AdotanteDetailPage extends StatefulWidget {
  final Adotante adotante;

  const AdotanteDetailPage({Key? key, required this.adotante})
      : super(key: key);

  @override
  State<AdotanteDetailPage> createState() => _AdotanteDetailPageState();
}

class _AdotanteDetailPageState extends State<AdotanteDetailPage> {
  UserServices adotanteServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber, // Cor do app bar
        title: Text("Detalhes do Adotante"),
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nome:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adotante.nome ?? "Não informado",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              const Text(
                "CPF:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adotante.cpf ?? "Não informado",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Data de Nascimento:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adotante.dtNascimento ?? "Não informado",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Telefone:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adotante.telefone ?? "Não informado",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              const Text(
                "Endereço:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adotante.endereco ?? "Não informado",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              const Text(
                "Renda:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adotante.renda ?? "Não informado",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              const Text(
                "Tipo de Moradia:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adotante.tipoMoradia ?? "Não informado",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              const Text(
                "Documento Pessoal:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Image.network(widget.adotante.image ?? "Não informado"),
              SizedBox(height: 24),

//----------------------------------------------------------------------------

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       primary: Colors.red,
                    //   shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(20),
                    //   ),
                     ),
                    onPressed: () {
                      adotanteServices
                          .reprovarAdotante(widget.adotante.id.toString());
                      adotanteServices.showSuccessDialog(
                          context, "Cadastro Reprovado!");
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AprovarCadastro()));
                      });
                    },
                    child: const Text(
                      "Reprovar Cadastro",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       primary: Colors.green,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                    ),
                    onPressed: () {
                      adotanteServices
                          .aprovarAdotante(widget.adotante.id.toString());

                      adotanteServices.showSuccessDialog(
                          context, "Cadastro aprovado com sucesso!");

                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AprovarCadastro()));
                      });
                    },
                    child: const Text(
                      "Aprovar Cadastro",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
