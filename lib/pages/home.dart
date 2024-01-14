import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    final iconList = <IconData>[
      Icons.calendar_today_rounded,
      Icons.calendar_month_rounded,
      Icons.bar_chart_rounded,
      Icons.person_rounded,
    ];

    var _bottomNavIndex = 0;

    data = ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/location');
                },
                icon: const Icon(Icons.edit_location),
                label: const Text('Edit Location'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  data['location'],
                  style: const TextStyle(
                    fontSize: 28,
                    letterSpacing: 2,
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Text(data['time'],
                  style: const TextStyle(
                    fontSize: 66,
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {},
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        iconSize: 30,
        height: 70,
        backgroundColor: Colors.grey[300],
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => setState(() {
          print(index);
          _bottomNavIndex = index;
        }),
        //other params
      ),
    );
  }
}
