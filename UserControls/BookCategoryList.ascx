<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BookCategoryList.ascx.cs" Inherits="BookCategoryList" %>
<asp:DataList ID="list" runat="server" Width="200px" CssClass="BookCategoryListContent">
  <ItemTemplate>
    &nbsp;&raquo;
    <asp:HyperLink 
      ID="HyperLink1" 
      Runat="server" 
      NavigateUrl='<%# "../Catalog.aspx?BookCategoryID=" + Eval("BookCategoryID")%>'
      Text='<%# Eval("Name") %>'
      ToolTip='<%# Eval("Description") %>'
      CssClass='<%# Eval("BookCategoryID").ToString() == Request.QueryString["BookCategoryID"] ? "BookCategorySelected" : "BookCategoryUnselected" %>'>
    </asp:HyperLink>
    &nbsp;&laquo;
 </ItemTemplate>
  <HeaderTemplate>
    Choose a Book Category
  </HeaderTemplate>
  <HeaderStyle CssClass="BookCategoryListHead" />
</asp:DataList>
