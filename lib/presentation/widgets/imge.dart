import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarImage extends StatelessWidget {
  final String avatarImageUrl;

  AvatarImage({required this.avatarImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
  width: 150.w,
  height: 150.h,
  decoration: BoxDecoration(
    // borderRadius: BorderRadius.circular(10),
    color: Colors.grey[300],
  ),
  child: Image.asset(
   avatarImageUrl,
    fit: BoxFit.cover,
  ),
);
    // return avatar(
    //   radius: 50,
    //   backgroundImage: Image.asset(avatarImageUrl).image,
    // );
  }
}

class RectangularImage extends StatelessWidget {
  final String avatarImageUrl;

  RectangularImage({required this.avatarImageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
  avatarImageUrl,
  width: 200,
  height: 150,
  fit: BoxFit.cover,
);
  }
}