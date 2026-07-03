using System;
using System.Configuration;
using System.Data.SqlClient;

namespace SIMS
{
    public partial class Students : System.Web.UI.Page
    {
        private string connString = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Protect page against unauthenticated access
            if (Session["userID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // Ensure profile reads occur only on initial load so user entries don't wipe out during postback execution
            if (!IsPostBack)
            {
                LoadStudentProfileData();
            }
        }

        private void LoadStudentProfileData()
        {
            int currentUserId = Convert.ToInt32(Session["userID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT u.name, u.email, s.phone, s.gender, s.dateOfBirth, s.address 
                    FROM Students s
                    INNER JOIN Users u ON s.userID = u.userID
                    WHERE s.userID = @UserID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", currentUserId);

                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Populate form controls with current records
                                txtName.Text = reader["name"].ToString();
                                txtEmail.Text = reader["email"].ToString();
                                txtPhone.Text = reader["phone"].ToString();
                                txtAddress.Text = reader["address"].ToString();

                                string databaseGender = reader["gender"].ToString();
                                if (ddlGender.Items.FindByValue(databaseGender) != null)
                                {
                                    ddlGender.SelectedValue = databaseGender;
                                }

                                if (reader["dateOfBirth"] != DBNull.Value)
                                {
                                    DateTime dob = Convert.ToDateTime(reader["dateOfBirth"]);
                                    txtDOB.Text = dob.ToString("yyyy-MM-dd"); // Standard binding format for HTML5 Date fields
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowMessage("❌ Error rendering profile fields: " + ex.Message, false);
                    }
                }
            }
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            int currentUserId = Convert.ToInt32(Session["userID"]);

            // Validate core identity requirements
            if (string.IsNullOrWhiteSpace(txtName.Text) || string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ShowMessage("⚠️ Name and Email are required for system records.", false);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlTransaction trans = conn.BeginTransaction();

                try
                {
                    // 1. Update Core User Info
                    string userSql = "UPDATE Users SET name = @Name, email = @Email WHERE userID = @UserID";
                    using (SqlCommand cmd = new SqlCommand(userSql, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@UserID", currentUserId);
                        cmd.ExecuteNonQuery();
                    }

                    // 2. Update Student Extended Profile
                    string studentSql = @"UPDATE Students SET phone = @Phone, gender = @Gender, 
                                 dateOfBirth = @DOB, address = @Address WHERE userID = @UserID";
                    using (SqlCommand cmd = new SqlCommand(studentSql, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@Phone", string.IsNullOrEmpty(txtPhone.Text) ? DBNull.Value : (object)txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@Gender", string.IsNullOrEmpty(ddlGender.SelectedValue) ? DBNull.Value : (object)ddlGender.SelectedValue);
                        cmd.Parameters.AddWithValue("@Address", string.IsNullOrEmpty(txtAddress.Text) ? DBNull.Value : (object)txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@UserID", currentUserId);
                        cmd.Parameters.AddWithValue("@DOB", string.IsNullOrEmpty(txtDOB.Text) ? DBNull.Value : (object)Convert.ToDateTime(txtDOB.Text));

                        cmd.ExecuteNonQuery();
                    }

                    trans.Commit();
                    ShowMessage("✨ Success! Your profile data has been updated.", true);
                    LoadStudentProfileData(); // Refresh to ensure UI shows stable state
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    ShowMessage("❌ Database transaction error: " + ex.Message, false);
                }
            }
        }

        /// <summary>
        /// Renders a modern contextual notification system inside our design structure.
        /// </summary>
        private void ShowMessage(string message, bool isSuccess)
        {
            lblStatusMessage.Text = message;
            lblStatusMessage.Visible = true;

            // Reset transitions dynamically so it re-triggers perfectly if clicked multiple times
            lblStatusMessage.Style["opacity"] = "1";
            lblStatusMessage.Style["display"] = "flex";

            if (isSuccess)
            {
                // Emerald Success Colors
                lblStatusMessage.Style["background"] = "#ecfdf5";
                lblStatusMessage.Style["color"] = "#065f46";
                lblStatusMessage.Style["border-color"] = "#a7f3d0";
                lblStatusMessage.Style["box-shadow"] = "0 4px 12px rgba(6, 95, 70, 0.05)";
            }
            else
            {
                // Rose Crimson Error Colors
                lblStatusMessage.Style["background"] = "#fee2e2";
                lblStatusMessage.Style["color"] = "#991b1b";
                lblStatusMessage.Style["border-color"] = "#fca5a5";
                lblStatusMessage.Style["box-shadow"] = "0 4px 12px rgba(153, 27, 27, 0.05)";
            }
        }

        // Handles the click event from your front-end LinkButton (OnClick="lnkSidebarLogout_Click")
        protected void lnkSidebarLogout_Click(object sender, EventArgs e)
        {
            // Clear backend session states safely
            Session.Clear();
            Session.Abandon();

            // Redirect back to login panel
            Response.Redirect("~/Login.aspx");
        }
    }
}