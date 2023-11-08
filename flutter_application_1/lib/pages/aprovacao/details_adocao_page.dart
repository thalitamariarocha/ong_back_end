import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/adocao/adocao.dart';
import 'package:flutter_application_1/models/usuarios/adotante.dart';
import 'package:flutter_application_1/pages/aprovacao/aprov_adocao_page.dart';
import 'package:flutter_application_1/services/adocao/adocao_services.dart';
import 'package:flutter_application_1/services/animal/animal_services.dart';
import 'package:flutter_application_1/services/users/users_services.dart';

class AdocaoDetailPage extends StatefulWidget {
  final Adocao adocao;

  const AdocaoDetailPage({Key? key, required this.adocao}) : super(key: key);

  @override
  State<AdocaoDetailPage> createState() => _AdotanteDetailPageState();
}

class _AdotanteDetailPageState extends State<AdocaoDetailPage> {
  AdocaoServices adocaoServices = AdocaoServices();
  UserServices adotanteServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 210, 15), // Cor do app bar
        title: const Text("Detalhes da Adoção"),
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
                "Dados do Adotante:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Nome:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adocao.adotante!.nome ?? "Não informado",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "CPF:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adocao.adotante!.cpf ?? "Não informado",
                style: const TextStyle(fontSize: 16),
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
                widget.adocao.adotante!.telefone ?? "Não informado",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Endereço:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adocao.adotante!.endereco ?? "Não informado",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Renda:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adocao.adotante!.renda ?? "Não informado",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Tipo de Moradia:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adocao.adotante!.tipoMoradia ?? "Não informado",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                  height: 20,
                  child: Divider(
                    color: Color.fromARGB(255, 58, 56, 56),
                  )),
              const Text(
                "Dados do Animal:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Nome:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adocao.animal!.nome ?? "Não informado",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Espécie:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adocao.animal!.especie ?? "Não informado",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Sexo:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adocao.animal!.sexo ?? "Não informado",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Porte:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adocao.animal!.porte ?? "Não informado",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Castrado:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.adocao.animal!.castrado ?? "Não informado",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Data pedido de Adoção:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.adocao.dataDeAdocao ?? "Não informado",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),

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
                      adocaoServices
                          .reprovarAdocao(widget.adocao.id.toString());
                      adotanteServices.showSuccessDialog(
                          context, "Cadastro Reprovado!");
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AprovarAdocao()));
                      });
                    },
                    child: const Text(
                      "Reprovar Adoção",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                    ),
                    onPressed: () {
                      adocaoServices.aprovarAdocao(widget.adocao.id.toString(), widget.adocao.animal!.id.toString());
                      adotanteServices.showSuccessDialog(
                          context, "Cadastro aprovado com sucesso!");

                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AprovarAdocao()));
                      });
                    },
                    child: const Text(
                      "Aprovar Adoção",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
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
