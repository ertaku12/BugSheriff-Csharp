<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="BugSheriff.login" Async="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - BugSheriff</title>
    <link rel="stylesheet" type="text/css" href="styles/home.css" /> 
</head>
<body>
    <form id="formLogin" runat="server">
        <div class="top-banner">
            <a href="home.aspx">Home</a>
            <a href="login.aspx">Login</a>
            <a href="signup.aspx">Sign Up</a>
            <%--<a href="profile.aspx">Profile</a>
            <a href="programs.aspx">Programs</a>
            <a href="reports.aspx">Reports</a>--%>

        </div>

        <div class="login-container">
            <h1>Welcome Back</h1>
            <p>Enter your credentials to login</p>
            <p>
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message" ForeColor="Red"></asp:Label>

            </p>

            <div class="input-group">
                <label for="username">Username</label>
                <asp:TextBox ID="username" runat="server" CssClass="input-field" placeholder="Username"></asp:TextBox>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <asp:TextBox ID="password" runat="server" CssClass="input-field" TextMode="Password" placeholder="Password"></asp:TextBox>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="login-button" OnClick="btnLogin_Click" />

            <asp:HyperLink ID="lnkForgotPassword" runat="server" NavigateUrl="~/forgot-password.aspx" Text="Forgot password?" CssClass="forgot-password-link"></asp:HyperLink>
            <p>Don't have an account? <asp:HyperLink ID="lnkSignup" runat="server" NavigateUrl="~/signup.aspx" Text="Sign Up" CssClass="signup-link"></asp:HyperLink></p>
        </div>
    </form>
</body>
</html>
