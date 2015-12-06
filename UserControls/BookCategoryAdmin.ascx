<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BookCategoryAdmin.ascx.cs" Inherits="BookCategoryAdmin" %>
<asp:Label ID="statusLabel" runat="server" CssClass="AdminPageText" Text="BookCategory Loaded"></asp:Label><br />
<br />
<asp:Label ID="locationLabel" runat="server" CssClass="AdminPageText" Text="These are your BookCategory:"></asp:Label><br />
<br />
<asp:GridView ID="grid" runat="server" AutoGenerateColumns="False" DataKeyNames="BookCategoryID" Width="100%" OnRowCancelingEdit="grid_RowCancelingEdit" OnRowDeleting="grid_RowDeleting" OnRowEditing="grid_RowEditing" OnRowUpdating="grid_RowUpdating">
  <Columns>
    <asp:BoundField DataField="Name" HeaderText="BookCategory Name" SortExpression="Name" />
    <asp:TemplateField HeaderText="BookCategory Description" SortExpression="Description">
      <ItemTemplate>
        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
      </ItemTemplate>
      <EditItemTemplate>
        <asp:TextBox ID="descriptionTextBox" runat="server" Text='<%# Bind("Description") %>' Height="70px" TextMode="MultiLine" Width="350px"></asp:TextBox>
      </EditItemTemplate>
    </asp:TemplateField>
    <asp:HyperLinkField DataNavigateUrlFields="BookCategoryID" DataNavigateUrlFormatString="../CatalogAdmin.aspx?BookCategoryID={0}"
      Text="View Categories" />
    <asp:CommandField ShowEditButton="True" />
    <asp:ButtonField CommandName="Delete" Text="Delete" />
  </Columns>
</asp:GridView>
<br />
<span class="AdminPageText">Create a new BookCategory:</span>
<table class="AdminPageText" cellspacing="0">
  <tr>
    <td valign="top" width="100">Name:
    </td>
    <td>
      <asp:TextBox cssClass="AdminPageText" ID="newName" Runat="server" 
Width="400px" />      
    </td>
  </tr>
  <tr>
    <td valign="top" width="100">Description:
    </td>
    <td>
      <asp:TextBox cssClass="AdminPageText" ID="newDescription" Runat="server" Width="400px" Height="70px" TextMode="MultiLine"/>
    </td>
  </tr>
</table>
<asp:Button ID="createBookCategory" Text="Create BookCategory" Runat="server" 
CssClass="Button" OnClick="createBookCategory_Click" />
