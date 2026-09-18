import 'package:flutter/material.dart';
import 'edit_cantor_page.dart';
import 'repertorio_page.dart';

class PainelCantorPage extends StatelessWidget {
  const PainelCantorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08061A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF08061A),
        elevation: 0,
        title: const Text(
          'Painel do Cantor',
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

            // ============================================================
            // CABEÇALHO
            // ============================================================

            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xFF7C3AED),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Henrique',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Painel do Cantor',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // ============================================================
            // RESUMO DO SHOW
            // ============================================================

            const Text(
              'Resumo do Show',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.play_circle,
                    titulo: 'Início',
                    valor: '20:00',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.stop_circle,
                    titulo: 'Final',
                    valor: '23:30',
                  ),
                ),

              ],
            ),

            const SizedBox(height: 15),

            // ============================================================
            // GORJETAS
            // ============================================================

            _buildLargeCard(
              icon: Icons.attach_money,
              titulo: 'Gorjetas arrecadadas',
              child: const Text(
                'R\$ 350,00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ============================================================
            // DADOS DO CANTOR
            // ============================================================

            const Text(
              'Dados do Cantor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _buildLargeCard(
              icon: Icons.person,
              titulo: 'Nome artístico',
              child: const Text(
                'Henrique',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 12),

            _buildLargeCard(
              icon: Icons.email,
              titulo: 'E-mail',
              child: const Text(
                'henrique@email.com',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 12),

            _buildLargeCard(
              icon: Icons.pix,
              titulo: 'Chave PIX',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Tipo: CPF',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    '***.***.***-**',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            // ============================================================
            // REPERTÓRIO
            // ============================================================

            const Text(
              'Meu Repertório',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _buildMusicCard(
              titulo: 'Evidências',
              artista: 'Chitãozinho & Xororó',
              genero: 'Sertanejo',
              disponivel: true,
            ),

            _buildMusicCard(
              titulo: 'Boate Azul',
              artista: 'Bruno & Marrone',
              genero: 'Sertanejo',
              disponivel: true,
            ),

            _buildMusicCard(
              titulo: 'Pais e Filhos',
              artista: 'Legião Urbana',
              genero: 'Rock',
              disponivel: false,
            ),

            _buildMusicCard(
              titulo: 'Garota de Ipanema',
              artista: 'Tom Jobim',
              genero: 'MPB',
              disponivel: true,
            ),

            const SizedBox(height: 30),

            // ============================================================
            // BOTÕES
            // ============================================================

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const EditCantorPage(),
                    ),
                  );
                },

                icon: const Icon(Icons.edit),

                label: const Text(
                  'Editar dados',
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

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const RepertorioPage(),
                    ),
                  );
                },

                icon: const Icon(Icons.library_music),

                label: const Text(
                  'Gerenciar repertório',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF161229),
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

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CARD PEQUENO
  // ============================================================

  static Widget _buildInfoCard({
    required IconData icon,
    required String titulo,
    required String valor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF161229),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Icon(
            icon,
            color: const Color(0xFF7C3AED),
            size: 30,
          ),

          const SizedBox(height: 12),

          Text(
            titulo,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            valor,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD GRANDE
  // ============================================================

  static Widget _buildLargeCard({
    required IconData icon,
    required String titulo,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFF161229),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Icon(
            icon,
            color: const Color(0xFF7C3AED),
            size: 30,
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 7),

                child,
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD DE MÚSICA
  // ============================================================

  static Widget _buildMusicCard({
    required String titulo,
    required String artista,
    required String genero,
    required bool disponivel,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF161229),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [

          const Icon(
            Icons.music_note,
            color: Color(0xFF7C3AED),
            size: 30,
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  artista,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  genero,
                  style: const TextStyle(
                    color: Color(0xFF7C3AED),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            disponivel
                ? Icons.check_circle
                : Icons.cancel,
            color: disponivel
                ? Colors.green
                : Colors.red,
          ),
        ],
      ),
    );
  }
}