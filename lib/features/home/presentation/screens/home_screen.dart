import 'package:client/core/themes.dart';
import 'package:client/features/home/presentation/widgets/calender.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                CalendarWidget(),
                // _buildMessages(),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 200),
        color: AppThemes.navigationBarColor.colors.last,

        items: <Widget>[
          FaIcon(FontAwesomeIcons.house, size: 20),
          FaIcon(FontAwesomeIcons.message, size: 25),
          FaIcon(FontAwesomeIcons.user, size: 25),
          FaIcon(FontAwesomeIcons.calendarPlus, size: 25),
        ],
        onTap: (index) {},
      ),
    );
  }

  _buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, John",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Good Morning",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            FaIcon(
              FontAwesomeIcons.solidBell,
              size: 21,
              color: AppThemes.navigationBarColor.colors.first,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.userDoctor, color: AppThemes.primaryBlue),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppThemes.lightField,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppThemes.secondaryText,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppThemes.primaryBlue),
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: AppThemes.secondaryText),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
