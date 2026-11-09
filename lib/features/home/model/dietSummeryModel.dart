class DietSummary {
  final String title;
  final String mainContent;
  final String subtitle;
  final double progress;

  DietSummary({
    required this.title,
    required this.mainContent,
    required this.subtitle,
    required this.progress,
  });

  // Optional: Factory method to create from a Map (if you need to use maps elsewhere)
  factory DietSummary.fromMap(Map<String, dynamic> map) {
    return DietSummary(
      title: map['title'],
      mainContent: map['mainContent'],
      subtitle: map['subtitle'],
      progress: map['progress'],
    );
  }
}
