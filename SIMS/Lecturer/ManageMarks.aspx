<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="ManageMarks.aspx.cs"
Inherits="SIMS.Lecturer.ManageMarks" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Manage Marks</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Poppins',sans-serif;
        }

        body{
            background:
            linear-gradient(135deg,#faf7ff,#f3eeff,#ffffff);

            min-height:100vh;
            overflow-y:auto;
        }

        .main-container{
            display:flex;
            min-height:100vh;
        }

        /* SIDEBAR */

        .sidebar{

            width:240px;

            background:white;

            border-right:
            2px solid #d9ccff;

            padding:35px 25px;
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

            padding:15px 18px;

            border-radius:14px;

            color:#666;

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
        }

        /* CONTENT */

        .content{

            flex:1;

            padding:35px 50px;
        }

        .page-title{

            font-size:52px;
            font-weight:700;
            color:#222;
        }

        .page-subtitle{

            color:#888;
            margin-top:8px;
            margin-bottom:35px;
        }

        /* CARD */

        .marks-card{

            width:100%;
            max-width:1000px;

            background:white;

            border-radius:30px;

            padding:40px;

            border:
            2px solid #d9ccff;

            box-shadow:
            0 12px 35px rgba(108,99,255,0.12);
        }

        .input-group{
            margin-bottom:25px;
        }

        .input-group label{

            display:block;

            margin-bottom:10px;

            color:#555;

            font-weight:500;
        }

        .input-box{

            width:100%;

            padding:16px;

            border:
            2px solid #e5dcff;

            border-radius:14px;

            outline:none;

            font-size:15px;
        }

        .input-box:focus{

            border-color:#6C63FF;
        }

        /* BUTTON */

        .btn-save{

            margin-top:10px;

            width:220px;

            padding:15px;

            border:none;

            border-radius:16px;

            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            color:white;

            font-size:16px;
            font-weight:600;

            cursor:pointer;
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
            margin-top:35px;
        }

        th{

            background:
            linear-gradient(90deg,#7b5cff,#9b7bff);

            color:white;

            padding:18px;

            text-align:left;

            font-size:15px;
        }

        th:first-child{
            border-top-left-radius:18px;
        }

        th:last-child{
            border-top-right-radius:18px;
        }

        td{

            padding:18px;

            border-top:
            1px solid #eee;

            color:#555;

            font-size:15px;

            background:white;
        }

        tr:hover td{

            background:#faf7ff;

            transition:0.3s;
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

            <a href="ManageAttendance.aspx">
                Attendance
            </a>

            <a href="ManageMarks.aspx" class="active">
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
            Manage Marks
        </div>

        <div class="page-subtitle">
            Update coursework and final exam marks
        </div>

        <div class="marks-card">

            <!-- STUDENT ID -->

            <div class="input-group">

                <label>Student ID</label>

                <asp:TextBox
                ID="txtStudentID"
                runat="server"
                CssClass="input-box"
                placeholder="Enter student ID">
                </asp:TextBox>

            </div>

            <!-- STUDENT NAME -->

            <div class="input-group">

                <label>Student Name</label>

                <asp:TextBox
                ID="txtStudentName"
                runat="server"
                CssClass="input-box"
                placeholder="Enter student name">
                </asp:TextBox>

            </div>

            <!-- COURSEWORK -->

            <div class="input-group">

                <label>Coursework Marks</label>

                <asp:TextBox
                ID="txtCoursework"
                runat="server"
                CssClass="input-box"
                placeholder="Enter coursework marks">
                </asp:TextBox>

            </div>

            <!-- FINAL EXAM -->

            <div class="input-group">

                <label>Final Exam Marks</label>

                <asp:TextBox
                ID="txtFinalExam"
                runat="server"
                CssClass="input-box"
                placeholder="Enter final exam marks">
                </asp:TextBox>

            </div>

            <!-- BUTTON -->

            <asp:Button
            ID="btnUpdate"
            runat="server"
            Text="Update Marks"
            CssClass="btn-save"
            OnClick="btnUpdate_Click" />

            <!-- GRIDVIEW -->

            <asp:GridView
            ID="GridView1"
            runat="server"
            Width="100%"
            AutoGenerateColumns="true"
            GridLines="None">
            </asp:GridView>

        </div>

    </div>

</div>

</form>

</body>
</html>