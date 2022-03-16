package ex3;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;
import java.io.FileWriter;

public class EncriptFile {
    public static void encriptFile(FileReader re, FileWriter wr) {
        try {
            Scanner scanner = new Scanner(re);
            while (scanner.hasNextLine()) {
                String s = scanner.nextLine();
                for (int i = 0; i <s.length(); i++) {
                    wr.write(s.charAt(i)<<1);
                }
                wr.write("\n");
            }
            re.close();
            wr.close();
        }
        catch(IOException e){
            System.out.println("Error has occured ");
            e.printStackTrace();
        }
    }
    public static void decriptFile(FileReader re, FileWriter wr) {
        try {
            Scanner scanner = new Scanner(re);
            while (scanner.hasNextLine()) {
                String s = scanner.nextLine();
                for (int i = 0; i <s.length(); i++) {
                    wr.write(s.charAt(i)>>1);
                }
                wr.write("\n");
            }
            re.close();
            wr.close();
        }
        catch(IOException e){
            System.out.println("Error has occured ");
            e.printStackTrace();
        }
    }
}
