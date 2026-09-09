import 'package:flutter/material.dart';

import 'request_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        title: const Text('Cardápio Musical'),
        backgroundColor: Colors.black,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('Evidências'),
              subtitle: const Text('Chitãozinho & Xororó'),
              trailing: const Text('R\$ 10'),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RequestPage(songName: 'Evidências'),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              title: const Text('Tempo Perdido'),
              subtitle: const Text('Legião Urbana'),
              trailing: const Text('R\$ 20'),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RequestPage(songName: 'Tempo Perdido'),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              title: const Text('Sinônimos'),
              subtitle: const Text('Chitãozinho & Xororó'),
              trailing: const Text('R\$ 15'),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const RequestPage(songName: 'Sinônimos'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
