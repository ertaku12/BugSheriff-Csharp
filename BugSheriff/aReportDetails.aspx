<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="aReportDetails.aspx.cs" Inherits="BugSheriff.aReportDetails" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Report</title>
    <link rel="stylesheet" type="text/css" href="styles/areports.css?v=1.4" />
</head>
<body>
    <div class="top-banner">
        <a href="ahome.aspx">Admin's Home</a>
        <a href="aprofile.aspx">Admin's Profile</a>
        <a href="aprograms.aspx">Admin's Programs</a>
        <a href="areports.aspx">Admin's Reports</a>
    </div>

    <form id="formAReportDetails" runat="server">
        <div>
            <p>
                <strong>Report ID: </strong>
                <asp:Label ID="report_id" runat="server" CssClass="input-field"></asp:Label>
            </p>

            <p>
                <strong>Program Name: </strong>
                <asp:Label ID="program_name" runat="server" CssClass="input-field"></asp:Label>
            </p>
            <p>
                <strong>Status: </strong>
                <asp:DropDownList ID="status" runat="server">
                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                    <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
                    <asp:ListItem Text="Accepted" Value="Accepted"></asp:ListItem>
                </asp:DropDownList>
            </p>
            <p>
                <strong>Reward: </strong>
                <asp:TextBox ID="reward_amount" runat="server" CssClass="input-field"></asp:TextBox>
            </p>

            <!-- Hidden input for report path -->
            <asp:HiddenField ID="hiddenReportPath" runat="server" />

            <div class="button-container">

                <asp:Button ID="btnView" runat="server" Text="View the Document" OnCommand="ViewReport_Command" CssClass="search-button" />
                
                <br />
                <asp:Button ID="btnUpdate" runat="server" Text="Update Report" OnClick="UpdateReport_Click" CssClass="search-button" />
                <br />
            </div>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>


        </div>
    </form>
</body>
</html>
