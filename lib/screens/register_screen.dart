import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';

class RegisterScreen extends StatelessWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  RegisterScreen({
    super.key,
    FirebaseAuth? authMock,
    FirebaseFirestore? firestoreMock,
  }) : auth = authMock ?? FirebaseAuth.instance,
       firestore = firestoreMock ?? FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            _buildTextField(
              nameController,
              'Nome Completo',
              Icons.person_outline,
            ),
            const SizedBox(height: 20),
            _buildTextField(emailController, 'E-mail', Icons.email_outlined),
            const SizedBox(height: 20),
            _buildTextField(
              passwordController,
              'Crie uma Senha',
              Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  String name = nameController.text.trim();
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();

                  if (name.isEmpty || email.isEmpty || password.isEmpty) {
                    _showSnackBar(
                      context,
                      'Todos os campos são obrigatórios!',
                      Colors.redAccent,
                    );
                    return;
                  }

                  // Mostra o loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );

                  try {
                    // 1. Cria usuário no Auth
                    UserCredential userCredential = await auth
                        .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                    // 2. Salva dados extras no Firestore
                    await firestore
                        .collection('users')
                        .doc(userCredential.user!.uid)
                        .set({
                          'name': name,
                          'email': email,
                          'createdAt': FieldValue.serverTimestamp(),
                          'favoriteIds': [],
                        });

                    // 3. Atualiza o nome de exibição no Firebase Auth
                    await userCredential.user?.updateDisplayName(name);

                    if (context.mounted) {
                      Navigator.pop(context); // Fecha o loading

                      _showSnackBar(
                        context,
                        'Conta criada com sucesso!',
                        Colors.green,
                      );

                      // Vai direto para a Home e limpa as telas anteriores
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false,
                      );
                    }
                  } catch (e) {
                    if (context.mounted)
                      Navigator.pop(context); // Fecha o loading

                    String msg = 'Erro ao cadastrar. Tente novamente.';
                    if (e is FirebaseAuthException) {
                      if (e.code == 'weak-password')
                        msg = 'A senha é muito fraca.';
                      else if (e.code == 'email-already-in-use')
                        msg = 'Este e-mail já está em uso.';
                    }

                    _showSnackBar(context, msg, Colors.redAccent);
                    print("ERRO NO CADASTRO: $e"); // Ajuda a debugar no console
                  }
                },
                child: const Text(
                  'CADASTRAR E ENTRAR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }
}
