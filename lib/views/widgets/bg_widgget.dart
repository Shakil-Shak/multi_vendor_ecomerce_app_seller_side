
import '../../const/const.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgBackground), fit: BoxFit.cover, opacity: 0.8)),
    child: child,
  );
}


