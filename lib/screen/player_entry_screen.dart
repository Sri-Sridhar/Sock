import 'package:flutter/material.dart';
import 'package:sock/screen/match_history_screen.dart';
import 'package:sock/screen/score_screen.dart';

class PlayerEntryScreen extends StatefulWidget {
  const PlayerEntryScreen({super.key});

  @override
  State<PlayerEntryScreen> createState() => _PlayerEntryScreenState();
}

class _PlayerEntryScreenState extends State<PlayerEntryScreen> {
  final _player1Controller = TextEditingController();
  final _player2Controller = TextEditingController();
  final _maxScoreController = TextEditingController();

  void _startMatch() {
    int? maxScore = int.tryParse(_maxScoreController.text);
    if (_player1Controller.text.trim().isEmpty ||
        _player2Controller.text.trim().isEmpty ||
        _maxScoreController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both player names and score'),
        ),
      );
    } else if (maxScore == null || maxScore <= 0 || maxScore > 21) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid number for Max Score')),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(
            player1Name: _player1Controller.text.trim(),
            player2Name: _player2Controller.text.trim(),
            maxScore: maxScore,
          ),
        ),
      );
    }
  }

  void _swapPlayerNames() {
    setState(() {
      final temp = _player1Controller.text;
      _player1Controller.text = _player2Controller.text;
      _player2Controller.text = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player Details"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                //TODO: Image
              ),
              child: const Text(
                'Sock',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Match History'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MatchHistoryScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _player1Controller,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Player 1 Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 6),
            IconButton(
              onPressed: _swapPlayerNames,
              icon: const Icon(Icons.swap_vert),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _player2Controller,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Player 2 Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _maxScoreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Max Score',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _startMatch,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white),
              child: const Text('Start Match'),
            ),
          ],
        ),
      ),
    );
  }
}
