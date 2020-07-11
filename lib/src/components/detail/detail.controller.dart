import 'package:momentum/momentum.dart';

import 'index.dart';

class DetailController extends MomentumController<DetailModel> {
  @override
  DetailModel init() {
    return DetailModel(
      this,
      // TODO: specify initial values here...
    );
  }
}
