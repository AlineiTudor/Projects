package ex3;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;

public class FileOpener extends JFrame {
    JTextField fileName;
    JButton b;
    public final JTextArea ta = new JTextArea(" ");

    public FileOpener() {
        this.setLayout(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        fileName = new JTextField();
        fileName.setBounds(300, 20, 350, 25);
        add(fileName);

        b = new JButton("Submit file name");
        b.setBounds(400, 50, 150, 25);
        add(b);
        b.addActionListener(new ApasareButon());

        ta.setEditable(false);
        JScrollPane scrollPane = new JScrollPane(ta, JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
        scrollPane.setBounds(100, 200, 800, 500);
        this.add(scrollPane);

        setSize(1000, 800);
        setVisible(true);

    }

    public class ApasareButon implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            try {
                ta.setBackground(Color.WHITE);
                ta.setText("");
                String fn = fileName.getText();
                BufferedReader a = new BufferedReader(new FileReader(fn));
                String s;
                s = a.readLine();
                while (s != null) {
                    ta.append(s+"\n");
                    s=a.readLine();
                }
            } catch (IOException exception) {
                ta.setText("");
                ta.setBackground(Color.RED);
                ta.append("File" + ta.getText() + " not found.\nTry another file or change file path.\n\n");
            }
        }
    }

    public static void main(String[] args) {
        new FileOpener();
    }
}
