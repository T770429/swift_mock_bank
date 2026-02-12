class Customer {
  const Customer({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.age,
  });

  final String name;
  final String email;
  final String address;
  final String phone;
  final int age;
}

enum AccountType { checking, savings }

extension AccountTypeLabel on AccountType {
  String get label {
    switch (this) {
      case AccountType.checking:
        return 'Checking';
      case AccountType.savings:
        return 'Savings';
    }
  }
}

class BankAccount {
  const BankAccount({
    required this.accountId,
    required this.nickname,
    required this.accountType,
    required this.accountNumber,
    required this.balance,
  });

  final String accountId;
  final String nickname;
  final AccountType accountType;
  final String accountNumber;
  final double balance;

  BankAccount copyWith({
    String? accountId,
    String? nickname,
    AccountType? accountType,
    String? accountNumber,
    double? balance,
  }) {
    return BankAccount(
      accountId: accountId ?? this.accountId,
      nickname: nickname ?? this.nickname,
      accountType: accountType ?? this.accountType,
      accountNumber: accountNumber ?? this.accountNumber,
      balance: balance ?? this.balance,
    );
  }
}

enum TransactionCategory { income, food, bills, dining, transfer }

extension TransactionCategoryLabel on TransactionCategory {
  String get label {
    switch (this) {
      case TransactionCategory.income:
        return 'Income';
      case TransactionCategory.food:
        return 'Food';
      case TransactionCategory.bills:
        return 'Bills';
      case TransactionCategory.dining:
        return 'Dining';
      case TransactionCategory.transfer:
        return 'Transfer';
    }
  }
}

class BankTransaction {
  const BankTransaction({
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
  });

  final String title;
  final TransactionCategory category;
  final DateTime date;
  final double amount;

  bool get isCredit => amount > 0;
}

class Biller {
  const Biller({required this.code, required this.name});

  final String code;
  final String name;
}
