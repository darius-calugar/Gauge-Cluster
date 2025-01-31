part of 'mileage.dart';

class MileageDigit extends StatelessWidget {
  const MileageDigit({
    super.key,
    required this.digit,
  });

  final int digit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.black2,
      ),
      child: Text(
        '$digit',
        style: TextStyle(
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
