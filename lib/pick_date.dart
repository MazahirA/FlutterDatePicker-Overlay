import 'package:flutter/material.dart';
import 'overlaywidget.dart';

class PickDatePage extends StatefulWidget {
  const PickDatePage({super.key});

  @override
  State<PickDatePage> createState() => _PickDatePageState();
}

class _PickDatePageState extends State<PickDatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Date Page"),
      ),
      body: Center(
          child: TextButton(
              onPressed: () => showDemoOverlay(),
              child: const Text("Click To Open Overly"))),
    );
  }

  /// Demo overly:
  OverlayEntry? _overlayEntry;
  ValueNotifier<DateTime?> notifyDatePicker = ValueNotifier(null);

  /// method to remove overlay entry from tree:
  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
  }

  /// method to insert overlay on top of current widget:
  void showDemoOverlay() {
    _overlayEntry = demoOverlyEntry(
      key: UniqueKey(),
      headerTitle: "Demo Overlay",
      topPosition: MediaQuery.of(context).size.height - 300,
      removeOverlyFunction: () {
        removeOverlay();
      },
      childWidget: TextButton(
          onPressed: () => selectDate(context),
          child: const Text("Click To Select Date")),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  DateTime? selectedDate;

  /// Shows a date picker calendar, and picks the date;
  void selectDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate, //Null initially
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
  }
}
