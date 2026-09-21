import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/public_layout.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PublicLayout(
      currentRoute: AppRoutes.comoFunciona,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'COMO FUNCIONA',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Sua música no show em poucos passos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Escolha uma música do repertório e acompanhe seu pedido.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 28),

          _step(
            number: '01',
            icon: Icons.library_music_outlined,
            title: 'Explore o cardápio',
            description:
                'Veja as músicas disponíveis e encontre a que você quer ouvir.',
          ),

          _step(
            number: '02',
            icon: Icons.edit_note,
            title: 'Faça o pedido',
            description:
                'Informe seu nome e, se quiser, deixe uma mensagem para o músico.',
          ),

          _step(
            number: '03',
            icon: Icons.queue_music,
            title: 'Acompanhe a fila',
            description:
                'Consulte os pedidos realizados na página da fila.',
          ),

          const SizedBox(height: 14),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.cardapio);
            },
            icon: const Icon(Icons.music_note),
            label: const Text('Abrir cardápio'),
          ),
        ],
      ),
    );
  }

  Widget _step({
    required String number,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 23,
            backgroundColor: AppColors.primary,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: AppColors.gold,
                  size: 24,
                ),

                const SizedBox(height: 8),

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.4,
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