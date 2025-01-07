using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;

namespace BugSheriff
{
    public partial class login : Page
    {
        private readonly string apiUrl = "http://localhost:5000/login"; // Flask API URL

        protected void Page_Load(object sender, EventArgs e)
        {
            // Page Load logic (if needed)
        }

        protected async void btnLogin_Click(object sender, EventArgs e)
        {
            // Get username and password from the text boxes
            string lUsername = username.Text.Trim(); // Use username.Text
            string lPassword = password.Text.Trim(); // Use password.Text

            await LoginUser(lUsername, lPassword);
        }

        private async Task LoginUser(string username, string password)
        {
            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                var json = $"{{\"username\":\"{username}\",\"password\":\"{password}\"}}";
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                try
                {
                    HttpResponseMessage response = await client.PostAsync(apiUrl, content);
                    if (response.IsSuccessStatusCode)
                    {
                        lblMessage.Text = "User logged in successfully!";

                        var responseBody = await response.Content.ReadAsStringAsync();

                        // JSON'dan sadece access_token'ı al
                        dynamic jsonResponse = Newtonsoft.Json.JsonConvert.DeserializeObject(responseBody);

                        string token = jsonResponse.access_token;
                        
                        // Token'ı cookie'ye kaydet
                        HttpCookie tokenCookie = new HttpCookie("jwt_token", token)
                        {
                            HttpOnly = true, // XSS saldırılarına karşı koruma için token'ı JavaScript erişimine kapatır
                            Secure = true, // Sadece HTTPS bağlantılarda token kullanılabilir
                            Expires = DateTime.Now.AddHours(1) // Token'ın geçerlilik süresi
                        };

                        Response.Cookies.Add(tokenCookie); // Cookie'yi tarayıcıya ekle

                        // Redirect based on user role
                        if (username == "admin")
                        {
                            Response.Redirect("aprograms.aspx", false);
                            return;
                        }
                        else
                        {
                            Response.Redirect("programs.aspx", false);
                            return;
                        }
                    }
                    else
                    {
                        // Read the error message from the response
                        var errorMessageJson = await response.Content.ReadAsStringAsync();

                        // Extract the message from the JSON
                        var jsonDocument = JsonDocument.Parse(errorMessageJson);
                        var errorMessage = jsonDocument.RootElement.GetProperty("message").GetString();

                        lblMessage.Text = $"Login failed: {errorMessage}";

                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred during login: " + ex.Message;
                }
            }
        }
    }
}
