class BaseEntity {
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;

  BaseEntity({
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });
}
