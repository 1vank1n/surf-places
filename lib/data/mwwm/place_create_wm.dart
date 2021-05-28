import 'dart:math';

import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/place_create_screen.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class PlaceCreateWidgetModel extends WidgetModel {
  final PlaceInteractor placeInteractor;
  final StreamedState<List<UploadImage>> uploadImageListState = StreamedState<List<UploadImage>>();
  final StreamedState<bool> isValidPlaceCreateState = StreamedState<bool>();
  final Action<void> addUploadImageAction = Action<void>();

  List<UploadImage> _uploadImages = [];
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController latTextEditingController = TextEditingController();
  TextEditingController lonTextEditingController = TextEditingController();
  TextEditingController detailsTextEditingController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode latFocusNode = FocusNode();
  FocusNode lonFocusNode = FocusNode();
  FocusNode detailsFocusNode = FocusNode();
  bool get isValidPlaceCreateForm {
    return titleTextEditingController.text.isNotEmpty &&
        latTextEditingController.text.isNotEmpty &&
        lonTextEditingController.text.isNotEmpty &&
        detailsTextEditingController.text.isNotEmpty;
  }

  PlaceCreateWidgetModel(
    WidgetModelDependencies baseDependencies, {
    required this.placeInteractor,
  }) : super(baseDependencies);

  static PlaceCreateWidgetModel builder(BuildContext context) {
    final WidgetModelDependencies wmDependencies = context.read<WidgetModelDependencies>();
    return PlaceCreateWidgetModel(
      wmDependencies,
      placeInteractor: context.read<PlaceInteractor>(),
    );
  }

  @override
  void onLoad() {
    super.onLoad();

    _uploadImages.add(
      UploadImage(
        isCreator: true,
        addUploadImage: addUploadImageAction,
      ),
    );
    uploadImageListState.accept(_uploadImages);
  }

  @override
  void onBind() {
    super.onBind();

    subscribe<void>(addUploadImageAction.stream, (_) {
      _addUploadImage();
    });
  }

  void _addUploadImage() async {
    ValueKey<int> key = ValueKey(Random().nextInt(100));

    _uploadImages.insert(
      1,
      UploadImage(
        key: key,
        deleteUploadImage: _deleteUploadImage,
      ),
    );
    uploadImageListState.accept(_uploadImages);
  }

  void _deleteUploadImage(ValueKey<int> key) {
    _uploadImages.removeWhere((UploadImage uploadImage) => uploadImage.key == key);
    uploadImageListState.accept(_uploadImages);
  }

  String? requiredValidator(String? value) {
    if (value != null && value.length > 0) {
      isValidPlaceCreateState.accept(isValidPlaceCreateForm);
      return null;
    } else {
      return 'Поле обязательно';
    }
  }

  Place createPlaceFromState() {
    return Place(
      id: 0,
      name: titleTextEditingController.text,
      lat: double.parse(latTextEditingController.text),
      lng: double.parse(lonTextEditingController.text),
      urls: [],
      description: detailsTextEditingController.text,
      placeType: '',
    );
  }

  void addPlaceFromStateToRepository() {
    Place place = createPlaceFromState();
    // TODO
    // placeInteractor.addNewPlace(place);
    print(place);
  }
}
