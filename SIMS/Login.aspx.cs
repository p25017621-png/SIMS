using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SIMS
{
    public partial class Login : System.Web.UI.Page
    {
        // Database Connection String
        private readonly string cs = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Set up variables to hold state outside the database reader scope
            bool isAuthenticated = false;
            string targetRole = string.Empty;
            string userEmail = string.Empty;
            string userID = string.Empty;

            string query = "SELECT userID, email, role FROM Users WHERE email=@email AND password=@password";

            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@password", txtPassword.Text.Trim());

                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            isAuthenticated = true;
                            userID = reader["userID"].ToString();
                            userEmail = reader["email"].ToString();
                            targetRole = reader["role"].ToString();
                        }
                    }
                }
            }

            if (isAuthenticated)
            {
                Session["userID"] = userID;
                Session["email"] = userEmail;
                Session["role"] = targetRole;

                if (targetRole == "Admin")
                {
                    Response.Redirect("Admin/AdminDashboard.aspx");
                }
                else if (targetRole == "Lecturer")
                {
                    Response.Redirect("Lecturer/LecturerDashboard.aspx");
                }
                else if (targetRole == "Student")
                {
                    Response.Redirect("Student/StudentDashboard.aspx");
                }
                else
                {
                    lblMessage.Text = "Account role not recognized.";
                }
            }
            else
            {
                lblMessage.Text = "Invalid Email or Password";
            }
        }
    }
}