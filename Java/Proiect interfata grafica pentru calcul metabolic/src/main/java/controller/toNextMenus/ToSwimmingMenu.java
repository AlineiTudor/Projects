package controller.toNextMenus;

import view.sportsMenu.SwimmingMenu;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ToSwimmingMenu implements ActionListener {
    @Override
    public void actionPerformed(ActionEvent e) {
        new SwimmingMenu();
    }
}
