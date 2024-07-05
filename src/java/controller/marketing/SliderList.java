
package controller.marketing;

import dao.SlideDAO;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Slide;
public class SliderList extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        SlideDAO sdao = new SlideDAO();
        HttpSession session = request.getSession();
        int userId = 1;
        String action = request.getParameter("action");
        if (action == null) {
            String status = request.getParameter("status");
            String search = request.getParameter("search");
            String typeSearch = request.getParameter("type-search");
            String title = "";
            String backlink = "";
            if ("0".equals(typeSearch)) {
                title = search;
            }
            if ("1".equals(typeSearch)) {
                backlink = search;
            }
            if (status == null) {
                status = "";
            }
            int numberSlide = sdao.getNumberSlideWithCondition(status, title, backlink);
            int numberPage = (int) Math.ceil((double) numberSlide / 9);
            int index;
            String currentPage = request.getParameter("index");
            if (currentPage == null) {
                index = 1;
            } else {
                index = Integer.parseInt(currentPage);
            }
            ArrayList<Slide> slist = sdao.getAllSlideWithCondition(status, title, backlink, index);
            request.setAttribute("numberPage", numberPage);
            request.setAttribute("slist", slist);
            request.getRequestDispatcher("./marketing/sliderlist.jsp").forward(request, response);
        }
        if ("edit".equals(action)) {
            String slidetitle = request.getParameter("slidetitle");
            String slideimage = request.getParameter("slideimage");
            String slidebacklink = request.getParameter("slidebacklink");
            String slidedescript = request.getParameter("slidedescript");
            String slidestatus = request.getParameter("slidestatus");
            String slideid = request.getParameter("slideid");
            sdao.updateSlide(slidetitle, slideimage, slidebacklink, userId, slidedescript, Integer.valueOf(slidestatus), Integer.valueOf(slideid));
            response.sendRedirect("sliderlist");
        }
        if ("switch".equals(action)) {
            String sid = request.getParameter("sid");
            String sstatus = request.getParameter("sstatus");
            sdao.switchStatus(Integer.valueOf(sid), Integer.valueOf(sstatus));
            response.sendRedirect("sliderlist");
        }
        if ("delete".equals(action)) {
            String sid = request.getParameter("sid");
            sdao.deleteSlide(Integer.valueOf(sid));
            response.sendRedirect("sliderlist");
        }

    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}



