enum ExpiryStatus {
  valid,
  expiringSoon,
  expired,
  unknown;

  static ExpiryStatus fromString(String? value) => switch (value) {
        'valid' => ExpiryStatus.valid,
        'expiring_soon' => ExpiryStatus.expiringSoon,
        'expired' => ExpiryStatus.expired,
        _ => ExpiryStatus.unknown,
      };

  String get apiValue => switch (this) {
        ExpiryStatus.valid => 'valid',
        ExpiryStatus.expiringSoon => 'expiring_soon',
        ExpiryStatus.expired => 'expired',
        ExpiryStatus.unknown => '',
      };
      String get toStrings => switch (this) {
        ExpiryStatus.valid => 'Valid',
        ExpiryStatus.expiringSoon => 'Expiring soon',
        ExpiryStatus.expired => 'Expired',
        ExpiryStatus.unknown => '',
      };
}