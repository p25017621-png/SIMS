﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SIMS.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>SIMS Login</title>

    <!-- CSS -->
    <link href="Assets/CSS/global.css" rel="stylesheet" />
    <link href="Assets/CSS/auth.css" rel="stylesheet" />
    <link href="Assets/CSS/components.css" rel="stylesheet" />

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

</head>

<body>

    <form id="form1" runat="server">

        <div class="login-page">

            <!-- Background Blur -->
            <div class="blur-circle circle1"></div>
            <div class="blur-circle circle2"></div>

            <!-- Login Card -->
            <div class="login-container">

                <h1 class="login-title">
                    Welcome Back
                </h1>

                <p class="login-subtitle">
                    Login to continue to SIMS
                </p>

                <!-- Email -->
<div class="form-group">

    <label class="form-label">
        Email Address
    </label>

    <asp:TextBox
        ID="txtEmail"
        runat="server"
        CssClass="form-input"
        placeholder="Enter your email">
    </asp:TextBox>

    <asp:RequiredFieldValidator
        ID="rfvEmail"
        runat="server"
        ControlToValidate="txtEmail"
        ErrorMessage="Email is required."
        ForeColor="Red"
        Display="Dynamic">
    </asp:RequiredFieldValidator>

</div>

                <!-- Password -->
<div class="form-group">

    <label class="form-label">
        Password
    </label>

    <asp:TextBox
        ID="txtPassword"
        runat="server"
        TextMode="Password"
        CssClass="form-input"
        placeholder="Enter your password">
    </asp:TextBox>

    <asp:RequiredFieldValidator
        ID="rfvPassword"
        runat="server"
        ControlToValidate="txtPassword"
        ErrorMessage="Password is required."
        ForeColor="Red"
        Display="Dynamic">
    </asp:RequiredFieldValidator>

</div>

                <!-- Login Button -->
                <div style="text-align: center; width: 100%;">
                <asp:Button ID="btnLogin"
                    runat="server"
                    Text="Login"
                    CssClass="primary-btn"
                    OnClick="btnLogin_Click" />
                  </div>
                <div style="margin-top:18px; text-align:center; width: 100%;">
                <a href="ForgotPassword.aspx"
                  style="text-decoration:none; color:#6366f1; font-weight:600;">
                  Forgot Password?
                </a>
                 </div>

                <!-- Error Message -->
                <asp:Label ID="lblMessage"
                    runat="server"
                    CssClass="error-message">
                </asp:Label>

            </div>

        </div>

    </form>

</body>
</html>