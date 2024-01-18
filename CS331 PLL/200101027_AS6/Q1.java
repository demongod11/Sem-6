import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;

public class Q1 extends JFrame implements ActionListener{
    JFrame frame;
    JLabel nameLabel, dobLabel, genderLabel, emailLabel, passwordLabel, mobileLabel, branchLabel, mathLabel, physicsLabel, chemistryLabel, percentageLabel;
    JTextField nameField, dobField, emailField, passwordField, mobileField, mathField, physicsField, chemistryField, percentageField;
    JRadioButton male, female;
    ButtonGroup genderGroup;
    JComboBox<String> branchField;
    JButton calculateButton, registerButton;
    Container panel;
    
    public Q1() {
        // create a new JFrame
        frame = new JFrame("Registration Desk");
        panel = getContentPane();
        panel.setLayout(null);
        // create labels for each field
        nameLabel = new JLabel("Name:");
        nameLabel.setBounds(20, 20, 120, 20);
        dobLabel = new JLabel("Date of Birth:");
        dobLabel.setBounds(20, 50, 120, 20);
        genderLabel = new JLabel("Gender:");
        genderLabel.setBounds(20, 80, 150, 20);
        emailLabel = new JLabel("Email:");
        emailLabel.setBounds(20, 110, 150, 20);
        passwordLabel = new JLabel("Password:");
        passwordLabel.setBounds(20, 140, 150, 20);
        mobileLabel = new JLabel("Mobile No.:");
        mobileLabel.setBounds(20, 170, 150, 20);
        branchLabel = new JLabel("Desired Branch:");
        branchLabel.setBounds(20, 200, 100, 20);
        mathLabel = new JLabel("Maths Marks:");
        mathLabel.setBounds(20, 230, 100, 20);
        physicsLabel = new JLabel("Physics Marks:");
        physicsLabel.setBounds(20, 260, 100, 20);
        chemistryLabel = new JLabel("Chemistry Marks:");
        chemistryLabel.setBounds(20, 290, 150, 20);
        percentageLabel = new JLabel("Percentage:");
        percentageLabel.setBounds(20, 320, 150, 20);

        // create text fields for each input
        nameField = new JTextField();
        nameField.setBounds(160, 20, 160, 20);
        dobField = new JTextField();
        dobField.setBounds(160, 50, 160, 20);
        emailField = new JTextField();
        emailField.setBounds(160, 110, 160, 20);
        passwordField = new JPasswordField();
        passwordField.setBounds(160, 140, 160, 20);
        mobileField = new JTextField();
        mobileField.setBounds(160, 170, 160, 20);
        mathField = new JTextField();
        mathField.setBounds(160, 230, 160, 20);
        physicsField = new JTextField();
        physicsField.setBounds(160, 260, 160, 20);
        chemistryField = new JTextField();
        chemistryField.setBounds(160, 290, 160, 20);
        percentageField = new JTextField();
        percentageField.setBounds(160, 320, 160, 20);
        percentageField.setEditable(false);

        // create radio buttons for gender input
        male = new JRadioButton("Male");
        male.setBounds(160, 80, 80, 20);
        female = new JRadioButton("Female");
        female.setBounds(240, 80, 80, 20);
        genderGroup = new ButtonGroup();
        genderGroup.add(male);
        genderGroup.add(female);

        // create drop-down menu for branch selection
        String[] branches = {"CSE", "ME", "EEE", "ET", "CE"};
        branchField = new JComboBox<>(branches);
        branchField.setBounds(160, 200, 160, 20);

        // create button for calculating percentage
        calculateButton = new JButton("Calculate Percentage");
        calculateButton.setBounds(330,320,180,20);
        calculateButton.addActionListener(this);

        // create button for registering the user
        registerButton = new JButton("Register");
        registerButton.setBounds(180, 380, 160, 30);
        registerButton.addActionListener(this);

        // create a panel to hold all the components
        // JPanel panel = new JPanel(new GridLayout(12, 2));

        panel.add(nameLabel);
        panel.add(nameField);
        panel.add(dobLabel);
        panel.add(dobField);
        panel.add(genderLabel);
        panel.add(male);
        panel.add(new JLabel());
        panel.add(female);
        panel.add(emailLabel);
        panel.add(emailField);
        panel.add(passwordLabel);
        panel.add(passwordField);
        panel.add(mobileLabel);
        panel.add(mobileField);
        panel.add(branchLabel);
        panel.add(branchField);
        panel.add(mathLabel);
        panel.add(mathField);
        panel.add(physicsLabel);
        panel.add(physicsField);
        panel.add(chemistryLabel);
        panel.add(chemistryField);
        panel.add(calculateButton);
        panel.add(percentageLabel);
        panel.add(percentageField);
        panel.add(registerButton);

        // add the panel to the frame
        frame.add(panel);

        // set frame properties
        frame.setSize(550, 500);
        frame.setVisible(true);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
    // ActionListener implementation for the calculateButton and registerButton
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == calculateButton) {
            // Getting the marks for math, physics, and chemistry
            int mathMarks = Integer.parseInt(mathField.getText());
            int physicsMarks = Integer.parseInt(physicsField.getText());
            int chemistryMarks = Integer.parseInt(chemistryField.getText());

            // Calculating the percentage and displaying it in the percentageField
            double percentage = (mathMarks + physicsMarks + chemistryMarks) / 3.0;
            percentageField.setText(Double.toString(percentage));
        } else if (e.getSource() == registerButton) {
            // Getting all the values from the text fields and combo box
            String name = nameField.getText();
            String dob = dobField.getText();
            String gender = male.isSelected() ? "Male" : "Female";
            String email = emailField.getText();
            String password = passwordField.getText();
            String mobileNumber = mobileField.getText();
            String branch = (String) branchField.getSelectedItem();
            String mathMarks = mathField.getText();
            String physicsMarks = physicsField.getText();
            String chemistryMarks = chemistryField.getText();
            String percentage = percentageField.getText();

            try {
                File file = new File("Database.txt");
                if (!file.exists()) {
                    file.createNewFile();
                }
                
                BufferedWriter writer = new BufferedWriter(new FileWriter(file, true));
                BufferedReader reader = new BufferedReader(new FileReader(file));
                String line;
                int lineNumber = 1;
                
                while ((line = reader.readLine()) != null) {
                    lineNumber++;
                }
                
                writer.write(lineNumber + " | " + name + " | " + dob + " | " + gender + " | " + email + " | " + password + " | " + mobileNumber + " | " + branch + " | " + mathMarks + " | " + physicsMarks + " | " + chemistryMarks + " | " + percentage + " | \n");
                writer.close();
                
                // Displaying the success message
                JOptionPane.showMessageDialog(frame, "Registration Successful !!");

                // Clearing all the text fields
                nameField.setText("");
                dobField.setText("");
                emailField.setText("");
                passwordField.setText("");
                mobileField.setText("");
                mathField.setText("");
                physicsField.setText("");
                chemistryField.setText("");
                percentageField.setText("");
                branchField.setSelectedIndex(0);
                male.setSelected(true);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
    
    public static void main(String[] args) {
        new Q1();
    }
}