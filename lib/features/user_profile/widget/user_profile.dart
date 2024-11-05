import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/error_page.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';
import 'package:twitter_clone/features/user_profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/features/user_profile/view/edit_profile_view.dart';
import 'package:twitter_clone/features/user_profile/widget/follow_count.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/theme/pallete.dart';
class UserProfile extends ConsumerWidget {
  final UserModel user;

  const UserProfile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return currentUser == null
        ? const Loader()
        : NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 180,
                  floating: true,
                  snap: true,
                  flexibleSpace: SizedBox(
                    height: 250,
                    child: Stack(
                      children: [
                        Positioned.fill(bottom: 50,
                          child: user.bannerPic.isEmpty
                              ? Container(
                                  decoration: const BoxDecoration(
                                      color: Pallete.blueColor,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))),

                                )
                              : Image.network(
                                  user.bannerPic,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                        Positioned(
                          bottom: 3,
                          left: 10,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Pallete.backgroundColor,
                                  width: 5,
                                ),
                                color: Pallete.blueColor,
                                shape: BoxShape.circle),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user.profilePic),
                              radius: 40,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                            child: OutlinedButton(
                              onPressed: () {
                                if (currentUser.uid == user.uid) {
                                  // edit profile
                                  Navigator.push(context, EditProfileView.route());
                                } else {
                                  ref
                                      .read(userProfileControllerProvider.notifier)
                                      .followUser(
                                        user: user,
                                        context: context,
                                        currentUser: currentUser,
                                      );
                                }
                              },
                              style: ElevatedButton.styleFrom(side: BorderSide(
                                color: Pallete.greyColor.withOpacity(0.4),
                                width: 1,
                              ),
                                shape: RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: Pallete.greyColor.withOpacity(0.4),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 1),
                              ),
                              child: Text(
                                currentUser.uid == user.uid
                                    ? 'Edit Profile'
                                    : currentUser.following.contains(user.uid)
                                        ? 'Unfollow'
                                        : 'Follow',
                                style: const TextStyle(
                                  color: Pallete.whiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Row(
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Pallete.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (user.isTwitterBlue)
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: SvgPicture.asset(
                                  AssetsConstants.verifiedIcon,
                                ),
                              ),
                          ],
                        ),
                        Text(
                          '@${user.name}',
                          style: const TextStyle(
                            fontSize: 17,
                            color: Pallete.greyColor,
                          ),
                        ),
                        Text(
                          user.bio,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            FollowCount(
                              count: user.following.length,
                              text: 'Following',
                            ),
                            const SizedBox(width: 15),
                            FollowCount(
                              count: user.followers.length,
                              text: 'Followers',
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: const Divider(
                            color: Pallete.whiteColor,
                            thickness: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: ref.watch(getUserTweetsProvider(user.uid)).when(
                  data: (tweets) {


                    // can make it realtime by copying code
                    // from twitter_reply_view
                    return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder: (BuildContext context, int index) {
                        final tweet = tweets[index];
                        return TweetCard(tweet: tweet);
                      },
                    );
                  },
                  error: (error, st) => ErrorText(
                    error: error.toString(),
                  ),
                  loading: () => const Loader(),
                ),
          );
  }
}
