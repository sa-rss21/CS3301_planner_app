// This class represents a mood-related item, storing information about a person's mood
class MoodItem {
  final String mood;
  final String reason;
  final String timestamp;

// Constructor to initialize the MoodItem with required properties
  MoodItem(
      {required this.mood, required this.reason, required this.timestamp});
}