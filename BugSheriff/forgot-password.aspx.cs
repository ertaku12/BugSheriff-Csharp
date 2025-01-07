using System;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI;

namespace BugSheriff
{
    public partial class forgot_password : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected async void btnResetPassword_Click(object sender, EventArgs e)
        {
            string lusername = username.Text;
            string lpassword = password.Text;
            string confirmPassword = txtConfirmPassword.Text;
            string secretQuestion = secret_question.SelectedValue;
            string secretAnswer = secret_answer.Text;

            // Form validation
            if (string.IsNullOrEmpty(lusername) || string.IsNullOrEmpty(lpassword) ||
                string.IsNullOrEmpty(confirmPassword) || string.IsNullOrEmpty(secretAnswer) ||
                secretQuestion == "")
            {
                lblMessage.Text = "Please fill in all fields!";
                return;
            }

            if (lpassword != confirmPassword)
            {
                lblMessage.Text = "Passwords do not match!";
                return;
            }

            // API Call to Reset Password
            string resultMessage = await ResetPasswordAsync(lusername, lpassword, secretQuestion, secretAnswer);
            lblMessage.Text = resultMessage;
        }

        private async Task<string> ResetPasswordAsync(string username, string password, string secretQuestion, string secretAnswer)
        {
            string apiUrl = "http://localhost:5000/reset-password"; // API endpoint

            using (HttpClient client = new HttpClient())
            {
                var data = new
                {
                    username = username,
                    password = password,
                    secret_question = secretQuestion,
                    secret_answer = secretAnswer
                };

                var content = new StringContent(Newtonsoft.Json.JsonConvert.SerializeObject(data), System.Text.Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PostAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    return "Password has been reset successfully!";
                }
                else
                {
                    var responseBody = await response.Content.ReadAsStringAsync();
                    dynamic responseData = Newtonsoft.Json.JsonConvert.DeserializeObject(responseBody);
                    return responseData.message;
                }
            }
        }
    }
}
