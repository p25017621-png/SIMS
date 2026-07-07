<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageProfile.aspx.cs" Inherits="SIMS.Lecturer.ManageProfile" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="UTF-8"/>
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
.nav-item i{width:18px;text-align:center;}
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
.profile-stat .ps-label{font-size:11px;color:var(--muted);font-weight:600;text-transform:uppercase;}
.profile-stat .ps-val{font-size:14px;font-weight:600;color:var(--text);margin-top:2px;}
.form-card{background:var(--white);border-radius:var(--radius);padding:30px;box-shadow:var(--card-shadow);border:1px solid var(--border);}
.form-card h3{font-size:17px;font-weight:700;margin-bottom:24px;padding-bottom:14px;border-bottom:1px solid var(--border);}
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:18px;margin-bottom:18px;}
.form-group{display:flex;flex-direction:column;gap:6px;}
.form-group.full{grid-column:1/-1;}
.form-group label{font-size:13px;font-weight:600;color:var(--text);}
.form-group input,.form-group textarea{padding:11px 14px;border:1.5px solid var(--border);border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;color:var(--text);background:var(--bg);transition:border .2s;outline:none;}
.form-group input:focus,.form-group textarea:focus{border-color:var(--purple);background:#fff;}
.form-group textarea{resize:vertical;min-height:90px;}
.btn-row{display:flex;gap:12px;margin-top:24px;}
.dash-btn{padding:11px 26px;background:linear-gradient(135deg,var(--purple),var(--purple-mid));color:#fff;border:none;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:600;cursor:pointer;box-shadow:0 4px 14px rgba(108,78,242,.35);transition:transform .2s;}
.dash-btn:hover{transform:scale(1.04);}
.btn-outline{padding:11px 26px;background:transparent;color:var(--purple);border:1.5px solid var(--purple);border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:600;cursor:pointer;}
.msg-success{background:#d1fae5;border:1.5px solid #34d399;color:#065f46;border-radius:10px;padding:12px 18px;margin-top:16px;font-size:13px;font-weight:600;}
.msg-error{background:#fee2e2;border:1.5px solid #ef4444;color:#991b1b;border-radius:10px;padding:12px 18px;margin-top:16px;font-size:13px;font-weight:600;}
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
  <div class="sidebar-footer" onclick="confirmLogout()" style="cursor:pointer;background:rgba(239,68,68,.15);border:1.5px solid rgba(239,68,68,.3);" onmouseover="this.style.background='rgba(239,68,68,.3)'" onmouseout="this.style.background='rgba(239,68,68,.15)'">
    <div class="avatar-circle" style="background:#ef4444;">
        <i class="fa-solid fa-right-from-bracket"></i>
    </div>
    <div class="user-info">
        <h4 style="color:#fca5a5;">Logout</h4>
        <p style="color:rgba(252,165,165,.7);">Click to sign out</p>
    </div>
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
    <div class="hero-text"><h2>Profile Settings 👤</h2><p>Update your personal info and account details.</p></div>
    <div class="hero-graphic"><i class="fa-solid fa-user-pen"></i></div>
  </div>
  <div class="profile-layout">
    <div class="profile-card">
      <div class="profile-avatar">L</div>
      <h3><asp:Label ID="lblFullName" runat="server" Text="Lecturer"/></h3>
      <div class="role">Lecturer</div>
      <div class="profile-stat"><div class="ps-label">Department</div><div class="ps-val"><asp:Label ID="lblDept" runat="server" Text="—"/></div></div>
      <div class="profile-stat"><div class="ps-label">Qualification</div><div class="ps-val"><asp:Label ID="lblQual" runat="server" Text="—"/></div></div>
      <div class="profile-stat"><div class="ps-label">Email</div><div class="ps-val"><asp:Label ID="lblEmail" runat="server" Text="—"/></div></div>
      <div class="profile-stat"><div class="ps-label">Phone</div><div class="ps-val"><asp:Label ID="lblPhone" runat="server" Text="—"/></div></div>
    </div>
    <div class="form-card">
      <h3>Edit Personal Information</h3>
      <div class="form-row">
        <div class="form-group">
          <label>Full Name</label>
          <asp:TextBox ID="txtName" runat="server" placeholder="Full Name" style="padding:11px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;"/>
        </div>
        <div class="form-group">
          <label>Email</label>
          <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" TextMode="Email" style="padding:11px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;"/>
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Phone</label>
          <asp:TextBox ID="txtPhone" runat="server" placeholder="Phone Number" style="padding:11px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;"/>
        </div>
        <div class="form-group">
          <label>Department</label>
          <asp:TextBox ID="txtDepartment" runat="server" placeholder="Department" style="padding:11px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;"/>
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Qualification</label>
          <asp:TextBox ID="txtQualification" runat="server" placeholder="Qualification" style="padding:11px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;"/>
        </div>
        <div class="form-group">
          <label>New Password (leave blank to keep)</label>
          <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="New password" style="padding:11px 14px;border:1.5px solid #e8e5f5;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;background:#f4f5fb;"/>
        </div>
      </div>
      <div class="btn-row">
        <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="dash-btn" OnClick="btnSave_Click"/>
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-outline" OnClick="btnCancel_Click"/>
      </div>
      <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
        <div class="msg-success">✅ Profile updated successfully!</div>
      </asp:Panel>
      <asp:Panel ID="pnlError" runat="server" Visible="false">
        <div class="msg-error">❌ <asp:Label ID="lblError" runat="server"/></div>
      </asp:Panel>
    </div>
  </div>
</main>
</form>
    <script>
function confirmLogout() {
    if (confirm('Are you sure you want to logout?')) {
        window.location.href = '../Login.aspx';
    }
}
    </script>
</body>
</html>