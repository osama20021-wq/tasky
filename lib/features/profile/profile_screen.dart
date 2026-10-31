// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/services/prefrence_manager.dart';
import 'package:flutter_application_4/core/themes/custome_svg_picture.dart';
import 'package:flutter_application_4/core/themes/theme_controller.dart';
import 'package:flutter_application_4/screens/user_details.dart';
import 'package:flutter_application_4/screens/welcome_screen.dart';
import 'package:flutter_application_4/widgets/custome_list_tile_widget.dart';
import 'package:flutter_application_4/core/widget/task_switch_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String username = PrefrenceManager().getString("username")!;

  String? selectedImage = PrefrenceManager().getString("image");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              children: [
                Text(
                  "My Profile",
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontSize: 20),
                ),
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
                            backgroundImage: selectedImage == null
                                ? AssetImage("images/person.png")
                                : FileImage(File(selectedImage!)),
                          ),
                          CircleAvatar(
                            maxRadius: 18,
                            backgroundColor: Theme.of(context).cardColor,
                            child: IconButton(
                              onPressed: () {
                                _showImageSourceDialog(
                                  context: context,
                                  setImage: (file) {
                                    _saveImage(file);
                                    setState(() {
                                      selectedImage = file.path;
                                    });
                                  },
                                );
                              },
                              icon: CustomeSvgPicture(
                                path: "images/camera-01.svg",
                                height: 22,
                                width: 22,
                              ),
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
                      leading: CustomeSvgPicture(
                        path: "images/Icon-person.svg",
                        height: 20,
                        width: 20,
                      ),

                      trailing: CustomeSvgPicture(
                        path: "images/arrow-right.svg",
                        height: 24,
                        width: 24,
                      ),
                    ),
                    Divider(color: Theme.of(context).dividerColor),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20),
                      ),
                      contentPadding: EdgeInsets.zero,
                      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                      title: Text("Dark Mode"),
                      leading: CustomeSvgPicture(
                        path: "images/Leading-element.svg",
                        height: 24,
                        width: 24,
                      ),
                      trailing: TaskSwitchWidget(
                        isDone: ThemeController().isDark(),
                        onTap: (value) async {
                          await ThemeController().toggleTheme();
                        },
                      ),
                    ),
                    Divider(color: Theme.of(context).dividerColor),
                    CustomeListTileWidget(
                      title: "Log out",
                      onTap: () async {
                        await PrefrenceManager().remove("username");
                        await PrefrenceManager().remove("allTasks");
                        await PrefrenceManager().remove("image");

                        await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(),
                          ),
                        );
                      },

                      leading: CustomeSvgPicture(
                        path: "images/log-out-01.svg",
                        height: 24,
                        width: 24,
                      ),
                      trailing: CustomeSvgPicture(
                        path: "images/arrow-right.svg",
                        height: 24,
                        width: 24,
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

  void _showImageSourceDialog({
    required BuildContext context,
    required Function(XFile file) setImage,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            "Choose image source",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                final XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  setImage(image);
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.photo_library,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  SizedBox(width: 8),
                  Text("Gallery", style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),

            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                final XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  setImage(image);
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.camera,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  SizedBox(width: 8),
                  Text("Camera", style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy("${appDir.path}/${file.name}");
    await PrefrenceManager().setString("image", newFile.path);
  }
}
