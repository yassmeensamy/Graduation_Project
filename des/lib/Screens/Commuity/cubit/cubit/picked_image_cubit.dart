import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'picked_image_state.dart';

class PickedImageCubit extends Cubit<PickedImageState> {
  PickedImageCubit() : super(PickedImageInitial());
  File? image=null;
  final ImagePicker picker = ImagePicker();

  Future<void> getImageFromGallery() async 
  {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickedFile != null) 
      {
        image=File(pickedFile.path);
        emit(ImagePickerSuccess(File(pickedFile.path)));
      } else {
        emit(ImagePickerFailure("No image picked"));
      }
    } catch (e) {
      emit(ImagePickerFailure(e.toString()));
    }
  }

  void RemoveImage()
  {
    
  }
}

