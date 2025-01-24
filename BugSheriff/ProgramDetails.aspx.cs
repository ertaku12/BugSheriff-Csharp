using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.IO;
using System.Web.UI;
using System.Runtime.InteropServices.ComTypes;

namespace BugSheriff
{
    public partial class programDetails : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string token = Request.Cookies["jwt_token"]?.Value;

                if (string.IsNullOrEmpty(token))
                {
                    lblProgramName.Text = "You must be logged in to view program details.";
                    Response.Redirect("login.aspx", false);
                    return;
                }

                string programId = Request.QueryString["id"];
                string name = Request.QueryString["name"];
                string description = Request.QueryString["description"];
                string status = Request.QueryString["status"];
                string application_start_date = Request.QueryString["start_date"];
                string application_end_date = Request.QueryString["end_date"];


                if (!string.IsNullOrEmpty(programId))
                {
                    // Set the labels with the passed program details
                    lblProgramName.Text = name;
                    lblDescription.Text = description;
                    lblStatus.Text = status;
                    lblStartDate.Text = application_start_date;
                    lblEndDate.Text = application_end_date;

                    // Store the program ID in the hidden field for future use (e.g., for file uploads)
                    program_id.Value = programId;
                }
                else
                {
                    lblProgramName.Text = "Program not found!";
                }
            }
        }



        protected async void UploadReport(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                string programId = program_id.Value;
                string apiUrl = "http://localhost:5000/upload";
                string token = Request.Cookies["jwt_token"]?.Value;

                if (string.IsNullOrEmpty(token))
                {
                    lblUploadMessage.Text = "You must be logged in to upload a report.";
                    Response.Redirect("login.aspx", false);
                    return;
                }

                using (HttpClient client = new HttpClient())
                {
                    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                    // Prepare the form content to send with the POST request
                    MultipartFormDataContent formData = new MultipartFormDataContent();
                    formData.Add(new StringContent(programId), "program_id");

                    // Read the uploaded file into a stream
                    Stream fileStream = fileUpload.PostedFile.InputStream;
                    StreamContent fileContent = new StreamContent(fileStream);
                    fileContent.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("form-data")
                    {
                        Name = "file",
                        FileName = fileUpload.FileName
                    };
                    fileContent.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/pdf");
                    formData.Add(fileContent);

                    // Send the POST request
                    HttpResponseMessage response = await client.PostAsync(apiUrl, formData);

                    if (response.IsSuccessStatusCode)
                    {
                        lblUploadMessage.ForeColor = System.Drawing.Color.Green;
                        lblUploadMessage.Text = "Report uploaded successfully!";
                    }
                    else
                    {
                        string errorResponse = await response.Content.ReadAsStringAsync();
                        var errorObj = Newtonsoft.Json.JsonConvert.DeserializeObject<ErrorResponse>(errorResponse);
                        lblUploadMessage.Text = errorObj?.message ?? "Error uploading file.";
                    }
                }
            }
            else
            {
                lblUploadMessage.Text = "Please select a file to upload.";
            }
        }
    }

    

    
}
