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
            padding: const EdgeInsets.symmetric( horizontal: 20.0, vertical: 30.0),
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
        color: AppThemes.custom,

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

  // _buildHeader() {
  //   return Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               CircleAvatar(
  //                 radius: 24,
  //                 backgroundImage: AssetImage('assets/images/user.png'),
  //               ),
  //               const SizedBox(width: 12),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "Hello, John",
  //                     style: Theme.of(context).textTheme.titleLarge,
  //                   ),
  //                   const SizedBox(height: 2),
  //                   Text(
  //                     "Good Morning",
  //                     style: Theme.of(context).textTheme.bodyMedium,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           FaIcon(
  //             FontAwesomeIcons.solidBell,
  //             size: 21,
  //             color: AppThemes.navigationBarColor.colors.first,
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 24),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           FaIcon(FontAwesomeIcons.userDoctor, color: AppThemes.primaryBlue),
  //           SizedBox(width: 16),
  //           Expanded(
  //             child: TextField(
  //               decoration: InputDecoration(
  //                 filled: true,
  //                 fillColor: AppThemes.lightField,
  //                 prefixIcon: Icon(
  //                   Icons.search,
  //                   color: AppThemes.secondaryText,
  //                 ),

  //                 focusedBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: AppThemes.primaryBlue),
  //                 ),
  //                 hintText: 'Search',
  //                 hintStyle: TextStyle(color: AppThemes.secondaryText),
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(16.0),
  //                   borderSide: BorderSide.none,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [

                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('assets/images/user.png'),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 12),

                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, John",
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _getGreeting(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


            Stack(
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: FaIcon(
                      FontAwesomeIcons.bell,
                      size: 22,
                      color: AppThemes.navigationBarColor.colors.first,
                    ),
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppThemes.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {

                },
                icon: FaIcon(
                  FontAwesomeIcons.userDoctor,
                  color: AppThemes.primaryBlue,
                  size: 20,
                ),
                tooltip: 'Find Doctor',
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppThemes.lightField,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppThemes.secondaryText,
                    size: 22,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.tune,
                      color: AppThemes.secondaryText,
                      size: 22,
                    ),
                    onPressed: () {

                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  hintText: 'Search doctors, specialists...',
                  hintStyle: TextStyle(
                    color: AppThemes.secondaryText,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppThemes.primaryBlue,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
    
                },
              ),
            ),
          ],
        ),
      ],
    );
  }


  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    if (hour < 21) return 'Good Evening';
    return 'Good Night';
  }
}
