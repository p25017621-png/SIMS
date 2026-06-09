using System;

namespace SIMS.Lecturer
{
    public partial class LecturerDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnAttendance_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Lecturer/ManageAttendance.aspx");
        }

        protected void btnMarks_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Lecturer/ManageMarks.aspx");
        }

        protected void btnStudents_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Lecturer/ViewStudents.aspx");
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Lecturer/ManageProfile.aspx");
        }

        protected void btnCourses_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Lecturer/ViewCourses.aspx");
        }

        protected void btnAnnouncement_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Lecturer/Announcements.aspx");
        }
    }
}