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
        int lecturerID = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadProfile();
        }

        private void LoadProfile()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = @"SELECT u.name, u.email, u.password,
                                   l.phone, l.department, l.qualification
                                   FROM Lecturers l
                                   JOIN Users u ON l.userID = u.userID
                                   WHERE l.lecturerID = @lid";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@lid", lecturerID);
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        txtName.Text = dr["name"].ToString();
                        txtEmail.Text = dr["email"].ToString();
                        txtPhone.Text = dr["phone"].ToString();
                        txtDepartment.Text = dr["department"].ToString();
                        txtQualification.Text = dr["qualification"].ToString();
                        lblFullName.Text = dr["name"].ToString();
                        lblEmail.Text = dr["email"].ToString();
                        lblPhone.Text = dr["phone"].ToString();
                        lblDept.Text = dr["department"].ToString();
                        lblQual.Text = dr["qualification"].ToString();
                    }
                }
            }
            catch { }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    // Update Users table
                    string sqlU = "UPDATE Users SET name=@name, email=@email WHERE userID=(SELECT userID FROM Lecturers WHERE lecturerID=@lid)";
                    SqlCommand cmdU = new SqlCommand(sqlU, con);
                    cmdU.Parameters.AddWithValue("@name", txtName.Text.Trim());
                    cmdU.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                    cmdU.Parameters.AddWithValue("@lid", lecturerID);
                    cmdU.ExecuteNonQuery();

                    // Update password if provided
                    if (!string.IsNullOrEmpty(txtPassword.Text))
                    {
                        string sqlP = "UPDATE Users SET password=@pwd WHERE userID=(SELECT userID FROM Lecturers WHERE lecturerID=@lid)";
                        SqlCommand cmdP = new SqlCommand(sqlP, con);
                        cmdP.Parameters.AddWithValue("@pwd", txtPassword.Text);
                        cmdP.Parameters.AddWithValue("@lid", lecturerID);
                        cmdP.ExecuteNonQuery();
                    }

                    // Update Lecturers table
                    string sqlL = "UPDATE Lecturers SET phone=@phone, department=@dept, qualification=@qual WHERE lecturerID=@lid";
                    SqlCommand cmdL = new SqlCommand(sqlL, con);
                    cmdL.Parameters.AddWithValue("@phone", txtPhone.Text.Trim());
                    cmdL.Parameters.AddWithValue("@dept", txtDepartment.Text.Trim());
                    cmdL.Parameters.AddWithValue("@qual", txtQualification.Text.Trim());
                    cmdL.Parameters.AddWithValue("@lid", lecturerID);
                    cmdL.ExecuteNonQuery();
                }

                pnlSuccess.Visible = true;
                pnlError.Visible = false;
                LoadProfile();
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                pnlSuccess.Visible = false;
                lblError.Text = "Error: " + ex.Message;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageProfile.aspx");
        }
    }
}