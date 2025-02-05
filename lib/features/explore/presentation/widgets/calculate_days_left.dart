// calculate Days left method from the deadline
int calculateDaysLeft(DateTime deadline) {
  final now = DateTime.now();
  final difference = deadline.difference(now);
  return difference.inDays;
}
