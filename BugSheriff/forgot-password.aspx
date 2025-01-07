<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgot-password.aspx.cs" Inherits="BugSheriff.forgot_password" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>
    <link rel="stylesheet" type="text/css" href="styles/forgot-password.css" />
</head>
<body>
    <form id="formForgotPassword" runat="server">
        <div class="top-banner">
            <a href="home.aspx">Home</a>
            <a href="login.aspx">Login</a>
            <a href="signup.aspx">Sign Up</a>
            <%--<a href="profile.aspx">Profile</a>
            <a href="programs.aspx">Programs</a>
            <a href="reports.aspx">Reports</a>--%>

        </div>

        <div class="form-container">
            <h2>Reset Password</h2>
            <h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            </h2>

            <asp:TextBox ID="username" runat="server" CssClass="form-field" Placeholder="Username"></asp:TextBox>
            <asp:TextBox ID="password" runat="server" TextMode="Password" CssClass="form-field" Placeholder="New Password"></asp:TextBox>
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-field" Placeholder="Confirm New Password"></asp:TextBox>

            <asp:DropDownList ID="secret_question" runat="server" CssClass="form-field">
                <asp:ListItem Text="Select Your Secret Question" Value=""></asp:ListItem>
                <asp:ListItem Text="What is your pet's name?" Value="What is your pet's name?"></asp:ListItem>
                <asp:ListItem Text="What is your mother's maiden name?" Value="What is your mother's maiden name?"></asp:ListItem>
                <asp:ListItem Text="What is your favorite book?" Value="What is your favorite book?"></asp:ListItem>
            </asp:DropDownList>

            <asp:TextBox ID="secret_answer" runat="server" CssClass="form-field" Placeholder="Answer to Secret Question"></asp:TextBox>

            <asp:Button ID="btnResetPassword" runat="server" CssClass="form-button" Text="Reset Password" OnClick="btnResetPassword_Click" />
        </div>
    </form>
</body>
</html>
