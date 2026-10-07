import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

import '../screens/explore_screen.dart';

import '../screens/create_screen.dart';

class PulseApp extends StatelessWidget {

  const PulseApp({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'PULSE',

      theme: ThemeData(

        brightness: Brightness.dark,

        useMaterial3: true,

        scaffoldBackgroundColor: Colors.black,

        colorScheme: ColorScheme.fromSeed(

          seedColor: Colors.deepPurple,

          brightness: Brightness.dark,

        ),

      ),

      home: const PulseHome(),

    );

  }

}

class PulseHome extends StatefulWidget {

  const PulseHome({super.key});

  @override

  State<PulseHome> createState() => _PulseHomeState();

}

class _PulseHomeState extends State<PulseHome> {

  int currentIndex = 0;

  @override

  Widget build(BuildContext context) {

    final List<Widget> screens = [

      const HomeScreen(),

      const ExploreScreen(),

      const CreateScreen(),

      const AlertsScreen(),

      const ProfileScreen(),

    ];

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: NavigationBar(

        selectedIndex: currentIndex,

        backgroundColor: const Color(0xFF111116),

        indicatorColor: Colors.deepPurple.withOpacity(0.35),

        onDestinationSelected: (int index) {

          setState(() {

            currentIndex = index;

          });

        },

        destinations: const [

          NavigationDestination(

            icon: Icon(Icons.home_outlined),

            selectedIcon: Icon(Icons.home),

            label: 'Home',

          ),

          NavigationDestination(

            icon: Icon(Icons.search_outlined),

            selectedIcon: Icon(Icons.search),

            label: 'Explore',

          ),

          NavigationDestination(

            icon: Icon(Icons.add_box_outlined),

            selectedIcon: Icon(Icons.add_box),

            label: 'Create',

          ),

          NavigationDestination(

            icon: Icon(Icons.notifications_outlined),

            selectedIcon: Icon(Icons.notifications),

            label: 'Alerts',

          ),

          NavigationDestination(

            icon: Icon(Icons.person_outline),

            selectedIcon: Icon(Icons.person),

            label: 'Profile',

          ),

        ],

      ),

    );

  }

}

// ------------------------------------------------------------

// ALERTS SCREEN

// ------------------------------------------------------------

class AlertsScreen extends StatelessWidget {

  const AlertsScreen({super.key});

  @override

  Widget build(BuildContext context) {

    return SafeArea(

      child: Column(

        children: [

          const Padding(

            padding: EdgeInsets.fromLTRB(18, 16, 18, 12),

            child: Row(

              children: [

                Text(

                  'Alerts',

                  style: TextStyle(

                    fontSize: 28,

                    fontWeight: FontWeight.bold,

                  ),

                ),

                Spacer(),

                Icon(Icons.settings_outlined),

              ],

            ),

          ),

          Expanded(

            child: ListView(

              padding: const EdgeInsets.symmetric(

                horizontal: 16,

              ),

              children: [

                const Padding(

                  padding: EdgeInsets.only(

                    left: 4,

                    top: 8,

                    bottom: 12,

                  ),

                  child: Text(

                    'Today',

                    style: TextStyle(

                      fontSize: 18,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                ),

                alertItem(

                  icon: Icons.favorite,

                  title: 'Someone liked your post',

                  subtitle: 'Your recent post received a new like.',

                  time: '2m',

                ),

                alertItem(

                  icon: Icons.chat_bubble,

                  title: 'New comment',

                  subtitle: 'Someone commented on your post.',

                  time: '8m',

                ),

                alertItem(

                  icon: Icons.person_add,

                  title: 'New follower',

                  subtitle: 'Someone started following you.',

                  time: '25m',

                ),

                alertItem(

                  icon: Icons.favorite,

                  title: 'Your post is getting attention',

                  subtitle: 'Your post is receiving more activity.',

                  time: '1h',

                ),

                const Padding(

                  padding: EdgeInsets.only(

                    left: 4,

                    top: 24,

                    bottom: 12,

                  ),

                  child: Text(

                    'Earlier',

                    style: TextStyle(

                      fontSize: 18,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                ),

                alertItem(

                  icon: Icons.alternate_email,

                  title: 'You were mentioned',

                  subtitle: 'You were mentioned in a post.',

                  time: 'Yesterday',

                ),

                alertItem(

                  icon: Icons.people_outline,

                  title: 'Suggested creator',

                  subtitle: 'Discover a creator you may like.',

                  time: 'Yesterday',

                ),

              ],

            ),

          ),

        ],

      ),

    );

  }

  static Widget alertItem({

    required IconData icon,

    required String title,

    required String subtitle,

    required String time,

  }) {

    return Container(

      margin: const EdgeInsets.only(bottom: 10),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(

        color: const Color(0xFF18151F),

        borderRadius: BorderRadius.circular(18),

      ),

      child: Row(

        children: [

          CircleAvatar(

            radius: 25,

            backgroundColor: Colors.deepPurple.withOpacity(0.25),

            child: Icon(

              icon,

              color: Colors.deepPurpleAccent,

            ),

          ),

          const SizedBox(width: 12),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style: const TextStyle(

                    fontWeight: FontWeight.bold,

                    fontSize: 15,

                  ),

                ),

                const SizedBox(height: 4),

                Text(

                  subtitle,

                  style: const TextStyle(

                    color: Colors.white60,

                    fontSize: 13,

                  ),

                ),

              ],

            ),

          ),

          Text(

            time,

            style: const TextStyle(

              color: Colors.white38,

              fontSize: 11,

            ),

          ),

        ],

      ),

    );

  }

}

