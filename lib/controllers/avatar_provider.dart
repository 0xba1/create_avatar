import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:create_avatar/models/pixel_art_variants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class AvatarProvider extends ChangeNotifier {
  final http.Client _httpClient = http.Client();

  // Download png file of avatar
  Future<void> download(BuildContext context) async {
    String? avatarSvgString;
    String dirPath;
    try {
      avatarSvgString = (await getAvatarSvgString());
      if (Platform.isAndroid) {
        if (await Permission.storage.request().isGranted) {
          dirPath = (await getExternalStorageDirectory() as Directory).path;
          String temp = dirPath.split('Android').first;
          dirPath = '$temp/Download';
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please give permission to download file.')));
          return;
        }
      } else {
        if (await Permission.storage.request().isGranted) {
          dirPath = (await getDownloadsDirectory() as Directory).path;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please give permission to download file.')));
          return;
        }
      }
    } catch (e, stacktrace) {
      debugPrintStack(stackTrace: stacktrace, label: '$e');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Download failed!')));
      return;
    }
    Uint8List rawPng = await _svgToPng(context, avatarSvgString!);
    String uuid = const Uuid().v4();
    String filePath = '$dirPath/$uuid.png';
    File pngFile = File(filePath);
    pngFile.writeAsBytes(rawPng);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Download complete : $filePath')));
  }

  Future<String?> getAvatarSvgString() async {
    try {
      var response = await _httpClient.get(avatarUri);
      return response.body;
    } catch (e, stacktrace) {
      debugPrintStack(stackTrace: stacktrace, label: '$e');
      rethrow;
    }
  }

  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  void notify() {
    notifyListeners();
  }

  Uri get avatarUri {
    Map<String, String> params = {
      'skinColor': PixelArtVariants.skinColorVariants[_skinColorIndex],
      'eyes': PixelArtVariants.eyesVariants[_eyesIndex],
      'eyebrows': PixelArtVariants.eyebrowsVariants[_eyebrowsIndex],
      'beard': PixelArtVariants.beardVariants[_beardIndex],
      'mouth': PixelArtVariants.mouthVariants[_mouthIndex],
      'mouthColor': PixelArtVariants.mouthColorVariants[_mouthColorIndex],
      'hair': PixelArtVariants.hairVariants[_hairIndex],
      'hairColor': PixelArtVariants.hairColorVariants[_hairColorIndex],
      'accessories': PixelArtVariants.accessoriesVariants[_accessoriesIndex],
      'accessoriesColor':
          PixelArtVariants.accessoriesColorVariants[_accessoriesColorIndex],
      'glasses': PixelArtVariants.glassesVariants[_glassesIndex],
      'glassesColor': PixelArtVariants.glassesColorVariants[_glassesColorIndex],
      'hat': PixelArtVariants.hatVariants[_hatIndex],
      'hatColor': PixelArtVariants.hatColorVariants[_hatColorIndex],
      'clothing': PixelArtVariants.clothingVariants[_clothingIndex],
      'clothesColor': PixelArtVariants.clothesColorVariants[_clothesColorIndex],
    };
    String _diceBearHost = 'avatars.dicebear.com';
    String _apiVersion = '4.9';
    String _sprite = 'pixel-art';

    return Uri.https(_diceBearHost,
        '/$_apiVersion/api/$_sprite/${_controller.text}.svg', params);
  }

  int _skinColorIndex = 0;
  int get skinColorIndex => _skinColorIndex;
  void toggleSkinColorIndex() {
    _skinColorIndex =
        (_skinColorIndex + 1) % PixelArtVariants.skinColorVariants.length;
    notifyListeners();
  }

  int _eyesIndex = 0;
  int get eyesIndex => _eyesIndex;
  void toggleEyesIndex() {
    _eyesIndex = (_eyesIndex + 1) % PixelArtVariants.eyesVariants.length;
    notifyListeners();
  }

  int _eyebrowsIndex = 0;
  int get eyebrowsIndex => _eyebrowsIndex;
  void toggleEyebrowsIndex() {
    _eyebrowsIndex =
        (_eyebrowsIndex + 1) % PixelArtVariants.eyebrowsVariants.length;
    notifyListeners();
  }

  int _beardIndex = 0;
  int get beardIndex => _beardIndex;
  void toggleBeardIndex() {
    _beardIndex = (_mouthIndex + 1) % PixelArtVariants.beardVariants.length;
    notifyListeners();
  }

  int _mouthIndex = 0;
  int get mouthIndex => _mouthIndex;
  void toggleMouthIndex() {
    _mouthIndex = (_mouthIndex + 1) % PixelArtVariants.beardVariants.length;
    notifyListeners();
  }

  int _mouthColorIndex = 0;
  int get mouthColorIndex => _mouthColorIndex;
  void toggleMouthColorIndex() {
    _mouthColorIndex =
        (_mouthColorIndex + 1) % PixelArtVariants.mouthColorVariants.length;
    notifyListeners();
  }

  int _hairIndex = 0;
  int get hairIndex => _hairIndex;
  void toggleHairIndex() {
    _hairIndex = (_hairIndex + 1) % PixelArtVariants.hairVariants.length;
    notifyListeners();
  }

  int _hairColorIndex = 0;
  int get hairColorIndex => _hairColorIndex;
  void toggleHairColorIndex() {
    _hairColorIndex =
        (_hairColorIndex + 1) % PixelArtVariants.hairColorVariants.length;
    notifyListeners();
  }

  int _accessoriesIndex = 0;
  int get accessoriesIndex => _accessoriesIndex;
  void toggleAccessoriesIndex() {
    _accessoriesIndex =
        (_accessoriesIndex + 1) % PixelArtVariants.accessoriesVariants.length;
    notifyListeners();
  }

  int _accessoriesColorIndex = 0;
  int get accessoriesColorIndex => _accessoriesColorIndex;
  void toggleAccessoriesColorIndex() {
    _accessoriesColorIndex = (_accessoriesColorIndex + 1) %
        PixelArtVariants.accessoriesColorVariants.length;
    notifyListeners();
  }

  int _glassesIndex = 0;
  int get glassesIndex => _glassesIndex;
  void toggleGlassesIndex() {
    _glassesIndex =
        (_glassesIndex + 1) % PixelArtVariants.glassesVariants.length;
    notifyListeners();
  }

  int _glassesColorIndex = 0;
  int get glassesColorIndex => _glassesColorIndex;
  void toggleGlassesColorIndex() {
    _glassesColorIndex =
        (_glassesColorIndex + 1) % PixelArtVariants.glassesColorVariants.length;
    notifyListeners();
  }

  int _hatIndex = 0;
  int get hatIndex => _hatIndex;
  void toggleHatIndex() {
    _hatIndex = (_hatIndex + 1) % PixelArtVariants.hatVariants.length;
    notifyListeners();
  }

  int _hatColorIndex = 0;
  int get hatColorIndex => _hatColorIndex;
  void toggleHatColorIndex() {
    _hatColorIndex =
        (_hatColorIndex + 1) % PixelArtVariants.hatColorVariants.length;
    notifyListeners();
  }

  int _clothingIndex = 0;
  int get clothingIndex => _clothingIndex;
  void toggleClothingIndex() {
    _clothingIndex =
        (_clothingIndex + 1) % PixelArtVariants.clothingVariants.length;
    notifyListeners();
  }

  int _clothesColorIndex = 0;
  int get clothesColorIndex => _clothesColorIndex;
  void toggleClothesColorIndex() {
    _clothesColorIndex =
        (_clothesColorIndex + 1) % PixelArtVariants.clothesColorVariants.length;
    notifyListeners();
  }

  // Convert svg to raw png
  Future<Uint8List> _svgToPng(BuildContext context, String svgString) async {
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, 'svgKey');

    // to have a nice rendering it is important to have the exact original height and width,
    // the easier way to retrieve it is directly from the svg string
    // but be careful, this is an ugly fix for a flutter_svg problem that works
    // with my images

    double width = 512;
    double height = 512;

    // Convert to ui.Picture
    final picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the screen DPI
    final image = await picture.toImage(width.toInt(), height.toInt());
    ByteData bytes = (await image.toByteData(format: ImageByteFormat.png))!;

    return bytes.buffer.asUint8List();
  }

  @override
  void dispose() {
    _httpClient.close();
    super.dispose();
  }
}
