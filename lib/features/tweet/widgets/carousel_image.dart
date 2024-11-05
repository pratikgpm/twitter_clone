import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CarouselImage extends StatefulWidget {
  final List<String> imageLinks;

  const CarouselImage({super.key, required this.imageLinks});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CarouselSlider(
              items: widget.imageLinks.map(
                (link) {
                  return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          link,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ));
                },
              ).toList(),
              options: CarouselOptions(
               // height: 300,
                aspectRatio: 2/3,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                  enableInfiniteScroll: false),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageLinks.asMap().entries.map(
                (e) {
                  return Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Pallete.whiteColor
                          .withOpacity(_current == e.key ? 0.9 : 0.4),
                    ),
                  );
                },
              ).toList(),
            )
          ],
        ),
      ],
    );
  }
}
