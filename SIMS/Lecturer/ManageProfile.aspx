<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageProfile.aspx.cs" Inherits="SIMS.Lecturer.ManageProfile" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Manage Profile – SIMS</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<style>
:root{--purple:#6c4ef2;--purple-mid:#7c5cf5;--purple-light:#a78bfa;--purple-pale:#ede9fe;--sidebar-bg:#5b3ee8;--sidebar-dark:#4a30cc;--white:#ffffff;--bg:#f4f5fb;--text:#1e1b3a;--muted:#7b7898;--border:#e8e5f5;--card-shadow:0 4px 24px rgba(108,78,242,.10);--radius:16px;}
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'DM Sans',sans-serif;background:var(--bg);color:var(--text);display:flex;min-height:100vh;}
.sidebar{width:230px;min-height:100vh;background:linear-gradient(175deg,var(--sidebar-bg) 0%,var(--sidebar-dark) 100%);display:flex;flex-direction:column;padding:28px 18px;position:fixed;top:0;left:0;bottom:0;z-index:100;}
.sidebar-logo{display:flex;align-items:center;gap:12px;margin-bottom:36px;}
.logo-icon{width:42px;height:42px;background:rgba(255,255,255,.18);border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;color:#fff;}
.logo-text h2{color:#fff;font-size:18px;font-weight:700;line-height:1;}
.logo-text p{color:rgba(255,255,255,.6);font-size:11px;margin-top:2px;}
.nav-label{font-size:10px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;color:rgba(255,255,255,.45);padding:0 10px;margin:18px 0 8px;}
.nav-item{display:flex;align-items:center;gap:12px;padding:11px 14px;border-radius:12px;color:rgba(255,255,255,.75);font-size:14px;font-weight:500;cursor:pointer;text-decoration:none;margin-bottom:3px;transition:background .2s,color .2s;}
.nav-item i{width:18px;text-align:center;font-size:15px;}
.nav-item:hover,.nav-item.active{background:rgba(255,255,255,.18);color:#fff;}
.sidebar-footer{margin-top:auto;background:rgba(255,255,255,.12);border-radius:14px;padding:14px;display:flex;align-items:center;gap:12px;}
.avatar-circle{width:38px;height:38px;border-radius:50%;background:rgba(255,255,255,.25);color:#fff;font-weight:700;font-size:16px;display:flex;align-items:center;justify-content:center;flex-shrink:0;}
.sidebar-footer .user-info h4{color:#fff;font-size:13px;font-weight:600;}
.sidebar-footer .user-info p{color:rgba(255,255,255,.6);font-size:11px;}
.main{margin-left:230px;flex:1;padding:32px 36px;}
.topbar{display:flex;align-items:center;justify-content:space-between;margin-bottom:28px;}
.topbar h1{font-size:26px;font-weight:700;}
.topbar p{font-size:13px;color:var(--muted);margin-top:2px;}
.topbar-right{display:flex;align-items:center;gap:14px;}
.icon-btn{width:40px;height:40px;background:var(--white);border:1px solid var(--border);border-radius:12px;display:flex;align-items:center;justify-content:center;cursor:pointer;color:var(--muted);font-size:15px;}
.top-avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,var(--purple),var(--purple-light));color:#fff;font-weight:700;font-size:16px;display:flex;align-items:center;justify-content:center;}
.hero{background:linear-gradient(130deg,#6c4ef2 0%,#8b6cf9 55%,#a78bfa 100%);border-radius:22px;padding:36px 40px;position:relative;overflow:hidden;color:#fff;margin-bottom:28px;display:flex;align-items:center;justify-content:space-between;box-shadow:0 12px 40px rgba(108,78,242,.30);}
.hero::before{content:'';position:absolute;width:320px;height:320px;border-radius:50%;background:rgba(255,255,255,.07);top:-100px;right:-60px;}
.hero-text h2{font-size:28px;font-weight:700;margin-bottom:8px;}
.hero-text p{font-size:14px;color:rgba(255,255,255,.8);}
.hero-graphic{width:90px;height:90px;background:rgba(255,255,255,.12);border-radius:18px;display:flex;align-items:center;justify-content:center;font-size:38px;position:relative;z-index:1;flex-shrink:0;}
.profile-layout{display:grid;grid-template-columns:280px 1fr;gap:24px;}
.profile-card{background:var(--white);border-radius:var(--radius);padding:30px 24px;box-shadow:var(--card-shadow);border:1px solid var(--border);display:flex;flex-direction:column;align-items:center;text-align:center;}
.profile-avatar{width:100px;height:100px;border-radius:50%;background:linear-gradient(135deg,var(--purple),var(--purple-light));color:#fff;font-size:38px;font-weight:700;display:flex;align-items:center;justify-content:center;margin-bottom:16px;}
.profile-card h3{font-size:18px;font-weight:700;margin-bottom:4px;}
.profile-card .role{font-size:13px;color:var(--muted);margin-bottom:20px;}
.profile-stat{width:100%;background:var(--purple-pale);border-radius:12px;padding:12px 16px;margin-bottom:10px;text-align:left;}
.profile-stat .ps-label{font-size:11px;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;}
.profile-stat .ps-val{font-size:14px;font-weight:600;color:var(--text);margin-top:2px;}
.form-card{background:var(--white);border-radius:var(--radius);padding:30px;box-shadow:var(--card-shadow);border:1px solid var(--border);}
.form-card h3{font-size:17px;font-weight:700;margin-bottom:24px;padding-bottom:14px;border-bottom:1px solid var(--border);}
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:18px;margin-bottom:18px;}
.form-group{display:flex;flex-direction:column;gap:6px;}
.form-group.full{grid-column:1/-1;}
.form-group label{font-size:13px;font-weight:600;color:var(--text);}
.form-group input,.form-group select,.form-group textarea{padding:11px 14px;border:1.5px solid var(--border);border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;color:var(--text);background:var(--bg);transition:border .2s;}
.form-group input:focus,.form-group select:focus,.form-group textarea:focus{outline:none;border-color:var(--purple);background:#fff;}
.form-group textarea{resize:vertical;min-height:90px;}
.btn-row{display:flex;gap:12px;margin-top:24px;}
.dash-btn{padding:11px 26px;background:linear-gradient(135deg,var(--purple),var(--purple-mid));color:#fff;border:none;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:600;cursor:pointer;box-shadow:0 4px 14px rgba(108,78,242,.35);transition:transform .2s;}
.dash-btn:hover{transform:scale(1.04);}
.btn-outline{padding:11px 26px;background:transparent;color:var(--purple);border:1.5px solid var(--purple);border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:600;cursor:pointer;transition:background .2s;}
.btn-outline:hover{background:var(--purple-pale);}
@keyframes fadeUp{from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:translateY(0);}}
.hero{animation:fadeUp .5s ease both;}
.profile-layout{animation:fadeUp .5s .1s ease both;}
</style>
</head>
<body>
<form id="form1" runat="server">
<aside class="sidebar">
  <div class="sidebar-logo">
    <div class="logo-icon"><i class="fa-solid fa-graduation-cap"></i></div>
    <div class="logo-text"><h2>SIMS</h2><p>Lecturer Panel</p></div>
  </div>
  <span class="nav-label">Main</span>
  <a href="LecturerDashboard.aspx" class="nav-item"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
  <a href="ManageAttendance.aspx" class="nav-item"><i class="fa-solid fa-calendar-check"></i> Attendance</a>
  <a href="ManageMarks.aspx" class="nav-item"><i class="fa-solid fa-chart-column"></i> Marks</a>
  <a href="ViewStudents.aspx" class="nav-item"><i class="fa-solid fa-user-graduate"></i> Students</a>
  <span class="nav-label">Account</span>
  <a href="ManageProfile.aspx" class="nav-item active"><i class="fa-solid fa-user-pen"></i> Profile</a>
  <div class="sidebar-footer">
    <div class="avatar-circle">L</div>
    <div class="user-info"><h4>Lecturer</h4><p>Welcome Back!</p></div>
    <i class="fa-solid fa-chevron-right" style="margin-left:auto;color:rgba(255,255,255,.5);font-size:12px;"></i>
  </div>
</aside>
<main class="main">
  <div class="topbar">
    <div><h1>My Profile</h1><p>Manage your personal information</p></div>
    <div class="topbar-right">
      <div class="icon-btn"><i class="fa-regular fa-bell"></i></div>
      <div class="top-avatar">L</div>
    </div>
  </div>
  <div class="hero">
    <div class="hero-text">
      <h2>Profile Settings 👤</h2>
      <p>Update your personal info and account details.</p>
    </div>
    <div class="hero-graphic"><i class="fa-solid fa-user-pen"></i></div>
  </div>
  <div class="profile-layout">
    <div class="profile-card">
      <div class="profile-avatar">L</div>
      <h3>Dr. Lecturer</h3>
      <div class="role">Senior Lecturer</div>
      <div class="profile-stat"><div class="ps-label">Staff ID</div><div class="ps-val">LEC-2024-001</div></div>
      <div class="profile-stat"><div class="ps-label">Department</div><div class="ps-val">Computer Science</div></div>
      <div class="profile-stat"><div class="ps-label">Email</div><div class="ps-val">lecturer@sims.edu</div></div>
      <div class="profile-stat"><div class="ps-label">Phone</div><div class="ps-val">+60 12-345 6789</div></div>
    </div>
    <div class="form-card">
      <h3>Edit Personal Information</h3>
      <div class="form-row">
        <div class="form-group">
          <label>First Name</label>
          <asp:TextBox ID="txtFirstName" runat="server" placeholder="First Name" />
        </div>
        <div class="form-group">
          <label>Last Name</label>
          <asp:TextBox ID="txtLastName" runat="server" placeholder="Last Name" />
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Staff ID</label>
          <asp:TextBox ID="txtStaffID" runat="server" placeholder="Staff ID" ReadOnly="true" />
        </div>
        <div class="form-group">
          <label>Department</label>
          <asp:TextBox ID="txtDepartment" runat="server" placeholder="Department" />
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Email Address</label>
          <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" TextMode="Email" />
        </div>
        <div class="form-group">
          <label>Phone Number</label>
          <asp:TextBox ID="txtPhone" runat="server" placeholder="Phone Number" />
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>New Password</label>
          <asp:TextBox ID="txtPassword" runat="server" placeholder="Leave blank to keep current" TextMode="Password" />
        </div>
        <div class="form-group">
          <label>Confirm Password</label>
          <asp:TextBox ID="txtConfirmPassword" runat="server" placeholder="Confirm new password" TextMode="Password" />
        </div>
      </div>
      <div class="form-row">
        <div class="form-group full">
          <label>Bio / About</label>
          <asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine" placeholder="Write a short bio..." />
        </div>
      </div>
      <div class="btn-row">
        <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="dash-btn" OnClick="btnSave_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-outline" OnClick="btnCancel_Click" />
      </div>
    </div>
  </div>
</main>
</form>
</body>
</html>