package ex2;


import java.util.Objects;

public class Product{
    private String name="None";
    private int quantity=0;
    private int price=0;

    public Product(){}
    public Product(String name,int quantity,int price){
        this.name=name;
        this.quantity=quantity;
        this.price=price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return quantity == product.quantity && price == product.price && Objects.equals(name, product.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, quantity, price);
    }

    @Override
    public String toString() {
        return "Product{" +
                "name='" + name + '\'' +
                ", quantity=" + quantity +
                ", price=" + price +
                '}';
    }
}
