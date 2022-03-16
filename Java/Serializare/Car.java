package ex4;

import java.io.Serializable;

/**
 * Write a program which allow user to
 * create car objects, save car objects on a
 * local folder , view existing car objects
 * on the local folder, read a car object from
 * local folder and display it's details.
 * Use serialization mechanism for
 * storing and retrieval of objects.
 */
public class Car implements Serializable {
    private int price;
    private String model;

    public Car() {
    }

    public Car(int price, String model) {
        this.price = price;
        this.model = model;
    }

    @Override
    public String toString() {
        return "Car{" +
                "price=" + price +
                ", model='" + model + '\'' +
                '}';
    }
}
