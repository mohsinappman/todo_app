import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/core/shared/cubits/image_upload_cubit.dart';
import 'package:todo_app/core/widgets/custom_error_handler.dart';
import 'package:todo_app/core/widgets/custom_loading_indicator.dart';

import '../../../shared/cubits/image_picker_cubit.dart';
import '../../../state/base_state.dart';
import '../../../themes/app_colors.dart';
import '../cubits/create_category_cubit.dart';
import '../models/category_model.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  late ImagePickerCubit _imagePickerCubit;
  late ImageUploadCubit _imageUploadCubit;
  late CreateCategoryCubit _createCategoryCubit;
  final TextEditingController _nameController = TextEditingController();
  final key = GlobalKey<FormState>();
  final List<Color> colors = List.generate(
    20,
    (_) => Color(Random().nextInt(0xFFFFFFFF)),
  );
  Color? selectedColor;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    initCubits();
    callCubits();
  }

  initCubits() {
    _imagePickerCubit = context.read<ImagePickerCubit>();
    _imageUploadCubit = context.read<ImageUploadCubit>();
    _createCategoryCubit = context.read<CreateCategoryCubit>();
  }

  callCubits() {
    _imagePickerCubit.clearImage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ImagePickerCubit, BaseState>(
          listener: (context, state) {
            if (state is SuccessState<File>) {
              selectedImage = state.data!;
            }
            errorHandler(context: context, state: state);
          },
        ),
        BlocListener<ImageUploadCubit, BaseState>(
          listener: (context, state) {
            if (state is SuccessState<String>) {
              _createCategoryCubit.createCategory(
                categoryModel: CategoryModel(
                  name: _nameController.text,
                  imageUrl: state.data!,
                  colorHex: selectedColor.toString(),
                ),
              );
            }
            errorHandler(context: context, state: state);
          },
        ),
        BlocListener<CreateCategoryCubit, BaseState>(
          listener: (context, state) {
            if (state is SuccessState) {
              context.pop();
            }
            errorHandler(context: context, state: state);
          },
        ),
      ],
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Category',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      16.verticalSpace,
                      Text(
                        'Category Name:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      16.verticalSpace,
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a category name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter category name',
                        ),
                      ),
                      20.verticalSpace,
                      Text(
                        'Category Icon:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      16.verticalSpace,
                      BlocBuilder<ImagePickerCubit, BaseState>(
                        builder: (context, state) {
                          if (state is InitialState) {
                            return ElevatedButton(
                              onPressed: () => _imagePickerCubit.pickImage(
                                source: ImageSource.gallery,
                              ),
                              child: Text('Choose icon from library'),
                            );
                          } else if (state is LoadingState) {
                            return ElevatedButton(
                              onPressed: () {},
                              child: Center(
                                child: LoadingIndicator(color: AppColors.white),
                              ),
                            );
                          } else if (state is SuccessState<File>) {
                            return SizedBox(
                              height: 42.h,
                              width: 42.w,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  image: DecorationImage(
                                    image: FileImage(state.data!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      20.verticalSpace,
                      Text(
                        'Category Icon',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      16.verticalSpace,
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: colors.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final color = colors[index];
                            final isSelected = selectedColor == color;
                            return GestureDetector(
                              onTap: () => setState(() {
                                selectedColor = color;
                              }),
                              child: Container(
                                height: 36.h,
                                width: 36.w,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: isSelected
                                      ? Border.all(
                                          color: Colors.white,
                                          width: 3.w,
                                        )
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      325.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => context.pop(),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          16.horizontalSpace,
                          Expanded(
                            child: BlocBuilder<CreateCategoryCubit, BaseState>(
                              builder: (context, createState) {
                                print('create cat state is $createState');
                                return BlocBuilder<ImageUploadCubit, BaseState>(
                                  builder: (context, imageState) {
                                    print('upload image state is $imageState');
                                    if (imageState is LoadingState ||
                                        createState is LoadingState) {
                                      return ElevatedButton(
                                        onPressed: () {},
                                        child: Center(
                                          child: LoadingIndicator(
                                            color: AppColors.white,
                                          ),
                                        ),
                                      );
                                    }
                                    return ElevatedButton(
                                      onPressed: () {
                                        if (key.currentState!.validate()) {
                                          if (selectedImage != null) {
                                            _imageUploadCubit.uploadImage(
                                              selectedImage!,
                                            );
                                          }
                                        }
                                      },
                                      child: Text('Create Category'),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
