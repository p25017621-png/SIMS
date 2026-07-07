using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SIMS.Lecturer
{
    public partial class LecturerDashboard : Page
    {
        string connStr = System.Web.Configuration.WebConfigurationManager
                         .ConnectionStrings["SIMSConnection"].ConnectionString;
        int lecturerID = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStats();
                LoadNotifications();
            }
        }

        private void LoadStats()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    string sql1 = @"SELECT COUNT(DISTINCT e.studentID)
                                    FROM Enrolments e
                                    JOIN LecturerCourseAssignments lca ON e.courseID = lca.courseID
                                    WHERE lca.lecturerID = @lid";
                    SqlCommand cmd1 = new SqlCommand(sql1, con);
                    cmd1.Parameters.AddWithValue("@lid", lecturerID);
                    lblTotalStudents.Text = cmd1.ExecuteScalar().ToString();

                    string sql2 = @"SELECT COUNT(*)
                                    FROM Attendance a
                                    JOIN LecturerCourseAssignments lca ON a.courseID = lca.courseID
                                    WHERE lca.lecturerID = @lid";
                    SqlCommand cmd2 = new SqlCommand(sql2, con);
                    cmd2.Parameters.AddWithValue("@lid", lecturerID);
                    lblTotalAttendance.Text = cmd2.ExecuteScalar().ToString();

                    string sql3 = @"SELECT COUNT(*)
                                    FROM Marks m
                                    JOIN LecturerCourseAssignments lca ON m.courseID = lca.courseID
                                    WHERE lca.lecturerID = @lid";
                    SqlCommand cmd3 = new SqlCommand(sql3, con);
                    cmd3.Parameters.AddWithValue("@lid", lecturerID);
                    lblTotalMarks.Text = cmd3.ExecuteScalar().ToString();
                }
            }
            catch
            {
                lblTotalStudents.Text = "0";
                lblTotalAttendance.Text = "0";
                lblTotalMarks.Text = "0";
            }
        }

        private void LoadNotifications()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = @"SELECT TOP 5 title, datePosted
                                   FROM Announcements
                                   WHERE lecturerID = @lid
                                   ORDER BY datePosted DESC";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@lid", lecturerID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        rptNotifications.DataSource = dt;
                        rptNotifications.DataBind();
                        lblNotifCount.Text = dt.Rows.Count.ToString();
                        pnlNoNotif.Visible = false;
                    }
                    else
                    {
                        lblNotifCount.Text = "0";
                        pnlNoNotif.Visible = true;
                    }
                }
            }
            catch
            {
                lblNotifCount.Text = "0";
                pnlNoNotif.Visible = true;
            }
        }

        protected void btnAttendance_Click(object sender, EventArgs e) { Response.Redirect("~/Lecturer/ManageAttendance.aspx"); }
        protected void btnMarks_Click(object sender, EventArgs e) { Response.Redirect("~/Lecturer/ManageMarks.aspx"); }
        protected void btnStudents_Click(object sender, EventArgs e) { Response.Redirect("~/Lecturer/ViewStudents.aspx"); }
        protected void btnProfile_Click(object sender, EventArgs e) { Response.Redirect("~/Lecturer/ManageProfile.aspx"); }
        protected void btnCourses_Click(object sender, EventArgs e) { Response.Redirect("~/Lecturer/ViewCourses.aspx"); }
        protected void btnAnnouncement_Click(object sender, EventArgs e) { Response.Redirect("~/Lecturer/Announcements.aspx"); }
    }
}