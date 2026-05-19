import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color1;
  final Color color2;
  final IconData? icon;
  final String? imagePath; // Adicionado para a foto do tênis flutuando
  final String? buttonText; // Adicionado para o botão de ação

  const BannerCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color1,
    required this.color2,
    this.icon,
    this.imagePath,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color2.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Ícone de fundo (se não houver imagem)
            if (icon != null && imagePath == null)
              Positioned(
                bottom: -20,
                right: -10,
                child: Icon(
                  icon,
                  size: 120,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            
            // Imagem do Tênis Flutuando
            if (imagePath != null)
              Positioned(
                right: -30,
                bottom: -20,
                child: Transform.rotate(
                  angle: -0.1, // Leve inclinação para dar dinamismo
                  child: Image.asset(
                    imagePath!,
                    width: 220,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

            // Textos e Botão
            Positioned(
              top: 25,
              left: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.2,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  if (buttonText != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        buttonText!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
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