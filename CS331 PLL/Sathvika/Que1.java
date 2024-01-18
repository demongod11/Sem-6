import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;

public class Que1 extends JFrame implements ActionListener {
    
    // Declare the form components
    JFrame frame;
    JLabel nameLabel, dobLabel, genderLabel, emailLabel, passwordLabel, mobileNoLabel, branchLabel, mathLabel, physicsLabel, chemistryLabel, percentageLabel;
    JTextField nameTextField, dobTextField, emailTextField, passwordTextField, mobileNoTextField, mathTextField, physicsTextField, chemistryTextField, percentageTextField;
    JRadioButton maleRadioButton, femaleRadioButton;
    ButtonGroup genderButtonGroup;
    JComboBox<String> branchComboBox;
    JButton calculateButton, registerButton;
    
    public Que1() {
        
        // Set the title of the JFrame
        super("Registration Desk");
        
        // Create the form components
        nameLabel = new JLabel("Name:");
        dobLabel = new JLabel("DOB (dd/mm/yyyy):");
        genderLabel = new JLabel("Gender:");
        emailLabel = new JLabel("Email:");
        passwordLabel = new JLabel("Password:");
        mobileNoLabel = new JLabel("Mobile No.:");
        branchLabel = new JLabel("Desired Branch:");
        mathLabel = new JLabel("Math Marks:");
        physicsLabel = new JLabel("Physics Marks:");
        chemistryLabel = new JLabel("Chemistry Marks:");
        percentageLabel = new JLabel("Percentage:");
        
        nameTextField = new JTextField();
        dobTextField = new JTextField();
        emailTextField = new JTextField();
        passwordTextField = new JTextField();
        mobileNoTextField = new JTextField();
        mathTextField = new JTextField();
        physicsTextField = new JTextField();
        chemistryTextField = new JTextField();
        percentageTextField = new JTextField();
        percentageTextField.setEditable(false);
        
        maleRadioButton = new JRadioButton("Male");
        femaleRadioButton = new JRadioButton("Female");
        genderButtonGroup = new ButtonGroup();
        genderButtonGroup.add(maleRadioButton);
        genderButtonGroup.add(femaleRadioButton);
        
        String[] branches = {"CSE", "ME", "EEE", "ET", "CE"};
        branchComboBox = new JComboBox<>(branches);
        
        calculateButton = new JButton("Calculate");
        registerButton = new JButton("Register");
        
        // Set the layout of the JFrame
        setLayout(new GridLayout(13, 2));
        
        // Add the form components to the JFrame
        add(nameLabel);
        add(nameTextField);
        add(dobLabel);
        add(dobTextField);
        add(genderLabel);
        add(maleRadioButton);
        add(new JLabel(""));
        add(femaleRadioButton);
        add(emailLabel);
        add(emailTextField);
        add(passwordLabel);
        add(passwordTextField);
        add(mobileNoLabel);
        add(mobileNoTextField);
        add(branchLabel);
        add(branchComboBox);
        add(mathLabel);
        add(mathTextField);
        add(physicsLabel);
        add(physicsTextField);
        add(chemistryLabel);
        add(chemistryTextField);
        add(new JLabel(""));
        add(calculateButton);
        add(percentageLabel);
        add(percentageTextField);
        add(registerButton);
        
        // Add action listeners to the buttons
        calculateButton.addActionListener(this);
        registerButton.addActionListener(this);
        
        // Set the size and visibility of the JFrame
        setSize(400, 500);
        setVisible(true);
    }
    
    public void actionPerformed(ActionEvent event) {
        if (event.getSource() == calculateButton) {
            // Calculate the percentage and display it in the percentage text field
            int mathMarks = Integer.parseInt(mathTextField.getText());
            int physicsMarks = Integer.parseInt(physicsTextField.getText());
            int chemistryMarks = Integer.parseInt(chemistryTextField.getText());
            // Calculating the percentage and displaying it in the percentageField
            double percentage = (mathMarks + physicsMarks + chemistryMarks) / 3.0;
            percentageLabel.setText(Double.toString(percentage));
        } else if (event.getSource() == registerButton) {
            // Getting all the values from the text fields and combo box
            String name = nameLabel.getText();
            String dob = dobLabel.getText();
            String gender = maleRadioButton.isSelected() ? "Male" : "Female";
            String email = emailLabel.getText();
            String password = passwordLabel.getText();
            String mobileNumber = mobileNoLabel.getText();
            String branch = (String) branchComboBox.getSelectedItem();
            String mathMarks = mathLabel.getText();
            String physicsMarks = physicsLabel.getText();
            String chemistryMarks = chemistryLabel.getText();
            String percentage = percentageLabel.getText();

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
                nameLabel.setText("");
                dobLabel.setText("");
                emailLabel.setText("");
                passwordLabel.setText("");
                mobileNoLabel.setText("");
                mathLabel.setText("");
                physicsLabel.setText("");
                chemistryLabel.setText("");
                percentageLabel.setText("");
                branchComboBox.setSelectedIndex(0);
                maleRadioButton.setSelected(true);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
    
    public static void main(String[] args) {
        new Que1();
    }
}