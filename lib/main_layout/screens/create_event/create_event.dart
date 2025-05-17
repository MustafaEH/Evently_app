import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/constant_manager.dart';
import 'package:evently/main_layout/tabs/home/widgets/tab_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          "Create Event",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(AssetsManager.birthDay),
              ),
              SizedBox(height: 6.h),
              CustomTabBar(
                categories: ConstantManager.categories,
                selectedTabBgColor: ColorsManager.blue,
                unSelectedTabBgColor: Colors.transparent,
                selectedTabContentColor: ColorsManager.white,
                unSelectedTabContentColor: ColorsManager.blue,
              ),
              SizedBox(height: 16.h),
              Text(
                "Title",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                prefixIcon: Icons.edit_outlined,
                hint: "Event Title",
              ),
              SizedBox(height: 16.h),
              Text(
                "Description",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                lines: 5,
                // prefixIcon: Icons.edit_outlined,
                hint: "Event Description",
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Icon(Icons.date_range_outlined),
                  SizedBox(width: 8.w),
                  Text(
                    "Event Date",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text("Choose Date"),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.punch_clock),
                  SizedBox(width: 8.w),
                  Text(
                    "Event Time",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _showTimePicker,
                    child: Text("Choose Time"),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 356)),
    );
  }

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }
}
