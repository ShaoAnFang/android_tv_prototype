import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// import '../components/ShimmerWidget.dart';

enum ImageType {
  userImage,
  apiErrorImage,
  logo,
  homeBackgroundImage,
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);
  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class ImageCached extends StatefulWidget {
  const ImageCached({
    Key? key,
    required this.imageUrl,
    this.placeholder = ImageType.logo,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String imageUrl;
  final ImageType placeholder;
  final BoxFit fit;

  @override
  State<ImageCached> createState() => _ImageCachedState();
}

class _ImageCachedState extends State<ImageCached> {
  final placeholderTypeEnum = EnumValues({
    // "assets/apiErrorPlaceholder.jpg": ImageType.apiErrorImage,
    "assets/user_photo.png": ImageType.userImage,
    "assets/logo_white.png": ImageType.logo,
    "assets/homeBackgroundImage": ImageType.homeBackgroundImage,
  });
  String placeholderPath = "";
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    placeholderPath = placeholderTypeEnum.reverse[widget.placeholder].toString();
    if (!widget.imageUrl.contains("http")) {
      imageUrl = 'https://image.tmdb.org/t/p/w300_and_h450_bestv2' + widget.imageUrl;
    } else {
      imageUrl = widget.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheKey: imageUrl,
      placeholder: (context, url) {
        // return ShimmerWidget.rectangle(width: MediaQuery.sizeOf(context).width, height: MediaQuery.sizeOf(context).height);
        if (placeholderPath.contains('homeBackgroundImage')) {
          return Container(color: Colors.black);
        }
        return Container(color: Colors.grey);
        // return Image.asset(placeholderPath, fit: BoxFit.contain);
      },
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: widget.fit)));
      },
      errorWidget: (context, url, error) {
        return Container(color: Colors.grey);
        // return Image.asset(placeholderPath, fit: BoxFit.contain);
        //Icon(Icons.image_not_supported_outlined);
        // Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       fit: BoxFit.fill,
        //       image: AssetImage(placeholderPath),
        //     ),
        //   ),
        // );
      },
    );
  }
}
