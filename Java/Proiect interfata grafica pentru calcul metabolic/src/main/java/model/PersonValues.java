package model;

public class PersonValues {
    private int heightCm;
    private int weightKg;
    private int age;
    private int bmr;


    public PersonValues(int height, int weight, int age) {
        this.heightCm = Math.abs(height);
        this.weightKg = Math.abs(weight);
        this.age = Math.abs(age);
        this.bmr = calc_bmr();
    }

    public int getHeightCm() {
        return heightCm;
    }

    public int getWeightKg() {
        return weightKg;
    }

    public int getAge() {
        return age;
    }

    public int getBmr() {
        return bmr;
    }

    @Override
    public String toString() {
        return "   Age=" + age + ";\n" +
                "   Height=" + heightCm + ";\n" +
                "   Weight=" + weightKg + ";\n";
    }

    public int calc_bmr() {
        return weightKg * 10 + (int) (6.25 * heightCm) - 5 * age - 85;//BMR = 10W + 6.25H - 5A -85
    }
}
