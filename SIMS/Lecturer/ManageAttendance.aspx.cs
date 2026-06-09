
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SIMS.Lecturer
{
    public partial class ManageAttendance : Page
    {
        string connStr = System.Web.Configuration.WebConfigurationManager
                         .ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                LoadStats();
                LoadPoorAttendance();
            }
        }

        private void LoadStats()
        {
            lblTotal.Text = "25";
            lblPresent.Text = "20";
            lblLate.Text = "2";
            lblAbsent.Text = "3";

            // Real DB:
            // using (SqlConnection con = new SqlConnection(connStr))
            // {
            //     con.Open();
            //     string sql = @"SELECT
            //         COUNT(*) AS Total,
            //         SUM(CASE WHEN Status='P' THEN 1 ELSE 0 END) AS Present,
            //         SUM(CASE WHEN Status='L' THEN 1 ELSE 0 END) AS Late,
            //         SUM(CASE WHEN Status='A' THEN 1 ELSE 0 END) AS Absent
            //         FROM Attendance WHERE Date = @date AND CourseID = @cid";
            //     SqlCommand cmd = new SqlCommand(sql, con);
            //     cmd.Parameters.AddWithValue("@date", txtDate.Text);
            //     cmd.Parameters.AddWithValue("@cid",  ddlCourse.SelectedValue);
            //     SqlDataReader dr = cmd.ExecuteReader();
            //     if (dr.Read())
            //     {
            //         lblTotal.Text   = dr["Total"].ToString();
            //         lblPresent.Text = dr["Present"].ToString();
            //         lblLate.Text    = dr["Late"].ToString();
            //         lblAbsent.Text  = dr["Absent"].ToString();
            //     }
            // }
        }

        protected void btnLoad_Click(object sender, EventArgs e)
        {
            LoadStats();
            LoadPoorAttendance();
        }

        protected void btnSaveAttendance_Click(object sender, EventArgs e)
        {
            try
            {
                // Real DB:
                // using (SqlConnection con = new SqlConnection(connStr))
                // {
                //     con.Open();
                //     // Loop through students and save P/A/L status
                //     string sql = @"IF EXISTS (SELECT 1 FROM Attendance WHERE StudentID=@sid AND CourseID=@cid AND Date=@date)
                //                    UPDATE Attendance SET Status=@status WHERE StudentID=@sid AND CourseID=@cid AND Date=@date
                //                    ELSE
                //                    INSERT INTO Attendance (StudentID,CourseID,Date,Status) VALUES (@sid,@cid,@date,@status)";
                //     SqlCommand cmd = new SqlCommand(sql, con);
                //     cmd.Parameters.AddWithValue("@cid",    ddlCourse.SelectedValue);
                //     cmd.Parameters.AddWithValue("@date",   txtDate.Text);
                //     // Add @sid and @status per student row
                // }

                ClientScript.RegisterStartupScript(this.GetType(), "msg",
                    "alert('Attendance saved successfully!');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "err",
                    "alert('Error: " + ex.Message + "');", true);
            }
        }

        // Requirement G — identify students with poor attendance below 75%
        private void LoadPoorAttendance()
        {
            // Real DB:
            // using (SqlConnection con = new SqlConnection(connStr))
            // {
            //     con.Open();
            //     string sql = @"
            //         SELECT s.StudentID,
            //                LEFT(s.Name,1) AS Initial,
            //                s.Name,
            //                c.CourseName AS Course,
            //                CAST(SUM(CASE WHEN a.Status='P' OR a.Status='L' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS INT) AS AttendancePct,
            //                SUM(CASE WHEN a.Status='A' THEN 1 ELSE 0 END) AS Missed
            //         FROM Attendance a
            //         JOIN Students s ON a.StudentID = s.StudentID
            //         JOIN Courses  c ON a.CourseID  = c.CourseID
            //         WHERE c.LecturerID = @lid
            //         GROUP BY s.StudentID, s.Name, c.CourseName
            //         HAVING (SUM(CASE WHEN a.Status='P' OR a.Status='L' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) < 75";
            //     SqlCommand cmd = new SqlCommand(sql, con);
            //     cmd.Parameters.AddWithValue("@lid", Session["LecturerID"]);
            //     SqlDataAdapter da = new SqlDataAdapter(cmd);
            //     DataTable dt = new DataTable();
            //     da.Fill(dt);
            //     rptPoorAttendance.DataSource = dt;
            //     rptPoorAttendance.DataBind();
            // }
        }
    }
}