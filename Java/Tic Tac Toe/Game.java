package ex4v2;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

public class Game extends JFrame {
    private JButton choice1 = new JButton("");
    private JButton choice2 = new JButton("");
    private JButton choice3 = new JButton("");
    private JButton choice4 = new JButton("");
    private JButton choice5 = new JButton("");
    private JButton choice6 = new JButton("");
    private JButton choice7 = new JButton("");
    private JButton choice8 = new JButton("");
    private JButton choice9 = new JButton("");

    private boolean flag = true;

    public Game() {
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setTitle("Tic Tac Toe");
        setBounds(100,100,300,300);
        initgame();
        setVisible(true);
    }

    public void setTabla() {
        choice1.addActionListener(new ApasareButon1());
        choice2.addActionListener(new ApasareButon2());
        choice3.addActionListener(new ApasareButon3());
        choice4.addActionListener(new ApasareButon4());
        choice5.addActionListener(new ApasareButon5());
        choice6.addActionListener(new ApasareButon6());
        choice7.addActionListener(new ApasareButon7());
        choice8.addActionListener(new ApasareButon8());
        choice9.addActionListener(new ApasareButon9());
        add(choice1);
        add(choice2);
        add(choice3);
        add(choice4);
        add(choice5);
        add(choice6);
        add(choice7);
        add(choice8);
        add(choice9);
    }

    public void initgame() {
        setLayout(new GridLayout(3, 3));
        setTabla();
    }

    public void resultWindow(String result){
        JFrame w=new JFrame("Rezultat");
        w.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        w.setBounds(200,200,100,100);
        JLabel l=new JLabel(result,SwingConstants.CENTER);
        w.add(l);
        w.setVisible(true);
        clearButtons();
    }

    public void clearButtons(){
        choice1.setText("");
        choice2.setText("");
        choice3.setText("");
        choice4.setText("");
        choice5.setText("");
        choice6.setText("");
        choice7.setText("");
        choice8.setText("");
        choice9.setText("");
    }

