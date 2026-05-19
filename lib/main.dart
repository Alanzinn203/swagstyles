import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Precisamos disso pro AuthGate
import 'firebase_options.dart';


import 'screens/home_page.dart';
import 'screens/login_screen.dart';


void main() async {
  // Garante que o Flutter inicialize antes do Firebase
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Erro ao inicializar Firebase: $e");
  }

  runApp(const AirCollectionApp());
}

class AirCollectionApp extends StatelessWidget {
  const AirCollectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swag Styles',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF181818),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.redAccent,
        ),
      ),
      // AQUI ESTAVA O ERRO! Agora o AuthGate assume o controle.
      home: const AuthGate(),
    );
  }
}

// --- O GUARDIÃO DE AUTENTICAÇÃO ---
// Ele fica "vigiando" o Firebase. Se o usuário logar, ele muda pra HomePage na mesma hora.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Se a conexão estiver carregando
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // Se o usuário estiver logado, vai direto para a Home!
        if (snapshot.hasData) {
          return const HomePage();
        }
        // Se NÃO estiver logado, fica na tela de Login
        return LoginScreen();
      },
    );
  }
}
