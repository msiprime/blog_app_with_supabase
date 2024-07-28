int calculateReadingTime(String content) {
  const averageReadingSpeed = 200;

  final words = content.split(RegExp(r'\s+'));

  final readingTime = words.length / averageReadingSpeed;

  return readingTime.ceil();
}
