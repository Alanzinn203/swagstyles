import 'package:flutter/material.dart';

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
              'Medidas referem-se ao comprimento da palmilha.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF222222),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  columns: const [
                    DataColumn(label: Text('BR')),
                    DataColumn(label: Text('US')),
                    DataColumn(label: Text('Tamanho (cm)')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('34')),
                      DataCell(Text('5')),
                      DataCell(Text('22,5 cm')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('36')),
                      DataCell(Text('6')),
                      DataCell(Text('24 cm')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('38')),
                      DataCell(Text('7')),
                      DataCell(Text('25 cm')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('40')),
                      DataCell(Text('8.5')),
                      DataCell(Text('26,5 cm')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('42')),
                      DataCell(Text('10')),
                      DataCell(Text('28 cm')),
                    ]),
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