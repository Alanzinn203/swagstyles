import 'package:flutter/material.dart';
import 'home_page.dart';

class PaymentScreen extends StatefulWidget {
  final double total;
  const PaymentScreen({super.key, required this.total});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _paymentMethod = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagamento')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Valor a Pagar: R\$ ${widget.total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              'Selecione a forma de pagamento:',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF222222),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RadioListTile(
                    title: const Text('PIX (Aprovação Imediata)'),
                    secondary: const Icon(
                      Icons.qr_code,
                      color: Colors.tealAccent,
                    ),
                    value: 1,
                    groupValue: _paymentMethod,
                    onChanged: (val) =>
                        setState(() => _paymentMethod = val as int),
                    activeColor: Colors.redAccent,
                  ),
                  const Divider(color: Colors.grey, height: 1),
                  RadioListTile(
                    title: const Text('Cartão de Crédito (Até 12x)'),
                    secondary: const Icon(
                      Icons.credit_card,
                      color: Colors.white,
                    ),
                    value: 2,
                    groupValue: _paymentMethod,
                    onChanged: (val) =>
                        setState(() => _paymentMethod = val as int),
                    activeColor: Colors.redAccent,
                  ),
                  const Divider(color: Colors.grey, height: 1),
                  RadioListTile(
                    title: const Text('Boleto Bancário'),
                    secondary: const Icon(Icons.receipt, color: Colors.white),
                    value: 3,
                    groupValue: _paymentMethod,
                    onChanged: (val) =>
                        setState(() => _paymentMethod = val as int),
                    activeColor: Colors.redAccent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pedido processado com sucesso! 🎉'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'CONFIRMAR PAGAMENTO',
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