// ------------------------------------------------------------

// PROFILE SCREEN

// ------------------------------------------------------------

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override

  Widget build(BuildContext context) {

    return SafeArea(

      child: Column(

        children: [

          Padding(

            padding: const EdgeInsets.fromLTRB(

              18,

              14,

              18,

              8,

            ),

            child: Row(

              children: [

                const Text(

                  'Profile',

                  style: TextStyle(

                    fontSize: 28,

                    fontWeight: FontWeight.bold,

                  ),

                ),

                const Spacer(),

                IconButton(

                  onPressed: () {},

                  icon: const Icon(

                    Icons.settings_outlined,

                  ),

                ),

              ],

            ),

          ),

          Expanded(

            child: SingleChildScrollView(

              child: Column(

                children: [

                  const SizedBox(height: 10),

                  const CircleAvatar(

                    radius: 48,

                    backgroundColor: Colors.deepPurple,

                    child: Text(

                      'K',

                      style: TextStyle(

                        fontSize: 42,

                        fontWeight: FontWeight.bold,

                      ),

                    ),

                  ),

                  const SizedBox(height: 12),

                  const Text(

                    'Khaddab',

                    style: TextStyle(

                      fontSize: 22,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 4),

                  const Text(

                    '@khaddab_m',

                    style: TextStyle(

                      color: Colors.white54,

                      fontSize: 14,

                    ),

                  ),

                  const SizedBox(height: 12),

                  const Padding(

                    padding: EdgeInsets.symmetric(

                      horizontal: 35,

                    ),

                    child: Text(

                      'Discover. Create. Connect.',

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        color: Colors.white70,

                        fontSize: 14,

                      ),

                    ),

                  ),

                  const SizedBox(height: 20),

                  Row(

                    mainAxisAlignment:

                        MainAxisAlignment.center,

                    children: [

                      profileStat(

                        'Posts',

                        '24',

                      ),

                      profileStat(

                        'Followers',

                        '1.2K',

                      ),

                      profileStat(

                        'Following',

                        '348',

                      ),

                    ],

                  ),

                  const SizedBox(height: 20),

                  Padding(

                    padding: const EdgeInsets.symmetric(

                      horizontal: 18,

                    ),

                    child: Row(

                      children: [

                        Expanded(

                          child: OutlinedButton.icon(

                            onPressed: () {},

                            icon: const Icon(

                              Icons.edit_outlined,

                            ),

                            label: const Text(

                              'Edit Profile',

                            ),

                          ),

                        ),

                        const SizedBox(width: 10),

                        Expanded(

                          child: OutlinedButton.icon(

                            onPressed: () {},

                            icon: const Icon(

                              Icons.share_outlined,

                            ),

                            label: const Text(

                              'Share',

                            ),

                          ),

                        ),

                      ],

                    ),

                  ),

                  const SizedBox(height: 24),

                  const Row(

                    mainAxisAlignment:

                        MainAxisAlignment.center,

                    children: [

                      Icon(

                        Icons.grid_on,

                        size: 26,

                        color: Colors.deepPurpleAccent,

                      ),

                      SizedBox(width: 45),

                      Icon(

                        Icons.video_library_outlined,

                        size: 26,

                        color: Colors.white54,

                      ),

                      SizedBox(width: 45),

                      Icon(

                        Icons.bookmark_border,

                        size: 26,

                        color: Colors.white54,

                      ),

                    ],

                  ),

                  const SizedBox(height: 15),

                  buildPostGrid(),

                  const SizedBox(height: 25),

                ],

              ),

            ),

          ),

        ],

      ),

    );

  }

  static Widget profileStat(

    String title,

    String value,

  ) {

    return SizedBox(

      width: 105,

      child: Column(

        children: [

          Text(

            value,

            style: const TextStyle(

              fontSize: 19,

              fontWeight: FontWeight.bold,

            ),

          ),

          const SizedBox(height: 3),

          Text(

            title,

            style: const TextStyle(

              color: Colors.white54,

              fontSize: 12,

            ),

          ),

        ],

      ),

    );

  }

  static Widget buildPostGrid() {

    return GridView.builder(

      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      padding: const EdgeInsets.symmetric(

        horizontal: 2,

      ),

      itemCount: 9,

      gridDelegate:

          const SliverGridDelegateWithFixedCrossAxisCount(

        crossAxisCount: 3,

        crossAxisSpacing: 2,

        mainAxisSpacing: 2,

      ),

      itemBuilder: (context, index) {

        final List<List<Color>> gradients = [

          [

            Colors.deepPurple,

            Colors.blue,

          ],

          [

            Colors.blue,

            Colors.cyan,

          ],

          [

            Colors.purple,

            Colors.pink,

          ],

          [

            Colors.indigo,

            Colors.deepPurple,

          ],

          [

            Colors.deepPurple,

            Colors.black,

          ],

          [

            Colors.blue,

            Colors.purple,

          ],

          [

            Colors.pink,

            Colors.deepPurple,

          ],

          [

            Colors.cyan,

            Colors.blue,

          ],

          [

            Colors.purple,

            Colors.indigo,

          ],

        ];

        return Container(

          decoration: BoxDecoration(

            gradient: LinearGradient(

              begin: Alignment.topLeft,

              end: Alignment.bottomRight,

              colors: gradients[index],

            ),

          ),

          child: const Center(

            child: Icon(

              Icons.image_outlined,

              color: Colors.white38,

              size: 32,

            ),

          ),

        );

      },

    );

  }

}