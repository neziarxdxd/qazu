import 'package:flutter/material.dart';

class ButtonCustom extends StatefulWidget {
  String text;
  Color color;
  Icon? icon;
  VoidCallback? onPressed;
  ButtonCustom({
    super.key,
    this.text = "Button",
    this.color = Colors.blue,
    this.icon,
    this.onPressed,
  });

  @override
  State<ButtonCustom> createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed!();
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon ?? Container(),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
