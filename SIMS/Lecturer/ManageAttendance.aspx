<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="ManageAttendance.aspx.cs"
Inherits="SIMS.Lecturer.ManageAttendance" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Manage Attendance</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Poppins',sans-serif;
        }

        body{
            background:
            linear-gradient(135deg,#f5f1ff,#ece5ff,#f8f6ff);

            min-height:100vh;
        }

        .main-container{
            display:flex;
            width:100%;
            min-height:100vh;
        }

        /* SIDEBAR */

        .sidebar{

            width:240px;

            background:white;

            padding:35px 25px;

            box-shadow:
            0 0 20px rgba(0,0,0,0.05);
        }

        .logo{
            font-size:48px;
            font-weight:700;
            color:#6C63FF;
            margin-bottom:50px;
        }

        .menu{
            display:flex;
            flex-direction:column;
            gap:18px;
        }

        .menu a{

            text-decoration:none;

            padding:15px;

            border-radius:14px;

            color:#555;

            transition:0.3s;
        }

        .menu a:hover{
            background:#eee9ff;
            color:#6C63FF;
        }

        .active{
            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            color:white !important;
        }

        /* CONTENT */

        .content{
            flex:1;
            padding:40px;
        }

        .page-title{
            font-size:50px;
            font-weight:700;
            color:#222;
        }

        .page-subtitle{
            color:#888;
            margin-top:10px;
            margin-bottom:40px;
        }

        .table-card{

            background:white;

            border-radius:25px;

            padding:35px;

            box-shadow:
            0 10px 30px rgba(0,0,0,0.05);

            border:
            2px solid #d9ccff;
        }

        /* TABLE */

        table{
            width:100%;
            border-collapse:separate;
            border-spacing:0;
            overflow:hidden;
            border-radius:20px;
            background:white;
            box-shadow:0 8px 20px rgba(128,0,255,0.08);
            border:2px solid #d9ccff;
            margin-top:20px;
        }

        th{

            background:
            linear-gradient(90deg,#7b5cff,#9b7bff);

            color:white;

            padding:18px;

            text-align:left;

            font-size:15px;
        }

        td{

            padding:18px;

            border-top:
            1px solid #eee;

            color:#555;

            font-size:15px;
        }

        tr:hover td{

            background:#faf7ff;

            transition:0.3s;
        }

        select{

            padding:10px 14px;

            border:none;

            border-radius:10px;

            background:#f2efff;

            color:#555;
        }

        .save-btn{

            margin-top:25px;

            padding:15px 30px;

            border:none;

            border-radius:14px;

            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            color:white;

            font-weight:600;

            cursor:pointer;
        }

        .save-btn:hover{
            opacity:0.9;
        }

        .grid{
            margin-top:30px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="main-container">

    <!-- SIDEBAR -->

    <div class="sidebar">

        <div class="logo">
            SIMS
        </div>

        <div class="menu">

            <a href="LecturerDashboard.aspx">
                Dashboard
            </a>

            <a href="ManageAttendance.aspx" class="active">
                Attendance
            </a>

            <a href="ManageMarks.aspx">
                Marks
            </a>

            <a href="ViewStudents.aspx">
                Students
            </a>

            <a href="ManageProfile.aspx">
                Profile
            </a>

        </div>

    </div>

    <!-- CONTENT -->

    <div class="content">

        <div class="page-title">
            Manage Attendance
        </div>

        <div class="page-subtitle">
            Update and manage student attendance records
        </div>

        <div class="table-card">

            <table>

                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Course</th>
                    <th>Status</th>
                </tr>

                <tr>

                    <td>ST001</td>
                    <td>John Tan</td>
                    <td>Computer Science</td>

                    <td>

                        <asp:DropDownList ID="ddl1" runat="server">

                            <asp:ListItem>Present</asp:ListItem>
                            <asp:ListItem>Absent</asp:ListItem>

                        </asp:DropDownList>

                    </td>

                </tr>

                <tr>

                    <td>ST002</td>
                    <td>Sarah Lim</td>
                    <td>Software Engineering</td>

                    <td>

                        <asp:DropDownList ID="ddl2" runat="server">

                            <asp:ListItem>Present</asp:ListItem>
                            <asp:ListItem>Absent</asp:ListItem>

                        </asp:DropDownList>

                    </td>

                </tr>

                <tr>

                    <td>ST003</td>
                    <td>Daniel Wong</td>
                    <td>Information Technology</td>

                    <td>

                        <asp:DropDownList ID="ddl3" runat="server">

                            <asp:ListItem>Present</asp:ListItem>
                            <asp:ListItem>Absent</asp:ListItem>

                        </asp:DropDownList>

                    </td>

                </tr>

                <tr>

                    <td>ST004</td>
                    <td>Alicia Tan</td>
                    <td>Cyber Security</td>

                    <td>

                        <asp:DropDownList ID="ddl4" runat="server">

                            <asp:ListItem>Present</asp:ListItem>
                            <asp:ListItem>Absent</asp:ListItem>

                        </asp:DropDownList>

                    </td>

                </tr>

            </table>

            <asp:Button
            ID="btnSave"
            runat="server"
            Text="Save Attendance"
            CssClass="save-btn"
            OnClick="btnSave_Click" />

            <div class="grid">

                <asp:GridView
                ID="GridView1"
                runat="server"
                Width="100%"
                AutoGenerateColumns="true"
                CellPadding="12"
                GridLines="None">
                </asp:GridView>

            </div>

        </div>

    </div>

</div>

</form>

</body>
</html>