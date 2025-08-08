import 'package:flutter/material.dart';

/// Extension on DateTime to provide human-readable formatting
extension DateTimeExtensions on DateTime {
  /// Converts DateTime to a human-readable format
  /// Examples:
  /// - Today at 2:30 PM
  /// - Tomorrow at 9:00 AM
  /// - Yesterday at 11:45 AM
  /// - Mon, Jan 15 at 3:20 PM
  /// - Dec 25, 2024 at 6:00 PM
  String toHumanReadable() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));
    final taskDate = DateTime(year, month, day);

    // Format time
    final timeFormat = _formatTime();

    // Check if it's today, yesterday, or tomorrow
    if (taskDate == today) {
      return 'Today at $timeFormat';
    } else if (taskDate == yesterday) {
      return 'Yesterday at $timeFormat';
    } else if (taskDate == tomorrow) {
      return 'Tomorrow at $timeFormat';
    }

    // Check if it's within this week
    final daysDifference = taskDate.difference(today).inDays;
    if (daysDifference.abs() <= 6 && daysDifference > 1) {
      return '${_getDayName()} at $timeFormat';
    } else if (daysDifference.abs() <= 6 && daysDifference < -1) {
      return '${_getDayName()} at $timeFormat';
    }

    // Check if it's within this year
    if (year == now.year) {
      return '${_getMonthName()} $day at $timeFormat';
    }

    // Default format for dates in different years
    return '${_getMonthName()} $day, $year at $timeFormat';
  }

  /// Converts DateTime to a short human-readable format
  /// Examples:
  /// - Today 2:30 PM
  /// - Tomorrow 9:00 AM
  /// - Jan 15 3:20 PM
  /// - Dec 25, 2024 6:00 PM
  String toShortHumanReadable() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));
    final taskDate = DateTime(year, month, day);

    final timeFormat = _formatTime();

    if (taskDate == today) {
      return 'Today $timeFormat';
    } else if (taskDate == yesterday) {
      return 'Yesterday $timeFormat';
    } else if (taskDate == tomorrow) {
      return 'Tomorrow $timeFormat';
    }

    if (year == now.year) {
      return '${_getShortMonthName()} $day $timeFormat';
    }

    return '${_getShortMonthName()} $day, $year $timeFormat';
  }

  /// Formats time in 12-hour format with AM/PM
  String _formatTime() {
    final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final period = hour >= 12 ? 'PM' : 'AM';
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$hour12:$minuteStr $period';
  }

  /// Gets the day name (Monday, Tuesday, etc.)
  String _getDayName() {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[weekday - 1];
  }

  /// Gets the full month name
  String _getMonthName() {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  /// Gets the short month name
  String _getShortMonthName() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  /// Checks if the date is overdue
  bool get isOverdue {
    final now = DateTime.now();
    return isBefore(now);
  }

  /// Checks if the date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if the date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  /// Checks if the date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  /// Returns the time remaining until this date
  String get timeRemaining {
    final now = DateTime.now();
    final difference = this.difference(now);

    if (difference.isNegative) {
      return 'Overdue';
    }

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} remaining';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} remaining';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} remaining';
    } else {
      return 'Due now';
    }
  }
}

/// Extension on TimeOfDay to provide additional functionality
extension TimeOfDayExtensions on TimeOfDay {
  /// Converts TimeOfDay to a human-readable string
  String toHumanReadable() {
    final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final period = hour >= 12 ? 'PM' : 'AM';
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$hour12:$minuteStr $period';
  }

  /// Combines TimeOfDay with a date to create DateTime
  DateTime combineWithDate(DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}

/// Extension on Duration to provide human-readable formatting
extension DurationExtensions on Duration {
  /// Converts Duration to a human-readable format
  String toHumanReadable() {
    if (inDays > 0) {
      return '$inDays day${inDays == 1 ? '' : 's'}';
    } else if (inHours > 0) {
      return '$inHours hour${inHours == 1 ? '' : 's'}';
    } else if (inMinutes > 0) {
      return '$inMinutes minute${inMinutes == 1 ? '' : 's'}';
    } else {
      return '$inSeconds second${inSeconds == 1 ? '' : 's'}';
    }
  }
}
