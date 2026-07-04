using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SIMS.Admin
{
    public partial class CourseManagement : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

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
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT programmeID, programmeName FROM Programmes";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlProgramme.DataSource = dt;
                ddlProgramme.DataTextField = "programmeName";
                ddlProgramme.DataValueField = "programmeID";
                ddlProgramme.DataBind();
            }
        }

        // LOAD COURSES
        void LoadCourses()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT
                        c.courseID,
                        c.courseName,
                        c.credits,
                        p.programmeName
                    FROM Courses c
                    INNER JOIN Programmes p ON c.programmeID = p.programmeID";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvCourses.DataSource = dt;
                gvCourses.DataBind();
            }
        }

        // ADD COURSE
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Courses(courseName, credits, programmeID) VALUES(@courseName, @credits, @programmeID)";
                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@courseName", txtCourseName.Text);
                cmd.Parameters.AddWithValue("@credits", Convert.ToInt32(txtCredits.Text));
                cmd.Parameters.AddWithValue("@programmeID", ddlProgramme.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "Course Added Successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;
            LoadCourses();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtCourseName.Text = "";
            txtCredits.Text = "";

            ddlProgramme.SelectedIndex = 0;
            lblMessage.Text = "";
        }

        // DELETE COURSE (SAFETY GUARD FOR OTHER MODULES)
        protected void gvCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int courseID = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Use a database transaction to ensure either everything deletes safely or nothing changes at all!
                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    // 1. Clear out student enrolments safely within the isolated transaction scope
                    string deleteEnrolments = "DELETE FROM Enrolments WHERE courseID=@id";
                    SqlCommand cmd0 = new SqlCommand(deleteEnrolments, con, transaction);
                    cmd0.Parameters.AddWithValue("@id", courseID);
                    cmd0.ExecuteNonQuery();

                    // 2. Clear out Lecturer assignments
                    string deleteAssignment = "DELETE FROM LecturerCourseAssignments WHERE courseID=@id";
                    SqlCommand cmd1 = new SqlCommand(deleteAssignment, con, transaction);
                    cmd1.Parameters.AddWithValue("@id", courseID);
                    cmd1.ExecuteNonQuery();

                    // 3. Delete the parent Course record
                    string deleteCourse = "DELETE FROM Courses WHERE courseID=@id";
                    SqlCommand cmd2 = new SqlCommand(deleteCourse, con, transaction);
                    cmd2.Parameters.AddWithValue("@id", courseID);
                    cmd2.ExecuteNonQuery();

                    // Commit changes only if every single step succeeds completely
                    transaction.Commit();

                    lblMessage.Text = "Course Deleted Successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    // If anything goes wrong, roll back entirely so no other module's data is ruined or partially broken!
                    transaction.Rollback();
                    lblMessage.Text = "Cannot delete course: Active relational dependencies found in other system modules.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
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
            string creditsText = ((TextBox)row.Cells[2].Controls[0]).Text;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                try
                {
                    string query = @"UPDATE Courses 
                                     SET courseName=@name, 
                                         credits=@credits
                                     WHERE courseID=@id";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@name", courseName);
                    cmd.Parameters.AddWithValue("@credits", Convert.ToInt32(creditsText));
                    cmd.Parameters.AddWithValue("@id", courseID);

                    cmd.ExecuteNonQuery();
                    gvCourses.EditIndex = -1;
                    lblMessage.Text = "Course Updated Successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }

            LoadCourses();
        }
    }
}