import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/extensions/date_ex.dart';
import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/constant_manager.dart';
import 'package:evently/data/dm/category.dart';
import 'package:evently/data/dm/eventDM.dart';
import 'package:evently/data/firebase_service/firebase_service.dart';
import 'package:evently/main_layout/tabs/home/widgets/tab_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late TextEditingController titleController;

  late TextEditingController descriptionController;

  DateTime selectedDate = DateTime.now();
  CategoryDM selectedCategory = ConstantManager.categories[0];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(selectedCategory.imagePath ?? AssetsManager.birthDayLight),
                ),
                SizedBox(height: 6.h),
                CustomTabBar(
                  onCategoryItemClicked: onCategoryClicked,
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
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Title is required";
                    }
                    if (input.length < 4) {
                      return "Title should be at least 4 characters";
                    } else {
                      return null;
                    }
                  },
                  controller: titleController,
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
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Description is required";
                    }
                    if (input.length < 4) {
                      return "Title should be at least 12 characters";
                    } else {
                      return null;
                    }
                  },
                  controller: descriptionController,
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
                      selectedDate.toFormattedDate,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: _selectEventDate,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(color: ColorsManager.blue),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined),
                    SizedBox(width: 8.w),
                    Text(
                      DateFormat("hh:mm a").format(
                        selectedDate.copyWith(
                          hour: selectedTime.hour,
                          minute: selectedTime.minute,
                        ),
                      ),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: _selectEventTime,
                      child: Text(
                        "Choose Time",
                        style: TextStyle(color: ColorsManager.blue),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: "Create Event",
                    onTap: createEvent,
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCategoryClicked(CategoryDM Category) {
    selectedCategory = Category;
    setState(() {});
  }

  void createEvent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    selectedDate = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedTime.minute,
    );
    EventDM event = EventDM(
      title: titleController.text,
      description: descriptionController.text,
      Category: selectedCategory,
      date: selectedDate,
    );
    await FirebaseService.addEventToFireStore(event);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorsManager.black,
        content: Text("Event Created Successfully"),
      ),
    );
  }

  void _selectEventDate() async {
    selectedDate =
        await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 356)),
        ) ??
        selectedDate;
    setState(() {});
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  void _selectEventTime() async {
    selectedTime =
        await showTimePicker(
            context: context, initialTime: TimeOfDay.now()) ??
        selectedTime;

    setState(() {});
  }
}
