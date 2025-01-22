using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient; // For MariaDB/MySQL Connection

namespace WCEConsoleApp
{
    class Program
    {
        private static string connectionString = "Server=127.0.0.1;Database=wce;Uid=root;Pwd=;";
        private static bool isLoggedIn = false; // Tracks login state
        private static string currentUserFullName = ""; // Stores the logged-in user's full name
        private static int currentUserId = -1; // Stores the logged-in user's ID

        static void Main(string[] args)
        {
            Console.WriteLine("Welcome to WCE Console Application!");
            while (true)
            {
                Console.WriteLine("\nMenu:");
                Console.WriteLine("1. Register");
                Console.WriteLine("2. Login");
                if (isLoggedIn)
                {
                    Console.WriteLine("3. Create Event");
                    Console.WriteLine("4. View Events");
                    Console.WriteLine("5. View My Information");
                    Console.WriteLine("6. Logout");
                }
                Console.WriteLine("0. Exit");
                Console.Write("Select an option: ");

                try
                {
                    switch (Console.ReadLine())
                    {
                        case "1":
                            RegisterUser();
                            break;
                        case "2":
                            LoginUser();
                            break;
                        case "3":
                            if (isLoggedIn)
                                CreateEvent();
                            else
                                Console.WriteLine("You must log in first to create an event.");
                            break;
                        case "4":
                            if (isLoggedIn)
                                ViewEvents();
                            else
                                Console.WriteLine("You must log in first to view events.");
                            break;
                        case "5":
                            if (isLoggedIn)
                                ViewUserInfo();
                            else
                                Console.WriteLine("You must log in first to view your information.");
                            break;
                        case "6":
                            if (isLoggedIn)
                                LogoutUser();
                            else
                                Console.WriteLine("You are not logged in.");
                            break;
                        case "0":
                            Console.WriteLine("Goodbye!");
                            return;
                        default:
                            Console.WriteLine("Invalid option. Please try again.");
                            break;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"An error occurred: {ex.Message}");
                    Console.WriteLine("Press any key to return to the main menu...");
                    Console.ReadKey();
                }
            }
        }

