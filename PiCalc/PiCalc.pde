import java.math.BigDecimal;
import java.math.RoundingMode;

BigDecimal pi;

void setup() {
  for (int k = 1; k >= 0; k++) {
    BigDecimal num1 = new BigDecimal(1).divide(new BigDecimal(pow(16, k)), 1000, RoundingMode.HALF_UP);
    BigDecimal num2 = new BigDecimal(4).divide(new BigDecimal(8).multiply(new BigDecimal(k)).add(new BigDecimal(1)), 1000, RoundingMode.HALF_UP);
    BigDecimal num3 = new BigDecimal(2).divide(new BigDecimal(8).multiply(new BigDecimal(k)).add(new BigDecimal(4)), 1000, RoundingMode.HALF_UP);
    BigDecimal num4 = new BigDecimal(1).divide(new BigDecimal(8).multiply(new BigDecimal(k)).add(new BigDecimal(5)), 1000, RoundingMode.HALF_UP);
    BigDecimal num5 = new BigDecimal(1).divide(new BigDecimal(8).multiply(new BigDecimal(k)).add(new BigDecimal(6)), 1000, RoundingMode.HALF_UP);
    BigDecimal num6 = num2.subtract(num3).subtract(num4).subtract(num5);
    
    pi = num1.multiply(num6);
    println(pi);
  }
}
