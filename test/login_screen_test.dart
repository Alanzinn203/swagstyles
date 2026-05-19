import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swagstyles/screens/login_screen.dart';
import 'package:swagstyles/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Geramos os dublês para os DOIS serviços
@GenerateNiceMocks([MockSpec<FirebaseAuth>(), MockSpec<FirebaseFirestore>()])
import 'login_screen_test.mocks.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
  });

  // Helper para carregar a tela de forma limpa em cada teste
  Future<void> loadScreen(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(authMock: mockAuth, firestoreMock: mockFirestore),
    ));
  }

  group('LoginScreen - UI e Validações', () {
    testWidgets('Deve exibir todos os elementos iniciais da tela', (tester) async {
      await loadScreen(tester);

      expect(find.text('SWAG STYLES'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2)); // E-mail e Senha
      expect(find.text('ENTRAR'), findsOneWidget);
      expect(find.text('CRIAR NOVA CONTA'), findsOneWidget);
    });

    testWidgets('Deve mostrar erro ao tentar logar com campos vazios', (tester) async {
      await loadScreen(tester);

      await tester.tap(find.text('ENTRAR'));
      await tester.pump();

      expect(find.text('Por favor, preencha seu e-mail e senha.'), findsOneWidget);
    });

    testWidgets('Deve mostrar erro se o e-mail for inválido (sem @)', (tester) async {
      await loadScreen(tester);

      await tester.enterText(find.byType(TextField).at(0), 'email_invalido');
      await tester.enterText(find.byType(TextField).at(1), '123456');
      
      await tester.tap(find.text('ENTRAR'));
      await tester.pump();

      expect(find.text('Formato inválido. Utilize @gmail, @email, etc.'), findsOneWidget);
    });
  });

  group('LoginScreen - Integração e Navegação', () {
    testWidgets('Deve navegar para RegisterScreen ao clicar em CRIAR NOVA CONTA', (tester) async {
      await loadScreen(tester);

      await tester.tap(find.text('CRIAR NOVA CONTA'));
      await tester.pumpAndSettle();

      expect(find.byType(RegisterScreen), findsOneWidget);
    });

    testWidgets('Deve chamar o Firebase com sucesso quando dados estiverem corretos', (tester) async {
      await loadScreen(tester);

      await tester.enterText(find.byType(TextField).at(0), 'usuario@teste.com');
      await tester.enterText(find.byType(TextField).at(1), 'senha123');

      await tester.tap(find.text('ENTRAR'));
      await tester.pump(); // Inicia o processo de login

      // Verifica se a função de login do Firebase foi chamada exatamente com esses dados
      verify(mockAuth.signInWithEmailAndPassword(
        email: 'usuario@teste.com',
        password: 'senha123',
      )).called(1);
    });

    testWidgets('Deve exibir SnackBar de erro quando o Firebase falhar', (tester) async {
      // Configuramos o dublê para lançar um erro de senha incorreta
      when(mockAuth.signInWithEmailAndPassword(
        email: 'usuario@teste.com',
        password: 'senha_errada',
      )).thenThrow(FirebaseAuthException(code: 'wrong-password'));

      await loadScreen(tester);

      await tester.enterText(find.byType(TextField).at(0), 'usuario@teste.com');
      await tester.enterText(find.byType(TextField).at(1), 'senha_errada');

      await tester.tap(find.text('ENTRAR'));
      
      // O pumpAndSettle garante que o Dialog de loading feche e a SnackBar apareça
      await tester.pumpAndSettle();

      expect(find.text('E-mail ou senha incorretos.'), findsOneWidget);
    });
  });
}