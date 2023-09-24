import 'package:bab/presentation/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool disabled;
  final EdgeInsetsGeometry margin;
  final bool obsecureText;
  final Widget? suffixIcon;
  // final bool requiredField;
  final TextInputType? keyboardType;
  late final String? countryDial;
  CustomPhoneInput(
      {required this.controller,
      required this.label,
      required this.hint,
      this.disabled = false,
      this.margin = const EdgeInsets.only(bottom: 16),
      this.obsecureText = false,
      this.suffixIcon,
      // required this.requiredField,
      this.keyboardType = TextInputType.text,
      this.countryDial});

  @override
  State<CustomPhoneInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomPhoneInput> {
  @override
  Widget build(BuildContext context) {
    print("builded");
    return Material(
      color: Colors.white,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70.h,
          padding: EdgeInsets.only(left: 14, right: 14, top: 4),
          margin: widget.margin,
          decoration: BoxDecoration(
            color: (widget.disabled == false)
                ? Colors.transparent
                : AppColor.primaryExtraSoft,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          ),
          child: IntlPhoneField(
            readOnly: widget.disabled,
            // keyboardType: widget.keyboardType,
            obscureText: widget.obsecureText,
            style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
            // maxLines: 1,
            showCountryFlag: false,
            showDropdownIcon: false,
            initialValue: widget.countryDial,
            onCountryChanged: (country) {
              widget.countryDial = "+" + country.dialCode;
            },
            controller: widget.controller,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon ?? SizedBox(),
              label: Text(
                widget.label,
                style: TextStyle(
                  color: AppColor.secondarySoft,
                  fontSize: 14,
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500,
                color: AppColor.secondarySoft,
              ),
            ),
          )),
    );
  }
}