    public class ApasareButon1 implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (flag) {
                choice1.setText("X");
                flag = false;
            } else {
                choice1.setText("0");
                flag = true;
            }
            if(checkResult().equals("X")){
                resultWindow("Congrats!\nX Won");
            }else if(checkResult().equals("0")){
                resultWindow("Congrats!\n0 Won");
            }
            else if(checkResult().equals("") && allBoxesCompleted()){
                resultWindow("Draw");
            }
        }
    }

    public class ApasareButon2 implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (flag) {
                choice2.setText("X");
                flag = false;
            } else {
                choice2.setText("0");
                flag = true;
            }
            if(checkResult().equals("X")){
                resultWindow("Congrats!\nX Won");

            }else if(checkResult().equals("0")){
                resultWindow("Congrats!\n0 Won");

            }
            else if(checkResult().equals("") && allBoxesCompleted()){
                resultWindow("Draw");

            }
        }
    }

    public class ApasareButon3 implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (flag) {
                choice3.setText("X");
                flag = false;
            } else {
                choice3.setText("0");
                flag = true;
            }
            if(checkResult().equals("X")){
                resultWindow("Congrats!\nX Won");
            }else if(checkResult().equals("0")){
                resultWindow("Congrats!\n0 Won");
            }
            else if(checkResult().equals("") && allBoxesCompleted()){
                resultWindow("Draw");
            }
        }
    }

    public class ApasareButon4 implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (flag) {
                choice4.setText("X");
                flag = false;
            } else {
                choice4.setText("0");
                flag = true;
            }
            if(checkResult().equals("X")){
                resultWindow("Congrats!\nX Won");
            }else if(checkResult().equals("0")){
                resultWindow("Congrats!\n0 Won");
            }
            else if(checkResult().equals("") && allBoxesCompleted()){
                resultWindow("Draw");
            }
        }
    }

    public class ApasareButon5 implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (flag) {
                choice5.setText("X");
                flag = false;
            } else {
                choice5.setText("0");
                flag = true;
            }
            if(checkResult().equals("X")){
                resultWindow("Congrats!\nX Won");
            }else if(checkResult().equals("0")){
                resultWindow("Congrats!\n0 Won");
            }
            else if(checkResult().equals("") && allBoxesCompleted()){
                resultWindow("Draw");
            }
        }
    }

    public class ApasareButon6 implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (flag) {
                choice6.setText("X");
                flag = false;
            } else {
                choice6.setText("0");
                flag = true;
            }
            if(checkResult().equals("X")){
                resultWindow("Congrats!\nX Won");
            }else if(checkResult().equals("0")){
                resultWindow("Congrats!\n0 Won");
            }
            else if(checkResult().equals("") && allBoxesCompleted()){
                resultWindow("Draw");
            }
        }
    }

    public class ApasareButon7 implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (flag) {
                choice7.setText("X");
                flag = false;
            } else {
                choice7.setText("0");
                flag = true;
            }
            if(checkResult().equals("X")){
                resultWindow("Congrats!\nX Won");
            }else if(checkResult().equals("0")){
                resultWindow("Congrats!\n0 Won");
            }
            else if(checkResult().equals("") && allBoxesCompleted()){
                resultWindow("Draw");
            }
        }
    }

    public class ApasareButon8 implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (flag) {
                choice8.setText("X");
                flag = false;
            } else {
                choice8.setText("0");
                flag = true;
            }
            if(checkResult().equals("X")){
                resultWindow("Congrats!\nX Won");
            }else if(checkResult().equals("0")){
                resultWindow("Congrats!\n0 Won");
            }
            else if(checkResult().equals("") && allBoxesCompleted()){
                resultWindow("Draw");
            }
        }
    }

    public class ApasareButon9 implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (flag) {
                choice9.setText("X");
                flag = false;
            } else {
                choice9.setText("0");
                flag = true;
            }
            if(checkResult().equals("X")){
                resultWindow("Congrats!\nX Won");
            }else if(checkResult().equals("0")){
                resultWindow("Congrats!\n0 Won");
            }
            else if(checkResult().equals("") && allBoxesCompleted()){
                resultWindow("Draw");
            }
        }
    }




    public String checkResult() {
        String[][] matrix = new String[3][3];
        int a = 1;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3 ; j++) {
                switch (a) {
                    case 1:
                        matrix[i][j] = choice1.getText();
                        break;
                    case 2:
                        matrix[i][j] = choice2.getText();
                        break;
                    case 3:
                        matrix[i][j] = choice3.getText();
                        break;
                    case 4:
                        matrix[i][j] = choice4.getText();
                        break;
                    case 5:
                        matrix[i][j] = choice5.getText();
                        break;
                    case 6:
                        matrix[i][j] = choice6.getText();
                        break;
                    case 7:
                        matrix[i][j] = choice7.getText();
                        break;
                    case 8:
                        matrix[i][j] = choice8.getText();
                        break;
                    case 9:
                        matrix[i][j] = choice9.getText();
                        break;
                }
                a++;
            }
        }
        //check for rows
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3 - 1; j++) {
                if (!(matrix[i][j].equals(matrix[i][j + 1]))) {
                    break;
                }
                if (j == 3 - 2 && !matrix[i][j].equals("")) {
                    return matrix[i][j];
                }
            }
        }

        //check for col
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3 - 1; j++) {
                if (!(matrix[j][i].equals(matrix[j + 1][i]))) {
                    break;
                }
                if (j == 3 - 2 && !matrix[j][i].equals("")) {
                    return matrix[j][i];
                }
            }
        }

        //check for diag
        if (matrix[0][0].equals(matrix[1][1]) && matrix[1][1].equals(matrix[2][2]) && !matrix[0][0].equals(""))
            return matrix[0][0];
        if (matrix[0][2].equals(matrix[1][1]) && matrix[0][2].equals(matrix[2][0]) && !matrix[0][2].equals(""))
            return matrix[0][2];


        return "";
    }

    public boolean allBoxesCompleted() {
        String[][] matrix = new String[3][3];
        int a = 1;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3 ; j++) {
                switch (a) {
                    case 1:
                        matrix[i][j] = choice1.getText();
                        break;
                    case 2:
                        matrix[i][j] = choice2.getText();
                        break;
                    case 3:
                        matrix[i][j] = choice3.getText();
                        break;
                    case 4:
                        matrix[i][j] = choice4.getText();
                        break;
                    case 5:
                        matrix[i][j] = choice5.getText();
                        break;
                    case 6:
                        matrix[i][j] = choice6.getText();
                        break;
                    case 7:
                        matrix[i][j] = choice7.getText();
                        break;
                    case 8:
                        matrix[i][j] = choice8.getText();
                        break;
                    case 9:
                        matrix[i][j] = choice9.getText();
                        break;
                }
                a++;
            }
        }
        for (int i = 0; i <  3; i++) {
            for (int j = 0; j <  3; j++) {
                if (matrix[i][j].equals(""))
                    return false;
            }
        }
        return true;
    }


    public static void main(String[] args) {
        new Game();
    }
}
