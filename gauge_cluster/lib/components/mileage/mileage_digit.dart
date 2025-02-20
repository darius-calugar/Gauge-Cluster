part of 'mileage.dart';

class MileageDigit extends StatelessWidget {
  const MileageDigit({super.key, required this.digit});

  final int digit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      padding: EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.black2),
      child: Text(
        '$digit',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      ),
    );
  }
}
