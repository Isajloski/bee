import 'package:bee/Widget/MapWidget.dart';
import 'package:bee/Widget/TrainWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Прикажи ја E-mail формата, податоците се чуваат во контролерот emailController
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            // Прикажи ја Password формата, податоците се чуваат во контролерот passwordController
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            // Прикажи го Login копчето
            ElevatedButton(
              // Пробај да се логираш , доколку е усоешно испечати го тоа, во срптиво прикажи дека не е успешно
              onPressed: () async {
                try {
                  UserCredential userCredential =
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  if (userCredential.user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Успешно сте се логирале!'),
                      ),
                    );
                    print("Успешно сте се логирале");
                    // Со помош на овој код ние немам опција за враќање назат,
                    // кога ќе се логира корисникот тој е логиран
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => TrainWidget(),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Обидете се повторно'),
                    ),
                  );
                  print("Обидете се повторно ${e}");
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
