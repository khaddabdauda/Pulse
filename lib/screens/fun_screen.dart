import 'package:flutter/material.dart';

class FunScreen extends StatefulWidget {
  const FunScreen({super.key});

  @override
  State<FunScreen> createState() => _FunScreenState();
}

class _FunScreenState extends State<FunScreen> {
  int selectedCategory = 0;

  final categories = [
    'All',
    'Creative',
    'Music',
    'Video',
    'Comedy',
    'Quiz',
    'AI Challenge',
  ];

  final challenges = [
    {
      'title': 'Daily Pulse',
      'subtitle': 'Show the world what you can create today.',
      'icon': Icons.bolt,
      'points': '500 PULSE',
    },
    {
      'title': 'Creator Battle',
      'subtitle': 'Compete against another creator.',
      'icon': Icons.sports_kabaddi,
      'points': '1,000 PULSE',
    },
    {
      'title': 'AI Challenge',
      'subtitle': 'Create something amazing with PULSE AI.',
      'icon': Icons.auto_awesome,
      'points': '750 PULSE',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07070D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF07070D),
        elevation: 0,
        title: const Text(
          'PULSE Fun',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.emoji_events_outlined),
            tooltip: 'Trophies',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        children: [
          _buildHero(),
          const SizedBox(height: 22),
          _buildCategories(),
          const SizedBox(height: 22),
          const Text(
            'Live Challenges',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          ...challenges.map(_buildChallenge),
          const SizedBox(height: 22),
          _buildLeaderboard(),
          const SizedBox(height: 22),
          _buildSeason(),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF24105C),
            Color(0xFF101A45),
            Color(0xFF090A15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.white12,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.emoji_events,
            color: Color(0xFFFFD54F),
            size: 42,
          ),
          SizedBox(height: 14),
          Text(
            'Compete. Create. Win.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Enter challenges, compete with the PULSE community and build your reputation.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.4,
            ),
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.orange),
              SizedBox(width: 7),
              Text(
                'Your PULSE Score starts here',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = selectedCategory == index;

          return ChoiceChip(
            label: Text(categories[index]),
            selected: selected,
            onSelected: (_) {
              setState(() {
                selectedCategory = index;
              });
            },
            selectedColor: const Color(0xFF6C4DFF),
            backgroundColor: const Color(0xFF15151F),
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.white70,
              fontWeight: FontWeight.w700,
            ),
            side: const BorderSide(color: Colors.white12),
          );
        },
      ),
    );
  }

  Widget _buildChallenge(Map<String, dynamic> challenge) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFF111119),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF6C4DFF).withOpacity(.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              challenge['icon'] as IconData,
              color: const Color(0xFF9C83FF),
              size: 27,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge['title'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  challenge['subtitle'] as String,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  challenge['points'] as String,
                  style: const TextStyle(
                    color: Color(0xFFFFD54F),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C4DFF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF111119),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.leaderboard,
                color: Color(0xFFFFD54F),
              ),
              SizedBox(width: 10),
              Text(
                'Top PULSE Players',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _leader('1', 'PULSE Champion', '12,840'),
          _leader('2', 'Creative Star', '11,420'),
          _leader('3', 'Rising Pulse', '9,870'),
        ],
      ),
    );
  }

  Widget _leader(String position, String name, String score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Text(
            position,
            style: const TextStyle(
              color: Color(0xFFFFD54F),
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 14),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF24243A),
            child: Icon(
              Icons.person,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            score,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeason() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF15121F),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PULSE Season 1',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Bronze → Silver → Gold → Elite → PULSE Legend',
            style: TextStyle(
              color: Colors.white70,
              height: 1.4,
            ),
          ),
          SizedBox(height: 14),
          LinearProgressIndicator(
            value: .35,
            minHeight: 7,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFF8B6CFF),
            ),
          ),
        ],
      ),
    );
  }
}
