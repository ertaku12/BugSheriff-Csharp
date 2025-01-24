<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="BugSheriff.home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BugSheriff Bug Bounty Platform</title>
    <link rel="stylesheet" type="text/css" href="styles/home.css" />
</head>
<body>
    <form id="formHome" runat="server">
        <div class="top-banner">
            <a href="home.aspx">Home</a>
            <a href="login.aspx">Login</a>
            <a href="signup.aspx">Sign Up</a>
            <a href="profile.aspx">Profile</a>
            <a href="programs.aspx">Programs</a>
            <a href="reports.aspx">Reports</a>

        </div>

        <div>
            <h1 style="text-align: center;">BugSheriff Bug Bounty Platform</h1>

            <div style="padding: 16px;">
                <p style="font-size: 16px; text-align: center;">
                    The Bug Bounty Program is an initiative that invites hackers and security researchers to find and report vulnerabilities in our systems.
                    By identifying potential security issues, we aim to improve the overall safety of our platform and protect our users. 
                    Participants are rewarded for their findings, creating a collaborative approach to security enhancement.
                </p>
            </div>

            <div style="text-align: center;">
                <img src="imgs/default.jfif" alt="default" style="height: 400px;" />
            </div>
        </div>
    </form>
</body>
</html>
