import 'package:flutter/material.dart';

import '../data/music_data.dart';
import '../screens/request_page.dart';
import '../theme/app_theme.dart';
import '../widgets/public_layout.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String categoriaSelecionada = 'Todos';

  final List<String> categorias = const [
    'Todos',
    'Sertanejo',
    'MPB',
    'Rock',
    'Pop',
    'Samba',
  ];

  List<MusicaItem> get musicasFiltradas {
    if (categoriaSelecionada == 'Todos') {
      return musicasDoShow;
    }

    return musicasDoShow
        .where(
          (musica) => musica.categoria == categoriaSelecionada,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return PublicLayout(
      currentRoute: AppRoutes.cardapio,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CARDÁPIO MUSICAL',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Escolha seu hit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Explore o repertório e toque em “Pedir música” para fazer seu pedido.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 24),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categorias.map((categoria) {
              final selecionada =
                  categoriaSelecionada == categoria;

              return ChoiceChip(
                label: Text(categoria),
                selected: selecionada,
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.surface,
                labelStyle: TextStyle(
                  color: selecionada
                      ? Colors.white
                      : AppColors.textSecondary,
                ),
                onSelected: (_) {
                  setState(() {
                    categoriaSelecionada = categoria;
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 18),

          Text(
            '${musicasFiltradas.length} músicas',
            style: const TextStyle(
              color: AppColors.textMuted,
            ),
          ),

          const SizedBox(height: 14),

          ...musicasFiltradas.map(
            (musica) => _musicCard(context, musica),
          ),
        ],
      ),
    );
  }

  Widget _musicCard(
    BuildContext context,
    MusicaItem musica,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Wrap(
        spacing: 18,
        runSpacing: 14,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 280,
            child: Row(
              children: [
                const Icon(
                  Icons.music_note,
                  color: AppColors.primaryLight,
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        musica.titulo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        musica.artista,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        musica.categoria,
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RequestPage(
                    musica: musica.titulo,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Pedir música'),
          ),
        ],
      ),
    );
  }
}