import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;
  final Color tileColor;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final double imageWidth;
  final Color activeColor;
  final BorderRadiusGeometry borderRadius;
  final VoidCallback? onTap;


  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.tileColor,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.imageWidth,
    required this.activeColor,
    required this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      leading: Image.asset(
        imageAsset,
        width: imageWidth,
      ),
      tileColor: tileColor,
      title: Text(
        title,
        style: titleStyle,
      ),
      subtitle: Text(
        subtitle,
        style: subtitleStyle,
      ),
      trailing: Radio<String>(
        activeColor: activeColor,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      onTap: onTap,
    );
  }
}
