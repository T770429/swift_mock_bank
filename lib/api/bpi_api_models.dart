class BpiTransferRequest {
  const BpiTransferRequest({
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    this.description,
    this.currency,
  });

  final String fromAccountId;
  final String toAccountId;
  final double amount;
  final String? description;
  final String? currency;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'from_account_id': fromAccountId,
      'to_account_id': toAccountId,
      'amount': amount,
      if (description != null && description!.isNotEmpty)
        'description': description,
      if (currency != null && currency!.isNotEmpty) 'currency': currency,
    };
  }
}

class BpiTransferResult {
  const BpiTransferResult({
    required this.success,
    this.referenceId,
    this.message,
    required this.raw,
  });

  final bool success;
  final String? referenceId;
  final String? message;
  final Map<String, dynamic> raw;
}
