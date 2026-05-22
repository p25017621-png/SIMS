<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="ManageProfile.aspx.cs"
Inherits="SIMS.Lecturer.ManageProfile" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>Manage Profile</title>

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
            linear-gradient(
            135deg,
            #f9f7ff,
            #f1ebff,
            #f6f2ff
            );

            min-height:100vh;

            overflow-x:hidden;

            position:relative;
        }

        /* Purple Glow */

        body::before{

            content:'';

            position:absolute;

            width:400px;
            height:400px;

            background:#9c88ff;

            border-radius:50%;

            top:-120px;
            left:-120px;

            filter:blur(130px);

            opacity:0.25;

            animation:move1 7s ease-in-out infinite;
        }

        body::after{

            content:'';

            position:absolute;

            width:350px;
            height:350px;

            background:#6c63ff;

            border-radius:50%;

            bottom:-100px;
            right:-100px;

            filter:blur(130px);

            opacity:0.18;

            animation:move2 8s ease-in-out infinite;
        }

        @keyframes move1{

            0%{
                transform:translateY(0px);
            }

            50%{
                transform:translateY(25px);
            }

            100%{
                transform:translateY(0px);
            }
        }

        @keyframes move2{

            0%{
                transform:translateY(0px);
            }

            50%{
                transform:translateY(-20px);
            }

            100%{
                transform:translateY(0px);
            }
        }

        .container{

            width:100%;

            display:flex;

            justify-content:center;

            padding:40px;
        }

        /* Main Card */

        .profile-card{

            width:720px;

            padding:35px;

            border-radius:35px;

            background:
            rgba(255,255,255,0.55);

            backdrop-filter:blur(18px);

            border:
            1px solid rgba(255,255,255,0.4);

            box-shadow:
            0 15px 40px rgba(108,99,255,0.15),
            inset 0 1px 1px rgba(255,255,255,0.4);

            animation:fadeUp 0.7s ease;
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

        /* Profile Icon */

        .profile-icon{

            width:95px;
            height:95px;

            margin:auto;

            border-radius:50%;

            background:
            linear-gradient(
            135deg,
            #6C63FF,
            #9c88ff
            );

            display:flex;

            justify-content:center;
            align-items:center;

            color:white;

            font-size:42px;

            margin-bottom:20px;

            box-shadow:
            0 12px 25px rgba(108,99,255,0.30);

            animation:floatIcon 3s ease-in-out infinite;
        }

        @keyframes floatIcon{

            0%{
                transform:translateY(0px);
            }

            50%{
                transform:translateY(-10px);
            }

            100%{
                transform:translateY(0px);
            }
        }

        .title{

            text-align:center;

            font-size:40px;

            font-weight:700;

            color:#222;
        }

        .subtitle{

            text-align:center;

            color:#777;

            margin-top:8px;

            margin-bottom:35px;

            font-size:14px;
        }

        /* Input */

        .input-group{
            margin-bottom:22px;
        }

        .input-group label{

            display:block;

            margin-bottom:8px;

            color:#555;

            font-weight:500;

            font-size:14px;
        }

        .input-box{

            width:100%;

            padding:15px 18px;

            border-radius:16px;

            border:
            1px solid rgba(108,99,255,0.10);

            background:
            rgba(255,255,255,0.75);

            outline:none;

            font-size:14px;

            transition:0.3s ease;

            box-shadow:
            inset 0 1px 1px rgba(255,255,255,0.4),
            0 8px 18px rgba(108,99,255,0.08);
        }

        .input-box:focus{

            transform:translateY(-2px);

            border:
            1px solid #8E7BFF;

            box-shadow:
            0 0 0 4px rgba(108,99,255,0.15);
        }

        /* Button */

        .btn-save{

            width:100%;

            padding:15px;

            border:none;

            border-radius:16px;

            background:
            linear-gradient(
            135deg,
            #6C63FF,
            #9c88ff
            );

            color:white;

            font-size:15px;

            font-weight:600;

            cursor:pointer;

            transition:0.3s ease;

            margin-top:10px;

            box-shadow:
            0 12px 25px rgba(108,99,255,0.25);
        }

        .btn-save:hover{

            transform:translateY(-3px);

            box-shadow:
            0 18px 30px rgba(108,99,255,0.30);
        }

        /* Table */

        .grid-title{

            margin-top:35px;

            margin-bottom:18px;

            font-size:24px;

            font-weight:600;

            color:#222;
        }

        .gridview{

            width:100%;

            border-collapse:collapse;

            overflow:hidden;

            border-radius:20px;

            background:
            rgba(255,255,255,0.75);

            box-shadow:
            0 12px 30px rgba(108,99,255,0.12);

            border:
            1px solid rgba(255,255,255,0.5);
        }

        .gridview th{

            background:
            linear-gradient(
            135deg,
            #6C63FF,
            #9c88ff
            );

            color:white;

            padding:16px;

            text-align:left;

            font-size:14px;
        }

        .gridview td{

            padding:16px;

            border-bottom:
            1px solid #eee;

            font-size:14px;
        }

        .gridview tr:hover{

            background:#faf8ff;

            transition:0.3s;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

    <div class="profile-card">

        <!-- ICON -->

        <div class="profile-icon">
            👤
        </div>

        <!-- TITLE -->

        <div class="title">
            Manage Profile
        </div>

        <div class="subtitle">
            Update lecturer information and manage profiles
        </div>

        <!-- NAME -->

        <div class="input-group">

            <label>Lecturer Name</label>

            <asp:TextBox
            ID="txtName"
            runat="server"
            CssClass="input-box"
            placeholder="Enter lecturer name">
            </asp:TextBox>

        </div>

        <!-- EMAIL -->

        <div class="input-group">

            <label>Email Address</label>

            <asp:TextBox
            ID="txtEmail"
            runat="server"
            CssClass="input-box"
            placeholder="Enter email">
            </asp:TextBox>

        </div>

        <!-- PHONE -->

        <div class="input-group">

            <label>Phone Number</label>

            <asp:TextBox
            ID="txtPhone"
            runat="server"
            CssClass="input-box"
            placeholder="Enter phone number">
            </asp:TextBox>

        </div>

        <!-- DEPARTMENT -->

        <div class="input-group">

            <label>Department</label>

            <asp:TextBox
            ID="txtDepartment"
            runat="server"
            CssClass="input-box"
            placeholder="Enter department">
            </asp:TextBox>

        </div>

        <!-- BUTTON -->

        <asp:Button
        ID="btnSave"
        runat="server"
        Text="Save Changes"
        CssClass="btn-save"
        OnClick="btnSave_Click" />

        <!-- TABLE -->

        <div class="grid-title">
            Lecturer Profiles
        </div>

        <asp:GridView
        ID="GridView1"
        runat="server"
        CssClass="gridview"
        Width="100%"
        AutoGenerateColumns="true"
        GridLines="None">
        </asp:GridView>

    </div>

</div>

</form>

</body>
</html>