import 'package:flutter/material.dart';
import 'dart:ui';

// --- Imports dos Modelos e Widgets ---
import '../models/sneaker.dart';
import '../widgets/banner_card.dart';
import '../widgets/sneaker_cards.dart';
import '../widgets/sneaker_details_modal.dart';

// --- Imports das Telas ---
import 'cart_screen.dart';
import 'login_screen.dart';
import 'account_screen.dart';
import 'size_guide_screen.dart';
import 'faq_screen.dart';
import 'contact_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Sneaker> cartItems = [];
  Set<String> favoriteIds = {};
  bool isSearching = false;
  String searchQuery = '';

  // --- Variáveis de Filtro e Ordenação ---
  String sortOption = 'Relevância';
  final List<String> sortOptions = ['Relevância', 'Maior Preço', 'Menor Preço'];

  List<String> selectedCategories = [];
  final List<String> categories = [
    'Nike',
    'Adidas',
    'Asics',
    'Jordan',
    'Dior',
    'Balenciaga',
    'Bape',
  ];

  List<String> selectedColors = [];
  final List<String> colors = [
    'Branco',
    'Preto',
    'Azul',
    'Bege',
    'Cinza',
    'Vermelho',
    'Prata',
    'Laranja',
    'Amarelo',
    'Rosa',
    'Verde',
  ];

  List<String> selectedSizes = [];
  final List<String> sizes = ['38', '39', '40', '41', '42', '43', '44'];

  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  double? minPrice;
  double? maxPrice;

  final ScrollController _scrollController = ScrollController();

  final List<Sneaker> catalog = [
    Sneaker(
      id: '1',
      name: 'Air Max 95 "OG Neon"',
      description: 'Inspirado no corpo humano e no DNA da corrida.',
      detailedDescription:
          'O Nike Air Max 95 se inspira no corpo humano e na estética de atletismo dos anos 90.',
      price: 1329.99,
      imagePath: 'assets/images/airmax95og.jpg',
      category: 'Nike',
      colors: ['Cinza', 'Verde'],
      sizes: ['38', '39', '40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '2',
      name: 'Air Max 97 "Wolf Grey"',
      description: 'O design clássico inspirado em trens-bala japoneses.',
      detailedDescription:
          'Inspirado na beleza e na aerodinâmica dos trens-bala japoneses, o Nike Air Max 97 impulsiona o seu estilo a toda velocidade.',
      price: 1234.99,
      imagePath: 'assets/images/airmax97white.jpg',
      category: 'Nike',
      colors: ['Cinza', 'Prata'],
      sizes: ['38', '39', '40', '41', '42'],
    ),
    Sneaker(
      id: '3',
      name: 'Air Max Plus "Sunset"',
      description: 'O clássico Tuned Air, com energia e atitude de sobra.',
      detailedDescription:
          'Comemore o estilo ousado com o Nike Air Max Plus. Ele oferece uma experiência Tuned Air que proporciona estabilidade premium.',
      price: 1519.99,
      imagePath: 'assets/images/airmaxtn_sunset.jpg',
      category: 'Nike',
      colors: ['Laranja', 'Vermelho', 'Preto'],
      sizes: ['39', '40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '4',
      name: 'Air Max DN "Laser Orange"',
      description: 'A nova geração do ar. Tecnologia Dynamic Air.',
      detailedDescription:
          'Sinta o irreal. O Air Max DN apresenta a nossa tecnologia Dynamic Air com sistema de tubos de dupla pressão.',
      price: 879.99,
      imagePath: 'assets/images/dn_laserorange.jpg',
      category: 'Nike',
      colors: ['Laranja'],
      sizes: ['40', '41', '42', '43'],
    ),
    Sneaker(
      id: '5',
      name: 'Jordan 11 Retro "Cool Grey"',
      description: 'J11',
      detailedDescription:
          'Lançado originalmente em 2001 e eternizado por MJ, o Jordan 11 "Cool Grey" é mais que um sneaker, é uma declaração de estilo. Com seu icônico verniz em tons de cinza e o solado translúcido.',
      price: 1599.99,
      imagePath: 'assets/images/j11coolgrey.jpg',
      category: 'Jordan',
      colors: ['Cinza', 'Branco'],
      sizes: ['38', '40', '42', '44'],
    ),
    Sneaker(
      id: '6',
      name: 'Air Max Dn8 "Black Leather"',
      description: 'D',
      detailedDescription:
          'O Air Max Dn8 eleva a tecnologia Dynamic Air a um novo patamar. Com oito câmaras de ar visíveis, ele não entrega apenas amortecimento, mas uma transição de peso que parece vir de outro planeta.',
      price: 1499.99,
      imagePath: 'assets/images/blackleatherdn8.jpg',
      category: 'Nike',
      colors: ['Preto'],
      sizes: ['39', '40', '41', '42', '43'],
    ),
    Sneaker(
      id: '7',
      name: 'P-6000 "Triple White"',
      description: 'D',
      detailedDescription:
          'O Nike P-6000 "Triple White" é a fusão perfeita entre a estética de corrida dos anos 2000 e o conforto moderno. Inspirado nos clássicos do passado da linha Pegasus.',
      price: 899.99,
      imagePath: 'assets/images/p6000white.jpg',
      category: 'Nike',
      colors: ['Branco'],
      sizes: ['38', '39', '40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '8',
      name: 'Air Jordan 4 Retro "Fire Red"',
      description: 'D',
      detailedDescription:
          'O Air Jordan 4 Retro "Fire Red" não é apenas um tênis; é um pedaço da história da cultura sneaker e do basquete. Desenhado pelo lendário Tinker Hatfield e lançado originalmente em 1989.',
      price: 1499.99,
      imagePath: 'assets/images/j4retrofire.jpg',
      category: 'Jordan',
      colors: ['Branco', 'Vermelho', 'Preto'],
      sizes: ['40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '9',
      name: 'Balenciaga Track LED Black',
      description: 'D',
      detailedDescription:
          'Com um design robusto e futurista, ele combina múltiplas camadas de materiais premium que criam uma estética ousada e sofisticada ao mesmo tempo. Destaque para a tecnologia LED integrada na sola.',
      price: 2279.99,
      imagePath: 'assets/images/trackledd.jpg',
      category: 'Balenciaga',
      colors: ['Preto'],
      sizes: ['38', '39', '40', '41'],
    ),
    Sneaker(
      id: '10',
      name: 'Dior B22 "Black Reflective"',
      description: 'D',
      detailedDescription:
          'Com um design robusto, moderno e cheio de personalidade, o B22 incorpora a forte tendência “chunky” em uma versão sofisticada e cuidadosamente refinada.',
      price: 1710.99,
      imagePath: 'assets/images/diorb22.jpg',
      category: 'Dior',
      colors: ['Branco', 'Bege', 'Cinza'],
      sizes: ['39', '40', '41', '42'],
    ),
    Sneaker(
      id: '11',
      name: 'Air Max Plus Drift "Black Deep Royal Baltic Blue"',
      description: 'Uma evolução futurista do clássico Tuned Air.',
      detailedDescription:
          'O Air Max Plus Drift redefine o design original com uma estrutura de TPU mais robusta e fluida.',
      price: 987.99,
      imagePath: 'assets/images/driftblackdeeproyal.jpg',
      category: 'Nike',
      colors: ['Preto', 'Azul'],
      sizes: ['40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '12',
      name: 'Air Jordan 4 "Women"',
      description: 'Silhueta icônica com ajuste e cores exclusivas.',
      detailedDescription:
          'Este Air Jordan 4 foi projetado pensando especificamente no público feminino, mantendo todos os elementos que tornaram o modelo um ícone desde 1989.',
      price: 1799.99,
      imagePath: 'assets/images/womenj4.jpg',
      category: 'Jordan',
      colors: ['Branco', 'Bege'],
      sizes: ['38', '39', '40', '41'],
    ),
    Sneaker(
      id: '13',
      name: 'Shox TL "Triple White"',
      description: 'O retorno triunfal das molas em um visual clean.',
      detailedDescription:
          'O Nike Shox TL leva o amortecimento mecânico ao limite. Esta versão "Triple White" apresenta um cabedal em malha respirável e sobreposições sintéticas que brilham na sua pureza.',
      price: 1399.99,
      imagePath: 'assets/images/shoxtriplewhite.jpg',
      category: 'Nike',
      colors: ['Branco'],
      sizes: ['39', '40', '41', '42', '43'],
    ),
    Sneaker(
      id: '14',
      name: 'Asics Gel NYC "Graphite Grey Black"',
      description: 'A fusão perfeita entre herança e modernidade.',
      detailedDescription:
          'O ASICS Gel NYC combina referências de modelos clássicos como o GEL-NIMBUS 3 e o MC-PLUS V.',
      price: 759.99,
      imagePath: 'assets/images/nycblackgel.jpg',
      category: 'Asics',
      colors: ['Cinza', 'Preto'],
      sizes: ['38', '39', '40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '15',
      name: 'Palace x Nike Air Max 95 "Metallic Silver"',
      description: 'Colaboração de peso entre o skate e o esporte.',
      detailedDescription:
          'A união entre a gigante do skate Palace e a Nike resulta em um Air Max 95 futurista. O acabamento Metallic Silver dá ao modelo uma estética industrial.',
      price: 1219.99,
      imagePath: 'assets/images/palacemetallic.jpg',
      category: 'Nike',
      colors: ['Prata'],
      sizes: ['40', '41', '42'],
    ),
    Sneaker(
      id: '16',
      name: 'Shox TL "Metallic Hematite"',
      description: 'Estilo agressivo com acabamento premium metálico.',
      detailedDescription:
          'Conhecido popularmente como "Shox Preto", a versão Metallic Hematite oferece um brilho sutil e furtivo.',
      price: 1399.99,
      imagePath: 'assets/images/shoxblack.jpg',
      category: 'Nike',
      colors: ['Preto', 'Prata'],
      sizes: ['39', '40', '41', '42', '43'],
    ),
    Sneaker(
      id: '17',
      name: 'Air Force 1 "White"',
      description: 'O maior clássico de todos os tempos.',
      detailedDescription:
          'Inalterado e essencial, o Air Force 1 "Triple White" é a definição de versatilidade. Couro legítimo, entressola macia e uma silhueta que transcende gerações.',
      price: 799.99,
      imagePath: 'assets/images/af1white.jpg',
      category: 'Nike',
      colors: ['Branco'],
      sizes: ['38', '39', '40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '18',
      name: 'Air Max 95 x Corteiz "Honey Black"',
      description: 'Uma das colaborações mais exclusivas do streetwear.',
      detailedDescription:
          'A marca londrina Corteiz coloca sua identidade no Air Max 95. Com cores inspiradas na natureza e no ambiente urbano, o detalhe "Honey" destaca-se no interior camuflado.',
      price: 1429.99,
      imagePath: 'assets/images/honeyblack.jpg',
      category: 'Nike',
      colors: ['Preto', 'Amarelo'],
      sizes: ['41', '42', '43'],
    ),
    Sneaker(
      id: '19',
      name: 'Asics Gel NYC "Cream Mineral Beige Pink"',
      description: 'Cores suaves em uma silhueta robusta.',
      detailedDescription:
          'Esta iteração do Gel NYC traz uma paleta sofisticada em tons de creme e bege mineral, com toques sutis de rosa.',
      price: 769.99,
      imagePath: 'assets/images/mineralpink.jpg',
      category: 'Asics',
      colors: ['Bege', 'Branco', 'Rosa'],
      sizes: ['38', '39', '40', '41'],
    ),
    Sneaker(
      id: '20',
      name: 'ASICS Gel NYC "Storm Cloud Pure Silver"',
      description: 'O brilho do prata metálico com tons sóbrios.',
      detailedDescription:
          'Inspirado na energia das tempestades e no brilho metálico de Nova York, este modelo apresenta sobreposições em Pure Silver sobre um mesh Storm Cloud.',
      price: 779.99,
      imagePath: 'assets/images/stormcloudasics.jpg',
      category: 'Asics',
      colors: ['Cinza', 'Prata'],
      sizes: ['40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '21',
      name: 'Jordan 11 Retro Low "University Blue" (2026)',
      description: 'O clássico esquema de cores de UNC em versão Low.',
      detailedDescription:
          'Comemorando o legado de Michael Jordan em North Carolina, este modelo apresenta o icônico couro envernizado em University Blue contrastando com o mesh branco balístico.',
      price: 1899.99,
      imagePath: 'assets/images/universityblue.jpg',
      category: 'Jordan',
      colors: ['Branco', 'Azul'],
      sizes: ['38', '39', '40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '22',
      name: 'Jordan 11 Retro "Gamma Blue" (2025)',
      description: 'Um dos esquemas de cores mais desejados da linha 11.',
      detailedDescription:
          'Retornando em 2025, o "Gamma Blue" traz um cabedal totalmente preto em mesh e couro envernizado, com detalhes vibrantes em azul Gamma e amarelo Varsity.',
      price: 2450.00,
      imagePath: 'assets/images/gammablue.jpg',
      category: 'Jordan',
      colors: ['Preto', 'Azul'],
      sizes: ['41', '42', '43', '44'],
    ),
    Sneaker(
      id: '23',
      name: 'Jordan 4 Retro "Fear" (2024)',
      description: 'Inspirado na icônica campanha "Fear" de 2013.',
      detailedDescription:
          'Este modelo apresenta uma paleta de cores degradê que vai do preto ao cinza, com o famoso solado com efeito respingado (speckled). Construído em nubuck premium de alta durabilidade.',
      price: 2100.00,
      imagePath: 'assets/images/retrofear.jpg',
      category: 'Jordan',
      colors: ['Preto', 'Cinza'],
      sizes: ['39', '40', '41', '42', '43'],
    ),
    Sneaker(
      id: '24',
      name: 'Nike Air VaporMax Plus "Triple Black"',
      description: 'Design agressivo com amortecimento máximo.',
      detailedDescription:
          'Combinando o cabedal do Air Max Plus com a sola tecnológica VaporMax, este modelo oferece um visual furtivo e futurista com conforto surreal para o dia a dia.',
      price: 1499.90,
      imagePath: 'assets/images/vapormaxplus.jpg',
      category: 'Nike',
      colors: ['Preto'],
      sizes: ['38', '39', '40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '25',
      name: 'adidas Yeezy Slide "Onyx"',
      description: 'Minimalismo e conforto extremo por Kanye West.',
      detailedDescription:
          'Construída em espuma EVA injetada, a Yeezy Slide Onyx oferece durabilidade leve e uma palmilha macia para conforto imediato. O design icônico que redefiniu os chinelos de luxo.',
      price: 850.00,
      imagePath: 'assets/images/yeezyslide.jpg',
      category: 'Adidas',
      colors: ['Preto'],
      sizes: ['38', '39', '40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '26',
      name: 'Jordan 5 Retro OG "Black Metallic Reimagined"',
      description: 'Um clássico de 1990 com materiais premium.',
      detailedDescription:
          'A versão "Reimagined" traz de volta o nubuck preto profundo, detalhes refletivos na língua e os "dentes de tubarão" prateados na entressola, seguindo as especificações originais da marca.',
      price: 1950.00,
      imagePath: 'assets/images/j5og.jpg',
      category: 'Jordan',
      colors: ['Preto', 'Prata'],
      sizes: ['40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '27',
      name: 'A Bathing Ape Bape Sta #3 "Shark Blue"',
      description: 'O ícone do streetwear japonês com o visual Shark.',
      detailedDescription:
          'Esta Bape Sta traz a estética inconfundível da marca japonesa, com couro envernizado em tons de azul e o gráfico de tubarão na lateral. Item de alto impacto visual.',
      price: 2800.00,
      imagePath: 'assets/images/bapestashark.jpg',
      category: 'Bape',
      colors: ['Azul', 'Branco'],
      sizes: ['39', '40', '41', '42'],
    ),
    Sneaker(
      id: '28',
      name: 'Jordan 4 Retro "Forget Me Not" (W)',
      description: 'Elegância feminina em tons de azul pastel.',
      detailedDescription:
          'Um lançamento exclusivo feminino que utiliza tons suaves de azul e branco. Combina camurça e couro de alta qualidade, sendo uma opção sofisticada para qualquer coleção.',
      price: 2200.00,
      imagePath: 'assets/images/forgetmenot.jpg',
      category: 'Jordan',
      colors: ['Azul', 'Branco'],
      sizes: ['38', '39', '40'],
    ),
    Sneaker(
      id: '29',
      name: 'Jordan 4 Retro "Black Cat" (2025)',
      description: 'O retorno de um dos maiores clássicos da história.',
      detailedDescription:
          'Construído em nubuck totalmente preto com detalhes em grafite fosco, o Black Cat é um dos modelos mais cobiçados do mundo pela sua versatilidade e presença imbatível.',
      price: 3200.00,
      imagePath: 'assets/images/blackcat.jpg',
      category: 'Jordan',
      colors: ['Preto'],
      sizes: ['38', '39', '40', '41', '42', '43', '44'],
    ),
    Sneaker(
      id: '30',
      name: 'Balenciaga Track White',
      description: 'Luxo vanguardista com pingentes exclusivos.',
      detailedDescription:
          'A Balenciaga eleva o modelo Track nesta versão da cor branca. Um design complexo com múltiplas camadas de mesh e nylon premium.',
      price: 6500.00,
      imagePath: 'assets/images/trackwhite.jpg',
      category: 'Balenciaga',
      colors: ['Branco'],
      sizes: ['38', '39', '40', '41', '42'],
    ),
  ];

  // --- Lógica Aplicada para Filtros e Busca ---
  List<Sneaker> get displayedCatalog {
    List<Sneaker> filtered = catalog.where((sneaker) {
      if (searchQuery.isNotEmpty &&
          !sneaker.name.toLowerCase().contains(searchQuery.toLowerCase())) {
        return false;
      }
      if (minPrice != null && sneaker.price < minPrice!) return false;
      if (maxPrice != null && sneaker.price > maxPrice!) return false;
      if (selectedCategories.isNotEmpty &&
          !selectedCategories.contains(sneaker.category)) {
        return false;
      }
      if (selectedColors.isNotEmpty &&
          !sneaker.colors.any((c) => selectedColors.contains(c))) {
        return false;
      }
      if (selectedSizes.isNotEmpty &&
          !sneaker.sizes.any((s) => selectedSizes.contains(s))) {
        return false;
      }
      return true;
    }).toList();

    if (sortOption == 'Maior Preço') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortOption == 'Menor Preço') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    }

    return filtered;
  }

  void applyPriceFilter() {
    setState(() {
      minPrice = double.tryParse(minPriceController.text);
      maxPrice = double.tryParse(maxPriceController.text);
    });
  }

  void addToCart(Sneaker sneaker) {
    setState(() => cartItems.add(sneaker));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Text('${sneaker.name} adicionado!'),
          ],
        ),
        backgroundColor: Colors.green.shade800,
      ),
    );
  }

  void toggleFavorite(String id) {
    setState(() {
      favoriteIds.contains(id) ? favoriteIds.remove(id) : favoriteIds.add(id);
    });
  }

  void scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _openSneakerModal(
    BuildContext context,
    Sneaker sneaker,
    String heroTag,
  ) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Fechar',
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SneakerDetailsModal(
          sneaker: sneaker,
          heroTag: heroTag,
          onAddToCart: () {
            addToCart(sneaker);
            Navigator.pop(context);
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation =
            Tween<Offset>(
              begin: const Offset(0.0, 0.1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12 * animation.value,
            sigmaY: 12 * animation.value,
          ),
          child: FadeTransition(
            opacity: animation,
            child: SlideTransition(position: slideAnimation, child: child),
          ),
        );
      },
    );
  }

  // =========================================================================
  // NOVO: MÉTODO QUE CONSTROÍ O MENU UNIFICADO (NAVEGAÇÃO + FILTROS)
  // =========================================================================
  List<Widget> _buildUnifiedMenu() {
    return [
      // 1. HEADER DO MENU
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

      // 2. LINKS DE NAVEGAÇÃO
      ListTile(
        leading: const Icon(Icons.person, color: Colors.white),
        title: const Text('Minha Conta', style: TextStyle(color: Colors.white)),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AccountScreen()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.straighten, color: Colors.white),
        title: const Text(
          'Guia de Medidas',
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SizeGuideScreen()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.help_outline, color: Colors.white),
        title: const Text(
          'Perguntas Frequentes',
          style: TextStyle(color: Colors.white),
        ),
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
        title: const Text('Contato', style: TextStyle(color: Colors.white)),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContactScreen()),
          );
        },
      ),
      const Divider(color: Colors.grey),

      // =========================================================
      // 3. INÍCIO DOS FILTROS (Tudo junto no mesmo menu)
      // =========================================================
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          'FILTROS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),

      // ORDENAR POR
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ORDENAR POR',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: sortOption,
              dropdownColor: const Color(0xFF252525),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFF252525),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              items: sortOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => sortOption = newValue);
                }
              },
            ),
          ],
        ),
      ),

      // CATEGORIAS
      Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: const Text(
            'CATEGORIAS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.grey,
          children: categories.map((category) {
            return CheckboxListTile(
              title: Text(
                category,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              value: selectedCategories.contains(category),
              activeColor: Colors.white,
              checkColor: Colors.black,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              dense: true,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedCategories.add(category);
                  } else {
                    selectedCategories.remove(category);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      const Divider(color: Colors.white12),

      // CORES
      Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: const Text(
            'COR',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.grey,
          children: colors.map((color) {
            return CheckboxListTile(
              title: Text(
                color,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              value: selectedColors.contains(color),
              activeColor: Colors.white,
              checkColor: Colors.black,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              dense: true,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedColors.add(color);
                  } else {
                    selectedColors.remove(color);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      const Divider(color: Colors.white12),

      // TAMANHOS
      Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: const Text(
            'TAMANHO',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.grey,
          children: sizes.map((size) {
            return CheckboxListTile(
              title: Text(
                size,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              value: selectedSizes.contains(size),
              activeColor: Colors.white,
              checkColor: Colors.black,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              dense: true,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedSizes.add(size);
                  } else {
                    selectedSizes.remove(size);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      const Divider(color: Colors.white12),

      // PREÇO
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PREÇO',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minPriceController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: const InputDecoration(
                      hintText: 'Mín',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Color(0xFF252525),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('-', style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  child: TextField(
                    controller: maxPriceController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: const InputDecoration(
                      hintText: 'Máx',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Color(0xFF252525),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  applyPriceFilter();
                  // Fecha o menu se estiver no celular após aplicar o filtro
                  if (MediaQuery.of(context).size.width <= 900) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Aplicar Preço'),
              ),
            ),
          ],
        ),
      ),

      const Divider(color: Colors.grey),

      // BOTÃO SAIR
      ListTile(
        leading: const Icon(Icons.logout, color: Colors.redAccent),
        title: const Text(
          'Sair da Conta',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
          );
        },
      ),
      const SizedBox(height: 40),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),

      // ÚNICO DRAWER (MENU) PARA O APLICATIVO
      drawer: Drawer(
        backgroundColor: const Color(0xFF1E1E1E), // Fundo unificado
        child: ListView(
          padding: EdgeInsets.zero,
          children: _buildUnifiedMenu(),
        ),
      ),

      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: isSearching
            ? TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Pesquisar...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() => searchQuery = value),
              )
            : const Text(
                'SWAG STYLES',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Georgia',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () => setState(() {
              isSearching = !isSearching;
              if (!isSearching) searchQuery = '';
            }),
          ),
          // Botão de Filtro agora abre o mesmo Drawer principal da esquerda
          if (!isDesktop)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        cartItems: cartItems,
                        onRemove: (sneaker) =>
                            setState(() => cartItems.remove(sneaker)),
                      ),
                    ),
                  );
                },
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
                        color: Colors.white,
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Renderiza o menu unificado como uma barra lateral se for tela grande (Desktop)
          if (isDesktop)
            Container(
              width: 260,
              color: const Color(0xFF151515),
              child: ListView(
                padding: EdgeInsets.zero,
                children: _buildUnifiedMenu(),
              ),
            ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSearching &&
                      selectedCategories.isEmpty &&
                      selectedColors.isEmpty &&
                      selectedSizes.isEmpty &&
                      minPrice == null &&
                      maxPrice == null) ...[
                    // ==========================================
                    // 1. BANNER PRINCIPAL: TELA CHEIA
                    // ==========================================
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/bannerswag.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ==========================================
                    // 2. BANNER DE 30% OFF
                    // ==========================================
                    Container(
                      height: 180,
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1A1A1A), Color(0xFF000000)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 24,
                                  bottom: 24,
                                  right: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ATÉ 30% OFF',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            letterSpacing: 1.1,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Modelos hypados.',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Text(
                                        'CONFIRA ABAIXO',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: -20,
                                    top: 0,
                                    bottom: 0,
                                    child: Transform.rotate(
                                      angle: -0.1,
                                      child: Image.asset(
                                        'assets/images/trackledd.jpg',
                                        width: 180,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],

                  if (!isSearching && displayedCatalog.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Mais Vendidos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                onPressed: scrollLeft,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                onPressed: scrollRight,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 24),
                        itemCount: displayedCatalog.take(5).length,
                        itemBuilder: (context, index) {
                          final sneaker = displayedCatalog[index];
                          final heroTag = 'featured_${sneaker.id}';
                          return Container(
                            width: 260,
                            margin: const EdgeInsets.only(right: 20),
                            child: FeaturedSneakerCard(
                              sneaker: sneaker,
                              isFavorite: favoriteIds.contains(sneaker.id),
                              onToggleFavorite: () =>
                                  toggleFavorite(sneaker.id),
                              onAddToCart: () => addToCart(sneaker),
                              onTap: () =>
                                  _openSneakerModal(context, sneaker, heroTag),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      isSearching ||
                              sortOption != 'Relevância' ||
                              minPrice != null ||
                              selectedCategories.isNotEmpty ||
                              selectedColors.isNotEmpty ||
                              selectedSizes.isNotEmpty
                          ? 'Resultados'
                          : 'Todos os Modelos',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  displayedCatalog.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text(
                              'Nenhum modelo encontrado com os filtros atuais.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 350,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                            itemCount: displayedCatalog.length,
                            itemBuilder: (context, index) {
                              final sneaker = displayedCatalog[index];
                              final heroTag = 'grid_${sneaker.id}';
                              return SneakerCard(
                                sneaker: sneaker,
                                isFavorite: favoriteIds.contains(sneaker.id),
                                onToggleFavorite: () =>
                                    toggleFavorite(sneaker.id),
                                onAddToCart: () => addToCart(sneaker),
                                onTap: () => _openSneakerModal(
                                  context,
                                  sneaker,
                                  heroTag,
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
