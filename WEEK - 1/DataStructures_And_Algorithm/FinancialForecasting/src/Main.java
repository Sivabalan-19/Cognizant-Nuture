import Forecast.FinancialForecaster;

public class Main {
    public static void main(String[] args) {
        double amount = 10000;
        double rate = 0.08;
        int years = 5;

        double futureValue = FinancialForecaster.calculateFutureValue(amount, rate, years);

        System.out.println("Present Value: " + amount);
        System.out.println("Growth Rate: " + (rate * 100) + "%");
        System.out.println("Years: " + years);
        System.out.println("Future Value: " + futureValue);
    }
}
