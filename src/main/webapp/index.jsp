<%-- 
    Document   : index
    Created on : Sep 18, 2023, 2:30:14 PM
    Author     : sai
--%>

<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ranjan -Home</title>
        
        
        <%@include file="components/common_css_js.jsp" %>
        
    </head>
    <body>
        
        <%@include file="components/navbar.jsp" %>
        
        <div class="container-fluid">
            
        <div class="row mt-3 mx-2">
            <% 
                
                
              String cat = request.getParameter("category");
                           
              
            ProductDao dao = new ProductDao(FactoryProvider.getFactory());
            
            List<Product> list= dao.getAllProducts();
            if(cat!=null)
            {
             if (cat.trim().equals("all")) 
            {
                list = dao.getAllProducts();
            
            }
            else{
            
                 int cid=Integer.parseInt(cat.trim());
                 list=dao.getAllProductsById(cid);
                
            }
            }
                  
            CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
            List<Category> clist = cdao.getCategories();
            
            
            %>
            
            
            
          <!--Show Categories-->
            <div class="col-md-2">
               
                
                <div class="list-group mt-4">
                    <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                  All Products
                 </a> 
                   
                    
                    
                
                
                
   
                <% 
                for (Category c: clist)
                {
                
                %>
                
                <a href="index.jsp?category=<%= c.getCategoryId() %>" class="list-group-item list-group-item-action"><%= c.getCategoryTitle() %></a> 
                
                
                <%
                }
                
                              
                %>
                
                </div>
                
            </div>
          
          
          <!--Show Products-->
            <div class="col-md-10">
                
            <!-- Row-->
            <div class="row mt-4">
                
               <!--Col:12-->
                <div class="col-md-12">
                    
                    <div class="card-columns">
                        
                 <!--Traversing Products-->
                 <%
                  
                   for(Product p: list){
                 
                 
                 
                 %> 
                 <!--Product Card-->
                 <div class="card product-card">
                  
                     <div class="container text-center">
                          <img src="img/products/<%= p.getpPhoto() %>" style="max-height: 300px;max-width: 100%; width: auto;" class="card-img-top m-2" alt="..">
                     </div> 
                     
                     <div class="card-body">
                         
                         <h5 class="card-title"><%= p.getpName() %></h5>  
                         <p class="card-text">
                             <%= Helper.get10Words(p.getpDesc()) %>
                                                          
                         </p>
                         
                         
                     </div>
                             
                             <div class="card-footer text-center">
                                 <button class="btn btn-outline-success"> &#8377; <%= p.getPriceAfterApplyingDiscount()%>/- <span class="text-secondary discount-label"> &#8377;<%= p.getpPrice()%> , <%= p.getpDiscount() %>% off</span></button>  
                                 <button class="btn custom-bg text-white" onclick="add_to_cart(<%= p.getpId() %> , '<%= p.getpName() %>' , <%= p.getPriceAfterApplyingDiscount() %>)">Add to Cart</button>  
                             
                             </div>         
                             
                     
                     
                 </div>
                        
                 
                 
                 
                 
                         
                 
                 
                 
                 
                 <%
                   }  

                  if(list.size() == 0){
                    out.println("<h3>No items in this Category</h3>");
                   }

                   
                 %>
                 
                 
                 
                 
                 
                        
                    </div>
                    
                </div>
            </div>              
                
                
            </div> 
        </div>
        
       
        </div>   
        
        
        <%@include file="components/common_modals.jsp" %> 
        
        
        
    </body>
</html>