        static void RegisterUser()
        {
            try
            {
                int residenceId = DisplayProvinces();

                Console.Write("Enter First Name: ");
                string firstName = Console.ReadLine();
                Console.Write("Enter Last Name: ");
                string lastName = Console.ReadLine();
                Console.Write("Enter Nickname: ");
                string nickname = Console.ReadLine();
                Console.Write("Enter Email: ");
                string email = Console.ReadLine();
                Console.Write("Enter Password: ");
                string plainTextPassword = Console.ReadLine();

                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(plainTextPassword).Replace("$2b$", "$2y$");

                using (var connection = new MySqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "INSERT INTO wce_utenti (nome, cognome, nickname, email, password, residenza) VALUES (@FirstName, @LastName, @Nickname, @Email, @Password, @Residence)";
                    using (var command = new MySqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@FirstName", firstName);
                        command.Parameters.AddWithValue("@LastName", lastName);
                        command.Parameters.AddWithValue("@Nickname", nickname);
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@Password", hashedPassword);
                        command.Parameters.AddWithValue("@Residence", residenceId);

                        command.ExecuteNonQuery();
                        Console.WriteLine("User registered successfully!");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to register user: {ex.Message}");
            }
        }


        static void LoginUser()
        {
            try
            {
                Console.Write("Enter Email: ");
                string email = Console.ReadLine();
                Console.Write("Enter Password: ");
                string password = Console.ReadLine();

                using (var connection = new MySqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT * FROM wce_utenti WHERE email = @Email";

                    using (var command = new MySqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Email", email);

                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string storedHashedPassword = reader["password"].ToString();

                                if (storedHashedPassword.StartsWith("$2y$"))
                                {
                                    storedHashedPassword = storedHashedPassword.Replace("$2y$", "$2b$");
                                }

                                if (BCrypt.Net.BCrypt.Verify(password, storedHashedPassword))
                                {
                                    currentUserFullName = $"{reader["nome"]} {reader["cognome"]}";
                                    currentUserId = Convert.ToInt32(reader["ID_user"]);
                                    isLoggedIn = true;
                                    Console.WriteLine($"Welcome, {currentUserFullName}!");
                                }
                                else
                                {
                                    Console.WriteLine("Invalid email or password.");
                                }
                            }
                            else
                            {
                                Console.WriteLine("Invalid email or password.");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to log in: {ex.Message}");
            }
        }



        static void LogoutUser()
        {
            isLoggedIn = false;
            currentUserFullName = "";
            currentUserId = -1;
            Console.WriteLine("You have been logged out.");
        }

        static void CreateEvent()
        {
            try
            {
                int locationId = DisplayProvinces();

                Console.Write("Enter Event Title: ");
                string title = Console.ReadLine();
                Console.Write("Enter Category ID: ");
                int categoryId = int.Parse(Console.ReadLine());
                Console.Write("Enter Date (YYYY-MM-DD): ");
                string date = Console.ReadLine();
                Console.Write("Enter Address: ");
                string address = Console.ReadLine();
                Console.Write("Enter Description: ");
                string description = Console.ReadLine();

                using (var connection = new MySqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "INSERT INTO wce_eventi (titolo, ID_categoria, ID_luogo, ID_user, data, indirizzo, descrizione, approvazione) VALUES (@Title, @CategoryId, @LocationId, @UserId, @Date, @Address, @Description, 0)";
                    using (var command = new MySqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Title", title);
                        command.Parameters.AddWithValue("@CategoryId", categoryId);
                        command.Parameters.AddWithValue("@LocationId", locationId);
                        command.Parameters.AddWithValue("@UserId", currentUserId);
                        command.Parameters.AddWithValue("@Date", date);
                        command.Parameters.AddWithValue("@Address", address);
                        command.Parameters.AddWithValue("@Description", description);

                        command.ExecuteNonQuery();
                        Console.WriteLine("Event created successfully! Awaiting approval.");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to create event: {ex.Message}");
            }
        }

        static void ViewEvents()
        {
            try
            {
                using (var connection = new MySqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT e.titolo, e.data, c.nome_cat, l.nome, e.descrizione FROM wce_eventi e JOIN wce_categoria c ON e.ID_categoria = c.ID_categoria JOIN wce_luogo l ON e.ID_luogo = l.ID_luogo WHERE e.approvazione = 1";
                    using (var command = new MySqlCommand(query, connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Console.WriteLine($"Title: {reader["titolo"]}, Date: {reader["data"]}, Category: {reader["nome_cat"]}, Location: {reader["nome"]}, Description: {reader["descrizione"]}");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to retrieve events: {ex.Message}");
            }
        }

        static void ViewUserInfo()
        {
            Console.WriteLine($"\nUser Information:");
            Console.WriteLine($"Name: {currentUserFullName}");
            Console.WriteLine($"User ID: {currentUserId}");
        }

        static int DisplayProvinces()
        {
            var provinces = new List<(int ID, string Name)>();

            try
            {
                using (var connection = new MySqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT ID_luogo, nome FROM wce_luogo";
                    using (var command = new MySqlCommand(query, connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                provinces.Add((Convert.ToInt32(reader["ID_luogo"]), reader["nome"].ToString()));
                            }
                        }
                    }
                }

                Console.WriteLine("\nAvailable Provinces:");
                for (int i = 0; i < provinces.Count; i++)
                {
                    Console.WriteLine($"{i + 1}. {provinces[i].Name} (ID: {provinces[i].ID})");
                }

                Console.Write("Select a province by number: ");
                int selectedIndex = int.Parse(Console.ReadLine()) - 1;

                if (selectedIndex >= 0 && selectedIndex < provinces.Count)
                {
                    return provinces[selectedIndex].ID;
                }
                else
                {
                    Console.WriteLine("Invalid selection. Try again.");
                    return DisplayProvinces();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to load provinces: {ex.Message}");
                return -1; // Default to an invalid ID
            }
        }
    }
}
