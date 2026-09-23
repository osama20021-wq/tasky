import 'package:flutter/material.dart';
import 'package:flutter_application_4/widgets/task_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  bool isDarkMode = true;

  @override
  void initState() {
    getusername();
    super.initState();
  }

  Future getusername() async {
    final sharedPref = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPref.getString("username") ?? "Guest";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Text(
            "My Profile",
            style: TextStyle(
              color: Color(0xFFFFFCFC),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
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
                  style: TextStyle(
                    color: Color(0xFFFFFCFC),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "One task at a time. One step closer.",
                  style: TextStyle(
                    color: Color(0xFFC6C6C6),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          Text(
            "Profile Info",
            style: TextStyle(
              color: Color(0xFFFFFCFC),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8),

          ListTile(
            contentPadding: EdgeInsets.zero,
            titleTextStyle: TextStyle(
              color: Color(0xFFFFFCFC),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            onTap: () {},
            leading: SvgPicture.asset("images/Icon-person.svg"),
            title: Text("User Details"),
            trailing: SvgPicture.asset("images/arrow-right.svg"),
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            titleTextStyle: TextStyle(
              color: Color(0xFFFFFCFC),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            leading: SvgPicture.asset("images/Leading-element.svg"),
            title: Text("Dark Mode"),
            trailing: TaskSwitch(
              isDone: isDarkMode,
              onTap: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            titleTextStyle: TextStyle(
              color: Color(0xFFFFFCFC),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            onTap: () {},
            leading: SvgPicture.asset("images/log-out-01.svg"),
            title: Text("Log out"),
            trailing: SvgPicture.asset("images/arrow-right.svg"),
          ),
        ],
      ),
    );
  }
}
