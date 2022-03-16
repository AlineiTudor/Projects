package controller.toNextMenus;

import view.sportsMenu.RunningMenu;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ToRunningMenu implements ActionListener {
    @Override
    public void actionPerformed(ActionEvent e) {
        new RunningMenu();
    }
}
