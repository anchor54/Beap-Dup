
import 'package:flutter/material.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';

import '../constants/my_theme.dart';
import '../phone/countries.dart';
import '../phone/intl_phone_field.dart';
import '../phone/phone_number.dart';

class mobileNumberTextFiled extends StatelessWidget {
  const mobileNumberTextFiled({super.key,
    required this.controller,
    this.countryCode,
    this.onChanged,
    this.onCountryChanged,
  });
  final TextEditingController controller;
  final String? countryCode;
  final Function(PhoneNumber)? onChanged;
  final void Function(Country)? onCountryChanged;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      initialCountryCode: countryCode ?? "1",
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      textInputAction: TextInputAction.done,
      style:  TextStyle(color:context.theme.onPrimary, fontSize: 15, letterSpacing: 1.5),
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: 'XXX-XXX-XXXX',
        hintStyle:TextStyle(fontSize:22,color:MyColor.onSecondary,fontWeight:FontWeight.w600),
        contentPadding: EdgeInsets.all(15),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color:Colors.red, width: 0.0),
        ),
        border: InputBorder.none,
      ),
      controller: controller,
      onChanged: onChanged,
      onCountryChanged: onCountryChanged,
    );
  }
}
