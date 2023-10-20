import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/animal/animal.dart';
import 'package:flutter_application_1/services/adocao/adocao_services.dart';
import 'package:flutter_application_1/services/animal/animal_services.dart';

class DetailsAnimalPage extends StatefulWidget {
  final Animal animal;

  const DetailsAnimalPage({Key? key, required this.animal}) : super(key: key);

  @override
  State<DetailsAnimalPage> createState() => _DetailsAnimalPage();
}

class _DetailsAnimalPage extends State<DetailsAnimalPage> {
  AnimalServices animalServices = AnimalServices();
  AdocaoServices adocaoServices = AdocaoServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber, // Cor do app bar
        title: Text("Detalhes do Animal"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Image.network(widget.animal.image ?? "Não informado",
                  width: 200, fit: BoxFit.cover),
              const SizedBox(height: 12),
              const Text(
                "Nome:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.animal.nome ?? "Não informado",
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
                widget.animal.especie ?? "Não informado",
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
                widget.animal.dtNascimento ?? "Não informado",
                style: TextStyle(fontSize: 16),
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
                widget.animal.sexo ?? "Não informado",
                style: TextStyle(fontSize: 16),
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
                widget.animal.porte ?? "Não informado",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Vacinas tomadas:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.animal.vacina ?? "Não informado",
                style: TextStyle(fontSize: 16),
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
                widget.animal.castrado ?? "Não informado",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "Descrição:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.animal.observacao ?? "Não informado",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "ONG que está com o animal:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.animal.vinculoOng ?? "Não informado",
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 24),

//----------------------------------------------------------------------------

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await adocaoServices.propostaAdocao(widget.animal.id,
                          FirebaseAuth.instance.currentUser!.uid);
                      animalServices.showSuccessDialog(context,
                          'solicitação cadastrada. Aguarde a aprovação da ONG.');
                    },
                    child: const Text(
                      "Quero Adotar!!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
