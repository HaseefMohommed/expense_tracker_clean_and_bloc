import 'package:expesne_tracker_app/constants/assets_paths.dart';

enum PaymentMethod { creditCard, debitCard, paypal, bankTransfer }

extension PaymentMethodExtension on PaymentMethod {
  String get icon {
    switch (this) {
      case PaymentMethod.creditCard:
        return AssetsPaths.salary;
      case PaymentMethod.debitCard:
        return AssetsPaths.salary;
      case PaymentMethod.paypal:
        return AssetsPaths.salary;
      case PaymentMethod.bankTransfer:
        return AssetsPaths.salary;
    }
  }
}

String getIconForPaymentMethod(PaymentMethod method) {
  return method.icon;
}
