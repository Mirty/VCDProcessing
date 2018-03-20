boolean isBetween (float value, float extr1, float extr2) {
  return value >= min (extr1, extr2) && value <= max (extr1, extr2);
}