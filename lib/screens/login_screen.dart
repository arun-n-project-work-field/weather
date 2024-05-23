import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:weather_assignment/screens/home_screen.dart';
import 'package:weather_assignment/screens/signup_screen.dart';
import 'package:weather_assignment/widgets/errors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              height: 200,
              child: Image.network(
                  'https://images.pexels.com/photos/415368/pexels-photo-415368.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            ),
            const Center(
                child: Text(
              'Weather App',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            )),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: controllerUsername,
              enabled: !isLoggedIn,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Username'),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: controllerPassword,
              enabled: !isLoggedIn,
              obscureText: true,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Password'),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: isLoggedIn ? null : () => doUserLogin(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Row(children: <Widget>[
              Expanded(child: Divider()),
              Text(
                "or",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
              ),
              Expanded(child: Divider()),
            ]),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('Sign Up'),
                onPressed: () => navigateToSignUp(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ]),
        ),
      ),
    );
  }

  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      navigateToUser();
    } else {
      Message.showError(context: context, message: response.error!.message);
    }
  }

  void navigateToUser() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (Route<dynamic> route) => false,
    );
  }

  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }
}
