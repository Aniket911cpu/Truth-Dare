import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('leaderboard').orderBy('score', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var leaderboard = snapshot.data!.docs;
          return ListView.builder(
            itemCount: leaderboard.length,
            itemBuilder: (context, index) {
              var entry = leaderboard[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(entry['name']),
                subtitle: Text('Score: ${entry['score']}'),
              );
            },
          );
        },
      ),
    );
  }
}