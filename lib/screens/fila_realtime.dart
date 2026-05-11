import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/precheck_card.dart';
import 'detalhes_precheckin.dart';

class FilaRealtimeScreen extends StatelessWidget {
  const FilaRealtimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fila em Tempo Real'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('0fila')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar dados: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum registro na fila agora',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> data =
                  docs[index].data() as Map<String, dynamic>;

              data['id'] = docs[index].id;

              final passageiro = data['passageiro']?.toString() ?? 'Não informado';
              final voo = data['voo']?.toString() ?? 'N/A';
              final status = data['status']?.toString();

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PrecheckCard(
                  title: passageiro,
                  subtitle: 'Voo: $voo',
                  status: status,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalhesPrecheckin(precheckData: data),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}