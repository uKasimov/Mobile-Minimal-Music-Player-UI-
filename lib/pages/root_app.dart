import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:musicui/pages/home_page.dart';
import 'package:musicui/theme/colors.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activityTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activityTab,
      children: const [
        HomePage(),
        Center(
          child: Text(
            "Home",
            style: TextStyle(fontSize: 20, color: white, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            "Library",
            style: TextStyle(fontSize: 20, color: white, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            "Search",
            style: TextStyle(fontSize: 20, color: white, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            "Settings",
            style: TextStyle(fontSize: 20, color: white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      Feather.home,
      Feather.book,
      Feather.search,
      Feather.settings,
    ];
    return Container(
      height: 80,
      decoration: const BoxDecoration(color: black),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) {
              return IconButton(
                  icon: Icon(
                    items[index],
                    color: activityTab == index ? primary : white,
                  ),
                  onPressed: () {
                    setState(() {
                      activityTab = index;
                    });
                  });
            })),
      ),
    );
  }
}
