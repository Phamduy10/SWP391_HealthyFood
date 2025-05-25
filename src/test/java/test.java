
import com.example.servlet.dao.NutritionistDAO;
import com.example.servlet.model.Blogs;
import java.sql.Timestamp;
import java.util.List;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Admin
 */
public class test {
    
    public static void main(String[] args) {
        dis3();
    }
    public static void dis(){
        NutritionistDAO _dao = new NutritionistDAO();
        List<Blogs> lstBlog = _dao.getBlogsByFilter("d" , 2 , true);
        System.out.println("Aloo Xin chào ");
        for(Blogs b : lstBlog){
            System.out.println(b.toString());
            System.out.println("Bai moi ne");
        }
    }
   public static void dis2() {
    NutritionistDAO _dao = new NutritionistDAO();
    Blogs testBlog = new Blogs(
    11, // blogID
    9,  // authorID
    "Nguyễn Văn Dũng", // authorName
    2,  // bmiId
    "Test update moi ne truoc deu th ", // title
    "https://example.com/imascdumay.jpg", // imageUlr
    "Nội dung chi tiết về chế độ ăn theo BMI.", // content
    "Private", // status
    new Timestamp(System.currentTimeMillis()), // create_at
    new Timestamp(System.currentTimeMillis())  // update_at
);

     System.out.println(testBlog);
//     _dao.insertBlog(testBlog);
     _dao.updateBlog(testBlog);
    
}
   public static void dis3() {
    NutritionistDAO _dao = new NutritionistDAO();
    _dao.deleteBlogByID(11);
}

}
