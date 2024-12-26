import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DailyChallengesPage extends StatelessWidget {
  const DailyChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Challenges'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('daily_challenges').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var challenges = snapshot.data!.docs;
          return ListView.builder(
            itemCount: challenges.length,
            itemBuilder: (context, index) {
              var challenge = challenges[index];
              return ListTile(
                title: Text(challenge['title']),
                subtitle: Text(challenge['description']),
              );
            },
          );
        },
      ),
    );
  }
}