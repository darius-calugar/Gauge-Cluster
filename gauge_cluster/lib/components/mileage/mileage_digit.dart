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
            AppColors.black.$4,
            AppColors.black.$6,
            AppColors.black.$6,
            AppColors.black.$4,
          ],
        ),
        boxShadow: [BoxShadow(color: AppColors.black.$2, blurRadius: 2)],
      ),
      child: Text(
        '$digit',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      ),
    );
  }
}
