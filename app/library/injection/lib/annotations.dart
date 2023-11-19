class Dependencies {
  /// Create an annotation that marks all extra dependencies.
  const Dependencies.dependsOn(
    this.type,
    this.dependsOn,
  );

  /// Type for which extra dependencies need to be listed.
  final Type type;
  /// List of extra dependencies.
  final List<Type>? dependsOn;
}
