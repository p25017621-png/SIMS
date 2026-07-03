using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SIMS.Lecturer
{
    public partial class LecturerDashboard : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStatistics();
                LoadAssignments();
            }
        }
        private void LoadStatistics()

        {
            string cs =
                ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                SqlCommand cmd1 =
                    new SqlCommand("SELECT COUNT(*) FROM Lecturers", conn);

                lblLecturers.Text =
                    cmd1.ExecuteScalar().ToString();

                SqlCommand cmd2 =
                    new SqlCommand("SELECT COUNT(*) FROM Courses", conn);

                lblCourses.Text =
                    cmd2.ExecuteScalar().ToString();

                SqlCommand cmd3 =
    new SqlCommand("SELECT COUNT(*) FROM LecturerCourseAssignments", conn);

                lblAssignments.Text =
                    cmd3.ExecuteScalar().ToString();
            }
         
        }
            private void LoadAssignments()
        {
            string cs =
                ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = @"
        SELECT
        c.courseName,
        p.programmeName,
        a.semester
        FROM LecturerCourseAssignments a
        JOIN Courses c
            ON a.courseID = c.courseID
        JOIN Programmes p
            ON c.programmeID = p.programmeID";

                SqlDataAdapter da =
                    new SqlDataAdapter(query, conn);

                DataTable dt =
                    new DataTable();

                da.Fill(dt);

                gvAssignments.DataSource = dt;
                gvAssignments.DataBind();
            }
        
        }



        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/Login.aspx");
        }
    }
}