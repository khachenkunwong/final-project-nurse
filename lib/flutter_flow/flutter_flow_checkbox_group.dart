import 'package:flutter/material.dart';

import '../model/present_model.dart';
import 'flutter_flow_theme.dart';

// ListView.builder(
//         shrinkWrap: true,
//         itemCount: widget.options.length,
//         itemBuilder: (context, index) {
//           final option = widget.options[index];
//           final selected = checkboxValues.contains(option);
//           return
class FlutterFlowCheckboxGroup extends StatefulWidget {
  FlutterFlowCheckboxGroup(
      {
      // this.initiallySelected,
      required this.onChanged,
      required this.textStyle,
      this.labelPadding,
      this.itemPadding,
      required this.activeColor,
      required this.checkColor,
      this.checkboxBorderRadius,
      required this.checkboxBorderColor,
      this.child,
      required this.checkboxValues,
      required this.selected,
      required this.checkboxbool,
      required this.index,
      required this.day,
      required this.idSelect,
      required this.userIDSelect,
      required this.yearSelect,
      required this.monthSelect,
      required this.daySelect,
      required this.groupSelect,
      required this.vSelect,
      required this.dutyStringSelect,
      required this.dutyNumberSelect
      // required this.month,
      // required this.year,
      // required this.data
      });

  // final List<String>? initiallySelected;
  final void Function(List<String>, String, String, int, int, int, String, int,
      String, int, bool) onChanged;
  final TextStyle textStyle;
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry? itemPadding;
  final Color activeColor;
  final Color checkColor;
  final BorderRadius? checkboxBorderRadius;
  final Color checkboxBorderColor;
  final Widget? child;
  var selected;
  final List<String> checkboxValues;
  final Map<String, List<bool>> checkboxbool;
  final int index;
  final int day;
  final String idSelect;
  final String userIDSelect;
  final int yearSelect;
  final int monthSelect;
  final int daySelect;
  final String groupSelect;
  final int vSelect;
  final String dutyStringSelect;
  final int dutyNumberSelect;
  // final int month;
  // final int year;
  // List<DutyPresent> data;

  @override
  State<FlutterFlowCheckboxGroup> createState() =>
      _FlutterFlowCheckboxGroupState();
}

class _FlutterFlowCheckboxGroupState extends State<FlutterFlowCheckboxGroup> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("widget.day ${widget.day}/${widget.monthSelect}/${widget.yearSelect} ${widget.userIDSelect}");
    return Theme(
      data: ThemeData(unselectedWidgetColor: widget.checkboxBorderColor),
      child: Padding(
        padding: widget.itemPadding ?? EdgeInsets.zero,
        child: Row(
          children: [
            Checkbox(
              value: widget.checkboxbool["${widget.day}/${widget.monthSelect}/${widget.yearSelect} ${widget.userIDSelect}"]![widget.index],
              // value: widget.checkboxbool[widget.index],
              onChanged: (isSelected) {
                print(isSelected);
                if (isSelected == null) {
                  return;
                }
                widget.checkboxbool["${widget.day}/${widget.monthSelect}/${widget.yearSelect} ${widget.userIDSelect}"]?[widget.index] =
                    !widget.checkboxbool["${widget.day}/${widget.monthSelect}/${widget.yearSelect} ${widget.userIDSelect}"]![widget.index];
                // !widget.checkboxbool[widget.index];
                if (isSelected == true) {
                  widget.checkboxValues.add(widget.selected.toString());
                } else
                  widget.checkboxValues.remove(widget.selected.toString());
                widget.onChanged(
                    widget.checkboxValues,
                    widget.idSelect,
                    widget.userIDSelect,
                    widget.yearSelect,
                    widget.monthSelect,
                    widget.daySelect,
                    widget.groupSelect,
                    widget.vSelect,
                    widget.dutyStringSelect,
                    widget.dutyNumberSelect,
                    isSelected);
                setState(() {});
              },
              activeColor: widget.activeColor,
              checkColor: widget.checkColor,
              shape: RoundedRectangleBorder(
                borderRadius: widget.checkboxBorderRadius ?? BorderRadius.zero,
              ),
            ),
            // widget.child == null? Padding(
            //   padding: widget.labelPadding ?? EdgeInsets.zero,
            //   child: Text(
            //     widget.options[index],
            //     style: widget.textStyle,
            //   ),
            // ):
            widget.child as Widget
          ],
        ),
      ),
    );
  }
}
