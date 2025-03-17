using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Windows.Forms;

namespace project_ii_v3.Controller
{ 
    public class DatabaseController
    {
        //string-ul difera in functie de calculatorul pe care e programul
        private static string conString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=D:\Facultate\An3\sem2\Informatica industriala\Project-industrial-informatics\Model\Database1.mdf;Integrated Security = True";
        private static SqlConnection connection=new SqlConnection(conString);
        private static DataSet getAllUsers()
        {
            DataSet users=null;
            try
            {
                connection.Open();
                SqlDataAdapter daUsers = new SqlDataAdapter("Select * from Users", connection);
                users = new DataSet();
                daUsers.Fill(users, "Users");
            }catch(Exception e)
            {
            }
            finally { connection.Close(); }
            return users;
        }

        public static void addCurrentCar(string carName, string userName)
        {
            int carId = getItemID(carName);
            int userID = getUserID(userName);
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("INSERT INTO CurrentCar (user_id, CurrentItemID) VALUES (@userID, @itemID)", connection);
                command.Parameters.AddWithValue("@userID", userID);
                command.Parameters.AddWithValue("@itemID", carId);
                command.ExecuteNonQuery();
            }
            catch (Exception e) { }
            finally
            {
                connection.Close();
            }
        }

        public static void changeCurrentCar(string carName, string userName)
        {
            int carId = getItemID(carName);
            int userID = getUserID(userName);
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("UPDATE CurrentCar SET CurrentItemID = @itemID WHERE user_id = @userID", connection);
                command.Parameters.AddWithValue("@userID", userID);
                command.Parameters.AddWithValue("@itemID", carId);
                command.ExecuteNonQuery();
            } catch (Exception e) {
                MessageBox.Show(e.Message + "\n carId: " + carId + "\nuserId: " + userID, "CHANGE CAR ERROR");
            }
            finally
            {
                connection.Close();
            }
        }

        public static void getCurrentCar(string userName, PictureBox box)
        {
            int userID = getUserID(userName);
            int carID = -1;
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT CurrentItemID FROM CurrentCar WHERE user_id = @userID", connection);
                command.Parameters.AddWithValue("@userID", userID);
                SqlDataReader reader = command.ExecuteReader();
                reader.Read();
                carID = Convert.ToInt32(reader[0].ToString());
            } catch(Exception e) {  }
            finally
            {
                connection.Close();
                if(carID != -1)
                getItemPhoto2D(carID, box);
            }
        }

        public static List<int> getUsersId()
        {
            DataSet users = getAllUsers();
            List<int> idList = new List<int>();
            foreach(DataRow row in users.Tables["Users"].Rows)
            {
                idList.Add(Convert.ToInt32(row.ItemArray.GetValue(0)));
            }
            return idList;
        }

        public static List<string> getUsersName()
        {
            DataSet users = getAllUsers();
            List<string> nameUsers = null;
            if (users != null)
            {
                nameUsers= new List<string>();
                foreach (DataRow row in users.Tables["Users"].Rows)
                {
                    nameUsers.Add(row.ItemArray.GetValue(1).ToString());
                }
            }
            return nameUsers;
        }

        public static void saveMoney(int userID, int money)
        {
            try
            {
                //TODO: UPDATE, when user created add 0 money to the table.
                connection.Open();
                SqlCommand command = new SqlCommand("INSERT INTO UserCurrency (id_user,money) VALUES (@id, @bani)", connection);
                command.Parameters.AddWithValue("@id", userID);
                command.Parameters.AddWithValue("@bani", money);
                command.ExecuteNonQuery();
            } catch(Exception ignored)
            {
                Debug.Write("User id " + userID);
                MessageBox.Show(ignored.Message, "INSERT MONEY EXCEPTION");
            }
            finally
            {
                connection.Close();
            }
        }

        public static void getItemPhoto3D(string itemName, PictureBox box) //reading the file into a pictureBox
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT ItemPicture3D FROM Items WHERE Name = @name", connection);
                command.Parameters.AddWithValue("@name", itemName);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataSet dataSet = new DataSet();
                adapter.Fill(dataSet);

                if(dataSet.Tables[0].Rows.Count == 1)
                {
                    Byte[] data = new Byte[0];
                    data = (Byte[])(dataSet.Tables[0].Rows[0]["ItemPicture3D"]);
                    MemoryStream memoryStream = new MemoryStream(data);
                    box.Image = Image.FromStream(memoryStream);
                    box.SizeMode = PictureBoxSizeMode.Zoom;
                }
            } catch(Exception ex)
            {
                MessageBox.Show(ex.Message,"GET ITEM PHOTO ERROR");
            } finally
            {
                connection.Close();
            }
        }

        public static void getItemPhoto2D(int itemID, PictureBox box) //reading the file into a pictureBox
        {
            
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT ItemPicture2D FROM Items WHERE Id = @ID", connection);
                command.Parameters.AddWithValue("@ID", itemID);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataSet dataSet = new DataSet();
                adapter.Fill(dataSet);

                if (dataSet.Tables[0].Rows.Count == 1)
                {
                    Byte[] data = new Byte[0];
                    data = (Byte[])(dataSet.Tables[0].Rows[0]["ItemPicture2D"]);
                    MemoryStream memoryStream = new MemoryStream(data);
                    box.Image = Image.FromStream(memoryStream);
                    box.SizeMode = PictureBoxSizeMode.Zoom;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "GET ITEM 2D PHOTO ERROR");
            }
            finally
            {
                connection.Close();
            }
        }

        public static void incarcaImagini()
        {
            byte[] duster = File.ReadAllBytes(@"C:\ii_proiect\Resources\duster.png");
            byte[] dokker = File.ReadAllBytes(@"C:\ii_proiect\Resources\dokker.png");
            byte[] bigster = File.ReadAllBytes(@"C:\ii_proiect\Resources\bigster.png");
            byte[] politie = File.ReadAllBytes(@"C:\ii_proiect\Resources\politie.png");
            byte[] trabant = File.ReadAllBytes(@"C:\ii_proiect\Resources\trabant.png");
            byte[] dacia = File.ReadAllBytes(@"C:\ii_proiect\Resources\dacia.png");

            byte[] duster2D = File.ReadAllBytes(@"C:\ii_proiect\Resources\duster2D.png");
            byte[] dokker2D = File.ReadAllBytes(@"C:\ii_proiect\Resources\dokker2D.png");
            byte[] bigster2D = File.ReadAllBytes(@"C:\ii_proiect\Resources\bigster2D.png");
            byte[] politie2D = File.ReadAllBytes(@"C:\ii_proiect\Resources\politie2D.png");
            byte[] trabant2D = File.ReadAllBytes(@"C:\ii_proiect\Resources\trabant2D.png");
            byte[] dacia2D = File.ReadAllBytes(@"C:\ii_proiect\Resources\dacia2D.png");

            try
            {
                connection.Open();
                SqlCommand sql = new SqlCommand("INSERT INTO Items  (Name, ItemPrice, ItemPicture3D, ItemPicture2D) VALUES (@name, @price, @pict3d, @pict2d)", connection);
                sql.Parameters.AddWithValue("@name", "Dacia 1310");
                sql.Parameters.AddWithValue("@price", 0);
                sql.Parameters.AddWithValue("@pict3d", dacia);
                sql.Parameters.AddWithValue("@pict2d", dacia2D);
                sql.ExecuteNonQuery();
                MessageBox.Show("SUCCESS");
            } catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "ERROR");
            }
            finally
            {
                connection.Close();
            }
        }

        public static List<string> getItems(string userN)
        {
            int userID = getUserID(userN);
            List<int> items = new List<int>();
            List<string> itemNames = new List<string>();
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT id_item FROM UsersItems WHERE id_user = @id", connection);
                command.Parameters.AddWithValue("@id", userID);
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    items.Add(Convert.ToInt32(reader[0].ToString()));
                }
                reader.Close();
                reader = null;
                command = new SqlCommand("SELECT Name FROM Items WHERE Id = @itemID", connection);
                foreach (int itemID in items)
                {
                    command.Parameters.AddWithValue("@itemID", itemID);
                    reader = command.ExecuteReader();
                    reader.Read();
                    itemNames.Add(reader[0].ToString());
                    command.Parameters.Clear();
                    reader.Close();
                    reader = null;
                }
            } catch(Exception ignored) {
                MessageBox.Show(ignored.Message, "getItems EXCEPTION");
            }
            finally
            {
                connection.Close ();
            }

            return itemNames;
        }

        public static int getMoney(string userName)
        {
            int userID = getUserID(userName);
            int money = -1;
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT money FROM UserCurrency WHERE id_user = @id", connection);
                command.Parameters.AddWithValue("@id", userID);
                SqlDataReader reader = command.ExecuteReader();
                reader.Read();
                money = Convert.ToInt32(reader[0].ToString());
            } catch(Exception ignored) {
                Debug.WriteLine(ignored.ToString());
            }
            finally
            {
                connection.Close();
            }
            return money;
        }

        public static void modifyMoney(string userName, int money)
        {
            int userID = getUserID(userName);
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("UPDATE UserCurrency SET money = @money WHERE id_user = @id", connection);
                command.Parameters.AddWithValue("@money", money);
                command.Parameters.AddWithValue("@id", userID);
                command.ExecuteNonQuery();
                Debug.Write("MONEY ADDED TO DATABASE");
            } catch(Exception ex) {
                MessageBox.Show(ex.Message, "modifyMoney exception");
            } finally
            {
                connection.Close();
            }
        }

        public static bool buyItem(string userN, string itemName)
        {
            int userID = getUserID(userN);
            int itemID = getItemID(itemName);
            int userMoney = getMoney(userN);
            int itemPrice = getItemPrice(itemName);
            bool reusit = false;

            if (userMoney < itemPrice)
            {
                MessageBox.Show("You don't have enough money to buy this item.");
                return false;
            }
            else
            {
                try
                {
                    modifyMoney(userN, userMoney - itemPrice);
                    connection.Open();
                    SqlCommand command = new SqlCommand("INSERT INTO UsersItems(id_item, id_user) VALUES (@item, @user)", connection);
                    command.Parameters.AddWithValue("@item", itemID);
                    command.Parameters.AddWithValue("@user", userID);
                    command.ExecuteNonQuery();
                    reusit = true;
                }
                catch (Exception ignored) { }
                finally
                {
                    connection.Close();
                }
                return reusit;
            }
        }

        private static int getItemID(string itemName)
        {
            int itemID = -1;
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT Id FROM Items WHERE Name = @name", connection);
                command.Parameters.AddWithValue("@name", itemName);
                SqlDataReader reader = command.ExecuteReader();
                reader.Read();
                itemID = Convert.ToInt32(reader[0].ToString());
            } catch(Exception ignored) { } finally
            {
                connection.Close();
            }

            return itemID;
        }

        public static int getItemPrice(string itemName)
        {
            int itemID = getItemID(itemName);
            int price = -1;
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT ItemPrice FROM Items WHERE Id = @id", connection);
                command.Parameters.AddWithValue("@id", itemID);
                SqlDataReader reader = command.ExecuteReader();
                reader.Read();
                price = Convert.ToInt32(reader[0].ToString());
            } catch (Exception ignored) { }
            finally
            {
                connection.Close();
            }
            return price;
        }

        public static int getUserID(string userN)
        {
            int userID;
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT Id FROM Users WHERE Username = @username", connection);
                command.Parameters.AddWithValue("@username", userN);
                SqlDataReader reader = command.ExecuteReader();
                reader.Read();
                userID = Convert.ToInt32(reader[0]);
            } catch (Exception ex)
            {
                userID = -2;
            } finally
            {
                connection.Close();
            }
            return userID;
        }

        public static void addScore(int userID, string userName, int score) {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("INSERT INTO Scores(id_user, Name, Score) VALUES (@userID, @userN, @score)", connection);
                command.Parameters.AddWithValue("@userID", userID);
                command.Parameters.AddWithValue("@userN", userName);
                command.Parameters.AddWithValue("@score", score);
                command.ExecuteNonQuery();
            } catch (Exception ignored) { }
            finally
            {
                connection.Close ();
            }
        }

        public static List<string> getScoreBoard()
        {
            List<string> list = new List<string>();
            try
            {
                connection.Open ();
                SqlCommand command = new SqlCommand("SELECT Name, Score FROM Scores ORDER BY Score DESC", connection);
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    list.Add(reader[0].ToString());
                    list.Add(reader[1].ToString());
                }
            } catch (Exception ex) {
                list = null;
            }
            finally
            {
                connection.Close () ;
            }
            return list;
        }

        public static List<string> getScores()
        {
            List<string> scores = null;

            return scores;
        }

        public static List<string> getUsersPassword()
        {
            DataSet users = getAllUsers();
            List<string> passUsers = new List<string>();
            foreach (DataRow row in users.Tables["Users"].Rows)
            {
                passUsers.Add(row.ItemArray.GetValue(2).ToString());
            }
            return passUsers;
        }

        public static void addItem(string userName, string itemName)
        {
            int userID = getUserID(userName);
            int itemID = getItemID(itemName);
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("INSERT INTO UsersItems (id_item, id_user) VALUES (@itemID, @userID)", connection);
                command.Parameters.AddWithValue("@itemID", itemID);
                command.Parameters.AddWithValue("@userID", userID);
                command.ExecuteNonQuery();
            }
            catch (Exception e)
            {
            }
            finally
            {
                connection.Close();
            }
        }

        public static void insertNewUser(string username,string password)
        {
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand("insert into Users(Username,Password) Values(@name,@password)", connection);
                command.Parameters.AddWithValue("@name", username);
                command.Parameters.AddWithValue("@password", password);
                command.ExecuteNonQuery();
            }
            catch (Exception e) { }
            finally { 
                connection.Close();
                addItem(username, "Dacia 1310"); //base car for all users
                addCurrentCar("Dacia 1310", username);
                int userID = getUserID(username);
                saveMoney(userID, 0);
            }
        }
        public static bool checkExistingUser(string userName)
        {
            bool test = false;
            List<string> names = getUsersName();
            if (names != null)
            {
                foreach (string name in names)
                {
                    if (name == userName) { test = true; break; }
                }
            }
            else { test = true; }
            return test;
        }
        public static bool checkExistingAccount(string userName,string password)
        {
            bool test = false;
            try
            {
                connection.Open();
                SqlDataAdapter da = new SqlDataAdapter("Select * from Users where Username=@name and Password=@password", connection);
                da.SelectCommand.Parameters.AddWithValue("@name", userName);
                da.SelectCommand.Parameters.AddWithValue("@password", password);
                DataSet users = new DataSet();
                int i =da.Fill(users, "Users");
                if (i == 1)
                {
                    test = true;
                }

            }catch(Exception e) { }
            finally { connection.Close(); }
            return test;
        }


    }
}