using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.DataVisualization.Charting;

namespace vikapplogger
{
    public partial class mylogreports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           

        }

        protected void ddlusers_SelectedIndexChanged(object sender, EventArgs e)
        {
           

        }
        private static DataTable GetData(string query)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand(query);
            String constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            return dt;
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Chart1.Visible = ddltcodes.SelectedValue != "";
            string query = string.Format("select [Transaction Code], count([Transaction Code])from SM20_Logs_new where [Audit Log Message Te] LIKE '%Field content%' GROUP BY [Transaction Code]", ddltcodes.SelectedValue);
            DataTable dt = GetData(query);
            string[] x = new string[dt.Rows.Count];
            int[] y = new int[dt.Rows.Count];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                x[i] = dt.Rows[i][0].ToString();
                y[i] = Convert.ToInt32(dt.Rows[i][1]);
            }
            Chart1.Series[0].Points.DataBindXY(x, y);
            Chart1.Series[0].ChartType = SeriesChartType.Pie;
            Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;
            Chart1.Legends[0].Enabled = true;
        }

        protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void DropDownDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}