package view;

import controller.toNextMenus.ToBicyclingMenu;
import controller.toNextMenus.ToRunningMenu;
import controller.toNextMenus.ToSwimmingMenu;
import controller.toNextMenus.ToWalkingMenu;

import javax.swing.*;
import java.awt.*;

public class FirstMenu extends JFrame {
    private JButton run = new JButton("Running");
    private JButton walk = new JButton("Walking");
    private JButton swim = new JButton("Swimming");
    private JButton bicycle = new JButton("Bicylcing");
    private JLabel label = new JLabel("Choose an activity:");

    private static FirstMenu firstMenu=null;
    private FirstMenu() {
        setTitle("Activity menu");
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        setLayout(new GridLayout(5, 1));
        setBounds(200, 200, 400, 200);
        run.addActionListener(new ToRunningMenu());
        walk.addActionListener(new ToWalkingMenu());
        bicycle.addActionListener(new ToBicyclingMenu());
        swim.addActionListener(new ToSwimmingMenu());
        add(label);
        add(run);
        add(walk);
        add(swim);
        add(bicycle);
        setVisible(true);
    }

    public static FirstMenu getInstance(){
        synchronized (FirstMenu.class){
            if(firstMenu==null){
                firstMenu=new FirstMenu();
            }
        }
        return firstMenu;
    }

    public JButton getRun() {
        return run;
    }

    public JButton getWalk() {
        return walk;
    }

    public JButton getSwim() {
        return swim;
    }

    public JButton getBicycle() {
        return bicycle;
    }

}
