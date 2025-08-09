import 'package:flutter/material.dart';

class BusinessCardPreviewWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final int layout;
  final Widget qr;

  const BusinessCardPreviewWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.layout,
    required this.qr,
  });

  @override
  Widget build(BuildContext context) {
    switch (layout) {
      case 1: // Título arriba, QR abajo
        return Column(
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            qr,
          ],
        );
      case 2: // QR a la derecha
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            qr,
          ],
        );
      case 3: // QR arriba, textos abajo
        return Column(
          children: [
            qr,
            const SizedBox(height: 12),
            Text(title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(fontSize: 16)),
          ],
        );
      default:
        return const Text('Diseño no válido');
    }
  }
}
