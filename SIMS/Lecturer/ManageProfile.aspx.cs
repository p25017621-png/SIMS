
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SIMS.Lecturer
{
    public partial class ManageProfile : Page
    {
        string connStr = System.Web.Configuration.WebConfigurationManager
                         .ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        private void LoadProfile()
        {
            // Sample data — replace with real DB query below
            txtFirstName.Text = "Ahmad";
            txtLastName.Text = "Lecturer";
            txtStaffID.Text = "LEC-2024-001";
            txtDepartment.Text = "Computer Science";
            txtEmail.Text = "lecturer@sims.edu";
            txtPhone.Text = "+60 12-345 6789";
            txtBio.Text = "Senior Lecturer in Computer Science.";

            // Real DB:
            // string lecturerID = Session["LecturerID"]?.ToString();
            // using (SqlConnection con = new SqlConnection(connStr))
            // {
            //     con.Open();
            //     string sql = "SELECT * FROM Lecturers WHERE LecturerID=@id";
            //     SqlCommand cmd = new SqlCommand(sql, con);
            //     cmd.Parameters.AddWithValue("@id", lecturerID);
            //     SqlDataReader dr = cmd.ExecuteReader();
            //     if (dr.Read())
            //     {
            //         txtFirstName.Text  = dr["FirstName"].ToString();
            //         txtLastName.Text   = dr["LastName"].ToString();
            //         txtStaffID.Text    = dr["StaffID"].ToString();
            //         txtDepartment.Text = dr["Department"].ToString();
            //         txtEmail.Text      = dr["Email"].ToString();
            //         txtPhone.Text      = dr["Phone"].ToString();
            //         txtBio.Text        = dr["Bio"].ToString();
            //     }
            // }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Validate passwords match
            if (!string.IsNullOrEmpty(txtPassword.Text))
            {
                if (txtPassword.Text != txtConfirmPassword.Text)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "err",
                        "alert('Passwords do not match!');", true);
                    return;
                }
            }

            try
            {
                // Real DB:
                // using (SqlConnection con = new SqlConnection(connStr))
                // {
                //     con.Open();
                //     string sql = @"UPDATE Lecturers SET
                //                    FirstName=@fn, LastName=@ln, Department=@dept,
                //                    Email=@email, Phone=@phone, Bio=@bio
                //                    WHERE LecturerID=@id";
                //     SqlCommand cmd = new SqlCommand(sql, con);
                //     cmd.Parameters.AddWithValue("@fn",    txtFirstName.Text);
                //     cmd.Parameters.AddWithValue("@ln",    txtLastName.Text);
                //     cmd.Parameters.AddWithValue("@dept",  txtDepartment.Text);
                //     cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                //     cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
                //     cmd.Parameters.AddWithValue("@bio",   txtBio.Text);
                //     cmd.Parameters.AddWithValue("@id",    Session["LecturerID"]);
                //     if (!string.IsNullOrEmpty(txtPassword.Text))
                //     {
                //         sql += ", Password=@pwd";
                //         cmd.Parameters.AddWithValue("@pwd", txtPassword.Text); // Hash in production!
                //     }
                //     cmd.ExecuteNonQuery();
                // }

                ClientScript.RegisterStartupScript(this.GetType(), "msg",
                    "alert('Profile updated successfully!');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "err",
                    "alert('Error: " + ex.Message + "');", true);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageProfile.aspx");
        }
    }
}
