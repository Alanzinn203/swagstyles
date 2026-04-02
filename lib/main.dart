import 'package:flutter/material.dart';

void main() {
  runApp(const AirCollectionApp());
}

class AirCollectionApp extends StatelessWidget {
  const AirCollectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universo Air',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
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
      home: const LoginScreen(),
    );
  }
}

class Sneaker {
  final String id;
  final String name;
  final String description;
  final String detailedDescription;
  final double price;
  final String imagePath;

  Sneaker({
    required this.id,
    required this.name,
    required this.description,
    required this.detailedDescription,
    required this.price,
    required this.imagePath,
  });
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.air, size: 80, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'U N I V E R S O  A I R',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text(
                    'ENTRAR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Ainda não tem conta? Cadastre-se',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome Completo',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Crie uma Senha',
                prefixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
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
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
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
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Sneaker> cartItems = [];
  bool isSearching = false;
  String searchQuery = '';

  final List<Sneaker> catalog = [
    Sneaker(
      id: '0',
      name: 'Air Jordan 1 Low "Black Phantom"',
      description: 'O ícone absoluto da cultura Streetwear.',
      detailedDescription:
          'Mais que um tênis, uma declaração de poder. O Air Jordan 1 Low Travis Scott Black Phantom é o ápice da exclusividade. Com sua estética Triple Black e costuras contrastantes, ele não apenas veste seus pés, ele define quem você é no asfalto. Uma obra de arte colecionável que une herança e hype em cada detalhe.',
      price: 4799.99,
      imagePath: 'assets/images/travisaj.jpg',
    ),
    Sneaker(
      id: '1',
      name: 'Air Max 95 "OG Neon"',
      description: 'Inspirado no corpo humano e no DNA da corrida.',
      detailedDescription:
          'O Nike Air Max 95 se inspira no corpo humano e na estética de atletismo dos anos 90.',
      price: 1329.99,
      imagePath: 'assets/images/airmax95og.jpg',
    ),
    Sneaker(
      id: '2',
      name: 'Air Max 97 "Wolf Grey"',
      description: 'O design clássico inspirado em trens-bala japoneses.',
      detailedDescription:
          'Inspirado na beleza e na aerodinâmica dos trens-bala japoneses, o Nike Air Max 97 impulsiona o seu estilo a toda velocidade.',
      price: 1234.99,
      imagePath: 'assets/images/airmax97white.jpg',
    ),
    Sneaker(
      id: '5',
      name: 'Jordan 11 Retro "Cool Grey"',
      description: 'Sofisticação em cada passo.',
      detailedDescription:
          'Lançado originalmente em 2001 e eternizado por MJ, o Jordan 11 "Cool Grey" é uma declaração de estilo com seu icônico verniz.',
      price: 2399.99,
      imagePath: 'assets/images/j11retro2.jpg',
    ),
    Sneaker(
      id: '6',
      name: 'Air Max Dn8 SP "Black Leather"',
      description: 'Tecnologia que parece vir de outro planeta.',
      detailedDescription:
          'O Air Max Dn8 eleva a tecnologia Dynamic Air a um novo patamar com oito câmaras de ar visíveis.',
      price: 1799.99,
      imagePath: 'assets/images/dn8sp.jpg',
    ),
  ];

  List<Sneaker> get displayedCatalog {
    if (searchQuery.isEmpty) return catalog;
    return catalog
        .where(
          (sneaker) =>
              sneaker.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  void addToCart(Sneaker sneaker) {
    setState(() {
      cartItems.add(sneaker);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Text('${sneaker.name} adicionado!'),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green.shade800,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Route _createCartRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CartScreen(
        cartItems: cartItems,
        onRemove: (sneaker) {
          setState(() {
            cartItems.remove(sneaker);
          });
        },
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.ease));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFF1E1E1E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('Minha Conta'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.straighten, color: Colors.white),
              title: const Text('Guia de Medidas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SizeGuideScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.white),
              title: const Text('Perguntas Frequentes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FAQScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.white),
              title: const Text('Contato'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactScreen(),
                  ),
                );
              },
            ),
            const Divider(color: Colors.grey),
          ],
        ),
      ),
      appBar: AppBar(
        title: isSearching
            ? TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Pesquisar...',
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() => searchQuery = value),
              )
            : const Text(
                'UNIVERSO AIR',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () => setState(() {
              isSearching = !isSearching;
              if (!isSearching) searchQuery = '';
            }),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () => Navigator.of(context).push(_createCartRoute()),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            if (!isSearching && catalog.isNotEmpty) ...[
              const Text(
                ' Mais Procurados',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 340,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: catalog.take(4).length,
                  itemBuilder: (context, index) {
                    final sneaker = catalog[index];
                    final heroTag = 'featured_${sneaker.id}';
                    return Container(
                      width: 260,
                      margin: const EdgeInsets.only(right: 20),
                      child: FeaturedSneakerCard(
                        sneaker: sneaker,
                        heroTag: heroTag,
                        onAddToCart: () => addToCart(sneaker),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SneakerDetailsScreen(
                                sneaker: sneaker,
                                heroTag: heroTag,
                                onAddToCart: () => addToCart(sneaker),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
            Text(
              isSearching ? 'Resultados' : 'Coleção Completa',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            displayedCatalog.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        'Nenhum modelo encontrado.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 350,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                    itemCount: displayedCatalog.length,
                    itemBuilder: (context, index) {
                      final sneaker = displayedCatalog[index];
                      final heroTag = 'grid_${sneaker.id}';
                      return SneakerCard(
                        sneaker: sneaker,
                        heroTag: heroTag,
                        onAddToCart: () => addToCart(sneaker),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SneakerDetailsScreen(
                                sneaker: sneaker,
                                heroTag: heroTag,
                                onAddToCart: () => addToCart(sneaker),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class FeaturedSneakerCard extends StatelessWidget {
  final Sneaker sneaker;
  final String heroTag;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;

  const FeaturedSneakerCard({
    super.key,
    required this.sneaker,
    required this.heroTag,
    required this.onAddToCart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '⭐ ITEM RARO',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 55,
              bottom: 100,
              left: 13,
              right: 13,
              child: Hero(
                tag: heroTag,
                child: Image.asset(
                  sneaker.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (c, e, s) => const Icon(
                    Icons.broken_image,
                    size: 45,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sneaker.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'R\$ ${sneaker.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SneakerCard extends StatelessWidget {
  final Sneaker sneaker;
  final String heroTag;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;

  const SneakerCard({
    super.key,
    required this.sneaker,
    required this.heroTag,
    required this.onAddToCart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Hero(
                    tag: heroTag,
                    child: Image.asset(
                      sneaker.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sneaker.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${sneaker.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: onAddToCart,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SneakerDetailsScreen extends StatelessWidget {
  final Sneaker sneaker;
  final String heroTag;
  final VoidCallback onAddToCart;

  const SneakerDetailsScreen({
    super.key,
    required this.sneaker,
    required this.heroTag,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40.0),
              child: Hero(
                tag: heroTag,
                child: Image.asset(
                  sneaker.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (c, e, s) =>
                      const Icon(Icons.image, size: 100, color: Colors.grey),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32.0),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          sneaker.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'R\$ ${sneaker.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Legado e Estilo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    sneaker.detailedDescription,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        onAddToCart();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'GARANTIR MEU PAR AGORA',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SizeGuideScreen extends StatelessWidget {
  const SizeGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guia de Medidas')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Encontre o seu tamanho ideal',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Medidas da palmilha interna em centímetros.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('BR')),
                    DataColumn(label: Text('US')),
                    DataColumn(label: Text('cm')),
                  ],
                  rows: List.generate(10, (index) {
                    int br = 34 + index;
                    return DataRow(
                      cells: [
                        DataCell(Text('$br')),
                        DataCell(Text('${5 + index * 0.5}')),
                        DataCell(Text('${22.5 + index * 0.5} cm')),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ExpansionTile(
            title: Text('Produtos Originais?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Trabalhamos com qualidade Premium 1:1 importada.'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Prazo de Entrega'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('De 2 a 7 dias úteis para pronta entrega.'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contato')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.chat, color: Colors.green),
              title: Text('+55 (11) 99815-7458'),
            ),
            const SizedBox(height: 20),
            TextField(decoration: const InputDecoration(labelText: 'Nome')),
            const SizedBox(height: 10),
            TextField(decoration: const InputDecoration(labelText: 'Mensagem')),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ENVIAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Sneaker> cartItems;
  final Function(Sneaker) onRemove;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: cartItems.isEmpty
          ? const Center(child: Text('Carrinho vazio.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Image.asset(item.imagePath, width: 50),
                        title: Text(item.name),
                        subtitle: Text('R\$ ${item.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => onRemove(item),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total:', style: TextStyle(fontSize: 20)),
                          Text(
                            'R\$ ${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('FINALIZAR COMPRA'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conta')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 20),
            const Text('Sneakerhead VIP', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              ),
              child: const Text('Sair'),
            ),
          
        ),
      ),
    );
  }
}
