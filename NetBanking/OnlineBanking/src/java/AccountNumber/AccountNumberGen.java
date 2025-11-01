package AccountNumber;
import java.util.*;

public class AccountNumberGen 
{
    private static Set<String> data = new HashSet<>(); // Simulated database

    public String generateUniqueAccountNumber() 
    {
        String accountNumber;
        do {
            accountNumber = "6801" + (int)(Math.random() * 1_000_000_000); // Generate a random account number
        } while (data.contains(accountNumber)); // Ensure it's not already in the database

        data.add(accountNumber); // Add to database
        return accountNumber;
    }

    public String demo() 
    {
        String accountNumber = generateUniqueAccountNumber();
        return accountNumber;
    }

    public static void main(String[] args) 
    {
        AccountNumberGen dm = new AccountNumberGen();
        dm.demo();
    }
}
 