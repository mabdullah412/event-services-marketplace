import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/category_button.dart';
import '../widgets/header.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Header(title: 'Discover'),
              const SizedBox(height: padding),
              const Banner(),
              const SizedBox(height: padding),
              Text(
                'All Categories',
                style: Theme.of(context).primaryTextTheme.bodyLarge,
              ),
              const SizedBox(height: padding),
              const CategoryButton(
                categoryName: 'Venue',
                image: 'wedding_hall.jpg',
              ),
              const SizedBox(height: padding),
              const CategoryButton(
                categoryName: 'Decoration',
                image: 'decoration.jpg',
              ),
              const SizedBox(height: padding),
              const CategoryButton(
                categoryName: 'Transport',
                image: 'red_suv.jpg',
              ),
              const SizedBox(height: padding),
              const CategoryButton(
                categoryName: 'Catering',
                image: 'catering.jpg',
              ),
              const SizedBox(height: padding),
              const CategoryButton(
                categoryName: 'Photography',
                image: 'photography.jpg',
              ),
              const SizedBox(height: padding),
            ],
          ),
        ),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/banner.jpg'),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(radius),
        ),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'EVENT PLANNING',
            style: Theme.of(context).primaryTextTheme.displayMedium!.apply(
                  color: const Color(0xFFF2F2F6),
                ),
          ),
          Text(
            'now just a few taps away.',
            style: Theme.of(context).primaryTextTheme.bodyLarge!.apply(
                  color: const Color(0xFFF2F2F6),
                ),
          ),
        ],
      ),
    );
  }
}
