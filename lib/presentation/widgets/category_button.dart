import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    required this.name,
    required this.image,
    Key? key,
  }) : super(key: key);

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
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
              borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(
                image: AssetImage('assets/images/$image'),
                fit: BoxFit.cover,
                opacity: 0.6,
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
                    name,
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
