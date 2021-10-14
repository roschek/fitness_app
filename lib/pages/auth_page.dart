import 'package:fit_proj/domain/user.dart';
import 'package:fit_proj/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showLogin = true;
  final AuthService _authService = AuthService();

  void _loginAction()  async {
        _email = _emailController.text;
        _password = _passwordController.text;
    if(_email.isEmpty || _password.isEmpty) return;
        LocalUser? user = await _authService.signInWithEmailAndPassword(_email.trim(), _password.trim());
        if(user == null) {
          Fluttertoast.showToast(
            msg: "Неправильный пароль или электронная почта",
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16
          );
        } else {
          _emailController.clear();
          _passwordController.clear();
        }
        }


  _registrationAction() async{
        _email = _emailController.text;
        _password = _passwordController.text;
        if(_email.length <4 || _password.length < 4) return;
        LocalUser? user = await _authService.registerWithEmailAndPassword(_email.trim(), _password.trim());
        if(user == null) {
          Fluttertoast.showToast(
              msg: "пароль  должен быть дленнее 4 символов или электронная почта",
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16
          );
        } else {
          _emailController.clear();
          _passwordController.clear();
        }
      }

  Widget _form(String label, void Function() sendRegistration) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: _inputField(
                const Icon(Icons.email), 'EMAIL', _emailController, false)),
        Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: _inputField(
                const Icon(Icons.lock), 'PASSWORD', _passwordController, true)),
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white30),
                    overlayColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () => {sendRegistration()},
                  child: Text(
                    label,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            )),
      ],
    );
  }

  Widget _inputField(
      Icon icon, String hint, TextEditingController controller, bool obscure) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
            hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white38),
            hintText: hint,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54, width: 1)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                data: const IconThemeData(color: Colors.white),
                child: icon,
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
              child: Text(
            'Введите ваш e-mail и пароль',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          )),
          (showLogin
              ? _form('ВОЙТИ', _loginAction)
              : _form('ЗАРЕГИСТРИРОВАТЬСЯ', _registrationAction)),
          showLogin
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    child: const Text('Еще не зарегистрировались?',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onTap: () {
                      setState(() {
                        showLogin = false;
                      });
                    },
                  ))
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    child: const Text('Уже зарегистрированы?',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onTap: () {
                      setState(() {
                        showLogin = true;
                      });
                    },
                  ))
        ],
      ),
    );
  }
}
