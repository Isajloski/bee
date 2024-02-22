import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // Прикажи ја E-mail формата, податоците се чуваат во контролерот emailController
          children: [
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
            // Прикажи го копчето Register
            ElevatedButton(
              // Обиди се да крериаш нов профил, во спротивно прикажи ерор.
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  if (userCredential.user != null) {
                    // Успрешноа е регистрацијата
                    print('Успешно сте регистрирани: ${userCredential.user!.uid}');
                  }
                } catch (e) {
                  // Обидете се повторно
                  print('Обидете се повторно: $e');
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
