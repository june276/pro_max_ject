import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
class ReminderList extends StatelessWidget {
  const ReminderList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFF0F1F0),
        body: Reminder(),
      ),
    );
  }
}

class Reminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          height: screenHeight, // 화면 높이에 맞게 설정
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFF0F1F0)),
          child: Stack(
            children: [
              Positioned(
                left: screenWidth * 0.05, // 화면 너비의 5%
                top: screenHeight * 0.05, // 화면 높이의 5%
                child: Container(
                  width: screenWidth * 0.9, // 화면 너비의 90%
                  height: screenHeight * 0.04, // 화면 높이의 4%
                  child: Stack(
                    children: [
                      /////////////   알림 텍스트   ///////////
                      Positioned(
                        left: screenWidth * 0.25, // 화면 너비의 25%
                        top: screenHeight * 0.01, // 화면 높이의 1%
                        child: SizedBox(
                          width: screenWidth * 0.6, // 화면 너비의 60%
                          child: Text(
                            '알림',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenHeight * 0.03, // 화면 높이의 3%
                              fontFamily: 'BM_HANNA_TTF',
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /////////////////   알림 박스   //////////////////
              buildReminderBox(
                top: screenHeight * 0.1, // 화면 높이의 12%
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                text: '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
              ),
              buildReminderBox(
                top: screenHeight * 0.22, // 화면 높이의 22%
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                text: '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
              ),
              buildReminderBox(
                top: screenHeight * 0.32, // 화면 높이의 32%
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                text: '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
              ),
              buildReminderBox(
                top: screenHeight * 0.42, // 화면 높이의 42%
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                text: '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
              ),
              buildReminderBox(
                top: screenHeight * 0.52, // 화면 높이의 52%
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                text: '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
              ),
              buildReminderBox(
                top: screenHeight * 0.62, // 화면 높이의 62%
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                text: '폭염주의보 지속 발효 중. 부모님께 안부전화드리기, 야외활동 자제, 폭염 안전 수칙(물, 그늘, 휴식) 준수 등 건강관리에 유의 바랍니다. [인천광역시]',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildReminderBox({
    required double top,
    required double screenWidth,
    required double screenHeight,
    String text = '',
  }) {
    return Positioned(
      left: screenWidth * 0.05, // 화면 너비의 5%
      top: top,
      child: Container(
        width: screenWidth * 0.9, // 화면 너비의 90%
        height: screenHeight * 0.1, // 화면 높이의 10%
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x30000000),
              blurRadius: 4,
              offset: Offset(0, 5),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF24252C),
                fontSize: 11,
                fontFamily: 'Lexend Deca',
                fontWeight: FontWeight.w400,
                height: 1.6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
