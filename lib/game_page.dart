import 'package:flutter/material.dart';
import 'questions.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  final int numberOfPlayers;
  final String gameType;

  const GamePage({
    super.key,
    required this.numberOfPlayers,
    required this.gameType,
  });

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _currentQuestion = '';
  bool _isTruth = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    _nextQuestion();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    setState(() {
      _isTruth = Random().nextBool();
      List<String> questions = _isTruth
          ? (widget.gameType == 'Friends' ? Questions.friendsTruth : Questions.couplesTruth)
          : (widget.gameType == 'Friends' ? Questions.friendsDare : Questions.couplesDare);
      _currentQuestion = questions[Random().nextInt(questions.length)];
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Truth or Dare Game'),
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isTruth ? 'Truth' : 'Dare',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                _currentQuestion,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _nextQuestion,
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}