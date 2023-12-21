class ReceiptEntity {
  final String? id;
  final double cash;
  final double change;
  final double totalGross;
  final double discount;
  final double totalNet;
  final String userEmail;

  ReceiptEntity({
    this.id,
    required this.cash,
    required this.change,
    required this.totalGross,
    required this.discount,
    required this.totalNet,
    required this.userEmail,
  });
}
