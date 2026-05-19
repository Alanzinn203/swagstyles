import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perguntas Frequentes')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ExpansionTile(
            title: Text(
              'Os tênis vendidos na loja são originais?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                child: Text(
                  'Com certeza! Trabalhamos exclusivamente com produtos 100% originais e autênticos. Todos os nossos tênis passam por um rigoroso processo de verificação de autenticidade (legit check) feito por especialistas antes de serem enviados para você. Eles sempre acompanham a caixa original e todos os acessórios de fábrica.',
                  style: TextStyle(height: 1.5, color: Colors.white70),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Quais são as formas de pagamento aceitas?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                child: Text(
                  'Para facilitar a sua compra, oferecemos diversas opções:\n\n'
                  '• PIX: Aprovação imediata e separação prioritária do pedido.\n'
                  '• Cartão de Crédito: Parcelamento em até 12x, sendo aceitas as principais bandeiras do mercado.\n'
                  '• Boleto Bancário: O pagamento pode levar de 1 a 3 dias úteis para ser compensado pelo banco.',
                  style: TextStyle(height: 1.5, color: Colors.white70),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Como funciona o custo de envio e o prazo de entrega?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                child: Text(
                  'O custo de envio e o prazo são calculados de forma automática no checkout, baseados no seu CEP e no volume da caixa. Oferecemos opções de frete Expresso (Sedex) para quem tem pressa e Normal (PAC). Lembrando que temos Frete Grátis para todo o Brasil em compras acima de R\$ 999,00!',
                  style: TextStyle(height: 1.5, color: Colors.white70),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Qual é a política de troca e devolução?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                child: Text(
                  'Se o tênis não servir ou você não gostar, não se preocupe! Você tem até 7 dias corridos, contados a partir do recebimento, para solicitar a devolução ou troca. O tênis deve ser devolvido na condição original (sem marcas de uso, com as etiquetas fixadas e dentro da caixa intacta). O frete da primeira troca é por nossa conta!',
                  style: TextStyle(height: 1.5, color: Colors.white70),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Estou em dúvida sobre a numeração. O que eu faço?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                child: Text(
                  'Cada marca pode ter uma forma levemente diferente. Por isso, recomendamos fortemente que você acesse o nosso "Guia de Medidas" disponível no menu principal. Lá, nós detalhamos o tamanho exato da palmilha em centímetros. Medir o seu pé ou a palmilha de um tênis confortável que você já tenha é a forma mais segura de acertar na escolha.',
                  style: TextStyle(height: 1.5, color: Colors.white70),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Como eu acompanho o rastreio do meu pedido?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                child: Text(
                  'Assim que o pagamento for aprovado e o pedido despachado, você receberá um e-mail com a nota fiscal e o código de rastreamento. Você também pode acompanhar o status da entrega acessando a aba "Minha Conta" no menu lateral do nosso app.',
                  style: TextStyle(height: 1.5, color: Colors.white70),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Vocês fazem reposição de modelos que esgotaram?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                child: Text(
                  'Como trabalhamos com muitos tênis de edição limitada e "hype", vários modelos não recebem reposição das marcas após esgotarem. Sugerimos que você fique de olho em nossas redes sociais e ative as notificações, pois algumas vezes conseguimos pares extras com nossos fornecedores parceiros através de "Restocks" surpresas.',
                  style: TextStyle(height: 1.5, color: Colors.white70),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
