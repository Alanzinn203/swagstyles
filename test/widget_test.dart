import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swagstyles/screens/login_screen.dart';
import 'package:swagstyles/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // <-- Importação adicionada
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Geramos os dublês para os DOIS serviços
@GenerateNiceMocks([MockSpec<FirebaseAuth>(), MockSpec<FirebaseFirestore>()])
import 'widget_test.mocks.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore; // <-- Variável adicionada

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore(); // <-- Inicialização adicionada
  });

  // --- TESTE 1 ---
  testWidgets('Tela de login carrega e exibe campos e botão', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(authMock: mockAuth, firestoreMock: mockFirestore),
    ));
    expect(find.byType(Scaffold), findsWidgets);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('ENTRAR'), findsOneWidget);
  });

  // --- TESTE 2 ---
  testWidgets('Mostra erro se tentar logar com campos vazios', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(authMock: mockAuth, firestoreMock: mockFirestore),
    ));
    await tester.tap(find.text('ENTRAR'));
    await tester.pump();
    expect(find.text('Por favor, preencha seu e-mail e senha.'), findsOneWidget);
  });

  // --- TESTE 3 ---
  testWidgets('Mostra erro se o e-mail não tiver arroba (@)', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(authMock: mockAuth, firestoreMock: mockFirestore),
    ));
    final camposDeTexto = find.byType(TextField);
    await tester.enterText(camposDeTexto.first, 'joaozinho_sem_arroba_no_email');
    await tester.enterText(camposDeTexto.last, '123456');
    await tester.tap(find.text('ENTRAR'));
    await tester.pump();
    expect(find.text('Formato inválido. Utilize @gmail, @email, etc.'), findsOneWidget);
  });

  // --- TESTE 4 (O QUE ESTAVA FALHANDO) ---
  testWidgets('Navega para RegisterScreen ao clicar em CRIAR NOVA CONTA', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(authMock: mockAuth, firestoreMock: mockFirestore),
    ));
    await tester.tap(find.text('CRIAR NOVA CONTA'));
    await tester.pumpAndSettle();
    expect(find.byType(RegisterScreen), findsOneWidget);
  });

  // --- TESTE 5 ---
  testWidgets('Chama o Firebase com e-mail e senha corretos ao logar', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(authMock: mockAuth, firestoreMock: mockFirestore),
    ));
    final camposDeTexto = find.byType(TextField);
    await tester.enterText(camposDeTexto.first, 'teste@alura.com.br');
    await tester.enterText(camposDeTexto.last, 'senha123');
    await tester.tap(find.text('ENTRAR'));
    await tester.pump();
    
    verify(mockAuth.signInWithEmailAndPassword(
      email: 'teste@alura.com.br',
      password: 'senha123',
    )).called(1); 
  });

  // --- TESTE 6 ---
  testWidgets('Mostra mensagem de erro se a senha estiver incorreta no Firebase', (WidgetTester tester) async {
    when(mockAuth.signInWithEmailAndPassword(
      email: 'errado@teste.com',
      password: '123',
    )).thenThrow(FirebaseAuthException(code: 'wrong-password'));

    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(authMock: mockAuth, firestoreMock: mockFirestore),
    ));

    final camposDeTexto = find.byType(TextField);
    await tester.enterText(camposDeTexto.first, 'errado@teste.com');
    await tester.enterText(camposDeTexto.last, '123');

    await tester.tap(find.text('ENTRAR'));
    await tester.pumpAndSettle();

    expect(find.text('E-mail ou senha incorretos.'), findsOneWidget);
  });
}