package ex2;


import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import java.util.Vector;

public class Controller {
    private Vector<Product> products = new Vector<>();
    private View view = new View();

    public Controller() {
        view.getAdd().addActionListener(new AddButton());
        view.getView().addActionListener(new SeeProducts());
        view.getChangeq().addActionListener(new ChangeQuantity());
        view.getDelete().addActionListener(new DeleteProduct());
    }


    public class AddButton implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            try {
                int price = Integer.parseInt(view.getPrice().getText());
                int quant = Integer.parseInt(view.getQuantity().getText());
                products.addElement(new Product(view.getNume().getText(), quant, price));
                view.getPrice().setText("");
                view.getQuantity().setText("");
                view.getNume().setText("");

            } catch (NumberFormatException numberFormatException) {
            }
        }
    }


    private class SeeProducts implements ActionListener {

        @Override
        public void actionPerformed(ActionEvent e) {
            try {
                view.getListModel().clear();
                for (Product p : products) {
                    view.getListModel().addElement(p);
                }
            } catch (Exception exception) {
            }
        }
    }

    private class ChangeQuantity implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            Product prod = view.getProducts().getSelectedValue();
            for (Product p : products) {
                if (prod.equals(p)) {
                    try {
                        int new_quant = Integer.parseInt(view.getChange_quant().getText());
                        p.setQuantity(new_quant);
                        view.getListModel().clear();
                        for (Product a : products) {
                            view.getListModel().addElement(a);
                        }
                    } catch (Exception exception) {
                    }
                }
            }
        }
    }

    private class DeleteProduct implements ActionListener {

        @Override
        public void actionPerformed(ActionEvent e) {
            try {
                int index_prod = view.getProducts().getSelectedIndex();
                products.remove(products.get(index_prod));
                view.getListModel().clear();
                for (Product a : products) {
                    view.getListModel().addElement(a);
                }
            } catch (Exception exception) {
            }
        }
    }
}
