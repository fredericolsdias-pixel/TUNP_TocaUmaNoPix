import 'package:flutter/material.dart';

import '../screens/login_cantor_page.dart';
import '../theme/app_theme.dart';
import 'app_header.dart';

class AppRoutes {
  AppRoutes._();

  static const inicio = '/';
  static const cardapio = '/cardapio';
  static const comoFunciona = '/como-funciona';
  static const fila = '/fila';
}

class PublicLayout extends StatelessWidget {
  final String currentRoute;
  final Widget child;

  const PublicLayout({
    super.key,
    required this.currentRoute,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppHeader(
                      onSingerPanelPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginCantorPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _navigationButton(
                          context,
                          label: 'Início',
                          route: AppRoutes.inicio,
                          icon: Icons.home_outlined,
                        ),
                        _navigationButton(
                          context,
                          label: 'Cardápio',
                          route: AppRoutes.cardapio,
                          icon: Icons.library_music_outlined,
                        ),
                        _navigationButton(
                          context,
                          label: 'Como funciona',
                          route: AppRoutes.comoFunciona,
                          icon: Icons.help_outline,
                        ),
                        _navigationButton(
                          context,
                          label: 'Fila e ao vivo',
                          route: AppRoutes.fila,
                          icon: Icons.queue_music,
                        ),
                      ],
                    ),

                    const SizedBox(height: 36),

                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navigationButton(
    BuildContext context, {
    required String label,
    required String route,
    required IconData icon,
  }) {
    final selected = currentRoute == route;

    return TextButton.icon(
      onPressed: selected
          ? null
          : () {
              Navigator.pushNamed(context, route);
            },
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: selected
            ? Colors.white
            : AppColors.textSecondary,
        disabledForegroundColor: Colors.white,
        backgroundColor: selected
            ? AppColors.primary
            : AppColors.surface,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}