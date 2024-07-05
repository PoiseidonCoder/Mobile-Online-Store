package controller.marketing;

import dao.FeedbackDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class FeedbackList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FeedbackDAO dao = new FeedbackDAO();
        String action = request.getParameter("action");
        if (action == null) {
            if (request.getParameter("star") == null) {
                int numberFeedback = dao.getNumberFeedbackWithCondition("", "", "", "");
                int numberPage = (int) Math.ceil((double) numberFeedback / 9);
                request.setAttribute("numberPage", numberPage);
                request.setAttribute("feedbackList", dao.getAllFeedbacks());
            } else {
                String search = request.getParameter("search");
                String typeSearch = request.getParameter("type-search");
                String fullname = "";
                String title = "";
                if (typeSearch.equals("0")) {
                    fullname = search;
                } else {
                    title = search;
                }
                int index;
                String currentPage = request.getParameter("index");
                if (currentPage == null) {
                    index = 1;
                } else {
                    index = Integer.parseInt(currentPage);
                }
                int numberFeedback = dao.getNumberFeedbackWithCondition(request.getParameter("star"), request.getParameter("status"),
                        fullname, title);
                int numberPage = (int) Math.ceil((double) numberFeedback / 9);
                request.setAttribute("numberPage", numberPage);
                request.setAttribute("feedbackList", dao.getFeedbackByConditions(request.getParameter("star"), request.getParameter("status"),
                        fullname, title, index));
            }
            request.getRequestDispatcher("./marketing/feedbacklist.jsp").forward(request, response);

        } else {
            if ("edit".equals(action)) {
                dao.updateStatusByFbID(request.getParameter("status"), request.getParameter("fid"));
            }
            if ("switch".equals(action)) {
                dao.updateStatusByFbID(request.getParameter("status"), request.getParameter("fid"));
            }
            response.sendRedirect("FeedbackList");
        }

    }

}
