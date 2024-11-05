import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../models/tweet_model.dart';
import '../widgets/tweet_card.dart';

class HashtagView extends ConsumerWidget {
  static rout(String hashtag) => MaterialPageRoute(
        builder: (context) => HashtagView(hashtag: hashtag),
      );
  final String hashtag;

  const HashtagView({super.key, required this.hashtag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hashtag),
        centerTitle: true,
      ),
      body: ref.watch(getTweetsByHashtagProvider(hashtag)).when(
            data: (List<Tweet> tweets) {
              return ListView.builder(
                itemCount: tweets.length,
                itemBuilder: (BuildContext context, int index) {
                  final tweet = tweets[index];
                  return TweetCard(tweet: tweet);
                },
              );
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
