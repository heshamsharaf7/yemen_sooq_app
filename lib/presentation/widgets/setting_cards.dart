

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingCard extends StatefulWidget {
   SettingCard({required this.title,required this.img, required this.onClick});
  final String title;
  final String img;
  final void Function() onClick;

  @override
  State<SettingCard> createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: InkWell(
        onTap:  widget.onClick,
        child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/${widget.img}.svg'),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              wordSpacing: 4.0,
                            ),
                          )
                        ],
                      ),
      ),
    );
  }
}