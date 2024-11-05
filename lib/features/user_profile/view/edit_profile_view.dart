import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/user_profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/theme/theme.dart';

class EditProfileView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const EditProfileView(),
      );

  const EditProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  File? bannerFile;
  File? profileFile;

  @override
  void initState() {
    nameController = TextEditingController(
      text: ref.read(currentUserDetailsProvider).value?.name ?? '',
    );
    bioController = TextEditingController(
      text: ref.read(currentUserDetailsProvider).value?.bio ?? '',
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bioController.dispose();
  }

  void selectBannerImage() async {
    final banner = await pickImage();
    if (banner != null) {
      setState(() {
        bannerFile = banner;
      });
    }
  }

  void selectProfileImage() async {
    final profileImage = await pickImage();
    if (profileImage != null) {
      setState(() {
        profileFile = profileImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserDetailsProvider).value;
    final isLoading = ref.watch(userProfileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              ref
                  .read(userProfileControllerProvider.notifier)
                  .updateUserProfile(
                    userModel: user!.copyWith(
                      bio: bioController.text,
                      name: nameController.text,
                    ),
                    context: context,
                    bannerFile: bannerFile,
                    profileFile: profileFile,
                  );
            },
            child: const Text(
              'Save',
              style: TextStyle(
                  color: Pallete.whiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: isLoading || user == null
          ? const Loader()
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: selectBannerImage,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: bannerFile != null
                                ? Image.file(
                                    bannerFile!,
                                    fit: BoxFit.fitWidth,
                                  )
                                : user.bannerPic.isEmpty
                                    ? Container(
                                        color: Pallete.blueColor,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          user.bannerPic,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 20,
                          child: GestureDetector(
                            onTap: selectProfileImage,
                            child: profileFile != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Pallete.blueColor,
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage: FileImage(profileFile!),
                                      radius: 40,
                                    ),
                                  )
                                : Container(
                              decoration: BoxDecoration(
                                color: Pallete.blueColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Pallete.backgroundColor,width: 6),

                              ),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(user.profilePic),
                                      radius: 40,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: inputDecoration(hintText: "Name"),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: bioController,
                    maxLines: 4,
                    decoration: inputDecoration(hintText: "Bio"),
                  ),
                ],
              ),
            ),
    );
  }
}
