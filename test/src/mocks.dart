import 'package:mocktail/mocktail.dart';

class Function0Mock<T0> extends Mock {
  T0 call();
}

class Function1Mock<T0, T1> extends Mock {
  T0 call([T1 arg1]);
}

class Function2Mock<T0, T1, T2> extends Mock {
  T0 call([T1 arg1, T2 arg2]);
}

class Function3Mock<T0, T1, T2, T3> extends Mock {
  T0 call([T1 arg1, T2 arg2, T3 arg3]);
}

class Function4Mock<T0, T1, T2, T3, T4> extends Mock {
  T0 call([T1 arg1, T2 arg2, T3 arg3, T4 arg4]);
}

class Function5Mock<T0, T1, T2, T3, T4, T5> extends Mock {
  T0 call([T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5]);
}
