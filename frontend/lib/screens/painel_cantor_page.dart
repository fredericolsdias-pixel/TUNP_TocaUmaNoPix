import 'package:flutter/material.dart';

import '../services/cantor_api.dart';
import 'edit_cantor_page.dart';
import 'login_cantor_page.dart';
import 'repertorio_page.dart';
import 'pedidos_cantor_page.dart';

class PainelCantorPage extends StatefulWidget {
  const PainelCantorPage({super.key});

  @override
  State<PainelCantorPage> createState() => _PainelCantorPageState();
}

class _PainelCantorPageState extends State<PainelCantorPage> {
  late Future<Map<String, dynamic>> _dados;

  @override
  void initState() {
    super.initState();
    _recarregar();
  }

  void _recarregar() {
    _dados = CantorApi.meusDados();
  }

  Future<void> _abrirEdicao() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditCantorPage()),
    );

    if (mounted) setState(_recarregar);
  }

  Future<void> _abrirRepertorio() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RepertorioPage()),
    );

    if (mounted) setState(_recarregar);
  }

  Future<void> _sair() async {
    await CantorApi.sair();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginCantorPage()),
    );
  }

  Widget _card(String titulo, String valor, IconData icone) {
    return Card(
      color: const Color(0xFF161229),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icone, color: const Color(0xFF7C3AED)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    valor,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08061A),
      appBar: AppBar(
        title: const Text('Painel do cantor'),
        backgroundColor: const Color(0xFF08061A),
        actions: [
          IconButton(
            tooltip: 'Atualizar',
            onPressed: () => setState(_recarregar),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: 'Sair',
            onPressed: _sair,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dados,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Não foi possível abrir o painel:\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final dados = snapshot.data!;
          final show = dados['show'] as Map<String, dynamic>?;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const Icon(
                    Icons.mic,
                    size: 64,
                    color: Color(0xFF7C3AED),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    dados['nome_artistico']?.toString() ?? 'Cantor',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _card(
                    'Show em andamento',
                    show == null
                        ? 'Nenhum show em andamento'
                        : show['nome']?.toString() ?? 'Show',
                    Icons.live_tv,
                  ),
                  _card(
                    'Local',
                    show?['nome_local']?.toString() ?? 'Não informado',
                    Icons.location_on_outlined,
                  ),
                  _card(
                    'E-mail',
                    dados['email']?.toString() ?? '',
                    Icons.email_outlined,
                  ),
                  _card(
                    'Chave Pix',
                    dados['chave_pix']?.toString() ?? '',
                    Icons.pix,
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _abrirEdicao,
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar dados'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: show == null ? null : _abrirRepertorio,
                    icon: const Icon(Icons.library_music),
                    label: const Text('Gerenciar repertório'),
                  ),
                  if (show == null)
                    const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: show == null
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PedidosCantorPage(),
                                  ),
                                );
                              },
                        icon: const Icon(Icons.queue_music),
                        label: const Text('Gerenciar pedidos e ao vivo'),
                      ),
                    const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        'É necessário ter um show em andamento para editar o repertório.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}