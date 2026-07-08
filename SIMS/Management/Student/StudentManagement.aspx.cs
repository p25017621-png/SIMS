using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SIMS.Management.Student
{
    public partial class StudentManagement : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        // PAGE LOAD
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudents();
            }
        }

        // LOAD STUDENTS
        private void LoadStudents()
        {
            SqlConnection con =
                new SqlConnection(connectionString);

            string query =
"SELECT Users.userID, Users.name, Users.email, " +
"Students.phone, Students.gender, " +
"Students.dateOfBirth, Students.address, " +
"Programmes.programmeName, " +
"Enrolments.semester " +
"FROM Students " +
"INNER JOIN Users ON Students.userID = Users.userID " +
"LEFT JOIN Enrolments ON Students.studentID = Enrolments.studentID " +
"LEFT JOIN Programmes ON Enrolments.programmeID = Programmes.programmeID";

            SqlDataAdapter da =
                new SqlDataAdapter(query, con);

            DataTable dt =
                new DataTable();

            da.Fill(dt);

            gvStudents.DataSource = dt;
            gvStudents.DataBind();
        }

        // ADD STUDENT
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            SqlConnection con =
                new SqlConnection(connectionString);

            con.Open();

            // INSERT USER
            string userQuery =
                "INSERT INTO Users(name,email,password,role) " +
                "VALUES(@name,@email,@password,'Student'); " +
                "SELECT SCOPE_IDENTITY();";

            SqlCommand userCmd =
                new SqlCommand(userQuery, con);

            userCmd.Parameters.AddWithValue("@name", txtName.Text);
            userCmd.Parameters.AddWithValue("@email", txtEmail.Text);
            userCmd.Parameters.AddWithValue("@password", txtPassword.Text);

            int userID =
                Convert.ToInt32(userCmd.ExecuteScalar());

            // INSERT STUDENT
            string studentQuery =
            "INSERT INTO Students(userID,phone,gender,dateOfBirth,address) " +
            "VALUES(@userID,@phone,@gender,@dob,@address)";

            SqlCommand studentCmd =
                new SqlCommand(studentQuery, con);

            studentCmd.Parameters.AddWithValue("@userID", userID);
            studentCmd.Parameters.AddWithValue("@phone", txtPhone.Text);
            studentCmd.Parameters.AddWithValue("@gender", ddlGender.SelectedValue);

            studentCmd.Parameters.AddWithValue("@dob",
                Convert.ToDateTime(txtDOB.Text));

            studentCmd.Parameters.AddWithValue("@address",
                txtAddress.Text);
            studentCmd.ExecuteNonQuery();

            con.Close();

            lblMessage.Text =
                "Student Added Successfully!";

            LoadStudents();
        }

        // EDIT BUTTON
        protected void gvStudents_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvStudents.EditIndex = e.NewEditIndex;
            LoadStudents();
        }

        // CANCEL EDIT
        protected void gvStudents_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvStudents.EditIndex = -1;
            LoadStudents();
        }



        // UPDATE STUDENT
        protected void gvStudents_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int userID =
                Convert.ToInt32(gvStudents.DataKeys[e.RowIndex].Value);

            GridViewRow row =
                gvStudents.Rows[e.RowIndex];

            string name =
                ((TextBox)row.Cells[0].Controls[0]).Text;

            string email =
                ((TextBox)row.Cells[1].Controls[0]).Text;

            string phone =
                ((TextBox)row.Cells[2].Controls[0]).Text;

            string gender =
               ((TextBox)row.Cells[3].Controls[0]).Text;

            string dob =
                ((TextBox)row.Cells[4].Controls[0]).Text;

            string address =
                ((TextBox)row.Cells[5].Controls[0]).Text;

            SqlConnection con =
                new SqlConnection(connectionString);

            string query =
           "UPDATE Users SET name=@name, email=@email WHERE userID=@userID;" +
           "UPDATE Students SET phone=@phone, gender=@gender, dateOfBirth=@dob, address=@address WHERE userID=@userID";

            SqlCommand cmd =
                new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@gender", gender);

            cmd.Parameters.AddWithValue("@dob",
                Convert.ToDateTime(dob));
            cmd.Parameters.AddWithValue("@address", address);
            cmd.Parameters.AddWithValue("@userID", userID);

            con.Open();
            int result = cmd.ExecuteNonQuery();

            lblMessage.Text = result + " row updated!";
            con.Close();

            gvStudents.EditIndex = -1;

            LoadStudents();
        }

        // DELETE STUDENT
        protected void gvStudents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userID = Convert.ToInt32(gvStudents.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 1. Get the studentID first using the userID
                string getStudentQuery = "SELECT studentID FROM Students WHERE userID=@userID";
                int studentID = 0;

                using (SqlCommand getCmd = new SqlCommand(getStudentQuery, con))
                {
                    getCmd.Parameters.AddWithValue("@userID", userID);
                    object result = getCmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        studentID = Convert.ToInt32(result);
                    }
                }

                // 2. Clear out all relational child records in the correct order before dropping the core entities
                string deleteQuery = @"
            DELETE FROM Marks WHERE studentID=@studentID;
            DELETE FROM Attendance WHERE studentID=@studentID;
            DELETE FROM Enrolments WHERE studentID=@studentID;
            DELETE FROM Students WHERE studentID=@studentID;
            DELETE FROM Users WHERE userID=@userID;";

                using (SqlCommand cmd = new SqlCommand(deleteQuery, con))
                {
                    cmd.Parameters.AddWithValue("@studentID", studentID);
                    cmd.Parameters.AddWithValue("@userID", userID);

                    cmd.ExecuteNonQuery();
                }
            }

            lblMessage.Text = "🗑️ Student and all associated records removed successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;

            LoadStudents();
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtPhone.Text = "";
            txtAddress.Text = "";

            ddlGender.SelectedIndex = 0;

            lblMessage.Text = "";
        }

    }
}
