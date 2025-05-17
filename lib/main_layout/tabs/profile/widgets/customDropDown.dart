import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customdropdown extends StatefulWidget {
  const Customdropdown({
    super.key,
    required this.dropDownTitle,
    required this.dropDownItems,
    required this.onChange,
    required this.viewedText,
  });

  final String dropDownTitle;
  final List<DropdownMenuItem<String>>? dropDownItems;

  final Function(String?) onChange;
  final String viewedText;

  @override
  State<Customdropdown> createState() => _CustomdropdownState();
}

class _CustomdropdownState extends State<Customdropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.dropDownTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: double.infinity,
          padding: REdgeInsets.all(8),
          margin: REdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: ColorsManager.blue),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: DropdownButton<String>(
            underline: Container(),
            iconEnabledColor: ColorsManager.blue,
            iconDisabledColor: ColorsManager.blue,
            borderRadius: BorderRadius.circular(16.r),
            focusColor: ColorsManager.blue,
            dropdownColor: ColorsManager.light,
            style: Theme.of(context).textTheme.labelMedium,
            isExpanded: true,
            items: widget.dropDownItems,
            value: widget.dropDownItems!.any((item) => item.value == widget.viewedText)
                ? widget.viewedText
                : null,

            onChanged: (newLang) {
              widget.onChange(newLang);
            },
          ),
        ),
      ],
    );
  }
}
