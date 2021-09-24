class PaymentOption {
  int number;
  double value;
  double total;

  PaymentOption(this.number, this.value, this.total);

  PaymentOption.fromJson(json) : this(
      json['number'], json['value'].toDouble(), json['total'].toDouble());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentOption &&
          runtimeType == other.runtimeType &&
          number == other.number &&
          value == other.value &&
          total == other.total;

  @override
  int get hashCode => number.hashCode ^ value.hashCode ^ total.hashCode;
}
