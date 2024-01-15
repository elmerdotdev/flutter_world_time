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

    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    // set background
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/$bgImage'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag']
                      };
                    });
                  },
                  icon: const Icon(Icons.edit_location),
                  label: const Text('Edit Location'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    data['location'],
                    style: const TextStyle(
                      fontSize: 28,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                ]),
                const SizedBox(height: 20),
                Text(data['time'],
                    style: const TextStyle(
                      fontSize: 66,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.pushNamed(context, '/location');
          },
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
        backgroundColor: Colors.white,
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
