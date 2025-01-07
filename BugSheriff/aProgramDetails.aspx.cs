using System;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI;
using System.Net.Http.Formatting;


namespace BugSheriff
{
    public partial class aProgramDetails : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string token = Request.Cookies["jwt_token"]?.Value;

                if (string.IsNullOrEmpty(token))
                {
                    lblMessage.Text = "You must be logged in to view program details.";
                    Response.Redirect("login.aspx", false);
                    return;
                }

                // Get the query string parameters for program details
                string programId = Request.QueryString["id"];
                string programName = Request.QueryString["name"];
                string descriptionText = Request.QueryString["description"];
                string programStatus = Request.QueryString["status"];
                string startDate = Request.QueryString["start_date"];
                string endDate = Request.QueryString["end_date"];

                // Load the details into the controls if the programId exists
                if (!string.IsNullOrEmpty(programId))
                {
                    name.Text = programName;
                    description.Text = descriptionText;
                    status.SelectedValue = programStatus;
                    application_start_date.Text = startDate;
                    application_end_date.Text = endDate;

                    if (DateTime.TryParse(startDate, out DateTime parsedStartDate))
                    {
                        application_start_date.Text = parsedStartDate.ToString("yyyy-MM-dd"); // Ensure the correct format for date input field
                    }
                    if (DateTime.TryParse(endDate, out DateTime parsedEndDate))
                    {
                        application_end_date.Text = parsedEndDate.ToString("yyyy-MM-dd");
                    }


                    // Store programId for future updates
                    program_id.Value = programId;
                }
                else
                {
                    lblMessage.Text = "Program not found!";
                }
            }
        }

        protected async void UpdateProgram_Click(object sender, EventArgs e)
        {
            string programId = program_id.Value;
            string apiUrl = $"http://localhost:5000/admin/program/{programId}";
            string token = Request.Cookies["jwt_token"]?.Value;

            var updatedProgram = new
            {
                name = name.Text,
                description = description.Text,
                application_start_date = application_start_date.Text,
                application_end_date = application_end_date.Text,
                status = status.SelectedValue
            };

            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Add("Authorization", "Bearer " + token);
                HttpResponseMessage response = await client.PutAsJsonAsync(apiUrl, updatedProgram);

                if (response.IsSuccessStatusCode)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Program updated successfully!";
                }
                else
                {
                    lblMessage.Text = "Failed to update program.";
                }
            }
        }
    }
}
