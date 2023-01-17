import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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

              // search bar
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(PhosphorIcons.magnifyingGlass),
                ),
              ),

              const SizedBox(height: padding),

              const CategoryButton(
                categoryName: 'Halls',
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

              // item-wigdget
              // const ServiceContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
