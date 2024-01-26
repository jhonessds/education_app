// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

abstract class Either<L, R> {
  const Either();

  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);

  bool isLeft() => fold((_) => true, (_) => false);
  bool isRight() => fold((_) => false, (_) => true);
}

class Left<L, R> extends Either<L, R> {
  const Left(this._l);
  final L _l;
  L get value => _l;
  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(_l);
  @override
  bool operator ==(Object other) => other is Left && other._l == _l;
  @override
  int get hashCode => _l.hashCode;
}

class Right<L, R> extends Either<L, R> {
  const Right(this._r);
  final R _r;
  R get value => _r;
  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(_r);
  @override
  bool operator ==(Object other) => other is Right && other._r == _r;
  @override
  int get hashCode => _r.hashCode;
}

Either<L, R> left<L, R>(L l) => Left(l);
Either<L, R> right<L, R>(R r) => Right(r);
