enum PaymentMethod { creditCard, debitCard, paypal, bankTransfer }

extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.debitCard:
        return 'Debit Card';
      case PaymentMethod.paypal:
        return 'PayPal';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
    }
  }
}

String getDisplayNameForPaymentMethod(PaymentMethod method) {
  return method.displayName;
}
