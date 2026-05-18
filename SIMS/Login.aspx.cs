using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SIMS
{
    public partial class Login : System.Web.UI.Page
    {
        // Database Connection String
        string cs = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Create SQL Connection
            SqlConnection con = new SqlConnection(cs);

            // SQL Query
            string query = "SELECT * FROM Users WHERE email=@email AND password=@password";

            // SQL Command
            SqlCommand cmd = new SqlCommand(query, con);

            // Parameters
            cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@password", txtPassword.Text.Trim());

            // Open Connection
            con.Open();

            // Execute Reader
            SqlDataReader reader = cmd.ExecuteReader();

            // Check Login
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    string role = reader["role"].ToString();

                    // Store Session
                    Session["email"] = reader["email"].ToString();
                    Session["role"] = role;

                    // Redirect Based On Role
                    if (role == "Admin")
                    {
                        Response.Redirect("Admin/AdminDashboard.aspx");
                    }
                    else if (role == "Lecturer")
                    {
                        Response.Redirect("Lecturer/LecturerDashboard.aspx");
                    }
                    else if (role == "Student")
                    {
                        Response.Redirect("Student/StudentDashboard.aspx");
                    }
                }
            }
            else
            {
                lblMessage.Text = "Invalid Email or Password";
            }

            // Close Connection
            con.Close();
        }
    }
}