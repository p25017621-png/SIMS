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
            lblMessage.Text = "";

            // ==========================
            // STEP 1 - EMPTY FIELD CHECK
            // ==========================

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Email is required.";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Registered phone number is required.";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtNewPassword.Text))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "New password is required.";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please confirm your new password.";
                return;
            }

            // ==========================
            // STEP 2 - PASSWORD MATCH
            // ==========================

            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // ====================================
                // STEP 3 - VERIFY EMAIL + PHONE NUMBER
                // ====================================

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
                    lblMessage.Text = "Invalid email or registered phone number.";
                    return;
                }

                // ====================================
                // STEP 4 - CHECK CURRENT PASSWORD
                // ====================================

                string currentPasswordQuery =
                    "SELECT password FROM Users WHERE userID=@userID";

                SqlCommand currentCmd = new SqlCommand(currentPasswordQuery, con);

                currentCmd.Parameters.AddWithValue("@userID", Convert.ToInt32(result));

                string currentPassword = currentCmd.ExecuteScalar().ToString();

                if (currentPassword == txtNewPassword.Text.Trim())
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "New password cannot be the same as the current password.";
                    return;
                }

                // ====================================
                // STEP 5 - UPDATE PASSWORD
                // ====================================

                string updateQuery =
                    "UPDATE Users SET password=@password WHERE userID=@userID";

                SqlCommand updateCmd = new SqlCommand(updateQuery, con);

                updateCmd.Parameters.AddWithValue("@password", txtNewPassword.Text.Trim());
                updateCmd.Parameters.AddWithValue("@userID", Convert.ToInt32(result));

                int rows = updateCmd.ExecuteNonQuery();

                if (rows > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.LimeGreen;
                    lblMessage.Text = "Password updated successfully.";

                    // Optional: Clear password fields
                    txtNewPassword.Text = "";
                    txtConfirmPassword.Text = "";
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