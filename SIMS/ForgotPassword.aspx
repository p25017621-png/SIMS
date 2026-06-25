<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="SIMS.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Forgot Password</title>

    <link href="Assets/CSS/global.css" rel="stylesheet" />
    <link href="Assets/CSS/auth.css" rel="stylesheet" />
    <link href="Assets/CSS/components.css" rel="stylesheet" />

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet" />

</head>

<body>

    <form id="form1" runat="server">

        <div class="login-page">

            <div class="blur-circle circle1"></div>
            <div class="blur-circle circle2"></div>

            <div class="login-container glass-card">

                <h1 class="login-title">
                    Reset Password
                </h1>

                <p class="login-subtitle">
                    Enter your email and new password
                </p>

                <!-- EMAIL -->
                <div class="form-group">

                    <label class="form-label">
                        Email Address
                    </label>

                    <asp:TextBox ID="txtEmail"
                        runat="server"
                        CssClass="form-input"
                        placeholder="Enter your email">
                    </asp:TextBox>

                </div>

                <!-- NEW PASSWORD -->
                <div class="form-group">

                    <label class="form-label">
                        New Password
                    </label>

                    <asp:TextBox ID="txtNewPassword"
                        runat="server"
                        TextMode="Password"
                        CssClass="form-input"
                        placeholder="Enter new password">
                    </asp:TextBox>

                </div>

                <!-- CONFIRM PASSWORD -->
                <div class="form-group">

                    <label class="form-label">
                        Confirm Password
                    </label>

                    <asp:TextBox ID="txtConfirmPassword"
                        runat="server"
                        TextMode="Password"
                        CssClass="form-input"
                        placeholder="Confirm new password">
                    </asp:TextBox>

                </div>

                <!-- RESET BUTTON -->
                <div style="text-align: center; width: 100%;">
                <asp:Button ID="btnResetPassword"
                    runat="server"
                    Text="Reset Password"
                    CssClass="primary-btn"
                    OnClick="btnResetPassword_Click" />
                </div>

                <asp:Label ID="lblMessage"
                    runat="server"
                    CssClass="error-message">
                </asp:Label>

                <div style="margin-top:20px; text-align:center;">

                    <a href="Login.aspx"
                        style="text-decoration:none; color:#6366f1; font-weight:600;">
                        Back to Login
                    </a>

                </div>

            </div>

        </div>

    </form>

</body>
</html>