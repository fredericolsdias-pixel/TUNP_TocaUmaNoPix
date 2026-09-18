import 'package:flutter/material.dart';

class EditCantorPage extends StatefulWidget {
  const EditCantorPage({super.key});

  @override
  State<EditCantorPage> createState() => _EditCantorPageState();
}

class _EditCantorPageState extends State<EditCantorPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController chavePixController = TextEditingController();

  String tipoChavePix = 'CPF';

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    chavePixController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08061A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF08061A),
        elevation: 0,
        title: const Text(
          'Editar Dados',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Center(
              child: Icon(
                Icons.person,
                color: Color(0xFF7C3AED),
                size: 80,
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'Dados do Cantor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 35),

            // NOME ARTÍSTICO

            const Text(
              'Nome artístico',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: nomeController,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: _inputDecoration(
                'Digite seu nome artístico',
                Icons.person,
              ),
            ),

            const SizedBox(height: 20),

            // EMAIL

            const Text(
              'E-mail',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: _inputDecoration(
                'Digite seu e-mail',
                Icons.email,
              ),
            ),

            const SizedBox(height: 20),

            // TIPO PIX

            const Text(
              'Tipo de chave PIX',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: tipoChavePix,

              dropdownColor: const Color(0xFF161229),

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: _inputDecoration(
                'Selecione o tipo',
                Icons.pix,
              ),

              items: const [
                DropdownMenuItem(
                  value: 'CPF',
                  child: Text('CPF'),
                ),
                DropdownMenuItem(
                  value: 'CNPJ',
                  child: Text('CNPJ'),
                ),
                DropdownMenuItem(
                  value: 'EMAIL',
                  child: Text('E-mail'),
                ),
                DropdownMenuItem(
                  value: 'TELEFONE',
                  child: Text('Telefone'),
                ),
                DropdownMenuItem(
                  value: 'ALEATORIA',
                  child: Text('Chave aleatória'),
                ),
              ],

              onChanged: (valor) {
                setState(() {
                  tipoChavePix = valor!;
                });
              },
            ),

            const SizedBox(height: 20),

            // CHAVE PIX

            const Text(
              'Chave PIX',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: chavePixController,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: _inputDecoration(
                'Digite sua chave PIX',
                Icons.pix,
              ),
            ),

            const SizedBox(height: 35),

            // SALVAR

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () {
                  // Aqui vamos conectar com o Laravel.
                },

                icon: const Icon(Icons.save),

                label: const Text(
                  'Salvar alterações',
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static InputDecoration _inputDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,

      hintStyle: const TextStyle(
        color: Colors.white54,
      ),

      prefixIcon: Icon(
        icon,
        color: const Color(0xFF7C3AED),
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
    );
  }
}