enum Affordability {
  AFFORDABLE,
  PRICEY,
  LUXURIOUS,
}

String getAffordabilityText(Affordability affordability) {
  switch (affordability) {
    case Affordability.AFFORDABLE:
      return 'Affordable';
    case Affordability.PRICEY:
      return 'Pricey';
    case Affordability.LUXURIOUS:
      return 'Luxurious';
    default:
      return 'Unknown';
  }
}
