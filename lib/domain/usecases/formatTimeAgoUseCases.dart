String formatTimeAgo(DateTime gameDatetime) {
  final duration = DateTime.now().difference(gameDatetime);
  if (duration.inMinutes < 1) {
    return 'moments ago';
  } else if (duration.inMinutes < 60) {
    return '${duration.inMinutes} minutes ago';
  } else if (duration.inHours < 24) {
    return '${duration.inHours} hour ago';
  } else if (duration.inDays < 30) {
    return '${duration.inDays} days ago';
  } else if (duration.inDays < 365) {
    return 'hace ${duration.inDays ~/ 30} months ago';
  } else {
    return 'hace más de un año';
  }
}
