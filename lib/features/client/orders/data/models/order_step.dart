class OrderStep {
  final String title;
  final String time;
  final bool isCompleted;

  OrderStep({
    required this.title,
    required this.time,
    this.isCompleted = false,
  });

  OrderStep copyWith({String? title, String? time, bool? isCompleted}) {
    return OrderStep(
      title: title ?? this.title,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
