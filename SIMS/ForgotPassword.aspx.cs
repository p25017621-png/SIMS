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
            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Verify Email + Phone Number
                string verifyQuery = @"
                SELECT U.userID
                FROM Users U
                LEFT JOIN Students S ON U.userID = S.userID
                LEFT JOIN Lecturers L ON U.userID = L.userID
                WHERE U.email=@email
                AND (S.phone=@phone OR L.phone=@phone)";

                SqlCommand verifyCmd = new SqlCommand(verifyQuery, con);

                verifyCmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                verifyCmd.Parameters.AddWithValue("@phone", txtPhone.Text.Trim());

                object result = verifyCmd.ExecuteScalar();

                if (result == null)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Invalid email or phone number.";
                    return;
                }

                string updateQuery =
                    "UPDATE Users SET password=@password WHERE userID=@userID";

                SqlCommand updateCmd = new SqlCommand(updateQuery, con);

                updateCmd.Parameters.AddWithValue("@password",
                    txtNewPassword.Text.Trim());

                updateCmd.Parameters.AddWithValue("@userID",
                    Convert.ToInt32(result));

                int rows = updateCmd.ExecuteNonQuery();

                if (rows > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.LimeGreen;
                    lblMessage.Text = "Password updated successfully.";
                }
                else
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Password reset failed.";
                }
            }
        }
    }
}