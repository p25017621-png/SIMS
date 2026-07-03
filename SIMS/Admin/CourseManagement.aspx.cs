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

        // LOAD COURSES
        void LoadCourses()
        {
            SqlConnection con =
                new SqlConnection(connectionString);

            string query = @"
SELECT
    c.courseName,
    c.description,
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

        // ADD COURSE
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            SqlConnection con =
                new SqlConnection(connectionString);

            string query =
          "INSERT INTO Courses(courseName, description, credits, programmeID) " +
          "VALUES(@courseName, @description, @credits, @programmeID)";

            SqlCommand cmd =
                new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@courseName", txtCourseName.Text);
            cmd.Parameters.AddWithValue("@description", txtDescription.Text);
            cmd.Parameters.AddWithValue("@credits", txtCredits.Text);
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
            txtDescription.Text = "";
            txtCredits.Text = "";

            ddlProgramme.SelectedIndex = 0;

            lblMessage.Text = "";
        }

        // DELETE COURSE
        protected void gvCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string courseName =
                gvCourses.DataKeys[e.RowIndex].Value.ToString();

            SqlConnection con =
                new SqlConnection(connectionString);

            con.Open();

            // Delete lecturer assignment first
            string deleteAssignment =
                @"DELETE FROM LecturerCourseAssignments
          WHERE courseID =
          (SELECT courseID
           FROM Courses
           WHERE courseName=@courseName)";

            SqlCommand cmd1 =
                new SqlCommand(deleteAssignment, con);

            cmd1.Parameters.AddWithValue("@courseName", courseName);

            cmd1.ExecuteNonQuery();

            // Delete course
            string deleteCourse =
                "DELETE FROM Courses WHERE courseName=@courseName";

            SqlCommand cmd2 =
                new SqlCommand(deleteCourse, con);

            cmd2.Parameters.AddWithValue("@courseName", courseName);

            cmd2.ExecuteNonQuery();

            con.Close();

            lblMessage.Text =
                "Course Deleted Successfully!";

            LoadCourses();
        }
        protected void gvCourses_RowEditing(
    object sender,
    GridViewEditEventArgs e)
        {
            gvCourses.EditIndex = e.NewEditIndex;

            LoadCourses();
        }

        protected void gvCourses_RowCancelingEdit(
            object sender,
            GridViewCancelEditEventArgs e)
        {
            gvCourses.EditIndex = -1;

            LoadCourses();
        }

        protected void gvCourses_RowUpdating(
            object sender,
            GridViewUpdateEventArgs e)
        {
            string oldCourseName =
                gvCourses.DataKeys[e.RowIndex].Value.ToString();

            string courseName =
                ((TextBox)gvCourses.Rows[e.RowIndex]
                .Cells[0].Controls[0]).Text;

            string description =
                ((TextBox)gvCourses.Rows[e.RowIndex]
                .Cells[1].Controls[0]).Text;

            string credits =
                ((TextBox)gvCourses.Rows[e.RowIndex]
                .Cells[2].Controls[0]).Text;

            SqlConnection con =
                new SqlConnection(connectionString);

            string query =
                "UPDATE Courses " +
                "SET courseName=@courseName, " +
                "description=@description, " +
                "credits=@credits " +
                "WHERE courseName=@oldCourseName";

            SqlCommand cmd =
                new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@courseName", courseName);
            cmd.Parameters.AddWithValue("@description", description);
            cmd.Parameters.AddWithValue("@credits", credits);
            cmd.Parameters.AddWithValue("@oldCourseName", oldCourseName);

            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            gvCourses.EditIndex = -1;

            lblMessage.Text =
                "Course Updated Successfully!";

            LoadCourses();
        }
    }
}