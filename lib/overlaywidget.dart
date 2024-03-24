import 'package:flutter/material.dart';

double overlyHeaderHeight = 40;
double dividerHeight = 5;

/// height of divider bw header section and container which holds child widget.
Color overlyContainerColor = Colors.black26;

Widget overlyHeaderSection(
    {required String headerTitle, required Function onTapFunc}) {
  return SizedBox(
    height: overlyHeaderHeight,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(
          flex: 4,
        ),
        Center(
            child: Text(
          headerTitle,
          style: const TextStyle(fontSize: 20),
        )),
        const Spacer(
          flex: 2,
        ),
        InkWell(
            onTap: () {
              onTapFunc();
            },
            child: const Icon(Icons.cancel_outlined)),
        const Spacer(),
      ],
    ),
  );
}

OverlayEntry demoOverlyEntry(
    {required Widget childWidget,
    required Key key,
    required Function removeOverlyFunction,
    required String headerTitle,
    double topPosition = 200,
    double bottomPosition = -5,
    double topCurveRadius = 25,
    double bottomCurveRadius = 0}) {
  return OverlayEntry(
    builder: (context) => Stack(
      children: [
        /// Transparent screen above visible overlay container.
        GestureDetector(
          onTap: () {
            removeOverlyFunction();
          },
          child: Container(
            color: overlyContainerColor,
          ),
        ),

        /// Actual visible overlay container:
        Positioned(
          top: topPosition,
          bottom: bottomPosition,
          left: -3,
          right: -3,
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 10,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(topCurveRadius),
              topLeft: Radius.circular(topCurveRadius),
              bottomRight: Radius.circular(bottomCurveRadius),
              bottomLeft: Radius.circular(bottomCurveRadius),
            )),
            child: Column(
              children: [
                overlyHeaderSection(
                    headerTitle: headerTitle,
                    onTapFunc: () {
                      removeOverlyFunction();
                    }),
                Divider(height: dividerHeight, thickness: 1),

                ///Container which shows the child widget of the overly:
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      topPosition -
                      overlyHeaderHeight -
                      bottomPosition -
                      dividerHeight -
                      10,
                  child: childWidget,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
