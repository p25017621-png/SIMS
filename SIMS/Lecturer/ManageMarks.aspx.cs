
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SIMS.Lecturer
{
    public partial class ManageMarks : Page
    {
        string connStr = System.Web.Configuration.WebConfigurationManager
                         .ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Page loads with default dropdown selections
            }
        }

        // Load marks for selected course and assessment
        protected void btnLoad_Click(object sender, EventArgs e)
        {
            string courseID = ddlCourse.SelectedValue;
            string assessmentID = ddlAssessment.SelectedValue;

            // Real DB:
            // using (SqlConnection con = new SqlConnection(connStr))
            // {
            //     con.Open();
            //     string sql = @"SELECT s.StudentID, s.Name, m.Marks, m.Grade,
            //                    CASE WHEN m.IsPublished=1 THEN 'Published' ELSE 'Draft' END AS Status
            //                    FROM Marks m
            //                    JOIN Students s ON m.StudentID = s.StudentID
            //                    WHERE m.CourseID=@cid AND m.AssessmentID=@aid";
            //     SqlCommand cmd = new SqlCommand(sql, con);
            //     cmd.Parameters.AddWithValue("@cid", courseID);
            //     cmd.Parameters.AddWithValue("@aid", assessmentID);
            //     SqlDataAdapter da = new SqlDataAdapter(cmd);
            //     DataTable dt = new DataTable();
            //     da.Fill(dt);
            //     // Bind dt to your GridView/Repeater
            // }
        }

        // Save marks to DB
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // Real DB:
                // using (SqlConnection con = new SqlConnection(connStr))
                // {
                //     con.Open();
                //     string sql = @"IF EXISTS (SELECT 1 FROM Marks WHERE StudentID=@sid AND CourseID=@cid AND AssessmentID=@aid)
                //                    UPDATE Marks SET Marks=@marks, Grade=@grade WHERE StudentID=@sid AND CourseID=@cid AND AssessmentID=@aid
                //                    ELSE
                //                    INSERT INTO Marks (StudentID,CourseID,AssessmentID,Marks,Grade,IsPublished)
                //                    VALUES (@sid,@cid,@aid,@marks,@grade,0)";
                //     // Loop through each student row and execute
                // }

                ClientScript.RegisterStartupScript(this.GetType(), "msg",
                    "alert('Marks saved successfully!');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "err",
                    "alert('Error saving marks: " + ex.Message + "');", true);
            }
        }

        // Publish marks — students can now see their marks
        protected void btnPublish_Click(object sender, EventArgs e)
        {
            try
            {
                // Real DB:
                // using (SqlConnection con = new SqlConnection(connStr))
                // {
                //     con.Open();
                //     string sql = @"UPDATE Marks SET IsPublished=1
                //                    WHERE CourseID=@cid AND AssessmentID=@aid";
                //     SqlCommand cmd = new SqlCommand(sql, con);
                //     cmd.Parameters.AddWithValue("@cid", ddlCourse.SelectedValue);
                //     cmd.Parameters.AddWithValue("@aid", ddlAssessment.SelectedValue);
                //     cmd.ExecuteNonQuery();
                // }

                ClientScript.RegisterStartupScript(this.GetType(), "msg",
                    "alert('Marks published! Students can now view their results.');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "err",
                    "alert('Error publishing: " + ex.Message + "');", true);
            }
        }

        // Helper — calculate grade from marks
        private string GetGrade(int marks)
        {
            if (marks >= 80) return "A";
            if (marks >= 70) return "B";
            if (marks >= 60) return "C";
            if (marks >= 50) return "D";
            return "F";
        }
    }
}