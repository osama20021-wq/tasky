// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/services/prefrence_manager.dart';
import 'package:flutter_application_4/core/themes/theme_controller.dart';
import 'package:flutter_application_4/screens/user_details.dart';
import 'package:flutter_application_4/screens/welcome_screen.dart';
import 'package:flutter_application_4/widgets/custome_list_tile_widget.dart';
import 'package:flutter_application_4/core/widget/task_switch_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";

  @override
  void initState() {
    getusername();
    super.initState();
  }

  Future getusername() async {
    setState(() {
      username = PrefrenceManager().getString("username") ?? "Guest";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text(
                  "My Profile",
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontSize: 20),
                ),
                // why?
                SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 60,
                            backgroundImage: AssetImage("images/person.png"),
                          ),
                          CircleAvatar(
                            backgroundColor: Color(0xFF282828),
                            child: IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset("images/camera-01.svg"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontSize: 20),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "One task at a time. One step closer.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile Info",
                      style: Theme.of(context).textTheme.bodyLarge!
                          .copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    CustomeListTileWidget(
                      title: "User Details",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetails(username: username),
                        ),
                      ),
                      leading: SvgPicture.asset(
                        "images/Icon-person.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).secondaryHeaderColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        "images/arrow-right.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).secondaryHeaderColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20),
                      ),
                      contentPadding: EdgeInsets.zero,
                      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                      title: Text("Dark Mode"),
                      leading: SvgPicture.asset(
                        "images/Leading-element.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).secondaryHeaderColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      trailing: TaskSwitchWidget(
                        isDone: ThemeController().isDark(),
                        onTap: (value) async {
                          await ThemeController().toggleTheme();
                        },
                      ),
                    ),
                    Divider(),
                    CustomeListTileWidget(
                      title: "Log out",
                      onTap: () async {
                        await PrefrenceManager().remove("username");
                        await PrefrenceManager().remove("allTasks");
                        await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(),
                          ),
                        );
                      },

                      leading: SvgPicture.asset(
                        "images/log-out-01.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).secondaryHeaderColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        "images/arrow-right.svg",

                        colorFilter: ColorFilter.mode(
                          Theme.of(context).secondaryHeaderColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
