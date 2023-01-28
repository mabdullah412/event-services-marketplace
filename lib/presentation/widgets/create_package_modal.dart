import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../data/repositories/package_repository.dart';
import '../../logic/bloc/create_package_bloc.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import 'custom_snack_bar.dart';

class CreatePackageModal extends StatefulWidget {
  const CreatePackageModal({
    required this.getPackagesBloc,
    Key? key,
  }) : super(key: key);

  final GetPackagesBloc getPackagesBloc;

  @override
  State<CreatePackageModal> createState() => _CreatePackageModalState();
}

class _CreatePackageModalState extends State<CreatePackageModal> {
  GetPackagesBloc get getPackagesBloc => widget.getPackagesBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _packageNameFocusNode = FocusNode();
  late CreatePackageBloc _createPackageBloc;
  String packageName = '';

  @override
  void initState() {
    _createPackageBloc = CreatePackageBloc(
      getPackagesBloc: getPackagesBloc,
      packageRepository: PackageRepository(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _createPackageBloc.close();
    super.dispose();
  }

  Future<void> createPackage() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    _createPackageBloc.add(CreatePackage(name: packageName));
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
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create a package',
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
              const SizedBox(height: padding),
              Form(
                key: _formKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  keyboardType: TextInputType.name,
                  focusNode: _packageNameFocusNode,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Package name cannot be empty.';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    packageName = value!;
                  },
                  onFieldSubmitted: (value) {
                    _formKey.currentState!.validate();
                  },
                ),
              ),
              const SizedBox(height: padding),
              BlocBuilder<CreatePackageBloc, CreatePackageState>(
                bloc: _createPackageBloc,
                builder: (context, state) {
                  if (state is CreatePackageFailure) {
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
                            description:
                                'Error occured while creating package.',
                            snackbarType: SnackbarType.error,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  }

                  if (state is CreatePackageSuccess) {
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
                            title: 'Package created',
                            snackbarType: SnackbarType.success,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  }

                  return ElevatedButton(
                    onPressed:
                        state is CreatePackageLoading ? null : createPackage,
                    child: state is CreatePackageLoading
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : const Text('Create'),
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
