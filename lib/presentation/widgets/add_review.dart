import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../data/repositories/review_repository.dart';
import '../../logic/bloc/create_review_bloc.dart';
import '../../logic/bloc/get_reviews_bloc.dart';
import 'custom_snack_bar.dart';

class AddReview extends StatefulWidget {
  const AddReview({
    required this.serviceId,
    required this.getReviewsBloc,
    required this.reviewRepository,
    Key? key,
  }) : super(key: key);

  final String serviceId;
  final GetReviewsBloc getReviewsBloc;
  final ReviewRepository reviewRepository;

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  String get serviceId => widget.serviceId;
  GetReviewsBloc get getReviewsBloc => widget.getReviewsBloc;
  ReviewRepository get reviewRepository => widget.reviewRepository;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _reviewFocusNode = FocusNode();
  late CreateReviewBloc _createReviewBloc;

  final Map<dynamic, dynamic> reviewData = {};
  int selectedRating = 0;

  @override
  void initState() {
    _createReviewBloc = CreateReviewBloc(
      reviewRepository: reviewRepository,
      getReviewsBloc: getReviewsBloc,
    );
    super.initState();
  }

  @override
  void dispose() {
    _createReviewBloc.close();
    super.dispose();
  }

  Future<void> createReview() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating value.'),
        ),
      );
      return;
    }

    reviewData['rating'] = selectedRating;

    _createReviewBloc.add(
      CreateReview(reviewData: reviewData, serviceId: serviceId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(padding),
          padding: const EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add a review',
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
              const SizedBox(height: padding),
              Container(
                padding: const EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(radius),
                  ),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingButton(
                      value: 1,
                      isSelected: selectedRating == 1,
                      onPressed: () {
                        setState(() {
                          selectedRating = 1;
                        });
                      },
                    ),
                    Expanded(child: Container()),
                    RatingButton(
                      value: 2,
                      isSelected: selectedRating == 2,
                      onPressed: () {
                        setState(() {
                          selectedRating = 2;
                        });
                      },
                    ),
                    Expanded(child: Container()),
                    RatingButton(
                      value: 3,
                      isSelected: selectedRating == 3,
                      onPressed: () {
                        setState(() {
                          selectedRating = 3;
                        });
                      },
                    ),
                    Expanded(child: Container()),
                    RatingButton(
                      value: 4,
                      isSelected: selectedRating == 4,
                      onPressed: () {
                        setState(() {
                          selectedRating = 4;
                        });
                      },
                    ),
                    Expanded(child: Container()),
                    RatingButton(
                      value: 5,
                      isSelected: selectedRating == 5,
                      onPressed: () {
                        setState(() {
                          selectedRating = 5;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: padding),
              Form(
                key: _formKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Review'),
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _reviewFocusNode,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Review cannot be empty.';
                    } else if (value.length < 10) {
                      return 'Review must be atleast 10 characters long.';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    reviewData['review'] = value!;
                  },
                  onFieldSubmitted: (value) {
                    _formKey.currentState!.validate();
                  },
                ),
              ),
              const SizedBox(height: padding),
              BlocBuilder<CreateReviewBloc, CreateReviewState>(
                bloc: _createReviewBloc,
                builder: (context, state) {
                  if (state is CreateReviewFailure) {
                    // _onWidgetDidBuild displays snackbar after
                    // Build() has finished building
                    _onWidgetDidBuild(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: 'close',
                            onPressed: () {},
                          ),
                          content: const CustomSnackbar(
                            title: 'Error',
                            description: 'Error occured while adding review.',
                            snackbarType: SnackbarType.error,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  }

                  if (state is CreateReviewSuccess) {
                    // _onWidgetDidBuild displays snackbar after
                    // Build() has finished building
                    _onWidgetDidBuild(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: 'close',
                            onPressed: () {},
                          ),
                          content: const CustomSnackbar(
                            title: 'Review added',
                            snackbarType: SnackbarType.success,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  }

                  return ElevatedButton(
                    onPressed:
                        state is CreateReviewLoading ? null : createReview,
                    child: state is CreateReviewLoading
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : const Text('Add'),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onWidgetDidBuild(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callback();
    });
  }
}

class RatingButton extends StatelessWidget {
  const RatingButton({
    required this.value,
    required this.isSelected,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final int value;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: OutlinedButton(
        onPressed: onPressed,
        style: isSelected
            ? ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary,
                ),
                foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary,
                ),
              )
            : const ButtonStyle(),
        child: Text(value.toString()),
      ),
    );
  }
}
