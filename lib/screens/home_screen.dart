import 'package:flutter/material.dart';
import 'fun_screen.dart';
import 'learn_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override

  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  int selectedTab = 0;
  bool liked = false;

  final List<String> tabs = [

    'For You',

    'Following',

    'Trending',

    'Nearby',

  ];

  @override

  Widget build(BuildContext context) {

    return SafeArea(

      child: CustomScrollView(

        slivers: [

          SliverToBoxAdapter(

            child: _buildHeader(context),

          ),

          SliverToBoxAdapter(

            child: _buildStories(),

          ),

          SliverToBoxAdapter(

            child: _buildTabs(),

          ),

          SliverToBoxAdapter(

            child: _buildPost(

              username: 'khaddab_m',

              location: 'Lagos, Nigeria',

              likes: '1.2K',

              comments: '320',

              shares: '95',

            ),

          ),

          SliverToBoxAdapter(

            child: _buildPost(

              username: 'pulse_creator',

              location: 'Abuja, Nigeria',

              likes: '856',

              comments: '142',

              shares: '41',

            ),

          ),

          const SliverToBoxAdapter(

            child: SizedBox(height: 30),

          ),

        ],

      ),

    );

  }

  Widget _buildHeader(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),

      child: Row(

        children: [

          const Text(

            'PULSE',

            style: TextStyle(

              fontSize: 27,

              fontWeight: FontWeight.w800,

              letterSpacing: 2,

            ),

          ),

                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          color: Color(0xFF101018),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.auto_awesome, color: Colors.white, size: 34),
                            const SizedBox(height: 12),
                            const Text(
                              'Tanko',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Ask, create, translate, learn and discover with Tanko.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white70, fontSize: 15),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {},

                                icon: const Icon(Icons.auto_awesome),
                                label: const Text('Open Tanko'),
                            const SizedBox(height: 10),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const FunScreen()));
            },
            icon: const Icon(Icons.emoji_events_outlined),
            label: const Text("PULSE Fun - Live Challenges"),
          ),
        ),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                  onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const LearnScreen())); },
                                icon: const Icon(Icons.school_outlined),
                                label: const Text('PULSE Learn — AI Teacher'),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.music_note_outlined),
                                label: const Text('AI Lyrics — Create Original Lyrics'),
                              ),
                            ),
                              ),
                            ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.auto_awesome),
                  tooltip: 'Tanko',
                ),

          const Spacer(),

          IconButton(

            onPressed: () {},

            icon: const Icon(Icons.favorite_border),

          ),

          IconButton(

            onPressed: () {},

            icon: const Icon(Icons.chat_bubble_outline),

          ),

        ],

      ),

    );

  }

  Widget _buildStories() {

    final stories = [

      ('Your Story', Icons.add),

      ('Aisha', Icons.person),

      ('Musa', Icons.person),

      ('Zainab', Icons.person),

      ('David', Icons.person),

      ('Maryam', Icons.person),

    ];

    return SizedBox(

      height: 112,

      child: ListView.builder(

        scrollDirection: Axis.horizontal,

        padding: const EdgeInsets.symmetric(horizontal: 14),

        itemCount: stories.length,

        itemBuilder: (context, index) {

          final story = stories[index];

          return Container(

            width: 76,

            margin: const EdgeInsets.symmetric(horizontal: 5),

            child: Column(

              children: [

                Container(

                  width: 66,

                  height: 66,

                  padding: const EdgeInsets.all(3),

                  decoration: BoxDecoration(

                    shape: BoxShape.circle,

                    gradient: LinearGradient(

                      colors: [

                        Colors.deepPurpleAccent,

                        Colors.blueAccent,

                        Colors.pinkAccent,

                      ],

                    ),

                  ),

                  child: Container(

                    decoration: const BoxDecoration(

                      shape: BoxShape.circle,

                      color: Colors.black,

                    ),

                    child: Icon(

                      story.$2,

                      color: Colors.white,

                      size: 28,

                    ),

                  ),

                ),

                const SizedBox(height: 7),

                Text(

                  story.$1,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(fontSize: 12),

                ),

              ],

            ),

          );

        },

      ),

    );

  }

  Widget _buildTabs() {

    return SizedBox(

      height: 48,

      child: ListView.builder(

        scrollDirection: Axis.horizontal,

        padding: const EdgeInsets.symmetric(horizontal: 14),

        itemCount: tabs.length,

        itemBuilder: (context, index) {

          final selected = selectedTab == index;

          return GestureDetector(

            onTap: () {

              setState(() {

                selectedTab = index;

              });

            },

            child: Container(

              margin: const EdgeInsets.only(right: 10),

              padding: const EdgeInsets.symmetric(

                horizontal: 18,

                vertical: 9,

              ),

              decoration: BoxDecoration(

                color: selected

                    ? Colors.deepPurpleAccent

                    : Colors.white10,

                borderRadius: BorderRadius.circular(22),

              ),

              child: Text(

                tabs[index],

                style: TextStyle(

                  fontWeight:

                      selected ? FontWeight.bold : FontWeight.normal,

                ),

              ),

            ),

          );

        },

      ),

    );

  }

  Widget _buildPost({

    required String username,

    required String location,

    required String likes,

    required String comments,

    required String shares,

  }) {

    return Container(

      margin: const EdgeInsets.only(top: 18),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Row(

              children: [

                const CircleAvatar(

                  radius: 21,

                  backgroundColor: Colors.deepPurple,

                  child: Icon(Icons.person, color: Colors.white),

                ),

                const SizedBox(width: 10),

                Expanded(

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Text(

                        username,

                        style: const TextStyle(

                          fontWeight: FontWeight.bold,

                        ),

                      ),

                      Text(

                        location,

                        style: const TextStyle(

                          fontSize: 12,

                          color: Colors.white60,

                        ),

                      ),

                    ],

                  ),

                ),

                const Icon(Icons.more_vert),

              ],

            ),

          ),

          const SizedBox(height: 12),

          Stack(
          children: [
            Container(

            height: 330,

            width: double.infinity,

            decoration: BoxDecoration(

              gradient: LinearGradient(

                begin: Alignment.topLeft,

                end: Alignment.bottomRight,

                colors: [

                  Colors.deepPurple.shade900,

                  Colors.blue.shade900,

                  Colors.black,

                ],

              ),

            ),

            child: const Center(

              child: Icon(

                Icons.image_outlined,

                size: 65,

                color: Colors.white38,

              ),

            ),

          ),
            Positioned(
              right: 4,
              top: 70,
              child: Padding(

            padding: const EdgeInsets.symmetric(

              horizontal: 12,

              vertical: 8,

            ),

            child: Column(
                mainAxisSize: MainAxisSize.min,

              children: [

                IconButton(

                    onPressed: () {
                      setState(() {
                        liked = !liked;
                      });
                    },
                    icon: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                    ),

                ),

                IconButton(

                  onPressed: () {},

                  icon: const Icon(Icons.chat_bubble_outline),

                ),

                IconButton(

                  onPressed: () {},

                  icon: const Icon(Icons.send_outlined),

                ),



                IconButton(

                  onPressed: () {},

                  icon: const Icon(Icons.bookmark_border),

                ),

              ],

            ),

          ),
            ),
          ],
        ),

          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Text(

              '$likes likes   $comments comments   $shares shares',

              style: const TextStyle(

                fontWeight: FontWeight.bold,

              ),

            ),

          ),

          const SizedBox(height: 6),

          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Text(

              'Discover moments. Share your world. Feel the PULSE.',

              style: const TextStyle(color: Colors.white70),

            ),

          ),

        ],

      ),

    );

  }

}