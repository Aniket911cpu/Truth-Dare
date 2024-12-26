import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameHistoryPage extends StatelessWidget {
  final String userId;

  const GameHistoryPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('games')
            .where('players', arrayContains: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var games = snapshot.data!.docs;
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              var game = games[index];
              return ListTile(
                title: Text('Game ${game.id}'),
                subtitle: Text('Outcome: ${game['outcome']}'),
              );
            },
          );
        },
      ),
    );
  }
}