import 'package:flutter/material.dart';
import 'package:test_yaho/core/config/colors.dart';
import 'package:test_yaho/core/config/enum/enum.dart';

class CardItem extends StatelessWidget {
  final DirectionCard direction;
  final String avatar;
  final String fullName;
  final String email;
  CardItem(
      {required this.direction,
      required this.avatar,
      required this.fullName,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 3,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ]),
      margin: const EdgeInsets.only(bottom: 25.0),
      child: LayoutBuilder(builder: (contex, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            direction == DirectionCard.horizontal
                ? Row(
                    children: [
                      Image.network(
                        avatar,
                      ),
                      Expanded(
                        child: buildProductInfo(),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Image.network(
                        avatar,
                        height: constraints.maxWidth,
                        width: constraints.maxWidth,
                        fit: BoxFit.cover,
                      ),
                      buildProductInfo()
                    ],
                  ),
          ],
        );
      }),
    );
  }

  Padding buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            fullName,
            style:
                TextStyle(fontSize: 18, color: Color.fromRGBO(51, 51, 51, 1)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            email,
            style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
