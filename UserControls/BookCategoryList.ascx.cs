using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class BookCategoryList : System.Web.UI.UserControl
{
    // Load BookCategory details into the DataList
  protected void Page_Load(object sender, EventArgs e)
  {
    // don't reload data during postbacks
    if (!IsPostBack)
    {
        // CatalogAccess.GetBookCategory returns a DataTable object containing
        // BookCategory data, which is read in the ItemTemplate of the DataList
        list.DataSource = CatalogAccess.GetBookCategory();
      // Needed to bind the data bound controls to the data source
      list.DataBind();
    }
  }
}
