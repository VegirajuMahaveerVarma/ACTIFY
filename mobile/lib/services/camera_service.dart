import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> capture() => _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
}
