import 'package:equatable/equatable.dart';
import 'package:gauge_cluster/utils/math/units/angle.dart';

class CircleSlice extends Equatable {
  CircleSlice({Angle? startAngle, Angle? endAngle, Angle? sweepAngle})
    : assert(startAngle == null || endAngle == null || sweepAngle == null) {
    if (endAngle == null) {
      this.startAngle = startAngle ?? Angle.zero;
      this.sweepAngle = sweepAngle ?? Angle.full;
      this.endAngle = this.startAngle + this.sweepAngle;
    } else if (startAngle == null) {
      this.endAngle = endAngle ?? Angle.full;
      this.sweepAngle = sweepAngle ?? Angle.full;
      this.startAngle = this.endAngle - this.sweepAngle;
    } else if (sweepAngle == null) {
      this.startAngle = startAngle ?? Angle.zero;
      this.endAngle = endAngle ?? Angle.full;
      this.sweepAngle = this.endAngle - this.startAngle;
    }
  }

  factory CircleSlice.full() =>
      CircleSlice(startAngle: Angle.zero, endAngle: Angle.full);

  late final Angle startAngle;
  late final Angle endAngle;
  late final Angle sweepAngle;

  Angle get midAngle => startAngle + sweepAngle / 2;

  Angle atRatio(double ratio) => startAngle + sweepAngle * ratio;

  @override
  List<Object?> get props => [startAngle, endAngle, sweepAngle];
}
