package memberController;

import domain.MemberVO;
import dto.MemberDTO;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.beanutils.BeanUtils;
import service.MemberService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDate;

@WebServlet("/addMember")
@Log4j2
public class AddmemberController extends HttpServlet {
    private final MemberService service=MemberService.INSTANCE;
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        log.info("add GET");
        try {
            request.getRequestDispatcher("WEB-INF/member/addMember.jsp").forward(request,response);
        }catch (Exception e) {
            log.info("두겟에러");
            log.error(e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        try {
            req.setCharacterEncoding("UTF-8"); //db넣을떄 한글꺠지는거막음
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }


        MemberVO memberVO = MemberVO.builder()
                .emailId(req.getParameter("emailId"))
                .memberName(req.getParameter("memberName"))
                .password(req.getParameter("password"))
                .phone(req.getParameter("phone"))
                .birthday(LocalDate.parse(req.getParameter("birthday")))
                .build();


        try {
            log.info(memberVO);
            service.insertMember(memberVO);
            resp.sendRedirect("/");
        } catch (Exception e) {
            log.error("addcontroll ERROR");
            throw new RuntimeException(e.getMessage());

        }

    }
}
