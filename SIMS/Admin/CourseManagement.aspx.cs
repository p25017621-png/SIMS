using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SIMS.Admin
{
    public partial class CourseManagement : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCourses();
                LoadProgrammes();
            }
        }

        // LOAD PROGRAMME
        void LoadProgrammes()
        {
            SqlConnection con =
                new SqlConnection(connectionString);

            string query =
                "SELECT programmeID, programmeName FROM Programmes";

            SqlDataAdapter da =
                new SqlDataAdapter(query, con);

            DataTable dt =
                new DataTable();

            da.Fill(dt);

            ddlProgramme.DataSource = dt;
            ddlProgramme.DataTextField = "programmeName";
            ddlProgramme.DataValueField = "programmeID";
            ddlProgramme.DataBind();
        }

        // LOAD COURSES
        void LoadCourses()
        {
            SqlConnection con =
                new SqlConnection(connectionString);

            string query = @"
SELECT
    c.courseID,
    c.courseName,
    c.courseCode,
    c.credits,
    p.programmeName
FROM Courses c
INNER JOIN Programmes p
ON c.programmeID = p.programmeID";

            SqlDataAdapter da =
                new SqlDataAdapter(query, con);

            DataTable dt =
                new DataTable();

            da.Fill(dt);

            gvCourses.DataSource = dt;
            gvCourses.DataBind();
        }



        // ADD COURSE
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            SqlConnection con =
                new SqlConnection(connectionString);

            string query =
          "INSERT INTO Courses(courseName, courseCode, credits, programmeID) " +
          "VALUES(@courseName, @courseCode, @credits, @programmeID)";

            SqlCommand cmd =
                new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@courseName", txtCourseName.Text);
            cmd.Parameters.AddWithValue("@courseCode", txtCourseCode.Text);
            cmd.Parameters.AddWithValue("@credits", Convert.ToInt32(txtCredits.Text));
            cmd.Parameters.AddWithValue("@programmeID", ddlProgramme.SelectedValue);

            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            lblMessage.Text = "Course Added Successfully!";

            LoadCourses();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtCourseName.Text = "";
            txtCourseCode.Text = "";
            txtCredits.Text = "";

            ddlProgramme.SelectedIndex = 0;

            lblMessage.Text = "";
        }

        // DELETE COURSE
        protected void gvCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int courseID = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                try
                {
                    // Delete lecturer assignments first (FK safety)
                    string deleteAssignment =
                        "DELETE FROM LecturerCourseAssignments WHERE courseID=@id";

                    SqlCommand cmd1 = new SqlCommand(deleteAssignment, con);
                    cmd1.Parameters.AddWithValue("@id", courseID);
                    cmd1.ExecuteNonQuery();

                    // Delete course
                    string deleteCourse =
                        "DELETE FROM Courses WHERE courseID=@id";

                    SqlCommand cmd2 = new SqlCommand(deleteCourse, con);
                    cmd2.Parameters.AddWithValue("@id", courseID);
                    cmd2.ExecuteNonQuery();

                    lblMessage.Text = "Course Deleted Successfully!";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                }
            }

            LoadCourses();
        }
        protected void gvCourses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCourses.EditIndex = e.NewEditIndex;
            LoadCourses();
        }

        protected void gvCourses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCourses.EditIndex = -1;
            LoadCourses();
        }

        protected void gvCourses_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int courseID = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);

            GridViewRow row = gvCourses.Rows[e.RowIndex];

            string courseName = ((TextBox)row.Cells[1].Controls[0]).Text;
            string courseCode = ((TextBox)row.Cells[2].Controls[0]).Text;
            string creditsText = ((TextBox)row.Cells[3].Controls[0]).Text;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                try
                {
                    string query = @"UPDATE Courses 
                             SET courseName=@name, 
                                 courseCode=@code, 
                                 credits=@credits
                             WHERE courseID=@id";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@name", courseName);
                    cmd.Parameters.AddWithValue("@code", courseCode);
                    cmd.Parameters.AddWithValue("@credits", Convert.ToInt32(creditsText));
                    cmd.Parameters.AddWithValue("@id", courseID);

                    cmd.ExecuteNonQuery();

                    gvCourses.EditIndex = -1;

                    lblMessage.Text = "Course Updated Successfully!";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                }
            }

            LoadCourses();
        }
    }
}