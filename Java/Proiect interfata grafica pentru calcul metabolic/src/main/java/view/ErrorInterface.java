package view;

import javax.swing.*;
import java.awt.*;

public final class ErrorInterface extends JFrame {
    private static final JLabel LABEL = new JLabel("Invalid argument");
    private JLabel label;

    public ErrorInterface() {
        setTitle("Error!");
        setBounds(200, 200, 400, 100);
        setLayout(null);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        LABEL.setBounds(150, 20, 100, 25);
        add(LABEL);
        setVisible(true);
    }

    public ErrorInterface(String error) {
        label = new JLabel(error);
        setTitle("Error!");
        setBounds(200, 200, 400, 100);
        setLayout(null);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        label.setBounds(100, 20, 1000, 25);
        add(label);
        setVisible(true);
    }

}
