import 'dart:html';
import 'dart:typed_data';
import 'package:br_validators/masks/br_masks.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:flutter_application_1/services/animal/animal_services.dart';
import 'package:flutter_application_1/services/voluntario/voluntario_services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadAnimalPage extends StatefulWidget {
  CadAnimalPage({Key? key}) : super(key: key);

  @override
  State<CadAnimalPage> createState() => _CadVoluntarioPageState();
}

class _CadVoluntarioPageState extends State<CadAnimalPage> {
  final TextEditingController _dtnascimento = TextEditingController();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _obsevacao = TextEditingController();
  final TextEditingController _vacinas = TextEditingController();
  String selectedPorte = '';
  String selectedCastrado = '';
  String selectedSexo = '';
  String selectedEspecie = '';
  final AnimalServices _animalServices = AnimalServices();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  var cpfMask = BRMasks.cpf;

  late List<String> _names = [];

  @override
  void initState() {
    super.initState();

    //_names = _loadNamesFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 50, left: 50),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              "assets/images/Untitled.png",
              fit: BoxFit.contain,
              //width: 300,
            ),
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                "Novo Cadastro de Animal",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //------------------------------------------------------------------
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Selecione a ONG que o animal é vinculado:",
              ),
            ),

            FutureBuilder<List<String>>(
              future: _animalServices.loadNamesFromFirebase()
                  as Future<List<String>>?,
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Erro ao carregar os nomes');
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return DropdownButton<String>(
                    alignment: Alignment.bottomCenter,
                    borderRadius: BorderRadius.circular(10),
                    value: _animalServices.selectedOng,
                    onChanged: (String? newValue) {
                      setState(() {
                        _animalServices.selectedOng = newValue!;
                      });
                    },
                    items: snapshot.data!.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                }

                return const CircularProgressIndicator();
              },
            ),

            //------------------------------------------------------------------
            SizedBox(height: 30),
            TextFormField(
              controller: _nome,
              decoration: InputDecoration(
                labelText: "Nome",
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            //--------------------------------------------------------------------------
            SizedBox(height: 30),
            TextFormField(
              controller: _dtnascimento,
              decoration: InputDecoration(
                labelText: 'Data de nascimento',
                hintText: 'DD/MM/AAAA',
                prefixIcon: const Icon(Icons.calendar_today),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              //keyboardType: TextInputType.datetime,
              inputFormatters: [
                MultiMaskedTextInputFormatter(
                  masks: ['DD/MM/YYYY'],
                  separator: '/',
                ),
              ],
            ),

            //---------------------------------------------------------------------------
            const SizedBox(height: 10),

            const Row(
              children: [
                Text('Selecione o porte do animal: '),
              ],
            ),

            const SizedBox(height: 10),

            RadioListTile(
              title: Text('Pequeno'),
              value: 'Pequeno',
              groupValue: selectedPorte,
              onChanged: (value) {
                setState(() {
                  selectedPorte = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text('Médio'),
              value: 'Médio',
              groupValue: selectedPorte,
              onChanged: (value) {
                setState(() {
                  selectedPorte = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text('Grande'),
              value: 'Grande',
              groupValue: selectedPorte,
              onChanged: (value) {
                setState(() {
                  selectedPorte = value.toString();
                });
              },
            ),

            //-------------------------------------------------------------------------------
            const SizedBox(height: 10),

            const Row(
              children: [
                Text('O animal é castrado?: '),
              ],
            ),

            const SizedBox(height: 10),

            RadioListTile(
              title: Text('Sim'),
              value: 'Sim',
              groupValue: selectedCastrado,
              onChanged: (value) {
                setState(() {
                  selectedCastrado = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text('Não'),
              value: 'Não',
              groupValue: selectedCastrado,
              onChanged: (value) {
                setState(() {
                  selectedCastrado = value.toString();
                });
              },
            ),
            //--------------------------------------------------------------------------------
            const SizedBox(height: 10),

            const Row(
              children: [
                Text('Sexo: '),
              ],
            ),

            const SizedBox(height: 10),

            RadioListTile(
              title: Text('Masculino'),
              value: 'Masculino',
              groupValue: selectedSexo,
              onChanged: (value) {
                setState(() {
                  selectedSexo = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text('Feminino'),
              value: 'Feminino',
              groupValue: selectedSexo,
              onChanged: (value) {
                setState(() {
                  selectedSexo = value.toString();
                });
              },
            ),
            const SizedBox(height: 15),

            //-------------------------------------------------------------------------------

            const Row(
              children: [
                Text('Espécie: '),
              ],
            ),

            const SizedBox(height: 10),

            RadioListTile(
              title: Text('Cachorro'),
              value: 'Cachorro',
              groupValue: selectedEspecie,
              onChanged: (value) {
                setState(() {
                  selectedEspecie = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text('Gato'),
              value: 'Gato',
              groupValue: selectedEspecie,
              onChanged: (value) {
                setState(() {
                  selectedEspecie = value.toString();
                });
              },
            ),

            const SizedBox(height: 15),

            //-------------------------------------------------------------------------------

            SizedBox(height: 30),
            TextFormField(
              controller: _obsevacao,
              maxLines: 5, // Permite múltiplas linhas de texto
              keyboardType: TextInputType
                  .multiline, // Define o teclado para aceitar várias linhas de texto
              decoration: InputDecoration(
                labelText: "Observações",
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            //-------------------------------------------------------------------------------
            SizedBox(height: 30),
            TextFormField(
              controller: _vacinas,
              maxLines: 3, // Permite múltiplas linhas de texto
              keyboardType: TextInputType
                  .multiline, // Define o teclado para aceitar várias linhas de texto
              decoration: InputDecoration(
                labelText: "Vacinas tomadas",
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            //--------------------------------------------------------------------------------
            SizedBox(height: 30),
            const Row(
              children: [
                Text('Insira abaixo a imagem do animal: '),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: LinearBorder.bottom(),
              ),
              onPressed: () async {
                await _animalServices.pickAndUploadImage();
              },
              child: const Text('selecione aqui'),
            ),

            const SizedBox(height: 15),

            //-------------------------------------------------------------------------------

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //minimumSize: const Size.fromHeight(50),
                      shape: LinearBorder.bottom(),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Voltar",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),

                //Column(
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // minimumSize: const Size.fromHeight(50),
                      shape: LinearBorder.bottom(),
                    ),
                    onPressed: () async {
                      if (_nome.text.isEmpty ||
                          _dtnascimento.text.isEmpty ||
                          _obsevacao.text.isEmpty ||
                          _vacinas.text.isEmpty ||
                          selectedPorte.isEmpty ||
                          selectedCastrado.isEmpty ||
                          selectedSexo.isEmpty ||
                          selectedEspecie.isEmpty ||
                          _animalServices.selectedOng.isEmpty) {
                        _animalServices.showErrorDialog(
                            context, 'todos os campos devem ser preenchidos');
                        return;
                      }
                      // ignore: unnecessary_null_comparison
                      if (_animalServices.pickAndUploadImage == null) {
                        _animalServices.showErrorDialog(
                            context, 'selecione uma imagem');
                        return;
                      }
                      if (await _animalServices.cadastrarAnimal(
                        selectedEspecie,
                        selectedSexo,
                        selectedPorte,
                        _dtnascimento.text,
                        _nome.text,
                        _vacinas.text,
                        selectedCastrado,
                        _obsevacao.text,
                        _animalServices.selectedOng,
                      )) {
                        // ignore: use_build_context_synchronously
                        _animalServices.showSuccessDialog(
                            context, 'cadastro salvo com sucesso!');
                      } else {
                        // ignore: use_build_context_synchronously
                        _animalServices.showErrorDialog(
                            context, 'erro, favor repetir');
                      }
                    }, //chamada do signup do user_services (controller)
                    child: const Text(
                      "Registrar",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 15.0,
                  ),
                  alignment: Alignment.bottomRight,
                ),
              ],
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}
