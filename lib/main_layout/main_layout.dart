import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/main_layout/tabs/favourites/favourites.dart';
import 'package:evently/main_layout/tabs/home/home.dart';
import 'package:evently/main_layout/tabs/maps/maps.dart';
import 'package:evently/main_layout/tabs/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;
  List<Widget> tabs = [Home(), Maps(), Favourites(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(color: ColorsManager.white, width: 3.5.w),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _createEvent,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  Widget buildBottomNavBar() {
    return BottomNavigationBar(
      onTap: (newSelectedIndex) {
        selectedIndex = newSelectedIndex;
        setState(() {});
      },
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: AppLocalizations.of(context)!.home,
          activeIcon: Icon(Icons.home_filled),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.location_pin), label: AppLocalizations.of(context)!.maps),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: AppLocalizations.of(context)!.favourites,
          activeIcon: Icon(Icons.favorite_outlined),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: AppLocalizations.of(context)!.profile,
          activeIcon: Icon(Icons.person),
        ),
      ],
    );
  }
  void _createEvent() {
    Navigator.pushNamed(context, RoutesManager.createEvent);
  }
}
