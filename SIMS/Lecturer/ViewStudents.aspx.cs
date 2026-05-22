using System;
using System.Data;
using System.Data.SqlClient;

namespace SIMS.Lecturer
{
    public partial class ViewStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudents();
            }
        }

        void LoadStudents()
        {
            SqlConnection con = new SqlConnection(
            @"Data Source=(LocalDB)\MSSQLLocalDB;
            Initial Catalog=SIMS_DB;
            Integrated Security=True");

            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT * FROM Students", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            da.Fill(dt);

            rptStudents.DataSource = dt;

            rptStudents.DataBind();

            con.Close();
        }
    }
}