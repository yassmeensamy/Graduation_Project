part of 'picked_image_cubit.dart';

@immutable
sealed class PickedImageState {}

final class PickedImageInitial extends PickedImageState {}
final class ImagePickerSuccess extends PickedImageState 
{
 final File image;
 ImagePickerSuccess(this.image);

}
final class ImagePickerFailure extends PickedImageState 
{
             String error;
             ImagePickerFailure(this.error);
}
final class ImageremoveImage extends PickedImageState 
{
             ImageremoveImage(Null);
}
