class Cordinate {
  int x;
  int y;

  Cordinate(this.x, this.y);

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object? other) {
    if (!(other is Cordinate)) return false;

    return x == other.x && y == other.y;
  }

  Cordinate operator +(Cordinate other) => Cordinate(
        this.x + other.x,
        this.y + other.y,
      );

  @override
  String toString() => "($x, $y)";
}
