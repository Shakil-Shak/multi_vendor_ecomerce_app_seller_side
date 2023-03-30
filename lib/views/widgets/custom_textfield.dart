import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/views/widgets/text_style.dart';

Widget customTextField({label, hint, controller, isDecs = false}) {
  return TextFormField(
    style: const TextStyle(color: purpleColor),
    controller: controller,
    maxLines: isDecs ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label, color: purpleColor),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: purpleColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: purpleColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: purpleColor)),
        hintText: hint,
        hintStyle: const TextStyle(color: darkGrey)),
  );
}
