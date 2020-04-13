package global.sesoc.brr.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * ?��?��?�� 로그?�� ?��?�� ?��?��?��?��. HandlerInterceptorAdapter�? ?��?��받아?�� ?��?��.
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	// 콘트롤러?�� 메서?�� ?��?�� ?��?�� 처리
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.debug("LoginInterceptor ?��?��");

		// ?��?��?�� 로그?�� ?���? ?���?
		HttpSession httpsession = request.getSession();
		String id = (String)httpsession.getAttribute("sessionId");

		// 로그?��?���? ?��?? 경우 로그?�� ?��?���?�? ?��?��
		if (id == null) {
			// request.getContextPath()�? 루트 경로�? 구하?�� ?��?? 경로�? 처리
			
			//member/login => 네이버, 구글 로그인 통합 경로 jsp를 구현 후 연결 하도록 하겠음.
			
			response.sendRedirect(request.getContextPath() + "/examples/login");
			return false;
		}
		// 로그?�� ?�� 경우 ?���??�� 경로�? 진행
		return super.preHandle(request, response, handler);
	}

}
