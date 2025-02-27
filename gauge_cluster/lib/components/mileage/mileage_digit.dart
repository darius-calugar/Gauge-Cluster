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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.black4,
            AppColors.black6,
            AppColors.black6,
            AppColors.black4,
          ],
        ),
        boxShadow: [BoxShadow(color: AppColors.black2, blurRadius: 4)],
      ),
      child: Text(
        '$digit',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      ),
    );
  }
}
