import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../widgets/pop_header.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  // form key
  final _serviceDetailsFormKey = GlobalKey<FormState>();
  // focus-nodes
  final _serviceTitleFocusNode = FocusNode();
  final _serviceDescriptionFocusNode = FocusNode();
  final _serviceLocationFocusNode = FocusNode();
  final _serviceCategoryFocusNode = FocusNode();
  final _servicePriceFocusNode = FocusNode();
  // form-data
  dynamic category;

  // image-data
  bool noImages = true;
  // File stores image paths to be shown in the images section
  File? selectedImage;
  // File stores image path and name that we want to upload
  XFile? selectedImageFile;

  @override
  void dispose() {
    _serviceTitleFocusNode.dispose();
    _serviceDescriptionFocusNode.dispose();
    _serviceLocationFocusNode.dispose();
    _serviceCategoryFocusNode.dispose();
    _servicePriceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const PopHeader(title: 'Create a service'),
                  const SizedBox(height: padding),
                  imageSection(context),
                  const SizedBox(height: padding),
                  Form(
                    key: _serviceDetailsFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        detailsSection(context),
                        const SizedBox(height: padding),
                        pricingSection(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container imageSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add images',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          const SizedBox(height: padding),
          Container(
            height: 100,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
            child: noImages == false
                ? Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            'Loading',
                            style: Theme.of(context).primaryTextTheme.bodySmall,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radius),
                            child: Image.file(
                              selectedImage!,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      '0 images added.',
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ),
          ),
          const SizedBox(height: padding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final imageFile = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );

                    if (imageFile == null) {
                      return;
                    }

                    setState(() {
                      selectedImage = File(imageFile.path);
                      selectedImageFile = imageFile;
                      noImages = false;
                    });
                  },
                  child: const Text('Capture'),
                ),
              ),
              const SizedBox(width: padding),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final imageFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );

                    if (imageFile == null) {
                      return;
                    }

                    setState(() {
                      selectedImage = File(imageFile.path);
                      selectedImageFile = imageFile;
                      noImages = false;
                    });
                  },
                  child: const Text('Gallery'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container detailsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add details',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          const SizedBox(height: padding),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            focusNode: _serviceTitleFocusNode,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Title cannot be empty.';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              // registerData['firstName'] = value!;
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(
                _serviceLocationFocusNode,
              );
            },
          ),
          const SizedBox(height: padding),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Location',
            ),
            focusNode: _serviceLocationFocusNode,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Location cannot be empty.';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              // registerData['firstName'] = value!;
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(
                _serviceDescriptionFocusNode,
              );
            },
          ),
          const SizedBox(height: padding),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            focusNode: _serviceDescriptionFocusNode,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Description cannot be empty.';
              } else if (value.length < 30) {
                return 'Description must be atleast 30 characters long.';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              // registerData['firstName'] = value!;
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(
                _serviceCategoryFocusNode,
              );
            },
          ),
          const SizedBox(height: padding),
          Container(
            padding: const EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                focusNode: _serviceCategoryFocusNode,
                value: category,
                onChanged: (value) {
                  setState(() {
                    category = value!;
                  });
                },
                hint: const Text('Select Category'),
                isExpanded: true,
                borderRadius: BorderRadius.circular(radius),
                icon: Icon(
                  PhosphorIcons.caretCircleDownFill,
                  color: Theme.of(context).colorScheme.primary,
                ),
                style: Theme.of(context).primaryTextTheme.bodyMedium,
                items: <String>[
                  'Decoration',
                  'Car Rental',
                  'Catering',
                  'Halls',
                  'Photography',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container pricingSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Set pricing',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          const SizedBox(height: padding),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Price',
            ),
            keyboardType: TextInputType.number,
            focusNode: _servicePriceFocusNode,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Price cannot be empty.';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              // registerData['firstName'] = value!;
            },
            onFieldSubmitted: (value) {
              FocusManager.instance.primaryFocus?.unfocus();
              _serviceDetailsFormKey.currentState!.validate();
            },
          ),
          const SizedBox(height: padding),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
