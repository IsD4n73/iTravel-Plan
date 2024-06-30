import 'package:flutter/material.dart';

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({
    super.key,
    required this.title,
    required this.days,
    required this.color,
    required this.nextColor,
    required this.onTap,
  });

  final String title;
  final int days;
  final Color color;
  final Color nextColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: nextColor,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(80),
            ),
          ),
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
            top: 50,
            bottom: 40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$days Giorni",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.navigate_next,
                size: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
