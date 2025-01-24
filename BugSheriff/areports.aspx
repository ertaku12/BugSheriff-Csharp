<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="areports.aspx.cs" Inherits="BugSheriff.areports" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>All Reports</title>
    <link rel="stylesheet" type="text/css" href="styles/reports.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script type="text/javascript">
        function redirectToEdit(program) {
            var url = "aReportDetails.aspx?id=" + program.id +
                "&status=" + encodeURIComponent(program.status) +
                "&program_name=" + encodeURIComponent(program.program_name) +
                "&report_pdf_path=" + program.report_pdf_path +
                "&reward_amount=" + program.reward_amount;

            window.location.href = url; // Redirect
        }

    </script>
</head>
<body>
    <div class="top-banner">
        <a href="ahome.aspx">Admin's Home</a>
        <a href="aprofile.aspx">Admin's Profile</a>
        <a href="aprograms.aspx">Admin's Programs</a>
        <a href="areports.aspx">Admin's Reports</a>
    </div>

    <form id="formReports" runat="server">
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

        <div>
            <h2>All Reports</h2>
            <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search..." onkeyup="filterReports()"></asp:TextBox>
            <div id="reportList">
                <asp:Repeater ID="reportRepeater" runat="server">
                    <ItemTemplate>
                        <div class="report-card">
                            <h4><strong>Report ID: </strong><%# Eval("id") %></h4>
                            <p><strong>Status: </strong><%# Eval("status") %></p>
                            <p><strong>Program: </strong><%# Eval("program_name") %></p>
                            <p><strong>Reward: </strong>$<%# Eval("reward_amount") %></p>
                            <p><strong>IBAN: </strong><span id="iban" style="cursor: pointer; color: blue;" onclick="copyToClipboard('<%# Eval("iban") %>')"><%# Eval("iban") %></span></p>


                            <asp:Button ID="btnView" runat="server" Text="View the Document" CommandArgument='<%# Eval("report_pdf_path") %>' OnCommand="ViewReport_Command" CssClass="search-button" />
                            
                            <a href="javascript:void(0);"
                                onclick='redirectToEdit({
                      id: "<%# Eval("id") %>",
                      status: "<%# Eval("status") %>",
                      program_name: "<%# Eval("program_name") %>",
                      reward_amount: "<%# Eval("reward_amount") %>",
                    report_pdf_path: "<%# Eval("report_pdf_path") %>"})'
                                class="search-button">Edit Report</a>
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
        function copyToClipboard(text) {
            navigator.clipboard.writeText(text).then(function () {
                alert("IBAN copied to clipboard!");
            }, function (err) {
                console.error('Could not copy text: ', err);
            });
        }
    </script>
</body>
</html>
