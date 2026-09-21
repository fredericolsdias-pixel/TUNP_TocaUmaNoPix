import 'package:flutter/material.dart';

import '../services/cantor_api.dart';

class RepertorioPage extends StatefulWidget {
  const RepertorioPage({super.key});

  @override
  State<RepertorioPage> createState() => _RepertorioPageState();
}

class _RepertorioPageState extends State<RepertorioPage> {
  late Future<List<Map<String, dynamic>>> _itens;

  @override
  void initState() {
    super.initState();
    _atualizar();
  }

  void _atualizar() {
    _itens = CantorApi.repertorio();
  }

  void _mensagem(Object erro) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$erro'.replaceFirst('Exception: ', ''))),
    );
  }

  Future<void> _formulario({Map<String, dynamic>? musica}) async {
    final titulo = TextEditingController(
      text: musica?['titulo']?.toString() ?? '',
    );
    final artista = TextEditingController(
      text: musica?['artista']?.toString() ?? '',
    );
    final genero = TextEditingController(
      text: musica?['genero']?.toString() ?? '',
    );

    try {
      final confirmou = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: const Color(0xFF161229),
          title: Text(
            musica == null ? 'Adicionar música' : 'Editar música',
          ),
          content: SizedBox(
            width: 420,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titulo,
                    decoration: const InputDecoration(
                      labelText: 'Nome da música',
                    ),
                  ),
                  TextField(
                    controller: artista,
                    decoration: const InputDecoration(
                      labelText: 'Artista original',
                    ),
                  ),
                  TextField(
                    controller: genero,
                    decoration: const InputDecoration(
                      labelText: 'Gênero (opcional)',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                if (titulo.text.trim().isEmpty ||
                    artista.text.trim().isEmpty) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('Informe música e artista.'),
                    ),
                  );
                  return;
                }

                Navigator.pop(dialogContext, true);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      );

      if (confirmou != true || !mounted) return;

      final dados = <String, dynamic>{
        'titulo': titulo.text.trim(),
        'artista_original': artista.text.trim(),
        'genero': genero.text.trim().isEmpty
            ? null
            : genero.text.trim(),
      };

      if (musica == null) {
        await CantorApi.adicionarMusica(dados);
      } else {
        await CantorApi.atualizarMusica(musica['id'] as int, dados);
      }

      if (mounted) setState(_atualizar);
    } catch (erro) {
      if (mounted) _mensagem(erro);
    } finally {
      titulo.dispose();
      artista.dispose();
      genero.dispose();
    }
  }

  Future<void> _alterarDisponibilidade(
    Map<String, dynamic> musica,
    bool disponivel,
  ) async {
    try {
      await CantorApi.atualizarMusica(
        musica['id'] as int,
        {'disponivel': disponivel},
      );

      if (mounted) setState(_atualizar);
    } catch (erro) {
      if (mounted) _mensagem(erro);
    }
  }

  Future<void> _arquivar(Map<String, dynamic> musica) async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Arquivar música?'),
        content: Text(
          '${musica['titulo']} deixará de aparecer no repertório '
          'e no cardápio. Pedidos antigos serão preservados.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Arquivar'),
          ),
        ],
      ),
    );

    if (confirmou != true || !mounted) return;

    try {
      await CantorApi.arquivarMusica(musica['id'] as int);

      if (mounted) setState(_atualizar);
    } catch (erro) {
      if (mounted) _mensagem(erro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08061A),
      appBar: AppBar(
        title: const Text('Meu repertório'),
        backgroundColor: const Color(0xFF08061A),
        actions: [
          IconButton(
            tooltip: 'Atualizar',
            onPressed: () => setState(_atualizar),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _formulario(),
        icon: const Icon(Icons.add),
        label: const Text('Adicionar música'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _itens,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Não foi possível carregar o repertório:\n'
                '${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final musicas = snapshot.data!;

          if (musicas.isEmpty) {
            return const Center(
              child: Text(
                'Seu repertório está vazio.\n'
                'Use “Adicionar música” para começar.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: musicas.length,
                itemBuilder: (context, index) {
                  final musica = musicas[index];
                  final disponivel = musica['disponivel'] == true;

                  return Card(
                    color: const Color(0xFF161229),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.music_note,
                              color: Color(0xFF7C3AED),
                            ),
                            title: Text(
                              musica['titulo']?.toString() ?? '',
                            ),
                            subtitle: Text(
                              [
                                musica['artista']?.toString() ?? '',
                                musica['genero']?.toString() ?? '',
                              ].where((texto) => texto.isNotEmpty).join(' • '),
                            ),
                          ),
                          Row(
                            children: [
                              Switch(
                                value: disponivel,
                                onChanged: (valor) =>
                                    _alterarDisponibilidade(musica, valor),
                              ),
                              Expanded(
                                child: Text(
                                  disponivel
                                      ? 'Disponível para pedidos'
                                      : 'Indisponível',
                                ),
                              ),
                              IconButton(
                                tooltip: 'Editar',
                                onPressed: () =>
                                    _formulario(musica: musica),
                                icon: const Icon(Icons.edit_outlined),
                              ),
                              IconButton(
                                tooltip: 'Arquivar',
                                onPressed: () => _arquivar(musica),
                                icon: const Icon(Icons.archive_outlined),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}