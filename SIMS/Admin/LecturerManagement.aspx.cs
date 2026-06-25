using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SIMS.Admin
{
    public partial class LecturerManagement : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLecturers();
            }
        }

        private void LoadLecturers()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = @"SELECT l.lecturerID,
                                        u.name,
                                        u.email,
                                        l.department,
                                        l.qualification,
                                        l.phone
                                 FROM Lecturers l
                                 JOIN Users u
                                 ON l.userID = u.userID";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);

                DataTable dt = new DataTable();

                da.Fill(dt);

                gvLecturers.DataSource = dt;
                gvLecturers.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                string userQuery =
                    @"INSERT INTO Users(name,email,password,role)
                      VALUES(@name,@email,@password,'Lecturer');
                      SELECT SCOPE_IDENTITY();";

                SqlCommand userCmd = new SqlCommand(userQuery, conn);

                userCmd.Parameters.AddWithValue("@name", txtName.Text);
                userCmd.Parameters.AddWithValue("@email", txtEmail.Text);
                userCmd.Parameters.AddWithValue("@password", txtPassword.Text);

                int userID = Convert.ToInt32(userCmd.ExecuteScalar());

                string lecturerQuery =
                    @"INSERT INTO Lecturers(userID,department,qualification,phone)
                      VALUES(@userID,@department,@qualification,@phone)";

                SqlCommand lecturerCmd =
                    new SqlCommand(lecturerQuery, conn);

                lecturerCmd.Parameters.AddWithValue("@userID", userID);
                lecturerCmd.Parameters.AddWithValue("@department", txtDepartment.Text);
                lecturerCmd.Parameters.AddWithValue("@qualification", txtQualification.Text);
                lecturerCmd.Parameters.AddWithValue("@phone", txtPhone.Text);

                lecturerCmd.ExecuteNonQuery();

                lblMessage.Text = "Lecturer Added Successfully!";

                LoadLecturers();
            }
        }

        protected void gvLecturers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLecturers.EditIndex = e.NewEditIndex;
            LoadLecturers();
        }

        protected void gvLecturers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvLecturers.EditIndex = -1;
            LoadLecturers();
        }

        protected void gvLecturers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int lecturerID = Convert.ToInt32(
                gvLecturers.DataKeys[e.RowIndex].Value);

            GridViewRow row = gvLecturers.Rows[e.RowIndex];

            string name =
                ((TextBox)row.Cells[1].Controls[0]).Text;

            string email =
                ((TextBox)row.Cells[2].Controls[0]).Text;

            string department =
                ((TextBox)row.Cells[3].Controls[0]).Text;

            string qualification =
                ((TextBox)row.Cells[4].Controls[0]).Text;

            string phone =
                ((TextBox)row.Cells[5].Controls[0]).Text;

            using (SqlConnection conn =
                new SqlConnection(cs))
            {
                conn.Open();

                string query = @"
UPDATE Users
SET name=@name,
    email=@email
WHERE userID =
(
    SELECT userID
    FROM Lecturers
    WHERE lecturerID=@lecturerID
)

UPDATE Lecturers
SET department=@department,
    qualification=@qualification,
    phone=@phone
WHERE lecturerID=@lecturerID";

                SqlCommand cmd =
                    new SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@department", department);
                cmd.Parameters.AddWithValue("@qualification", qualification);
                cmd.Parameters.AddWithValue("@phone", phone);
                cmd.Parameters.AddWithValue("@lecturerID", lecturerID);

                cmd.ExecuteNonQuery();
            }

            gvLecturers.EditIndex = -1;
            LoadLecturers();

            lblMessage.Text =
                "Lecturer Updated Successfully!";
        }

        protected void gvLecturers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int lecturerID =
                Convert.ToInt32(
                    gvLecturers.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn =
                new SqlConnection(cs))
            {
                conn.Open();

                string getUserQuery =
                    "SELECT userID FROM Lecturers WHERE lecturerID=@lecturerID";

                SqlCommand getCmd =
                    new SqlCommand(getUserQuery, conn);

                getCmd.Parameters.AddWithValue("@lecturerID", lecturerID);

                int userID =
                    Convert.ToInt32(getCmd.ExecuteScalar());

                string deleteLecturer =
                    "DELETE FROM Lecturers WHERE lecturerID=@lecturerID";

                SqlCommand cmd1 =
                    new SqlCommand(deleteLecturer, conn);

                cmd1.Parameters.AddWithValue("@lecturerID", lecturerID);

                cmd1.ExecuteNonQuery();

                string deleteUser =
                    "DELETE FROM Users WHERE userID=@userID";

                SqlCommand cmd2 =
                    new SqlCommand(deleteUser, conn);

                cmd2.Parameters.AddWithValue("@userID", userID);

                cmd2.ExecuteNonQuery();
            }

            LoadLecturers();

            lblMessage.Text =
                "Lecturer Deleted Successfully!";
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtDepartment.Text = "";
            txtQualification.Text = "";
            txtPhone.Text = "";

            lblMessage.Text = "";
        }
    }
}