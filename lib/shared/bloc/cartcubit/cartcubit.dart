import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_fire_base/shared/bloc/cartcubit/cartstatus.dart';


class countercubit extends Cubit<elamalia> {
  countercubit() : super(CartInitialstatee());

  static countercubit get(context) => BlocProvider.of(context);

  var Unitdata ;
  var firstvalue ;


  int counter = 1;
  void minus(context) {
    if (counter == 1) {
      counter = 1;
    }
    else {
      counter--;
    }
    emit(Counterministatee());
  }

  void plus() {
    counter++;
    emit((Counterplusstatee()));
  }

}
