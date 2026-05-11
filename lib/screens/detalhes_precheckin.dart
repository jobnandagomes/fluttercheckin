import 'package:flutter/material.dart';

class DetalhesPrecheckin extends StatelessWidget {
  final Map<String, dynamic> precheckData;

  const DetalhesPrecheckin({
    super.key,
    required this.precheckData,
  });

  @override
  Widget build(BuildContext context) {
    final title = precheckData['title']?.toString() ?? 'Detalhes do Pré-Check-in';
    final subtitle = precheckData['subtitle']?.toString() ?? 'Informações do hóspede';
    final status = precheckData['status']?.toString() ?? 'Pendente';
    final nome = precheckData['nome']?.toString() ?? 'Nome do Hóspede';
    final email = precheckData['email']?.toString() ?? 'email@exemplo.com';
    final telefone = precheckData['telefone']?.toString() ?? '(11) 99999-9999';

    IconData statusIcon = Icons.pending;
    Color statusColor = Colors.orange;
    if (status == 'Aprovado') {
      statusIcon = Icons.check_circle;
      statusColor = Colors.green;
    } else if (status == 'Rejeitado') {
      statusIcon = Icons.cancel;
      statusColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle
            Text(
              subtitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            // Status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      statusIcon,
                      color: statusColor,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Status: $status',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Dados do Hóspede
            Text(
              'Dados do Hóspede',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Nome'),
                    subtitle: Text(nome),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('E-mail'),
                    subtitle: Text(email),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Telefone'),
                    subtitle: Text(telefone),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Documentos
            Text(
              'Documentos',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.image,
                        size: 64,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Documento do Hóspede',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Ações
            Text(
              'Ações',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Dados validados!')),
                          );
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Validar Dados'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Marcado como exceção!')),
                          );
                        },
                        icon: const Icon(Icons.flag),
                        label: const Text('Marcar como Exceção'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Check-in finalizado!')),
                          );
                        },
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Finalizar Check-in'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}