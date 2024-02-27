import '../data/all.dart';

class CommonImage extends StatelessWidget {
  String imageName;
  ColorFilter? colorFilter;
  BoxFit? fit;

  CommonImage({
    super.key,
    required this.imageName,
    this.colorFilter,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageName,
      colorFilter: colorFilter,
      fit: fit ?? BoxFit.scaleDown,
    );
  }
}
