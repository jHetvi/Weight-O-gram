import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weight_o_gram/Global/Colors/Colors.dart';

enum CTFType {
  FullName,
  OneWord,
  Text,
  Email,
  PhoneNumber,
  Date,
  Number,
  DecimalNumber,
  Password
}

//ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  int minLines = 1, maxLines = 1, maxLength;
  CTFType fieldType;
  double fontSize = 16;
  InputBorder border;
  String hint;
  bool readOnly;
  RegExp regex;
  Function onChangedFunction;
  DateTime firstDate, selectedDate, lastDate;
  Function(DateTime) onDatePicked;
  TextAlign textAlign;
  EdgeInsets padding;
  List<TextInputFormatter> inputFormatters = [];
  TextCapitalization textCapitalization;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  String prefixText;
  Widget prefixWidget;
  Widget suffixWidget;
  String initialValue;
  bool disabled = false;
  bool autoValidate = false;
  final String Function(String) validator;

  CustomTextField.oneWord({
    this.controller,
    this.hint,
    this.regex,
    this.readOnly = false,
    this.padding,
    this.border,
    this.fontSize,
    this.prefixWidget,
    this.validator,
  }) {
    if (controller == null) controller = TextEditingController();
    maxLines = minLines = 1;
    fieldType = CTFType.OneWord;
    keyboardType = TextInputType.text;
    textInputAction = TextInputAction.next;
    textCapitalization = TextCapitalization.words;
  }

  CustomTextField.phoneNumber(
      {this.controller,
      this.hint,
      this.regex,
      this.readOnly = false,
      this.padding,
      this.border,
      this.maxLength,
      this.fontSize,
      this.prefixWidget,
      this.prefixText,
      this.validator,
      this.suffixWidget}) {
    if (controller == null) controller = TextEditingController();
    maxLines = minLines = 1;
    fieldType = CTFType.PhoneNumber;
    keyboardType = TextInputType.phone;
    textCapitalization = TextCapitalization.sentences;
    // ignore: deprecated_member_use
    inputFormatters.add(WhitelistingTextInputFormatter.digitsOnly);
    textInputAction = TextInputAction.next;
    if (maxLength == null)
      inputFormatters.add(LengthLimitingTextInputFormatter(10));
  }

  CustomTextField.number(
      {Key key,
      this.maxLength,
      this.controller,
      this.hint,
      this.regex,
      this.onChangedFunction,
      this.readOnly = false,
      this.padding,
      this.border,
      this.fontSize,
      this.validator,
      this.suffixWidget,
      this.prefixWidget})
      : super(key: key) {
    if (controller == null) controller = TextEditingController();
    maxLines = maxLines ?? minLines;
    fieldType = CTFType.Number;
    textCapitalization = TextCapitalization.sentences;
    keyboardType = TextInputType.phone;
    textInputAction = TextInputAction.next;
    // ignore: deprecated_member_use
    inputFormatters.add(WhitelistingTextInputFormatter.digitsOnly);
    if (maxLength != null)
      inputFormatters.add(LengthLimitingTextInputFormatter(16));
  }

  CustomTextField.text(
      {this.controller,
      this.disabled = false,
      this.hint,
      this.regex,
      this.readOnly = false,
      this.padding,
      this.border,
      this.fontSize,
      this.prefixWidget,
      this.suffixWidget,
      this.validator,
      this.minLines = 1,
      this.maxLines = 1,
      this.maxLength,
      this.textCapitalization = TextCapitalization.sentences,
      this.keyboardType = TextInputType.text}) {
    if (controller == null) controller = TextEditingController();
    maxLines = maxLines ?? minLines;
    fieldType = CTFType.Text;
    keyboardType = maxLines == 1
        ? keyboardType ?? TextInputType.text
        : TextInputType.multiline;
    textInputAction = maxLines == 1
        ? textInputAction ?? TextInputAction.next
        : TextInputAction.newline;
  }

  CustomTextField.decimalNumber(
      {Key key,
      this.controller,
      this.hint,
      this.regex,
      this.readOnly = false,
      this.textAlign = TextAlign.left,
      this.padding,
      this.border,
      this.maxLength,
      this.textInputAction,
      this.fontSize,
      this.validator})
      : super(key: key) {
    if (controller == null) controller = TextEditingController();
    maxLines = maxLines ?? minLines;
    fieldType = CTFType.DecimalNumber;
    textCapitalization = TextCapitalization.sentences;
    textInputAction = TextInputAction.next;
    keyboardType = TextInputType.numberWithOptions(decimal: true);
    // inputFormatters.add(DecimalTextInputFormatter(decimalRange: 2));
  }

  CustomTextField.email(
      {Key key,
      this.controller,
      this.hint,
      this.regex,
      this.readOnly = false,
      this.padding,
      this.border,
      this.textInputAction,
      this.fontSize,
      this.validator,
      this.initialValue,
      this.disabled = false})
      : super(key: key) {
    if (controller == null) controller = TextEditingController();
    maxLines = maxLines ?? minLines;
    fieldType = CTFType.Email;
    textInputAction = TextInputAction.next;
    textCapitalization = TextCapitalization.none;
    keyboardType = TextInputType.emailAddress;
  }

  CustomTextField.password(
      {Key key,
      this.controller,
      this.hint,
      this.regex,
      this.readOnly = false,
      this.onChangedFunction,
      this.autoValidate = false,
      this.padding,
      this.border,
      this.textInputAction,
      this.fontSize,
      this.validator})
      : super(key: key) {
    if (controller == null) controller = TextEditingController();
    maxLines = maxLines ?? minLines;
    fieldType = CTFType.Password;
    textInputAction = TextInputAction.next;
    textCapitalization = TextCapitalization.none;
    keyboardType = TextInputType.emailAddress;
  }

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode focusNode;
  double borderRadius;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    borderRadius = 10;
    return TextFormField(
      // ignore: deprecated_member_use
      cursorColor: whiteColor(),
      autovalidate: widget.autoValidate,
      controller: widget.controller,
      focusNode: focusNode,
      onChanged: widget.onChangedFunction,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      maxLengthEnforced: true,
      textAlign: widget.textAlign ?? TextAlign.start,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      enabled: !widget.readOnly && !widget.disabled,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      style: TextStyle(fontSize: widget.fontSize, color: blackColor()),
      obscureText: widget.fieldType == CTFType.Password,
      validator: widget.validator == null
          ? widget.regex == null
              ? null
              : (str) {
                  if (widget.regex.hasMatch(str))
                    return null;
                  else
                    return "Invalid Input";
                }
          : (str) => widget.validator(str),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: widget.fontSize,
          color: blackColor(),
        ),
        counter: SizedBox(
          height: 5,
          width: 0,
        ),
        contentPadding: widget.padding ??
            EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: blackColor(),
              width: 2.0,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: blackColor(),
              width: 2.0,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: blackColor(),
              width: 2.0,
            )),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.red.shade200, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: whiteColor(), width: 1.0),
        ),
        fillColor: bgLightColor().withOpacity(0.4),
        filled: true,
        prefixText: widget.prefixText,
        hintText: widget.hint ?? "",
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: widget.suffixWidget,
        ),
        suffixIconConstraints: BoxConstraints(maxHeight: 40, maxWidth: 40),
      ),
    );
  }
}
