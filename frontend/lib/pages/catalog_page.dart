import 'package:flutter/material.dart';

import '../data/music_data.dart';
import '../screens/request_page.dart';
import '../services/tunp_api.dart';
import '../theme/app_theme.dart';
import '../widgets/public_layout.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogData {
  final ShowInfo? show;
  final List<MusicaItem> musicas;

  const _CatalogData({
    required this.show,
    required this.musicas,
  });
}

class _CatalogPageState extends State<CatalogPage> {
  String categoriaSelecionada = 'Todos';

  late Future<_CatalogData> _catalogFuture;

  final List<String> categorias = const [
    'Todos',
    'Sertanejo',
    'MPB',
    'Rock',
    'Pop',
    'Samba',
  ];

  @override
  void initState() {
    super.initState();
    _catalogFuture = _carregarCatalogo();
  }

  Future<_CatalogData> _carregarCatalogo() async {
    final show = await TunpApi.instance.showAtual();

    if (show == null) {
      return const _CatalogData(
        show: null,
        musicas: [],
      );
    }

    final musicas = await TunpApi.instance.repertorio(
      show.id,
    );

    return _CatalogData(
      show: show,
      musicas: musicas,
    );
  }

  void _tentarNovamente() {
    setState(() {
      _catalogFuture = _carregarCatalogo();
    });
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
            'Selecione uma música do repertório do show.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 24),

          FutureBuilder<_CatalogData>(
            future: _catalogFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Não foi possível carregar o cardápio. '
                      'Verifique se o Laravel está ligado.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 14),
                    OutlinedButton.icon(
                      onPressed: _tentarNovamente,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Tentar novamente'),
                    ),
                  ],
                );
              }

              if (!snapshot.hasData) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                );
              }

              final dados = snapshot.data!;

              if (dados.show == null) {
                return const Text(
                  'Nenhum show público está em andamento.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                  ),
                );
              }

              if (dados.musicas.isEmpty) {
                return const Text(
                  'O repertório deste show ainda está vazio.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                  ),
                );
              }

              final musicasFiltradas =
                  categoriaSelecionada == 'Todos'
                  ? dados.musicas
                  : dados.musicas
                        .where(
                          (musica) =>
                              musica.categoria ==
                              categoriaSelecionada,
                        )
                        .toList();

              return Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    dados.show!.nome,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: categorias.map((categoria) {
                      final selecionada =
                          categoriaSelecionada ==
                          categoria;

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
                            categoriaSelecionada =
                                categoria;
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

                  for (final musica in musicasFiltradas)
                    _musicCard(
                      context,
                      showId: dados.show!.id,
                      musica: musica,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _musicCard(
    BuildContext context, {
    required int showId,
    required MusicaItem musica,
  }) {
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
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
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
                    showId: showId,
                    repertorioId: musica.id,
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