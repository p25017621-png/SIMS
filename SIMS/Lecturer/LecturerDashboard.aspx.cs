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
            Response.Redirect("ManageAttendance.aspx");
        }

        protected void btnMarks_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageMarks.aspx");
        }

        protected void btnStudents_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewStudents.aspx");
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageProfile.aspx");
        }
    }
}