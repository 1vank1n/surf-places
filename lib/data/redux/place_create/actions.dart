import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/place_create_screen.dart';

abstract class PlaceCreateAction {}

class UploadPlaceCreateAction extends PlaceCreateAction {
  final Place place;

  UploadPlaceCreateAction({required this.place});
}

class SuccessUploadPlaceCreateAction extends PlaceCreateAction {
  final Place place;

  SuccessUploadPlaceCreateAction({required this.place});
}

class ErrorPlaceCreateAction extends PlaceCreateAction {
  final String message;

  ErrorPlaceCreateAction({required this.message});
}

class AddImagePlaceCreateAction extends PlaceCreateAction {
  final UploadImage uploadImage;

  AddImagePlaceCreateAction({required this.uploadImage});
}

class RemoveImagePlaceCreateAction extends PlaceCreateAction {
  final ValueKey valueKey;

  RemoveImagePlaceCreateAction({required this.valueKey});
}

class SetValidPlaceCreateAction extends PlaceCreateAction {
  final bool isValid;

  SetValidPlaceCreateAction({required this.isValid});
}

class ResetPlaceCreateAction extends PlaceCreateAction {}
