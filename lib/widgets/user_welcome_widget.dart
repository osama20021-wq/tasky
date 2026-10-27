import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/themes/theme_controller.dart';
import 'package:flutter_application_4/models/task_model.dart';
import 'package:flutter_svg/svg.dart';

class UserWelcomeWidget extends StatelessWidget {
  const UserWelcomeWidget({super.key, required this.username, this.tasks});

  final String username;
  final List<TaskModel>? tasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("images/person.png"),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Evening ,$username",
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "One task at a time. One steps\ncloser.",
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: Theme.of(context).cardColor,
                child: SizedBox(
                  height: 34,
                  width: 34,
                  child: IconButton(
                    color: Theme.of(context).cardColor,
                    onPressed: () async {
                      await ThemeController().toggleTheme();
                    },
                    icon: SvgPicture.asset(
                      ThemeController().isDark()
                          ? "images/Icon-light.svg"
                          : "images/Leading-element.svg",
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).secondaryHeaderColor,
                        BlendMode.srcIn,
                      ),
                      height: 18,
                      width: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (tasks != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Yuhuu ,Your work Is ",
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontSize: 32),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      "almost done ! ",
                      style: Theme.of(context).textTheme.bodyLarge!
                          .copyWith(fontSize: 32),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SvgPicture.asset(
                      "images/waving-hand.svg",
                      width: 32,
                      height: 32,
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
