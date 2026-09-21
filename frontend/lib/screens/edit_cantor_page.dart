import 'package:flutter/material.dart';

import '../services/cantor_api.dart';

class EditCantorPage extends StatefulWidget {
  const EditCantorPage({super.key});

  @override
  State<EditCantorPage> createState() => _EditCantorPageState();
}

class _EditCantorPageState extends State<EditCantorPage> {
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _pix = TextEditingController();

  String _tipoPix = 'CPF';
  bool _carregando = true;
  bool _salvando = false;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    try {
      final dados = await CantorApi.meusDados();

      if (!mounted) return;

      setState(() {
        _nome.text = dados['nome_artistico']?.toString() ?? '';
        _email.text = dados['email']?.toString() ?? '';
        _pix.text = dados['chave_pix']?.toString() ?? '';
        _tipoPix = dados['tipo_chave_pix']?.toString() ?? 'CPF';
        _carregando = false;
      });
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$erro')),
      );

      Navigator.pop(context);
    }
  }

  Future<void> _salvar() async {
    if (_nome.text.trim().isEmpty ||
        _email.text.trim().isEmpty ||
        _pix.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    setState(() => _salvando = true);

    try {
      await CantorApi.atualizarDados({
        'nome_artistico': _nome.text.trim(),
        'email': _email.text.trim(),
        'tipo_chave_pix': _tipoPix,
        'chave_pix': _pix.text.trim(),
      });

      if (!mounted) return;
      Navigator.pop(context);
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$erro'.replaceFirst('Exception: ', ''))),
      );
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _pix.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08061A),
      appBar: AppBar(
        title: const Text('Editar dados'),
        backgroundColor: const Color(0xFF08061A),
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    TextField(
                      controller: _nome,
                      decoration: const InputDecoration(
                        labelText: 'Nome artístico',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _tipoPix,
                      decoration: const InputDecoration(
                        labelText: 'Tipo de chave Pix',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'CPF', child: Text('CPF')),
                        DropdownMenuItem(value: 'CNPJ', child: Text('CNPJ')),
                        DropdownMenuItem(value: 'EMAIL', child: Text('E-mail')),
                        DropdownMenuItem(
                          value: 'TELEFONE',
                          child: Text('Telefone'),
                        ),
                        DropdownMenuItem(
                          value: 'ALEATORIA',
                          child: Text('Aleatória'),
                        ),
                      ],
                      onChanged: (valor) {
                        if (valor != null) {
                          setState(() => _tipoPix = valor);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _pix,
                      decoration: const InputDecoration(
                        labelText: 'Chave Pix',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: _salvando ? null : _salvar,
                      icon: const Icon(Icons.save),
                      label: Text(
                        _salvando ? 'Salvando...' : 'Salvar alterações',
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}