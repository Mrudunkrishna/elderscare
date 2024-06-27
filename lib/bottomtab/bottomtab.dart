import 'package:elderscareapp/home/Homepage.dart';
import 'package:elderscareapp/home/home2.dart';
import 'package:elderscareapp/home/home3.dart';
import 'package:elderscareapp/home/home4.dart';
import 'package:flutter/material.dart';



class BottomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        body: TabBarView(
          children: [
            homepage(),
            home2(),
            homee3(),
            ImageUploadPage()
          ],
        ),

        bottomNavigationBar: TabBar(
            dividerHeight: 0,
            enableFeedback: false,
            unselectedLabelColor: Colors.black,
            tabAlignment: TabAlignment.fill,
            overlayColor: MaterialStatePropertyAll(Colors.grey[300]),
            splashBorderRadius: BorderRadius.circular(60),
            splashFactory: InkSparkle.splashFactory,
            labelPadding: const EdgeInsets.only(left: 1, right: 1),
            indicator: const BoxDecoration(),
            labelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.green[800],
            ),
            tabs: [
              tabIconText(
                  bottomIcon: Icons.home, bottomIconText: 'Home'),
              tabIconText(
                  bottomIcon: Icons.health_and_safety_outlined,
                  bottomIconText: 'Health Care'),
              tabIconText(
                  bottomIcon: Icons.notification_add_outlined,
                  bottomIconText: 'Reminder'),
              tabIconText(
                  bottomIcon: Icons.account_circle_outlined,
                  bottomIconText: 'My Account')
            ]),
      ),
    );
  }

  Widget tabIconText({required bottomIcon, required bottomIconText}) {
    return Tab(
      iconMargin: const EdgeInsets.all(0.01),
      height: 55,
      icon: Icon(bottomIcon, size: 25),
      text: bottomIconText,
    );
  }
}
