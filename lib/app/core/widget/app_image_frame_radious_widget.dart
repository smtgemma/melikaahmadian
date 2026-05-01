import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'shimmer_loader.dart';

class AppImageFrameRadiousWidget extends StatelessWidget {
  final String? imageLink;
  final double? radious;
  
  const AppImageFrameRadiousWidget({super.key, this.imageLink, this.radious});

  @override
  Widget build(BuildContext context) {
    double r = radious ?? 50;
    double size = r * 2;
    
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: CachedNetworkImage(
          imageUrl: imageLink ?? "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTY1LWtsaGN3ZWNtLmpwZw.jpg",
          fit: BoxFit.cover,
          placeholder: (context, url) => ShimmerWidget.circular(height: size, width: size),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.person, color: Colors.grey, size: 30),
          ),
        ),
      ),
    );
  }
}
