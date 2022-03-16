package ex2;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class View extends JFrame {
    private JButton add=new JButton("Add product");
    private JButton view=new JButton("See products");
    private JButton delete=new JButton("Delete products");
    private JButton changeq=new JButton("Change quantity");

    private DefaultListModel<Product> listModel=new DefaultListModel<>();
    private JList<Product> products=new JList<>(listModel);

    private JScrollPane scrollPane=new JScrollPane(products);

    private JTextField change_quant=new JTextField();
    private JTextField name=new JTextField();
    private JTextField quantity=new JTextField();
    private JTextField price=new JTextField();

    private JLabel nume_prod=new JLabel("Name: ");
    private JLabel cant_prod=new JLabel("Quantity: ");
    private JLabel pret_prod=new JLabel("Price: ");
    private JLabel pr_list=new JLabel("Product list: ");
    private JLabel c=new JLabel("New Quantity: ");

    public View(){
        this.setDefaultCloseOperation(EXIT_ON_CLOSE);

        this.setTitle("Stock Managemet");
        this.setSize(900,600);
        this.setLayout(new GridLayout(1,2));
        JPanel panel1=new JPanel(new GridLayout(3,3));
        panel1.setBounds(0,0,300,600);
        panel1.add(nume_prod);
        panel1.add(cant_prod);
        panel1.add(pret_prod);

        panel1.add(name);
        panel1.add(quantity);
        panel1.add(price);
        panel1.add(new JLabel());
        panel1.add(add);


        JPanel panel2=new JPanel();
        panel2.setLayout(new GridLayout(6,1));
        panel2.setBounds(300,600,600,600);
        panel2.add(pr_list);
        scrollPane.createVerticalScrollBar();
        scrollPane.createHorizontalScrollBar();
        panel2.add(scrollPane);
        JPanel panel3=new JPanel(new GridLayout(1,2));
        panel3.add(view);
        panel3.add(delete);
        panel2.add(panel3);
        panel2.add(c);
        panel2.add(change_quant);
        panel2.add(changeq);

        this.add(panel1);
        this.add(panel2);

        this.setVisible(true);
    }



    public JButton getAdd() {
        return add;
    }

    public JButton getView() {
        return view;
    }

    public JButton getDelete() {
        return delete;
    }

    public JButton getChangeq() {
        return changeq;
    }

    public JList<Product> getProducts() {
        return products;
    }

    public JTextField getChange_quant() {
        return change_quant;
    }

    public JTextField getNume() {
        return name;
    }

    public JTextField getQuantity() {
        return quantity;
    }

    public JTextField getPrice() {
        return price;
    }

    public DefaultListModel<Product> getListModel() {
        return listModel;
    }
}
