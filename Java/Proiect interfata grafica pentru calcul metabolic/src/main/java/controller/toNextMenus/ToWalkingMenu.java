package controller.toNextMenus;

import view.sportsMenu.WalkingMenu;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ToWalkingMenu implements ActionListener {
    @Override
    public void actionPerformed(ActionEvent e) {
        new WalkingMenu();
    }
}
