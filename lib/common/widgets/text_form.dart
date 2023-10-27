// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class TextForm extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  late String hintText;
  final String errorMessage;
  final IconData icon;
  final bool canBeEmpty;
  final bool isEnabled;
  final bool isEmail;
  final bool isLink;
  final bool isDesc;
  final bool validatorCondition;
  int? maxLines = 1;
  final TextInputType keyboardType;
  final Function(String?)? onSaved;
  final Function(String)? onSubmit;
  final Function(String)? onChange;

  TextForm(
      {super.key,
      required this.controller,
      required this.title,
      required this.icon,
      required this.hintText,
      this.errorMessage = 'Incorrect Input',
      this.canBeEmpty = false,
      this.isEmail = false,
      this.isLink = false,
      this.isDesc = false,
      this.validatorCondition = false,
      this.isEnabled = true,
      this.keyboardType = TextInputType.text,
      this.onSaved,
      this.onSubmit,
      this.onChange,
      this.maxLines});

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  bool isfocused = false;
  bool showSuffix = false;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.canBeEmpty
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.title,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '  Optional',
                    style:
                        TextStyle(fontSize: 11.sp, color: AppColors.darkGrey),
                  ),
                ],
              )
            : Text(
                widget.title,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isfocused ? AppColors.hardMintGreen : AppColors.lightGrey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: Icon(
                  widget.icon,
                  color:
                      isfocused ? AppColors.hardMintGreen : AppColors.lightGrey,
                ),
              ),
              Container(
                height: widget.isDesc ? 55 : 30,
                width: 1.0,
                color:
                    isfocused ? AppColors.hardMintGreen : AppColors.lightGrey,
                margin: const EdgeInsets.only(right: 10.0),
              ),
              Expanded(
                child: TextFormField(
                  maxLines: widget.maxLines,
                  controller: widget.controller,
                  maxLength: widget.isDesc ? 150 : null,
                  validator: (value) {
                    if (value!.isEmpty && !widget.canBeEmpty) {
                      setState(() {
                        showSuffix = true;
                      });
                      return '';
                    } else if (widget.isEmail &&
                        !validateEmail(value) &&
                        !widget.canBeEmpty) {
                      setState(() {
                        showSuffix = true;
                      });
                      return '';
                    } else if (widget.isLink &&
                        !value.isURL &&
                        !widget.canBeEmpty) {
                      setState(() {
                        showSuffix = true;
                      });
                      return '';
                    } else {
                      setState(() {
                        showSuffix = false;
                      });
                    }
                    if (widget.validatorCondition) {
                      return widget.errorMessage;
                    }
                    return null;
                  },
                  enabled: widget.isEnabled,
                  keyboardType: widget.keyboardType,
                  onFieldSubmitted: widget.onSubmit,
                  onChanged: widget.onChange,
                  onSaved: widget.onSaved,
                  onTap: () {
                    setState(() {
                      isfocused = true;
                    });
                  },
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      isfocused = false;
                    });
                  },
                  cursorColor: AppColors.hardMintGreen,
                  decoration: InputDecoration(
                    contentPadding: widget.isDesc
                        ? const EdgeInsets.only(top: 20, right: 6)
                        : const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 16),
                    errorStyle: const TextStyle(fontSize: 0.001),
                    suffixIcon: showSuffix
                        ? Tooltip(
                            enableFeedback: true,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.red),
                            key: tooltipkey,
                            textStyle: const TextStyle(color: Colors.white),
                            showDuration: const Duration(milliseconds: 500),
                            message: widget.isEmail
                                ? 'Please enter a valid email'
                                : widget.isLink
                                    ? 'Please enter a valid link'
                                    : 'The ${widget.title.toLowerCase()} is required',
                            child: IconButton(
                              icon: const Icon(Icons.error_outline_rounded,
                                  color: Colors.red),
                              onPressed: () {
                                tooltipkey.currentState?.ensureTooltipVisible();
                              },
                            ),
                          )
                        : null,
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(color: AppColors.lightGrey),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  bool validateEmail(String email) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
