<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reports.aspx.cs" Inherits="BugSheriff.Reports" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reports</title>
    <link rel="stylesheet" type="text/css" href="styles/reports.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="top-banner">
        <a href="home.aspx">Home</a>
        <a href="profile.aspx">Profile</a>
        <a href="programs.aspx">Programs</a>
        <a href="reports.aspx">Reports</a>
    </div>

    <form id="formReports" runat="server">
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

        <div>
            <h2>Reports</h2>
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search..." onkeyup="filterReports()" ></asp:TextBox>
            <div id="reportList">
                <asp:Repeater ID="reportRepeater" runat="server">
                    <ItemTemplate>
                        <div class="report-card">
                            <h4>Report ID: <%# Eval("id") %></h4>
                            <p>Status: <%# Eval("status") %></p>
                            <p>Program: <%# Eval("program_name") %></p>
                            <p>Reward: $<%# Eval("reward_amount") %></p>
                            <asp:Button ID="btnView" runat="server" Text="View the Document" CommandArgument='<%# Eval("report_pdf_path") %>' OnCommand="ViewReport_Command" CssClass="search-button"/>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function filterReports() {
            const searchText = document.getElementById("txtSearch").value.toLowerCase();
            const reportCards = document.querySelectorAll('.report-card');
            reportCards.forEach(card => {
                const text = card.innerText.toLowerCase();
                card.style.display = text.includes(searchText) ? 'block' : 'none';
            });
        }
    </script>
</body>
</html>
