using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SIMS
{
    public partial class Lecturers : System.Web.UI.Page
    {
        private string connString = ConfigurationManager.ConnectionStrings["SIMSConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userID"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindLecturers();
            }
        }

        private void BindLecturers(string searchFilter = "")
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT u.name, u.email, l.department, l.qualification, l.phone 
                    FROM Lecturers l
                    INNER JOIN Users u ON l.userID = u.userID";

                if (!string.IsNullOrEmpty(searchFilter))
                {
                    query += " WHERE u.name LIKE @Search OR l.department LIKE @Search";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(searchFilter))
                    {
                        cmd.Parameters.AddWithValue("@Search", "%" + searchFilter.Trim() + "%");
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvLecturers.DataSource = dt;
                        gvLecturers.DataBind();
                    }
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindLecturers(txtSearch.Text);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            BindLecturers();
        }

        // Handles the click event from your front-end LinkButton (OnClick="btnLogout_Click")
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear backend session states safely
            Session.Clear();
            Session.Abandon();

            // Redirect back to login panel
            Response.Redirect("~/Login.aspx");
        }
    }
}