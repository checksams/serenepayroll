<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="SerenePayroll.About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        About
    </h2>
    <p>
        Serene Payroll Version 10.0.0
        <asp:Button ID="btnPopup" runat="server" Text="Popup" 
            onclick="btnPopup_Click" />
    </p>
    <a href="javascript:void(0)" id="example2_1">error</a>

    <div>

    </div>

<div class="wrap">

  <h1>Modal - Pure CSS (no Javascript)</h1>
  
  <p>Example of modal in CSS only, here I use the pseudo selector ":target" and no javascript for modal action.</p>
  
  <p>This works in IE9+ and all modern browsers.</p>
  
  <hr />
  
  <a href="#modal-one" class="btn btn-big">Modal!</a>
  <a href="#modal-two" class="btn btn-big">Modal!</a>
  
</div>
 
<!-- Modal -->
<a href="#" class="modal" id="modal-one" aria-hidden="true">
  </a>
  <div class="modal-dialog">
    <div class="modal-header">
      <h2>Modal in CSS?</h2>
      <a href="#" class="btn-close" aria-hidden="true">×</a>
    </div>
    <div class="modal-body">
      <p>One modal example here! :D</p>
    </div>
    <div class="modal-footer">
      <a href="#" class="btn">Nice!</a>
    </div>
  </div>

<!-- /Modal -->
<!-- Modal2 -->
<a href="#" class="modal" id="modal-two" aria-hidden="true">
  </a>
  <div class="modal-dialog">
    <div class="modal-header">
      <h2>Modal in TWO</h2>
      <a href="#" class="btn-close" aria-hidden="true">×</a>
    </div>
    <div class="modal-body">
      <p>Two modal example here! :D</p>
    </div>
    <div class="modal-footer">
      <a href="#" class="btn">Nice!</a>
    </div>
  </div>

<!-- /Modal2 -->
</asp:Content>
