import "package:flutter/material.dart";

class CustomIconButton extends StatefulWidget {
  const CustomIconButton(this.onPressed, this.icon, this.isEnabled, this.size,
      {this.colorEnabled,
      this.colorDisabled,
      // this.text,
      // this.colorTextEnabled,
      // this.colorTextDisabled,
      Key? key})
      : super(key: key);

  final Function onPressed;
  final Icon icon;
  final bool isEnabled;
  final double size;
  final Color? colorEnabled;
  final Color? colorDisabled;


  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.isEnabled ? widget.onPressed() : null,
      icon: widget.icon,
      color:  widget.colorEnabled,
      disabledColor: widget.colorDisabled,

    );
    //
    // OutlinedButton(
    //   style: ButtonStyle(
    //     shape: MaterialStateProperty.all(const StadiumBorder()),
    //     backgroundColor: MaterialStateProperty.all(
    //       color.withOpacity(0.5),
    //     ),
    //     overlayColor: MaterialStateProperty.all(
    //       color.withOpacity(0.3),
    //     ),
    //   ),
    //   onPressed: () => onPressed(),
    //   child: Row(
    //     children: [
    //       Icon(icon, color: Colors.white),
    //       Text(
    //         text,
    //         style: const TextStyle(color: Colors.white),
    //       )
    //     ],
    //   ),
    // );
  }
}
