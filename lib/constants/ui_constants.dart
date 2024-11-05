import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/assets_constant.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_list.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../features/explore/view/explore_view.dart';
import '../features/notifications/views/notification_view.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(centerTitle: true,
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
    );
  }

  static const List<Widget> bottomTabBarWidgets = [
    TweetList(),
    ExploreView(),
    NotificationView(),
  ];

}
