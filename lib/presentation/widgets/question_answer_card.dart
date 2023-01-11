import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class QuestionAnswerCard extends StatelessWidget {
  const QuestionAnswerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Question(),
          SizedBox(height: padding / 2),
          Answer(),
        ],
      ),
    );
  }
}

class Answer extends StatelessWidget {
  const Answer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: Theme.of(context).colorScheme.outline,
          child: Center(
            child: Text(
              'A',
              style: Theme.of(context).primaryTextTheme.bodySmall,
            ),
          ),
        ),
        const SizedBox(width: padding),
        Flexible(
          child: Text(
            '1 week sir.',
            style: Theme.of(context).primaryTextTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class Question extends StatelessWidget {
  const Question({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: Theme.of(context).colorScheme.error,
          child: Center(
            child: Text(
              'Q',
              style: Theme.of(context).primaryTextTheme.bodySmall,
            ),
          ),
        ),
        const SizedBox(width: padding),
        Flexible(
          child: Text(
            'How long will it take to deliever the product to Karachi?',
            style: Theme.of(context).primaryTextTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
