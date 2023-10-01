import 'dart:html';
import 'dart:typed_data';
import 'package:br_validators/masks/br_masks.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import '../../services/users/users_services.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _dtnascimento = TextEditingController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _endereco = TextEditingController();
  final TextEditingController _telefone = TextEditingController();
  final TextEditingController _renda = TextEditingController();
  final TextEditingController _tipoMoradia = TextEditingController();

  final UserServices _userServices = UserServices();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  var cpfMask = BRMasks.cpf;
  late String urlImg;

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
                "Cadastre-se",
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
            SizedBox(height: 10),
            TextFormField(
                controller: _renda,
                decoration: InputDecoration(
                  labelText: "Valor Mensal de Renda",
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
                inputFormatters: [
                  //mascara de dinheiro
                  CurrencyTextInputFormatter(
                    locale: 'br',
                    //decimalDigits: 0,
                    symbol: 'BRL',
                  )
                ],
                keyboardType: TextInputType.number),
            //-------------------------------------------------------------------------------
            SizedBox(height: 10),
            TextFormField(
              controller: _tipoMoradia,
              decoration: InputDecoration(
                labelText: "informe o tipo de moradia",
                hintText: 'ex: casa, apartamento, etc',
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
            // carregar imagem teste
            const Row(
              children: [
                Text('Insira abaixo a imagem do documento pessoal: '),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: LinearBorder.bottom(),
              ),
              onPressed: () async {
                await _userServices.pickAndUploadImage();
              },
              child: const Text('selecione aqui'),
            ),

            const SizedBox(height: 15),

            Row(
              //botao voltar e cadastrar
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child:
                        //botao voltar
                        ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: LinearBorder.bottom(),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Voltar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )),
                Expanded(
                  child:
                      //botao registrar
                      ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
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
                          _renda.text.isEmpty ||
                          _tipoMoradia.text.isEmpty) {
                        _userServices.showErrorDialog(
                            context, 'todos os campos devem ser preenchidos');
                        return;
                      }
                      if (_password.text.length < 6) {
                        debugPrint("senha menor que 6 caracteres");
                        return;
                      }
                      if (await _userServices.signUp(
                        _email.text,
                        _password.text,
                        _nome.text,
                        _cpf.text,
                        _endereco.text,
                        _dtnascimento.text,
                        _telefone.text,
                        _renda.text,
                        _tipoMoradia.text,
                      )) {
                        //  await _userServices.salvaImagem(image);
                        Navigator.pop(context);
                      } else {
                        debugPrint("erro, favor repetir");
                      }
                    }, //chamada do signup do user_services (controller)
                    child: const Text(
                      "Registrar",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 15.0,
              ),
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: const Text(
                  "já tem conta? Login",
                  style: TextStyle(color: Color.fromARGB(255, 61, 6, 112)),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
