import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel('flutter.native/Stapper');

  // Int
  int currentStep = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TyrAds"),
      ),
      body: _getBodyWidget(),
    );
  }

  Widget _getBodyWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _getStepWidget(
              stepNo: 1,
              stepTitle: "Select campaign settings",
            ),
            _getStepWidget(
              stepNo: 2,
              stepTitle: "Create an Ad group",
            ),
            _getStepWidget(
              stepNo: 3,
              stepTitle: "Create an Ad",
              stepSubTitle: "Last Step",
            ),
          ],
        ),
      ),
    );
  }

  Widget _getStepWidget({
    required int stepNo,
    required String stepTitle,
    String? stepSubTitle,
  }) {
    return Column(
      children: [
        // Title Part
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(
                right: 12,
              ),
              decoration: BoxDecoration(
                color: (stepNo == currentStep) ? Colors.blue : Colors.grey,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                "$stepNo",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  stepTitle,
                  style: TextStyle(
                    color: (stepNo == currentStep) ? Colors.black : Colors.grey,
                    fontWeight:
                        (stepNo == currentStep) ? FontWeight.w600 : null,
                    fontSize: 15,
                  ),
                ),
                (stepSubTitle != null)
                    ? Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text(
                          stepSubTitle,
                          style: TextStyle(
                            color: (stepNo == currentStep)
                                ? Colors.black
                                : Colors.grey,
                            fontWeight: (stepNo == currentStep)
                                ? FontWeight.w600
                                : null,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : Container()
              ],
            )
          ],
        ),
        // Body Part
        _getStepDetails(stepNo),
      ],
    );
  }

  Widget _getStepDetails(int stepNo) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        top: 4,
        bottom: 4,
      ),
      constraints: BoxConstraints(
        minHeight: (stepNo == 3) ? 0 : 15,
      ),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Column(
        children: [
          (currentStep == stepNo)
              ? FutureBuilder(
                  future: platform.invokeMethod('$currentStep'),
                  builder: ((context, snapshot) {
                    return Container(
                      margin: const EdgeInsets.only(
                        left: 27,
                      ),
                      child: Column(
                        children: [
                          Text(snapshot.data ?? ""),
                          Row(
                            children: [
                              _getButton(
                                text: (stepNo == 3) ? "FINISH" : "CONTINUE",
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                onClick: () {
                                  currentStep++;
                                  setState(() {});
                                },
                              ),
                              _getButton(
                                text: "BACK",
                                backgroundColor: Colors.transparent,
                                textColor:
                                    (stepNo != 1) ? Colors.blue : Colors.grey,
                                onClick: (stepNo != 1)
                                    ? () {
                                        currentStep--;
                                        setState(() {});
                                      }
                                    : null,
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _getButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    Function()? onClick,
  }) {
    return TextButton(
      onPressed: onClick,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
    /*return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 60,
        height: 35,
        decoration: BoxDecoration(
          color: forgorundColor,
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );*/
  }

  @override
  void dispose() {
    super.dispose();
  }
}
