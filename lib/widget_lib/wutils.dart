// create a ShowMyMenu statefull widget
import 'package:flutter/material.dart';

class CwPopupMenuButton extends StatefulWidget {
  const CwPopupMenuButton(
      {super.key,
      required this.options,
      required this.selectedIndex,
      this.shadowColor,
      this.tooltip,
      this.clipBehavior,
      this.borderRadius,
      this.radius = 10.0,
      this.elevation = 8.0,
      this.yoffset = 30.0,
      this.xoffset = 0.0,
      this.padding,
      this.horizontalPadding = 10.0,
      this.verticalPadding = 0.0,
      this.backgroundColor,
      this.foregroundColor,
      this.textColor,
      this.fontFamily,
      this.fontSize,
      this.width = 150.0,
      this.height = 30.0});
  final List<String> options;
  //final ValueChanged<int> onChanged;
  final ValueNotifier<int> selectedIndex;
  final Color? shadowColor;
  final String? tooltip;
  final Clip? clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final double? radius;
  final double? elevation;
  final double yoffset;
  final double xoffset;
  final double? padding;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final String? fontFamily;
  final double? fontSize;
  final double? width;
  final double? height;

  // final int initialSelectedIndex;
  // String getChosenOption() => options[selectedIndex.value];
  // int getChosenIndex() => selectedIndex.value;

  @override
  State<CwPopupMenuButton> createState() => CwPopupMenuButtonState();
}

class CwPopupMenuButtonState extends State<CwPopupMenuButton> {
  late GlobalKey actionKey;
  CwPopupMenuButtonState();

  @override
  void initState() {
    super.initState();
    actionKey = LabeledGlobalKey('PopupMenuButton');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: PopupMenuButton(
        padding: const EdgeInsets.all(0.0),
        offset: Offset(widget.xoffset, widget.yoffset),
        elevation: widget.elevation ?? 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ??
              BorderRadius.circular(widget.radius ?? 10.0),
        ),
        shadowColor:
            widget.shadowColor ?? Theme.of(context).colorScheme.secondary,
        clipBehavior: Clip.antiAlias,
        tooltip: 'Choose one',
        child: ListTile(
          //contentPadding: EdgeInsets.all(widget.padding ?? 4.0),
          trailing: Icon(
            Icons.arrow_drop_down,
            color: widget.backgroundColor ??
                Theme.of(context).colorScheme.secondary,
          ),
          title: TextButton(
            onPressed: null,
            // Text button with rounded corners
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.horizontalPadding ?? 10.0,
                  vertical: widget.verticalPadding ?? 2.0),
              shape: RoundedRectangleBorder(
                borderRadius: widget.borderRadius ??
                    BorderRadius.circular(widget.radius ?? 10.0),
              ),
              backgroundColor: widget.backgroundColor ??
                  Theme.of(context).colorScheme.secondary,
              foregroundColor: widget.foregroundColor ??
                  Theme.of(context).colorScheme.primary,
            ),
            child: Text(widget.options[widget.selectedIndex.value]),
            // wrap Text with ListTile and use a down arrow for choosing an option
            // as a trailing icon
          ),
        ),
        itemBuilder: (BuildContext context) {
          return List<PopupMenuEntry>.generate(
            2 * (widget.options.length - 1) + 1,
            (index) {
              // if index is even return a divider
              if (index % 2 != 0) {
                return const PopupMenuDivider(height: 0.5);
              } else {
                return PopupMenuItem(
                  height: widget.fontSize != null
                      ? widget.fontSize! * 2
                      : Theme.of(context).textTheme.bodyMedium!.fontSize! * 2,
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.horizontalPadding ?? 10.0,
                      vertical: widget.verticalPadding ?? 2.0),
                  value: index,
                  child: Text(
                    widget.options[index / 2 as int],
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                      fontFamily: widget.fontFamily,
                    ),
                  ),
                );
              }
            },
          );
        },
        onSelected: (value) {
          setState(() {
            if (value % 2 == 0) {
              widget.selectedIndex.value = value / 2;
            }
          });
        },
      ),
    );
  }
}

// This is a non-pressable Text widget with borders and background color
class CwText extends StatelessWidget {
  final String text;

  final Color? textColor;

  final double horizontalSpace;

  final double verticalSpace;

  final Color? backgroundColor;

  final double borderRadius;

  final double borderWidth;
  final Color? borderColor;
  final double fontSize;

  const CwText(this.text,
      {super.key,
      this.textColor,
      this.horizontalSpace = 10.0,
      this.verticalSpace = 6.0,
      this.backgroundColor,
      this.borderRadius = 10.0,
      this.borderWidth = 0.5,
      this.borderColor,
      this.fontSize = 12.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalSpace, vertical: verticalSpace),
      decoration: BoxDecoration(
        color: backgroundColor, // Background color
        borderRadius: BorderRadius.circular(borderRadius), // Rounded borders
        border: Border.all(
            color: borderColor == null ? Colors.black : borderColor!,
            width: borderWidth), // Border color and width
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
    );
  }
}
