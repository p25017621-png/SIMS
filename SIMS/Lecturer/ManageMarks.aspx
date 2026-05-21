<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="ManageMarks.aspx.cs"
Inherits="SIMS.Lecturer.ManageMarks" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Manage Marks</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

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
            linear-gradient(135deg,#faf7ff,#f3eeff,#ffffff);

            min-height:100vh;

            overflow:hidden;

            position:relative;
        }

        /* BLUR PURPLE BACKGROUND */

        body::before{

            content:'';

            position:absolute;

            width:420px;
            height:420px;

            background:#8f7cff;

            border-radius:50%;

            top:-140px;
            left:-140px;

            filter:blur(120px);

            opacity:0.22;

            z-index:-1;
        }

        body::after{

            content:'';

            position:absolute;

            width:350px;
            height:350px;

            background:#6C63FF;

            border-radius:50%;

            bottom:-130px;
            right:-130px;

            filter:blur(120px);

            opacity:0.18;

            z-index:-1;
        }

        /* MAIN LAYOUT */

        .main-container{
            display:flex;
            height:100vh;
        }

        /* SIDEBAR */

        .sidebar{

            width:240px;

            background:
            rgba(255,255,255,0.55);

            backdrop-filter:blur(18px);

            border-right:
            1px solid rgba(255,255,255,0.4);

            padding:35px 25px;

            box-shadow:
            0 10px 30px rgba(108,99,255,0.08);
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

            box-shadow:
            0 10px 20px rgba(108,99,255,0.25);
        }

        /* CONTENT */

        .content{

            flex:1;

            padding:35px 50px;

            overflow-y:auto;
        }

        .topbar{

            display:flex;
            justify-content:space-between;
            align-items:center;
        }

        .page-title{

            font-size:54px;
            font-weight:700;
            color:#222;
        }

        .page-subtitle{

            color:#888;

            margin-top:6px;
        }

        .profile{

            width:58px;
            height:58px;

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

        /* MAIN CARD */

        .marks-card{

            margin-top:40px;

            width:100%;
            max-width:850px;

            background:
            rgba(255,255,255,0.60);

            backdrop-filter:blur(18px);

            border-radius:30px;

            padding:40px;

            border:
            1px solid rgba(255,255,255,0.4);

            box-shadow:
            0 12px 35px rgba(108,99,255,0.12);

            animation:fadeUp 0.6s ease;
        }

        .card-header{

            display:flex;
            align-items:center;

            gap:18px;

            margin-bottom:35px;
        }

        .icon-box{

            width:75px;
            height:75px;

            border-radius:22px;

            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            display:flex;
            justify-content:center;
            align-items:center;

            color:white;

            font-size:30px;

            box-shadow:
            0 12px 25px rgba(108,99,255,0.25);
        }

        .card-title{

            font-size:38px;
            font-weight:700;
            color:#222;
        }

        .card-subtitle{

            color:#888;

            margin-top:5px;
        }

        /* FORM */

        .input-group{
            margin-bottom:28px;
        }

        .input-group label{

            display:block;

            margin-bottom:12px;

            color:#555;

            font-weight:500;
        }

        .input-box{

            width:100%;

            padding:16px 18px;

            border:none;

            border-radius:16px;

            background:#ffffff;

            font-size:15px;

            color:#333;

            outline:none;

            margin-top:8px;

            box-shadow:
            0 6px 18px rgba(108,99,255,0.12);

            transition:0.3s ease;
        }

        .input-box:focus{

            box-shadow:
            0 0 0 4px rgba(108,99,255,0.18);

            transform:translateY(-2px);
        }

        /* BUTTON */

        .btn-save{

            width:220px;

            padding:16px;

            border:none;

            border-radius:16px;

            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            color:white;

            font-size:16px;
            font-weight:600;

            cursor:pointer;

            transition:0.3s ease;

            box-shadow:
            0 10px 20px rgba(108,99,255,0.22);
        }

        .btn-save:hover{

            transform:translateY(-3px);

            box-shadow:
            0 15px 28px rgba(108,99,255,0.30);
        }

        /* ANIMATION */

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

        <!-- TOP -->

        <div class="topbar">

            <div>

                <div class="page-title">
                    Manage Marks
                </div>

                <div class="page-subtitle">
                    Update coursework and final exam marks
                </div>

            </div>

            <div class="profile">
                R
            </div>

        </div>

        <!-- CARD -->

        <div class="marks-card">

            <div class="card-header">

                <div class="icon-box">
                    <i class="fa-solid fa-chart-column"></i>
                </div>

                <div>

                    <div class="card-title">
                        Student Marks
                    </div>

                    <div class="card-subtitle">
                        Enter and update student marks easily
                    </div>

                </div>

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
            CssClass="btn-save" />

        </div>

    </div>

</div>

</form>

</body>
</html>