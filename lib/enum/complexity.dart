enum Complexity {
  SIMPLE,
  CHALLENGING,
  HARD,
}
String getComplexityText(Complexity complexity) {
  switch (complexity) {
    case Complexity.SIMPLE:
      return 'Simple';
    case Complexity.CHALLENGING:
      return 'Challenging';
    case Complexity.HARD:
      return 'Hard';
    default:
      return 'Unknown';
  }
}
