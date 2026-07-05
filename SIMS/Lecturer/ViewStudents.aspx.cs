using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SIMS.Lecturer
{
    public partial class ViewStudents : Page
    {
        string connStr = System.Web.Configuration.WebConfigurationManager
                         .ConnectionStrings["SIMSConnection"].ConnectionString;
        int lecturerID = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStats();
                LoadStudentProgress();
            }
        }

        private void LoadStats()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    string sqlT = @"SELECT COUNT(DISTINCT e.studentID)
                                    FROM Enrolments e
                                    JOIN Courses c ON e.courseID = c.courseID
                                    WHERE c.lecturerID = @lid";
                    SqlCommand cmdT = new SqlCommand(sqlT, con);
                    cmdT.Parameters.AddWithValue("@lid", lecturerID);
                    lblTotal.Text = cmdT.ExecuteScalar().ToString();

                    string sqlG = @"SELECT COUNT(*) FROM (
                                    SELECT s.studentID,
                                    ISNULL(CAST(SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                                    * 100.0 / NULLIF(COUNT(a.attendanceID),0) AS INT),0) AS AttPct
                                    FROM Students s
                                    JOIN Enrolments e ON s.studentID = e.studentID
                                    JOIN Courses c ON e.courseID = c.courseID
                                    LEFT JOIN Attendance a ON s.studentID = a.studentID AND a.courseID = c.courseID
                                    WHERE c.lecturerID = @lid
                                    GROUP BY s.studentID
                                    ) AS sub WHERE AttPct >= 75";
                    SqlCommand cmdG = new SqlCommand(sqlG, con);
                    cmdG.Parameters.AddWithValue("@lid", lecturerID);
                    lblGood.Text = cmdG.ExecuteScalar().ToString();

                    string sqlA = @"SELECT COUNT(*) FROM (
                                    SELECT s.studentID,
                                    ISNULL(CAST(SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                                    * 100.0 / NULLIF(COUNT(a.attendanceID),0) AS INT),0) AS AttPct
                                    FROM Students s
                                    JOIN Enrolments e ON s.studentID = e.studentID
                                    JOIN Courses c ON e.courseID = c.courseID
                                    LEFT JOIN Attendance a ON s.studentID = a.studentID AND a.courseID = c.courseID
                                    WHERE c.lecturerID = @lid
                                    GROUP BY s.studentID
                                    ) AS sub WHERE AttPct BETWEEN 50 AND 74";
                    SqlCommand cmdA = new SqlCommand(sqlA, con);
                    cmdA.Parameters.AddWithValue("@lid", lecturerID);
                    lblAvg.Text = cmdA.ExecuteScalar().ToString();

                    string sqlP = @"SELECT COUNT(*) FROM (
                                    SELECT s.studentID,
                                    ISNULL(CAST(SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                                    * 100.0 / NULLIF(COUNT(a.attendanceID),0) AS INT),0) AS AttPct
                                    FROM Students s
                                    JOIN Enrolments e ON s.studentID = e.studentID
                                    JOIN Courses c ON e.courseID = c.courseID
                                    LEFT JOIN Attendance a ON s.studentID = a.studentID AND a.courseID = c.courseID
                                    WHERE c.lecturerID = @lid
                                    GROUP BY s.studentID
                                    ) AS sub WHERE AttPct < 50";
                    SqlCommand cmdP = new SqlCommand(sqlP, con);
                    cmdP.Parameters.AddWithValue("@lid", lecturerID);
                    lblPoor.Text = cmdP.ExecuteScalar().ToString();
                }
            }
            catch
            {
                lblTotal.Text = "0";
                lblGood.Text = "0";
                lblAvg.Text = "0";
                lblPoor.Text = "0";
            }
        }

        private void LoadStudentProgress()
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
                            ISNULL(CAST(AVG(CAST(m.score AS FLOAT)) AS INT), 0) AS AvgMarks,
                            CASE
                                WHEN ISNULL(CAST(SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                                * 100.0 / NULLIF(COUNT(a.attendanceID),0) AS INT),0) >= 75 THEN 'Good'
                                WHEN ISNULL(CAST(SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                                * 100.0 / NULLIF(COUNT(a.attendanceID),0) AS INT),0) >= 50 THEN 'Average'
                                ELSE 'Poor'
                            END AS ProgressStatus,
                            CASE
                                WHEN ISNULL(CAST(SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                                * 100.0 / NULLIF(COUNT(a.attendanceID),0) AS INT),0) >= 75 THEN 'badge-good'
                                WHEN ISNULL(CAST(SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                                * 100.0 / NULLIF(COUNT(a.attendanceID),0) AS INT),0) >= 50 THEN 'badge-avg'
                                ELSE 'badge-poor'
                            END AS BadgeClass,
                            CASE
                                WHEN ISNULL(CAST(SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                                * 100.0 / NULLIF(COUNT(a.attendanceID),0) AS INT),0) >= 75 THEN 'fill-green'
                                WHEN ISNULL(CAST(SUM(CASE WHEN a.status='Present' OR a.status='Late' THEN 1 ELSE 0 END)
                                * 100.0 / NULLIF(COUNT(a.attendanceID),0) AS INT),0) >= 50 THEN 'fill-yellow'
                                ELSE 'fill-red'
                            END AS FillClass
                        FROM Students s
                        JOIN Users u ON s.userID = u.userID
                        JOIN Enrolments e ON s.studentID = e.studentID
                        JOIN Courses c ON e.courseID = c.courseID
                        LEFT JOIN Attendance a ON s.studentID = a.studentID
                            AND a.courseID = c.courseID
                        LEFT JOIN Marks m ON s.studentID = m.studentID
                            AND m.courseID = c.courseID
                        WHERE c.lecturerID = @lid
                        GROUP BY s.studentID, u.name, c.courseName
                        ORDER BY AttendancePct ASC";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@lid", lecturerID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptStudents.DataSource = dt;
                    rptStudents.DataBind();
                }
            }
            catch { }
        }
    }
}