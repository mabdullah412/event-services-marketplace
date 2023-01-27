import 'dart:io';

import 'package:event_planner/logic/bloc/get_user_services_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/repositories/service_repository.dart';
import '../../logic/bloc/create_service_bloc.dart';
import '../widgets/pop_header.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({
    required this.getUserServicesBloc,
    super.key,
  });

  final GetUserServicesBloc getUserServicesBloc;

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  GetUserServicesBloc get getUserServicesBloc => widget.getUserServicesBloc;

  final ServiceRepository serviceRepository = ServiceRepository();
  late CreateServiceBloc _createServiceBloc;

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
  final Map<dynamic, dynamic> serviceData = {};

  // image-data
  bool noImages = true;
  // File stores image paths to be shown in the images section
  File? selectedImage;
  // File stores image path and name that we want to upload
  XFile? selectedImageFile;

  @override
  void initState() {
    _createServiceBloc = CreateServiceBloc(
      serviceRepository: serviceRepository,
      getUserServicesBloc: getUserServicesBloc,
    );
    super.initState();
  }

  @override
  void dispose() {
    _serviceTitleFocusNode.dispose();
    _serviceDescriptionFocusNode.dispose();
    _serviceLocationFocusNode.dispose();
    _serviceCategoryFocusNode.dispose();
    _servicePriceFocusNode.dispose();
    _createServiceBloc.close();
    super.dispose();
  }

  Future<void> createService() async {
    if (!_serviceDetailsFormKey.currentState!.validate()) return;
    _serviceDetailsFormKey.currentState!.save();

    if (noImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add an image.'),
        ),
      );
      return;
    }

    if (category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category.'),
        ),
      );
      return;
    }

    // adding image-link to data;
    serviceData['coverImage'] = selectedImageFile!.name;

    _createServiceBloc.add(CreateService(serviceData: serviceData));
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
                        const SizedBox(height: padding),
                        createButton(context),
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

  Container createButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: BlocConsumer<CreateServiceBloc, CreateServiceState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is CreateServiceFailure) {
            // _onWidgetDidBuild displays snackbar after
            // Build() has finished building
            _onWidgetDidBuild(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error creating service.'),
                ),
              );
              Navigator.pop(context);
            });
          }

          if (state is CreateServiceSuccess) {
            // _onWidgetDidBuild displays snackbar after
            // Build() has finished building
            _onWidgetDidBuild(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Service created.'),
                ),
              );
              Navigator.pop(context);
            });
          }
        },
        bloc: _createServiceBloc,
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state is CreateServiceLoading ? null : createService,
            child: state is CreateServiceLoading
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                  )
                : const Text('Create'),
          );
        },
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
            'Add image',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          const SizedBox(height: padding),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
            child: noImages == false
                ? Column(
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
                      'No image added.',
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
              serviceData['title'] = value!;
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
              serviceData['location'] = value!;
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
              serviceData['description'] = value!;
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
                  serviceData['category'] = value!.toString().toLowerCase();
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
              serviceData['price'] = value!;
            },
            onFieldSubmitted: (value) {
              FocusManager.instance.primaryFocus?.unfocus();
              _serviceDetailsFormKey.currentState!.validate();
            },
          ),
        ],
      ),
    );
  }

  void _onWidgetDidBuild(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callback();
    });
  }
}
