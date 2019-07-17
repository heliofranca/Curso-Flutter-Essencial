import 'package:carros/domain/login_service.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/utils/alerts.dart';
import 'package:carros/utils/navigation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FLoginController = TextEditingController(text: "Hélio");
  final FSenhaController = TextEditingController(text: "12345");
  final GlobalKey<FormState> FFormKey = GlobalKey<FormState>();

  var FProgress = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: _body(context),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: FFormKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            validator: _validateLogin,
            controller: FLoginController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Login",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
              hintText: "Digite o usuário",
            ),
          ),
          TextFormField(
            validator: _validateSenha,
            controller: FSenhaController,
            obscureText: true,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText: "Senha",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
              hintText: "Digite a senha",
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 50,
            child: RaisedButton(
              onPressed: () {
                _onClickLogin(context);
              },
              color: Colors.blue,
              child: FProgress
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o usuário";
    }

    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    if (text.length < 2) {
      return "A senha deve conter no mínimo 2 caracteres";
    }

    return null;
  }

  _onClickLogin(BuildContext context) async {
    final login = FLoginController.text;
    final senha = FSenhaController.text;

    if (!FFormKey.currentState.validate()) {
      return;
    }

    print("Login: $login, Senha: $senha");

    setState(() {
      FProgress = true;
    });

    final response = await LoginService.login(login, senha);

    if (response.isOK()) {
      push(context, HomePage());
    } else {
      alert(
        context,
        response.status,
        response.msg,
      );
    }

    setState(() {
      FProgress = false;
    });
  }
}
