using System;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Web.UI.WebControls;

namespace BugSheriff
{
    public partial class aReportDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string token = Request.Cookies["jwt_token"]?.Value;

                if (string.IsNullOrEmpty(token))
                {
                    lblMessage.Text = "You must be logged in to view report details.";
                    Response.Redirect("login.aspx", false);
                    return;
                }

                // Get query string parameters
                string id = Request.QueryString["id"];
                string statusValue = Request.QueryString["status"];
                string programName = Request.QueryString["program_name"];
                string reportPdfPath = Request.QueryString["report_pdf_path"];
                string rewardAmount = Request.QueryString["reward_amount"];

                // Load the details into controls if id exists
                if (!string.IsNullOrEmpty(id))
                {
                    report_id.Text = id;
                    program_name.Text = programName;
                    status.SelectedValue = statusValue;
                    reward_amount.Text = rewardAmount;
                    hiddenReportPath.Value = reportPdfPath;

                }
                else
                {
                    lblMessage.Text = "Report not found!";
                }
            }
        }

        protected async void UpdateReport_Click(object sender, EventArgs e)
        {
            int id = int.Parse(Request.QueryString["id"]);
            string apiUrl = $"http://localhost:5000/admin/report/{id}";
            string token = Request.Cookies["jwt_token"]?.Value;

            var updatedReport = new
            {
                report_id = id,
                status = status.SelectedValue,
                reward_amount = reward_amount.Text
            };

            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);
                HttpResponseMessage response = await client.PutAsJsonAsync(apiUrl, updatedReport);

                if (response.IsSuccessStatusCode)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Report updated successfully!";
                }
                else
                {
                    lblMessage.Text = "Failed to update report.";
                }
            }
        }

        protected async void ViewReport_Command(object sender, CommandEventArgs e)
        {
            string reportPath = Request.QueryString["report_pdf_path"];
            string token = Request.Cookies["jwt_token"]?.Value;

            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = new Uri("http://localhost:5000/");
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                HttpResponseMessage response = await client.GetAsync($"admin/uploads/{reportPath}");

                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsByteArrayAsync();
                    Response.ContentType = "application/pdf";
                    Response.AppendHeader("Content-Disposition", $"inline; filename={reportPath}");
                    Response.BinaryWrite(content);
                    Response.End(); // End the response
                }
                else
                {
                    lblMessage.Text = $"Error: {await response.Content.ReadAsStringAsync()}"; // Display the error message
                }
            }
        }
    }
}
