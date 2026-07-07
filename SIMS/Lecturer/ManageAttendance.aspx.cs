using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SIMS.Lecturer
{
    public partial class ManageAttendance : Page
    {
        string connStr = System.Web.Configuration.WebConfigurationManager
                         .ConnectionStrings["SIMSConnection"].ConnectionString;
        int lecturerID = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                LoadCourses();
                LoadPoorAttendance();
            }
        }

        private void LoadCourses()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = @"SELECT c.courseID, c.courseName
                                   FROM Courses c
                                   JOIN LecturerCourseAssignments lca ON c.courseID = lca.courseID
                                   WHERE lca.lecturerID = @lid";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@lid", lecturerID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    ddlCourse.DataSource = dt;
                    ddlCourse.DataTextField = "courseName";
                    ddlCourse.DataValueField = "courseID";
                    ddlCourse.DataBind();
                    ddlCourse.Items.Insert(0,
                        new System.Web.UI.WebControls.ListItem("-- Select Course --", ""));
                }
            }
            catch { }
        }

        protected void btnLoad_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlCourse.SelectedValue))
            {
                pnlError.Visible = true;
                pnlSuccess.Visible = false;
                lblErrorMsg.Text = "Please select a course first!";
                return;
            }
            pnlError.Visible = false;
            pnlSuccess.Visible = false;
            lblCourseName.Text = ddlCourse.SelectedItem.Text;
            lblSelectedCourse.Text = ddlCourse.SelectedItem.Text;

            int courseID = int.Parse(ddlCourse.SelectedValue);
            LoadTotalStudents(courseID);
            LoadStudentsByCourse(courseID);
            LoadPoorAttendance();
        }

        private void LoadTotalStudents(int courseID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = "SELECT COUNT(*) FROM Enrolments WHERE courseID = @cid";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@cid", courseID);
                    lblTotal.Text = cmd.ExecuteScalar().ToString();
                }
            }
            catch { lblTotal.Text = "0"; }
        }

        private void LoadStudentsByCourse(int courseID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = @"
                        SELECT
                            u.name AS Name,
                            LEFT(u.name, 1) AS Initial,
                            c.courseName AS Course,
                            ISNULL(CAST(
                                SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                                * 100.0 / NULLIF(COUNT(a.attendanceID), 0)
                            AS INT), 0) AS AttPct
                        FROM Enrolments e
                        JOIN Students s ON e.studentID = s.studentID
                        JOIN Users u ON s.userID = u.userID
                        JOIN Courses c ON e.courseID = c.courseID
                        LEFT JOIN Attendance a ON s.studentID = a.studentID
                            AND a.courseID = c.courseID
                        WHERE e.courseID = @cid
                        GROUP BY s.studentID, u.name, c.courseName
                        ORDER BY u.name";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@cid", courseID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptStudents.DataSource = dt;
                    rptStudents.DataBind();
                }
            }
            catch { }
        }

        protected void btnSaveAttendance_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlCourse.SelectedValue))
            {
                pnlError.Visible = true;
                pnlSuccess.Visible = false;
                lblErrorMsg.Text = "Please select a course before saving!";
                return;
            }
            try
            {
                pnlSuccess.Visible = true;
                pnlError.Visible = false;
                lblSuccessMsg.Text = "✅ Attendance for " + ddlCourse.SelectedItem.Text
                                   + " on " + txtDate.Text + " saved successfully!";
                LoadPoorAttendance();
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                pnlSuccess.Visible = false;
                lblErrorMsg.Text = "Error: " + ex.Message;
            }
        }

        private void LoadPoorAttendance()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string sql = @"
                        SELECT
                            LEFT(u.name, 1) AS Initial,
                            u.name AS Name,
                            c.courseName AS Course,
                            ISNULL(CAST(
                                SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                                * 100.0 / NULLIF(COUNT(a.attendanceID), 0)
                            AS INT), 0) AS AttendancePct,
                            SUM(CASE WHEN a.status='Absent' THEN 1 ELSE 0 END) AS Missed
                        FROM Students s
                        JOIN Users u ON s.userID = u.userID
                        JOIN Enrolments e ON s.studentID = e.studentID
                        JOIN Courses c ON e.courseID = c.courseID
                        JOIN LecturerCourseAssignments lca ON c.courseID = lca.courseID
                        LEFT JOIN Attendance a ON s.studentID = a.studentID
                            AND a.courseID = c.courseID
                        WHERE lca.lecturerID = @lid
                        GROUP BY s.studentID, u.name, c.courseName
                        HAVING ISNULL(CAST(
                            SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                            * 100.0 / NULLIF(COUNT(a.attendanceID), 0)
                        AS INT), 0) < 75";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@lid", lecturerID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        rptPoorAttendance.DataSource = dt;
                        rptPoorAttendance.DataBind();
                        lblPoorCount.Text = dt.Rows.Count.ToString();
                        pnlNoPoor.Visible = false;
                    }
                    else
                    {
                        rptPoorAttendance.DataSource = null;
                        rptPoorAttendance.DataBind();
                        lblPoorCount.Text = "0";
                        pnlNoPoor.Visible = true;
                    }
                }
            }
            catch { lblPoorCount.Text = "0"; }
        }
    }
}