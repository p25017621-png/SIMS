<%@ Page Language="C#" AutoEventWireup="true"
CodeBehind="ManageProfile.aspx.cs"
Inherits="SIMS.Lecturer.ManageProfile" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Manage Profile</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Poppins',sans-serif;
        }

        body{
            min-height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            overflow:hidden;

            background:
            linear-gradient(
            135deg,
            #f5f1ff,
            #ece5ff,
            #f8f6ff,
            #efe8ff
            );

            position:relative;
        }

        /* LEFT PURPLE BLUR */
        body::before{
            content:'';
            position:absolute;

            width:500px;
            height:500px;

            background:#8c7bff;

            border-radius:50%;

            top:-150px;
            left:-150px;

            filter:blur(140px);

            opacity:0.35;

            z-index:-1;
        }

        /* RIGHT PURPLE BLUR */
        body::after{
            content:'';
            position:absolute;

            width:450px;
            height:450px;

            background:#6c63ff;

            border-radius:50%;

            bottom:-120px;
            right:-120px;

            filter:blur(140px);

            opacity:0.25;

            z-index:-1;
        }

        .container{
            width:100%;
            display:flex;
            justify-content:center;
            align-items:center;
            padding:20px;
        }

        .profile-card{

            width:520px;

            background:rgba(255,255,255,0.65);

            backdrop-filter:blur(20px);

            border-radius:30px;

            padding:45px;

            box-shadow:
            0 10px 30px rgba(108,99,255,0.15);

            border:1px solid rgba(255,255,255,0.4);

            animation:fadeUp 0.7s ease;
        }

        .top-section{
            text-align:center;
            margin-bottom:35px;
        }

        .profile-icon{

            width:110px;
            height:110px;

            margin:auto;

            border-radius:50%;

            display:flex;
            justify-content:center;
            align-items:center;

            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            color:white;

            font-size:42px;

            box-shadow:
            0 10px 25px rgba(108,99,255,0.30);

            animation:floatIcon 3s ease-in-out infinite;
        }

        .title{
            margin-top:25px;
            font-size:42px;
            font-weight:700;
            color:#222;
        }

        .subtitle{
            margin-top:8px;
            color:#777;
            font-size:15px;
        }

        .input-group{
            margin-top:24px;
        }

        .input-group label{

            display:block;

            margin-bottom:10px;

            font-weight:600;

            color:#444;

            font-size:15px;
        }

        .input-box{

            width:100%;

            padding:16px;

            border:none;

            border-radius:16px;

            background:white;

            font-size:15px;

            color:#333;

            box-shadow:
            0 4px 12px rgba(108,99,255,0.08);

            transition:0.3s ease;
        }

        .input-box:focus{

            outline:none;

            border:2px solid #6C63FF;

            box-shadow:
            0 0 12px rgba(108,99,255,0.25);

            transform:scale(1.02);
        }

        .save-btn{

            width:100%;

            margin-top:35px;

            padding:16px;

            border:none;

            border-radius:18px;

            background:
            linear-gradient(135deg,#6C63FF,#8E7BFF);

            color:white;

            font-size:16px;

            font-weight:600;

            cursor:pointer;

            transition:0.3s ease;

            box-shadow:
            0 10px 20px rgba(108,99,255,0.25);
        }

        .save-btn:hover{

            transform:
            translateY(-4px);

            box-shadow:
            0 15px 25px rgba(108,99,255,0.35);
        }

        @keyframes fadeUp{

            from{
                opacity:0;
                transform:translateY(30px);
            }

            to{
                opacity:1;
                transform:translateY(0);
            }
        }

        @keyframes floatIcon{

            0%{
                transform:translateY(0px);
            }

            50%{
                transform:translateY(-8px);
            }

            100%{
                transform:translateY(0px);
            }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

    <div class="profile-card">

        <div class="top-section">

            <div class="profile-icon">
                <i class="fa-solid fa-user"></i>
            </div>

            <div class="title">
                Manage Profile
            </div>

            <div class="subtitle">
                Update lecturer information and account settings
            </div>

        </div>

        <div class="input-group">

            <label>Lecturer Name</label>

            <asp:TextBox
            ID="txtName"
            runat="server"
            CssClass="input-box"></asp:TextBox>

        </div>

        <div class="input-group">

            <label>Email Address</label>

            <asp:TextBox
            ID="txtEmail"
            runat="server"
            CssClass="input-box"></asp:TextBox>

        </div>

        <div class="input-group">

            <label>Phone Number</label>

            <asp:TextBox
            ID="txtPhone"
            runat="server"
            CssClass="input-box"></asp:TextBox>

        </div>

        <asp:Button
        ID="btnSave"
        runat="server"
        Text="Save Changes"
        CssClass="save-btn" />

    </div>

</div>

</form>

</body>
</html>