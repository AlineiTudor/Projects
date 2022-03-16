package controller.toNextMenus;

import view.sportsMenu.BicyclingMenu;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ToBicyclingMenu implements ActionListener {
    @Override
    public void actionPerformed(ActionEvent e) {
        new BicyclingMenu();
    }
}
