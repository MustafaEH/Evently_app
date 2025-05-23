import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/constant_manager.dart';
import 'package:evently/data/dm/category.dart';
import 'package:evently/data/dm/eventDM.dart';
import 'package:evently/data/firebase_service/firebase_service.dart';
import 'package:evently/main_layout/tabs/home/widgets/event_component.dart';
import 'package:evently/main_layout/tabs/home/widgets/tab_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoryDM category = ConstantManager.categoriesWithAll[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
          ),
          child: SafeArea(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcome_back,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "Mustafa Ehab",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      Text(
                        "Cairo, Egypt",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  CustomTabBar(
                    onCategoryItemClicked: (selectedCategory) {
                      category = selectedCategory;
                      setState(() {});
                    },

                    categories: ConstantManager.categoriesWithAll,
                    selectedTabBgColor: ColorsManager.light,
                    unSelectedTabBgColor: Colors.transparent,
                    selectedTabContentColor: ColorsManager.blue,
                    unSelectedTabContentColor: ColorsManager.light,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseService.getEventsRealTime(category),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              }
              if (snapshot.hasError) {
                Text(snapshot.error.toString());
              }
              List<EventDM> events = snapshot.data!;
              return ListView.builder(
                itemBuilder:
                    (context, index) => EventComponent(event: events[index]),
                itemCount: events.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
