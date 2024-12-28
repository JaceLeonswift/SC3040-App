import 'package:flutter/material.dart';

class LinkText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Widget page;

  const LinkText({
    super.key,
    required this.text,
    required this.textStyle,
    required this.page,
  });

  @override
  State<StatefulWidget> createState() {
    return _LinkText();
  }
}

class _LinkText extends State<LinkText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.page),
          );
        },
        onHover: _onHover,
        child: Text(
          widget.text,
          style: widget.textStyle.copyWith(
              color: _isHovering ? theme.colorScheme.secondary : null),
        ),
      ),
    );
  }

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }
}
