using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SIMS.Lecturer
{
    public partial class ManageMarks : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
        @"Data Source=(LocalDB)\MSSQLLocalDB;
        Initial Catalog=SIMS_DB;
        Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMarks();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "INSERT INTO StudentMarks VALUES(@id,@name,@cw,@final)", con);

            cmd.Parameters.AddWithValue("@id", "ST001");

            cmd.Parameters.AddWithValue("@name",
            txtStudentName.Text);

            cmd.Parameters.AddWithValue("@cw",
            txtCoursework.Text);

            cmd.Parameters.AddWithValue("@final",
            txtFinalExam.Text);

            cmd.ExecuteNonQuery();

            con.Close();

            LoadMarks();
        }

        void LoadMarks()
        {
            SqlDataAdapter da = new SqlDataAdapter(
            "SELECT * FROM StudentMarks", con);

            DataTable dt = new DataTable();

            da.Fill(dt);

            GridView1.DataSource = dt;

            GridView1.DataBind();
        }
    }
}