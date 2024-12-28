import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final String labelText;
  final TextStyle labelTextStyle;
  final TextEditingController controller;
  final bool obscureText;
  final double maxLength = 300.0;
  final MainAxisAlignment alignment;

  const CustomTextInput({
    super.key,
    required this.labelText,
    required this.labelTextStyle,
    required this.controller,
    this.obscureText = false,
    this.alignment = MainAxisAlignment.center,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomTextInputState();
  }
}

class _CustomTextInputState extends State<CustomTextInput> {
  late bool viewContent = widget.obscureText;

  void initViewContent() {
    viewContent = widget.obscureText;
  }

  void setViewContent() {
    if (widget.obscureText) {
      viewContent = !viewContent;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextField nonObscureTextField = TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelStyle: widget.labelTextStyle,
        labelText: widget.labelText,
      ),
    );

    TextField obscureTextField = TextField(
      controller: widget.controller,
      obscureText: viewContent,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelStyle: widget.labelTextStyle,
        labelText: widget.labelText,
        suffixIcon: IconButton(
          icon: Icon(
            viewContent ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              viewContent = !viewContent;
            });
          },
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: widget.alignment,
        children: [
          SizedBox(
            width: widget.maxLength,
            child: SafeArea(
              child:
                  widget.obscureText ? obscureTextField : nonObscureTextField,
            ),
          ),
        ],
      ),
    );
  }
}
