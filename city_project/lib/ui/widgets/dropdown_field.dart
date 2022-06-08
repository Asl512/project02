import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';

import 'package:lan_code/ui/pages/guide/booking/booking_page.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';

class DropdownField extends StatefulWidget {
  final BookingController controller;
  final List<DateExcursion> dates;
  final StreamController<bool> streamController;

  const DropdownField({
    Key? key,
    required this.dates,
    required this.controller,
    required this.streamController,
  }) : super(key: key);

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;
  late DateExcursion active;

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
    active = widget.dates.first;
    widget.streamController.sink.add(true);
    widget.controller.dateExcursion = active;
    widget.streamController.sink.add(false);
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() => isShow = !isShow);
            _runExpandCheck();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: White,
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrefixIconTextField(
                  color: const Color(0xFFc25cf2),
                  icon: const Icon(
                    Icons.calendar_today_rounded,
                    color: White,
                    size: 25,
                  ),
                ),
                Text(
                  'Дата: ' + active.getDate + ', время: ' + active.getTime,
                  style: Montserrat(color: Blue, size: 15),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: White,
          ),
          margin: const EdgeInsets.only(top: 3),
          child: SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Column(
              children: widget.dates.map((item) {
                return GestureDetector(
                  onTap: () {
                    widget.streamController.sink.add(true);
                    setState(() => active = item);
                    widget.controller.dateExcursion = active;
                    setState(() => isShow = !isShow);
                    widget.streamController.sink.add(false);
                    _runExpandCheck();
                  },
                  child: Container(
                    color: White,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                    child: Row(
                      children: [
                        Text(
                          'Дата: ' + item.getDate + ', время: ' + item.getTime,
                          style: Montserrat(color: Blue, size: 15),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
