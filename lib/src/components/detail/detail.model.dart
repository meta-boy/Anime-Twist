import 'package:momentum/momentum.dart';

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
