import 'package:flutter/material.dart';

import '../animations/fade_in.dart';
import '../constants/app_colors.dart';
import '../theme/text_styles.dart';

/// Reusable product card widget.
class CardProduct extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String price;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const CardProduct({
    super.key,
    required this.name,
    this.imageUrl,
    required this.price,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: imageUrl != null
                        ? Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: AppColors.surface,
                            child: const Icon(Icons.fastfood, size: 48),
                          ),
                  ),
                  if (onFavoriteTap != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: onFavoriteTap,
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyles.labelLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: TextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
