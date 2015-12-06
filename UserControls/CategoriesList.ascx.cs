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

public partial class CategoriesList : System.Web.UI.UserControl
{
  protected void Page_Load(object sender, EventArgs e)
  {
    // don't reload data during postbacks
    if (!IsPostBack)
    {
        // Obtain the ID of the selected BookCategory
        string BookCategoryId = Request.QueryString["BookCategoryID"];
        // Continue only if BookCategoryID exists in the query string
        if (BookCategoryId != null)
      {
          // Catalog.GetCategoriesInBookCategory returns a DataTable object containing
        // category data, which is displayed by the DataList
          list.DataSource = CatalogAccess.GetCategoriesInBookCategory(BookCategoryId);
        // Needed to bind the data bound controls to the data source
        list.DataBind();
        // Make space for the next control
        brLabel.Text = "<br />";
      }
    }
  }
}
