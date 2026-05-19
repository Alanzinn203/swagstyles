import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swagstyles/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// --- ESSA LINHA ABAIXO É A "ORDEM DE SERVIÇO" QUE ESTAVA FALTANDO! ---
@GenerateNiceMocks([MockSpec<FirebaseAuth>(), MockSpec<FirebaseFirestore>()])
import 'register_screen_test.mocks.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
  });

  // --- TESTE 1: Montagem da Tela ---
  testWidgets('Tela de registro carrega e exibe campos e botão', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RegisterScreen(authMock: mockAuth, firestoreMock: mockFirestore),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.text('CADASTRAR E ENTRAR'), findsOneWidget);
  });

  // --- TESTE 2: Validação Básica ---
  testWidgets('Mostra erro se tentar cadastrar com campos vazios', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RegisterScreen(authMock: mockAuth, firestoreMock: mockFirestore),
      ),
    );

    await tester.tap(find.text('CADASTRAR E ENTRAR'));
    await tester.pump();

    expect(find.text('Todos os campos são obrigatórios!'), findsOneWidget);
  });

  // --- TESTE 3: O Caminho do Sucesso (Auth + Firestore) ---
  testWidgets('Cadastro com sucesso chama Auth e salva no Firestore', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RegisterScreen(authMock: mockAuth, firestoreMock: mockFirestore),
      ),
    );

    // 1. Preenche os três campos
    final campos = find.byType(TextField);
    await tester.enterText(campos.at(0), 'Gabriel Alura'); // Nome
    await tester.enterText(campos.at(1), 'gabriel@teste.com'); // E-mail
    await tester.enterText(campos.at(2), '123456'); // Senha

    // 2. Clica para cadastrar
    await tester.tap(find.text('CADASTRAR E ENTRAR'));

    // O pump() faz a lógica começar, o pumpAndSettle() espera o loading sumir
    await tester.pump();

    // 3. VERIFICAÇÕES
    // Verificamos se o Auth foi chamado com os dados certos
    verify(
      mockAuth.createUserWithEmailAndPassword(
        email: 'gabriel@teste.com',
        password: '123456',
      ),
    ).called(1);

    // Verificamos se o Firestore foi acessado (coleção 'users')
    verify(mockFirestore.collection('users')).called(1);
  });
  // --- TESTE 4: Erro de E-mail em uso ---
  testWidgets('Mostra erro se o Firebase avisar que o e-mail já está em uso', (
    WidgetTester tester,
  ) async {
    // 1. CONFIGURAMOS O DUBLÊ PARA DAR ERRO
    // Quando tentarem criar conta com esse e-mail, o Auth vai "gritar" um erro
    when(
      mockAuth.createUserWithEmailAndPassword(
        email: 'ja_existe@teste.com',
        password: '123456',
      ),
    ).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

    await tester.pumpWidget(
      MaterialApp(
        home: RegisterScreen(authMock: mockAuth, firestoreMock: mockFirestore),
      ),
    );

    // 2. Preenche os campos
    final campos = find.byType(TextField);
    await tester.enterText(campos.at(0), 'Usuário Repetido');
    await tester.enterText(campos.at(1), 'ja_existe@teste.com');
    await tester.enterText(campos.at(2), '123456');

    // 3. Tenta cadastrar
    await tester.tap(find.text('CADASTRAR E ENTRAR'));

    // pumpAndSettle espera o loading sumir e a SnackBar aparecer
    await tester.pumpAndSettle();

    // 4. VERIFICAÇÃO
    // Checa se a sua mensagem personalizada de e-mail em uso apareceu
    expect(
      find.text('Este e-mail já está em uso por outra conta.'),
      findsOneWidget,
    );
  });
}
