package global.sesoc.brr.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

/**
 * ?ŒŒ?¼ ê´?? ¨ ?œ ?‹¸
 * ?—…ë¡œë“œ?•œ ?ŒŒ?¼?˜ ???¥ & ?„œë²„ì— ???¥?œ ?ŒŒ?¼ ?‚­? œ ?“±?˜ ê¸°ëŠ¥ ? œê³?
 */
public class FileService {

	/**
	 * ?—…ë¡œë“œ ?œ ?ŒŒ?¼?„ ì§?? •?œ ê²½ë¡œ?— ???¥?•˜ê³?, ???¥?œ ?ŒŒ?¼ëª…ì„ ë¦¬í„´
	 * @param mfile ?—…ë¡œë“œ?œ ?ŒŒ?¼
	 * @param path ???¥?•  ê²½ë¡œ
	 * @return ???¥?œ ?ŒŒ?¼ëª?
	 */
	public static String saveFile(MultipartFile mfile, String uploadPath) {
		//?—…ë¡œë“œ?œ ?ŒŒ?¼?´ ?—†ê±°ë‚˜ ?¬ê¸°ê? 0?´ë©? ???¥?•˜ì§? ?•Šê³? null?„ ë¦¬í„´
		if (mfile == null || mfile.isEmpty() || mfile.getSize() == 0) {
			return null;
		}
		
		//???¥ ?´?”ê°? ?—†?œ¼ë©? ?ƒ?„±
		File path = new File(uploadPath);
		if (!path.isDirectory()) {
			path.mkdirs();
		}
		
		//?›ë³? ?ŒŒ?¼ëª?
		String originalFilename = mfile.getOriginalFilename();
		
		//???¥?•  ?ŒŒ?¼ëª…ì„ ?˜¤?Š˜ ?‚ ì§œì˜ ?…„?›”?¼ë¡? ?ƒ?„±
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String savedFilename = sdf.format(new Date());
		
		//?›ë³? ?ŒŒ?¼?˜ ?™•?¥?
		String ext;
		int lastIndex = originalFilename.lastIndexOf('.');
		//?™•?¥?ê°? ?—†?Š” ê²½ìš°
		if (lastIndex == -1) {
			ext = "";
		}
		//?™•?¥?ê°? ?ˆ?Š” ê²½ìš°
		else {
			ext = "." + originalFilename.substring(lastIndex + 1);
		}

		//???¥?•  ? „ì²? ê²½ë¡œë¥? ?¬?•¨?•œ File ê°ì²´
		File serverFile = null;
		
		//ê°™ì? ?´ë¦„ì˜ ?ŒŒ?¼?´ ?ˆ?Š” ê²½ìš°?˜ ì²˜ë¦¬
		while (true) {
			serverFile = new File(uploadPath + "/" + savedFilename + ext);
			//ê°™ì? ?´ë¦„ì˜ ?ŒŒ?¼?´ ?—†?œ¼ë©? ?‚˜ê°?.
			if ( !serverFile.isFile()) break;	
			//ê°™ì? ?´ë¦„ì˜ ?ŒŒ?¼?´ ?ˆ?œ¼ë©? ?´ë¦? ?’¤?— long ???…?˜ ?‹œê°„ì •ë³´ë?? ?§ë¶™ì„.
			savedFilename = savedFilename + new Date().getTime();	
		}		
		
		//?ŒŒ?¼ ???¥
		try {
			mfile.transferTo(serverFile);
		} catch (Exception e) {
			savedFilename = null;
			e.printStackTrace();
		}
		
		return savedFilename + ext;
	}
	
	/**
	 * ?„œë²„ì— ???¥?œ ?ŒŒ?¼?˜ ? „ì²? ê²½ë¡œë¥? ? „?‹¬ë°›ì•„, ?•´?‹¹ ?ŒŒ?¼?„ ?‚­? œ
	 * @param fullpath ?‚­? œ?•  ?ŒŒ?¼?˜ ê²½ë¡œ
	 * @return ?‚­? œ ?—¬ë¶?
	 */
	public static boolean deleteFile(String fullpath) {
		//?ŒŒ?¼ ?‚­? œ ?—¬ë¶?ë¥? ë¦¬í„´?•  ë³??ˆ˜
		boolean result = false;
		
		//? „?‹¬?œ ? „ì²? ê²½ë¡œë¡? Fileê°ì²´ ?ƒ?„±
		File delFile = new File(fullpath);
		
		//?•´?‹¹ ?ŒŒ?¼?´ ì¡´ì¬?•˜ë©? ?‚­? œ
		if (delFile.isFile()) {
			delFile.delete();
			result = true;
		}
		
		return result;
	}
}
