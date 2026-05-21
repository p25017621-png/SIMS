<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="ViewStudents.aspx.cs"
Inherits="SIMS.Lecturer.ViewStudents" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>View Students</title>

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

        /* BACKGROUND PURPLE BLUR */

        body::before{

            content:'';

            position:absolute;

            width:420px;
            height:420px;

            background:#8f7cff;

            border-radius:50%;

            top:-120px;
            left:-120px;

            filter:blur(120px);

            opacity:0.20;

            animation:moveOne 8s ease-in-out infinite alternate;

            z-index:-1;
        }

        body::after{

            content:'';

            position:absolute;

            width:350px;
            height:350px;

            background:#6C63FF;

            border-radius:50%;

            bottom:-120px;
            right:-120px;

            filter:blur(120px);

            opacity:0.18;

            animation:moveTwo 9s ease-in-out infinite alternate;

            z-index:-1;
        }

        @keyframes moveOne{

            from{
                transform:translateY(0px);
            }

            to{
                transform:translateY(40px);
            }
        }

        @keyframes moveTwo{

            from{
                transform:translateX(0px);
            }

            to{
                transform:translateX(-40px);
            }
        }

        /* MAIN */

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

        /* CARD */

        .students-card{

            margin-top:40px;

            background:
            rgba(255,255,255,0.60);

            backdrop-filter:blur(18px);

            border-radius:30px;

            padding:35px;

            border:
            1px solid rgba(255,255,255,0.4);

            box-shadow:
            0 12px 35px rgba(108,99,255,0.12);

            animation:fadeUp 0.6s ease;

            position:relative;

            overflow:hidden;
        }

        /* FLOATING EMOJIS */

        .students-card::before{

            content:'🎓';

            position:absolute;

            top:20px;
            right:40px;

            font-size:110px;

            opacity:0.08;

            animation:floatOne 5s ease-in-out infinite;
        }

        .students-card::after{

            content:'👨‍🎓';

            position:absolute;

            bottom:20px;
            left:40px;

            font-size:90px;

            opacity:0.06;

            animation:floatTwo 6s ease-in-out infinite;
        }

        @keyframes floatOne{

            0%{
                transform:translateY(0px) rotate(0deg);
            }

            50%{
                transform:translateY(-15px) rotate(4deg);
            }

            100%{
                transform:translateY(0px) rotate(0deg);
            }
        }

        @keyframes floatTwo{

            0%{
                transform:translateY(0px);
            }

            50%{
                transform:translateY(12px);
            }

            100%{
                transform:translateY(0px);
            }
        }

        .card-header{

            display:flex;
            align-items:center;

            gap:18px;

            margin-bottom:30px;
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

        /* TABLE */

        .student-table{

            width:100%;

            border-collapse:collapse;

            margin-top:25px;

            overflow:hidden;

            border-radius:20px;
        }

        .student-table th{

            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            color:white;

            padding:18px;

            text-align:left;

            font-size:15px;
        }

        .student-table td{

            padding:18px;

            background:white;

            color:#555;

            border-bottom:
            1px solid #f1f1f1;

            transition:0.3s ease;
        }

        .student-table tr:hover td{

            background:#f8f5ff;

            transform:scale(1.01);
        }

        .course-badge{

            padding:8px 14px;

            border-radius:20px;

            background:#ede9ff;

            color:#6C63FF;

            font-size:13px;

            font-weight:600;
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

            <a href="ManageMarks.aspx">
                Marks
            </a>

            <a href="ViewStudents.aspx" class="active">
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
                    Student List
                </div>

                <div class="page-subtitle">
                    View all registered students
                </div>

            </div>

            <div class="profile">
                R
            </div>

        </div>

        <!-- CARD -->

        <div class="students-card">

            <div class="card-header">

                <div class="icon-box">
                    <i class="fa-solid fa-user-graduate"></i>
                </div>

                <div>

                    <div class="card-title">
                        Students Information
                    </div>

                    <div class="card-subtitle">
                        Manage and monitor student records easily
                    </div>

                </div>

            </div>

            <!-- TABLE -->

            <table class="student-table">

                <tr>

                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Course</th>

                </tr>

                <tr>

                    <td>ST001</td>

                    <td>John Tan</td>

                    <td>john@gmail.com</td>

                    <td>
                        <span class="course-badge">
                            Computer Science
                        </span>
                    </td>

                </tr>

                <tr>

                    <td>ST002</td>

                    <td>Sarah Lim</td>

                    <td>sarah@gmail.com</td>

                    <td>
                        <span class="course-badge">
                            Software Engineering
                        </span>
                    </td>

                </tr>

                <tr>

                    <td>ST003</td>

                    <td>Daniel Wong</td>

                    <td>daniel@gmail.com</td>

                    <td>
                        <span class="course-badge">
                            Information Technology
                        </span>
                    </td>

                </tr>

            </table>

        </div>

    </div>

</div>

</form>

</body>
</html>