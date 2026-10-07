import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {

  const ExploreScreen({super.key});

  @override

  State<ExploreScreen> createState() => _ExploreScreenState();

}

class _ExploreScreenState extends State<ExploreScreen> {

  int selectedCategory = 0;

  final categories = [

    'All',

    'People',

    'Videos',

    'Photos',

    'Places',

  ];

  @override

  Widget build(BuildContext context) {

    return SafeArea(

      child: CustomScrollView(

        slivers: [

          SliverToBoxAdapter(

            child: Padding(

              padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Text(

                    'Explore',

                    style: TextStyle(

                      fontSize: 30,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 16),

                  TextField(

                    decoration: InputDecoration(

                      hintText: 'Search people, posts and places',

                      prefixIcon: const Icon(Icons.search),

                      filled: true,

                      fillColor: Colors.white10,

                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(18),

                        borderSide: BorderSide.none,

                      ),

                    ),

                  ),

                  const SizedBox(height: 16),

                  SizedBox(

                    height: 42,

                    child: ListView.builder(

                      scrollDirection: Axis.horizontal,

                      itemCount: categories.length,

                      itemBuilder: (context, index) {

                        final selected = selectedCategory == index;

                        return GestureDetector(

                          onTap: () {

                            setState(() {

                              selectedCategory = index;

                            });

                          },

                          child: Container(

                            margin: const EdgeInsets.only(right: 8),

                            padding: const EdgeInsets.symmetric(

                              horizontal: 18,

                              vertical: 10,

                            ),

                            decoration: BoxDecoration(

                              color: selected

                                  ? Colors.deepPurpleAccent

                                  : Colors.white10,

                              borderRadius: BorderRadius.circular(22),

                            ),

                            child: Text(

                              categories[index],

                              style: TextStyle(

                                fontWeight: selected

                                    ? FontWeight.bold

                                    : FontWeight.normal,

                              ),

                            ),

                          ),

                        );

                      },

                    ),

                  ),

                  const SizedBox(height: 14),

                ],

              ),

            ),

          ),

          SliverPadding(

            padding: const EdgeInsets.all(3),

            sliver: SliverGrid(

              delegate: SliverChildBuilderDelegate(

                (context, index) {

                  return Container(

                    decoration: BoxDecoration(

                      gradient: LinearGradient(

                        begin: Alignment.topLeft,

                        end: Alignment.bottomRight,

                        colors: [

                          Colors.deepPurple.shade900,

                          Colors.blue.shade900,

                        ],

                      ),

                    ),

                    child: Stack(

                      children: [

                        const Center(

                          child: Icon(

                            Icons.image_outlined,

                            size: 42,

                            color: Colors.white38,

                          ),

                        ),

                        if (index % 4 == 0)

                          const Positioned(

                            right: 8,

                            top: 8,

                            child: Icon(

                              Icons.play_circle_fill,

                              color: Colors.white,

                            ),

                          ),

                      ],

                    ),

                  );

                },

                childCount: 18,

              ),

              gridDelegate:

                  const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 3,

                crossAxisSpacing: 3,

                mainAxisSpacing: 3,

                childAspectRatio: 0.9,

              ),

            ),

          ),

        ],

      ),

    );

  }

}