import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import '../router/custom_page_route.dart';
import '../screens/services_screen.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    required this.categoryName,
    required this.image,
    Key? key,
  }) : super(key: key);

  final String categoryName;
  final String image;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.of(context).push(
          CustomPageRoute(
            child: BlocProvider.value(
              value: BlocProvider.of<GetPackagesBloc>(context),
              child: ServicesScreen(categoryName: categoryName),
            ),
          ),
        );
      },
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(radius),
        ),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 120,
            padding: const EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(
                image: AssetImage('assets/images/$image'),
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(padding / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  child: Text(
                    categoryName,
                    style: Theme.of(context).primaryTextTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
