package global.sesoc.brr.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * ?‚¬?š©? ë¡œê·¸?¸ ?™•?¸ ?¸?„°?…‰?„°. HandlerInterceptorAdapterë¥? ?ƒ?†ë°›ì•„?„œ ? •?˜.
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	// ì½˜íŠ¸ë¡¤ëŸ¬?˜ ë©”ì„œ?“œ ?‹¤?–‰ ? „?— ì²˜ë¦¬
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.debug("LoginInterceptor ?‹¤?–‰");

		// ?„¸?…˜?˜ ë¡œê·¸?¸ ? •ë³? ?½ê¸?
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		// ë¡œê·¸?¸?˜ì§? ?•Š?? ê²½ìš° ë¡œê·¸?¸ ?˜?´ì§?ë¡? ?´?™
		if (id == null) {
			// request.getContextPath()ë¡? ë£¨íŠ¸ ê²½ë¡œë¥? êµ¬í•˜?—¬ ? ˆ?? ê²½ë¡œë¡? ì²˜ë¦¬
			response.sendRedirect(request.getContextPath() + "/member/login");
			return false;
		}
		// ë¡œê·¸?¸ ?œ ê²½ìš° ?š”ì²??•œ ê²½ë¡œë¡? ì§„í–‰
		return super.preHandle(request, response, handler);
	}

}
