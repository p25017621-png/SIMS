using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SIMS
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            // Check Password Match
            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            SqlConnection con = new SqlConnection(cs);

            string query = "UPDATE Users SET password=@password WHERE email=@email";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@password", txtNewPassword.Text.Trim());

            con.Open();

            int rows = cmd.ExecuteNonQuery();

            con.Close();

            if (rows > 0)
            {
                lblMessage.ForeColor = System.Drawing.Color.LimeGreen;
                lblMessage.Text = "Password updated successfully.";
            }
            else
            {
                lblMessage.Text = "Email not found.";
            }
        }
    }
}