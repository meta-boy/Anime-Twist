// Package imports:
import 'package:momentum/momentum.dart';

// Project imports:
import 'index.dart';

class DetailModel extends MomentumModel<DetailController> {
  DetailModel(DetailController controller) : super(controller);

  @override
  void update() {
    DetailModel(
      controller,
    ).updateMomentum();
  }
}
