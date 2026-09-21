import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/public_layout.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PublicLayout(
      currentRoute: AppRoutes.inicio,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.surfaceSoft,
                  AppColors.surface,
                ],
              ),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.music_note_rounded,
                  color: AppColors.gold,
                  size: 44,
                ),

                const SizedBox(height: 20),

                const Text(
                  'A música da noite também pode ser sua escolha.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.15,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Explore o repertório, escolha uma música e acompanhe seu pedido na fila do show.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.cardapio,
                        );
                      },
                      icon: const Icon(Icons.library_music_outlined),
                      label: const Text('Ver cardápio musical'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.comoFunciona,
                        );
                      },
                      icon: const Icon(Icons.help_outline),
                      label: const Text('Como funciona'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          const Text(
            'Participe do show',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Você escolhe no cardápio e acompanha os pedidos em uma página própria.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _homeCard(
                context,
                icon: Icons.library_music_outlined,
                title: 'Escolha uma música',
                description: 'Veja o repertório completo do show.',
                route: AppRoutes.cardapio,
              ),
              _homeCard(
                context,
                icon: Icons.queue_music,
                title: 'Acompanhe a fila',
                description: 'Confira os pedidos feitos nesta sessão.',
                route: AppRoutes.fila,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _homeCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String route,
  }) {
    return SizedBox(
      width: 290,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.primaryLight, size: 30),
              const SizedBox(height: 16),
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
      ),
    );
  }
}