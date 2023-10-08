import 'dart:html';
import 'dart:typed_data';
import 'package:br_validators/masks/br_masks.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:flutter_application_1/services/ong/ong_services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import '../../services/users/users_services.dart';

class CadOngPage extends StatelessWidget {
  CadOngPage({Key? key}) : super(key: key);

  final TextEditingController _email = TextEditingController();
  final TextEditingController _cnpj = TextEditingController();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _endereco = TextEditingController();
  final TextEditingController _telefone = TextEditingController();

  final OngServices _services = OngServices();
  var cnpjMask = BRMasks.cnpj;

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
            ),
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                "Cadastrar ONG",
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
                labelText: "Nome Fantasia",
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
              controller: _cnpj,
              decoration: InputDecoration(
                labelText: "CNPJ",
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
              inputFormatters: [BRMasks.cnpj],
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
            // -----------------------------------------------------------------------------------
            TextFormField(
              controller: _telefone,
              decoration: InputDecoration(
                labelText: 'Telefone',
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

            const SizedBox(height: 15),

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
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //minimumSize: const Size.fromHeight(50),
                      shape: LinearBorder.bottom(),
                    ),

                    onPressed: () async {
                      if (_email.text.isEmpty ||
                          _cnpj.text.isEmpty ||
                          _nome.text.isEmpty ||
                          _endereco.text.isEmpty ||
                          _telefone.text.isEmpty) {
                        _services.showErrorDialog(
                            context, 'todos os campos devem ser preenchidos');
                        return;
                      }
                      if (await _services.cadastrarOng(_nome.text, _cnpj.text,
                          _telefone.text, _endereco.text, _email.text)) {
                        _services.showSuccessDialog(
                            context, 'cadastro salvo com sucesso!');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                        );
                      } else {
                        _services.showErrorDialog(
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
