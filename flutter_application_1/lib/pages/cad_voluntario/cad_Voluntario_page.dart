import 'dart:html';
import 'dart:typed_data';
import 'package:br_validators/masks/br_masks.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:flutter_application_1/services/voluntario/voluntario_services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import '../../services/users/users_services.dart';

class CadVoluntarioPage extends StatefulWidget {
  CadVoluntarioPage({Key? key}) : super(key: key);

  @override
  State<CadVoluntarioPage> createState() => _CadVoluntarioPageState();
}

class _CadVoluntarioPageState extends State<CadVoluntarioPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _dtnascimento = TextEditingController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _endereco = TextEditingController();
  final TextEditingController _telefone = TextEditingController();
  final TextEditingController _renda = TextEditingController();
  final TextEditingController _tipoUsuario = TextEditingController();
  String selectedProfile = '';
  //final List<String> options = ['Voluntário', 'Administrador'];

  final VoluntarioServices _voluntarioServices = VoluntarioServices();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  var cpfMask = BRMasks.cpf;
  //late String selectedProfile = '';

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
                "Novo Cadastro de Voluntário",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _nome,
              decoration: InputDecoration(
                labelText: "Nome Completo",
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
            SizedBox(height: 10),
            TextFormField(
              controller: _cpf,
              decoration: InputDecoration(
                labelText: "CPF",
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
              keyboardType: TextInputType.number,
              inputFormatters: [BRMasks.cpf],
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _endereco,
              decoration: InputDecoration(
                labelText: "Endereço",
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
            SizedBox(height: 10),
            //-------------------------------------//dt nascimento

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
            SizedBox(height: 10),
            // -----------------------------------------------------------------------------------
            TextFormField(
              controller: _telefone,
              decoration: InputDecoration(
                labelText: 'Celular',
                hintText: 'xx-xxxxx-xxxx',
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
              keyboardType: TextInputType.phone,
              inputFormatters: [
                MultiMaskedTextInputFormatter(
                  masks: ['xx-xxxxx-xxxx'],
                  separator: '-',
                ),
              ],
            ),
            //-------------------------------------------------------------------------------
            const SizedBox(height: 10),

            const Row(
              children: [
                Text('Selecione abaixo o tipo de perfil do usuário: '),
              ],
            ),

            const SizedBox(height: 10),

            // ListView.builder(
            //   itemCount: options.length,
            //   itemBuilder: (context, index) {
            //     final option = options[index];
            //     return ListTile(
            //       title: Text(option),
            //       leading: Radio(
            //         value: option,
            //         groupValue: selectedOption,
            //         onChanged: (value) {
            //           // Atualize o estado quando uma opção for selecionada.
            //           // Isso fará com que o widget seja reconstruído com a nova seleção.
            //           setState(() {
            //             selectedOption = value!;
            //           });
            //         },
            //       ),
            //     );
            //   },
            // ),

            RadioListTile(
              title: Text('Voluntário'),
              value: 'Voluntário',
              groupValue: selectedProfile,
              onChanged: (value) {
                setState(() {
                  selectedProfile = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text('Administrador'),
              value: 'Administrador',
              groupValue: selectedProfile,
              onChanged: (value) {
                setState(() {
                  selectedProfile = value.toString();
                });
              },
            ),

            //-------------------------------------------------------------------------------
            SizedBox(height: 10),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                labelText: "email",
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
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              controller: _password,
              decoration: InputDecoration(
                labelText: "senha",
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
                      if (_email.text.isEmpty ||
                          _password.text.isEmpty ||
                          _nome.text.isEmpty ||
                          _cpf.text.isEmpty ||
                          _endereco.text.isEmpty ||
                          _dtnascimento.text.isEmpty ||
                          _telefone.text.isEmpty ||
                          selectedProfile.isEmpty) {
                        _voluntarioServices.showErrorDialog(
                            context, 'todos os campos devem ser preenchidos');
                        return;
                      }
                      if (_password.text.length < 6) {
                        debugPrint("senha menor que 6 caracteres");
                        return;
                      }
                      if (await _voluntarioServices.signUp(
                        _email.text,
                        _password.text,
                        _nome.text,
                        _cpf.text,
                        _endereco.text,
                        _dtnascimento.text,
                        _telefone.text,
                        _renda.text,
                        selectedProfile,
                      )) {
                        _voluntarioServices.showSuccessDialog(
                            context, 'cadastro salvo com sucesso!');
                        //Navigator.pop(context);
                      } else {
                        _voluntarioServices.showErrorDialog(
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
