import 'package:flutter/material.dart';
import 'painel_cantor_page.dart';

class LoginCantorPage extends StatefulWidget {
  const LoginCantorPage({super.key});

  @override
  State<LoginCantorPage> createState() => _LoginCantorPageState();
}

class _LoginCantorPageState extends State<LoginCantorPage> {
  final TextEditingController usuarioController =
      TextEditingController();

  final TextEditingController senhaController =
      TextEditingController();

  bool esconderSenha = true;

  @override
  void dispose() {
    usuarioController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void _entrar() {
    final usuario = usuarioController.text.trim();
    final senha = senhaController.text;

    // TEMPORÁRIO
    // Depois substituiremos pela autenticação do Laravel.
    if (usuario == 'cantor' && senha == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PainelCantorPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Usuário ou senha incorretos.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08061A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF08061A),
        elevation: 0,
        title: const Text(
          'Acesso do Cantor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [

            const SizedBox(height: 30),

            // ÍCONE

            const Icon(
              Icons.mic,
              color: Color(0xFF7C3AED),
              size: 90,
            ),

            const SizedBox(height: 20),

            const Text(
              'Painel do Cantor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Entre com suas credenciais para acessar o painel.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 40),

            // USUÁRIO

            TextField(
              controller: usuarioController,

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(
                hintText: 'Usuário',

                hintStyle: const TextStyle(
                  color: Colors.white54,
                ),

                prefixIcon: const Icon(
                  Icons.person,
                  color: Color(0xFF7C3AED),
                ),

                filled: true,

                fillColor: const Color(0xFF161229),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Color(0xFF7C3AED),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // SENHA

            TextField(
              controller: senhaController,

              obscureText: esconderSenha,

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(
                hintText: 'Senha',

                hintStyle: const TextStyle(
                  color: Colors.white54,
                ),

                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color(0xFF7C3AED),
                ),

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      esconderSenha = !esconderSenha;
                    });
                  },

                  icon: Icon(
                    esconderSenha
                        ? Icons.visibility
                        : Icons.visibility_off,

                    color: Colors.white70,
                  ),
                ),

                filled: true,

                fillColor: const Color(0xFF161229),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Color(0xFF7C3AED),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // BOTÃO ENTRAR

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: _entrar,

                icon: const Icon(
                  Icons.login,
                ),

                label: const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  foregroundColor: Colors.white,

                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Área exclusiva do cantor',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}