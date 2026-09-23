import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserWelcome extends StatelessWidget {
  const UserWelcome({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("images/person.png"),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Evening ,$username",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFFCFC),
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              Text(
                "One task at a time.One steps\ncloser.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFC6C6C6),
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        CircleAvatar(
          backgroundColor: Color(0xFF282828),
          child: SizedBox(
            height: 34,
            width: 34,
            child: IconButton(
              color: Color(0xFF282828),
              onPressed: () {},
              icon: SvgPicture.asset(
                "images/Icon-light.svg",
                colorFilter: ColorFilter.mode(
                  Color(0xFFFFFCFC),
                  BlendMode.srcIn,
                ),
                height: 18,
                width: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
