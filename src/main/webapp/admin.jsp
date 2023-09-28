
<%@page import="java.util.Map"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.User"%>
<%

    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("message", "You are not logged in!! Login First");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not admin! Do not access this page");
            response.sendRedirect("login.jsp");
            return;
        }

    }


%>

    <%
                              
            CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
            List<Category> list = cdao.getCategories();
    

//       Getting Count
      Map<String,Long> m = Helper.getCounts(FactoryProvider.getFactory());


    %>





<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>


    </head>
    <body>

        <%@include file="components/navbar.jsp" %>



        <div class="container admin">
            
            
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>                
                
            </div>

            
            <div class="row mt-3">

                <!--  first col-->
                <div class="col-md-4">

                    <!--first box-->
                    <div class="card">

                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/team.png" alt="user_icon">
                            </div>
                            <h1><%= m.get("userCount") %></h1>
                            <h1 class="text-uppercase text-muted">User</h1>   

                        </div>

                    </div>

                </div>
                <!--Second col-->
                <div class="col-md-4">
                    <!--second box-->  
                    <div class="card">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/list.png" alt="user_icon">
                            </div>
                            <h1><%= list.size() %></h1>
                            <h1  class="text-uppercase text-muted">Categories</h1>   

                        </div>

                    </div>

                </div>
                <!--third col-->
                <div class="col-md-4">
                    <!--third box-->
                    <div class="card">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/delivery-box.png" alt="user_icon">
                            </div>
                            <h1><%= m.get("productCount") %></h1>
                            <h1  class="text-uppercase text-muted">Products</h1>   

                        </div>

                    </div>

                </div>


            </div>

            <!--Second Row-->
            <div class="row mt-3">
                
                <!--Second Row First Coln-->
                <div class="col-md-6">
                    
                    <div class="card" data-toggle="modal" data-target="#add-category-modal" >
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/keys.png" alt="user_icon">
                            </div>
                            <p class="mt-2">Click here to add new category</p>
                            <h1  class="text-uppercase text-muted">Add Category</h1>   

                        </div>

                    </div> 


                </div>
                <!--Second Row second Coln-->
                <div class="col-md-6">

                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid rounded-circle" src="img/plus.png" alt="user_icon">
                            </div>

                            <p class="mt-2">Click here to add new Product</p>
                            <h1  class="text-uppercase text-muted">Products</h1>   

                        </div>

                    </div>


                </div>

            </div> 



        </div>

        <!--add catergory model-->

    
        <!-- Modal For Category -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill category details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    
                    <div class="modal-body">
                        
                        <form action="ProductOperationServlet" method="post">
                            
                            <input type="hidden" name="operation" value="addcategory">
                            
                            
                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required /> 
                            </div>
                            
                            <div class="form-group">
                                <textarea style="height: 300px;" class="form-control" placeholder="Enter category description" name="catDescription" required></textarea>                                  
                            </div>
                            
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>
                                 <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                            
                        </form>
                        
                    </div>
                    
                </div>
            </div>
        </div>
   
        <!--Endcatergory model--> 
<!--       ==================================================================================================== -->
        <!-- Modal For Product -->
          <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill category details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="addproduct" />
                                                         
                            <div class="form-group">
                                <input type="text" class="form-control" name="pName" placeholder="Enter Product Name" required /> 
                            </div>
                            
                            <div class="form-group">
                                <textarea style="height: 100px;" class="form-control" placeholder="Enter Product Description" name="pDesc" required></textarea>                                  
                            </div>
                            
                                                         
                             <div class="form-group">
                                <input type="number" class="form-control" name="pPrice" placeholder="Enter Product Price" required /> 
                            </div>
                            
                             <div class="form-group">
                                <input type="number" class="form-control" name="pDiscount" placeholder="Enter Product Discount" required /> 
                            </div>
                            
                            <div class="form-group">
                                <input type="number" class="form-control" name="pQuantity" placeholder="Enter Product Quantity" required /> 
                            </div>
                            
                            <!--Product Categories-->
                            
                           
                            
                            
                                                      
                            <div class="form-group">
                                <select name="catId" class="form-control" id="">
                                    
                                    <%
                                      for(Category c:list){
                                      
                                                          

                                    %>
                                    
                                    
                                    <option value="<%= c.getCategoryId() %>"><%= c.getCategoryTitle() %> </option>
                                    
                                    <% 
                                        }
                                    %>                                   
                                    
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="pPic">Select Picture of Product</label>
                                <br>
                                <input type="file" id="pPic" name="pPic" required /> 
                            </div>
                           
                            
                            
                           <!--buttons-->
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Product</button>
                                 <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                            
                        </form>
                        
                    </div>
                    
                </div>
            </div>
        </div>
       <!--End Product model-->
       
       <%@include file="components/common_modals.jsp" %> %>
       
    </body>
</html>
