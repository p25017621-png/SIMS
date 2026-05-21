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

            overflow:hidden;

            position:relative;
        }

        body::before{
            content:'';

            position:absolute;

            width:450px;
            height:450px;

            background:#8c7bff;

            border-radius:50%;

            top:-180px;
            left:-180px;

            filter:blur(140px);

            opacity:0.30;

            z-index:-1;
        }

        body::after{
            content:'';

            position:absolute;

            width:400px;
            height:400px;

            background:#6c63ff;

            border-radius:50%;

            bottom:-180px;
            right:-180px;

            filter:blur(140px);

            opacity:0.20;

            z-index:-1;
        }

        .main-container{
            display:flex;
            width:100%;
            height:100vh;
        }

        /* SIDEBAR */

        .sidebar{

            width:240px;

            background:
            rgba(255,255,255,0.55);

            backdrop-filter:blur(18px);

            padding:35px 25px;

            border-right:
            1px solid rgba(255,255,255,0.4);

            box-shadow:
            0 10px 30px rgba(108,99,255,0.08);
        }

        .logo{
            font-size:46px;
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

            padding:16px 18px;

            border-radius:14px;

            color:#555;

            font-weight:500;

            transition:0.3s ease;
        }

        .menu a:hover{
            background:#ede9ff;
            color:#6C63FF;
        }

        .active{
            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            color:white !important;

            box-shadow:
            0 10px 20px rgba(108,99,255,0.25);
        }

        /* CONTENT */

        .content{

            flex:1;

            padding:35px;

            overflow-y:auto;
        }

        .topbar{
            display:flex;
            justify-content:space-between;
            align-items:center;
        }

        .page-title{
            font-size:52px;
            font-weight:700;
            color:#222;
        }

        .page-subtitle{
            color:#888;
            margin-top:8px;
        }

        .profile{

            width:60px;
            height:60px;

            border-radius:50%;

            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            display:flex;
            justify-content:center;
            align-items:center;

            color:white;

            font-weight:600;

            box-shadow:
            0 10px 20px rgba(108,99,255,0.25);
        }

        /* SEARCH */

        .search-box{

            margin-top:35px;

            width:320px;

            position:relative;
        }

        .search-box input{

            width:100%;

            padding:15px 18px 15px 48px;

            border:none;

            border-radius:16px;

            background:
            rgba(255,255,255,0.75);

            backdrop-filter:blur(10px);

            font-size:15px;

            box-shadow:
            0 8px 20px rgba(108,99,255,0.08);

            outline:none;
        }

        .search-box i{

            position:absolute;

            top:16px;
            left:18px;

            color:#6C63FF;
        }

        /* TABLE CARD */

        .table-card{

            margin-top:35px;

            background:
            rgba(255,255,255,0.65);

            backdrop-filter:blur(18px);

            border-radius:28px;

            padding:30px;

            box-shadow:
            0 12px 35px rgba(108,99,255,0.12);

            border:
            1px solid rgba(255,255,255,0.4);

            animation:fadeUp 0.6s ease;
        }

        table{
            width:100%;
            border-collapse:collapse;
        }

        th{

            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            color:white;

            padding:18px;

            text-align:left;

            font-size:15px;
        }

        th:first-child{
            border-top-left-radius:14px;
        }

        th:last-child{
            border-top-right-radius:14px;
        }

        td{

            padding:20px 18px;

            color:#555;

            border-bottom:
            1px solid #eee;
        }

        tr:hover{
            background:#faf8ff;
        }

        select{

            padding:10px 14px;

            border:none;

            border-radius:10px;

            background:#f2efff;

            color:#555;

            outline:none;
        }

        .save-btn{

            margin-top:28px;

            padding:15px 30px;

            border:none;

            border-radius:16px;

            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            color:white;

            font-weight:600;

            cursor:pointer;

            transition:0.3s ease;

            box-shadow:
            0 10px 20px rgba(108,99,255,0.20);
        }

        .save-btn:hover{

            transform:translateY(-3px);

            box-shadow:
            0 14px 25px rgba(108,99,255,0.30);
        }

        @keyframes fadeUp{

            from{
                opacity:0;
                transform:translateY(25px);
            }

            to{
                opacity:1;
                transform:translateY(0);
            }
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

        <div class="topbar">

            <div>

                <div class="page-title">
                    Manage Attendance
                </div>

                <div class="page-subtitle">
                    Update and manage student attendance records
                </div>

            </div>

            <div class="profile">
                R
            </div>

        </div>

        <!-- SEARCH -->

        <div class="search-box">

            <i class="fa-solid fa-magnifying-glass"></i>

            <asp:TextBox
            ID="txtSearch"
            runat="server"
            placeholder="Search Student"></asp:TextBox>

        </div>

        <!-- TABLE -->

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

            </table>

            <asp:Button
            ID="btnSave"
            runat="server"
            Text="Save Attendance"
            CssClass="save-btn" />

        </div>

    </div>

</div>

</form>

</body>
</html>