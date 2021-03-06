package global.sesoc.brr.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

/**
 * ??Ό κ΄?? ¨ ? ?Έ
 * ?λ‘λ? ??Ό? ???₯ & ?λ²μ ???₯? ??Ό ?­?  ?±? κΈ°λ₯ ? κ³?
 */
public class FileService {

	/**
	 * ?λ‘λ ? ??Ό? μ§?? ? κ²½λ‘? ???₯?κ³?, ???₯? ??Όλͺμ λ¦¬ν΄
	 * @param mfile ?λ‘λ? ??Ό
	 * @param path ???₯?  κ²½λ‘
	 * @return ???₯? ??Όλͺ?
	 */
	public static String saveFile(MultipartFile mfile, String uploadPath) {
		//?λ‘λ? ??Ό?΄ ?κ±°λ ?¬κΈ°κ? 0?΄λ©? ???₯?μ§? ?κ³? null? λ¦¬ν΄
		if (mfile == null || mfile.isEmpty() || mfile.getSize() == 0) {
			return null;
		}
		
		//???₯ ?΄?κ°? ??Όλ©? ??±
		File path = new File(uploadPath);
		if (!path.isDirectory()) {
			path.mkdirs();
		}
		
		//?λ³? ??Όλͺ?
		String originalFilename = mfile.getOriginalFilename();
		
		//???₯?  ??Όλͺμ ?€? ? μ§μ ???Όλ‘? ??±
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String savedFilename = sdf.format(new Date());
		
		//?λ³? ??Ό? ??₯?
		String ext;
		int lastIndex = originalFilename.lastIndexOf('.');
		//??₯?κ°? ?? κ²½μ°
		if (lastIndex == -1) {
			ext = "";
		}
		//??₯?κ°? ?? κ²½μ°
		else {
			ext = "." + originalFilename.substring(lastIndex + 1);
		}

		//???₯?  ? μ²? κ²½λ‘λ₯? ?¬?¨? File κ°μ²΄
		File serverFile = null;
		
		//κ°μ? ?΄λ¦μ ??Ό?΄ ?? κ²½μ°? μ²λ¦¬
		while (true) {
			serverFile = new File(uploadPath + "/" + savedFilename + ext);
			//κ°μ? ?΄λ¦μ ??Ό?΄ ??Όλ©? ?κ°?.
			if ( !serverFile.isFile()) break;	
			//κ°μ? ?΄λ¦μ ??Ό?΄ ??Όλ©? ?΄λ¦? ?€? long ???? ?κ°μ λ³΄λ?? ?§λΆμ.
			savedFilename = savedFilename + new Date().getTime();	
		}		
		
		//??Ό ???₯
		try {
			mfile.transferTo(serverFile);
		} catch (Exception e) {
			savedFilename = null;
			e.printStackTrace();
		}
		
		return savedFilename + ext;
	}
	
	/**
	 * ?λ²μ ???₯? ??Ό? ? μ²? κ²½λ‘λ₯? ? ?¬λ°μ, ?΄?Ή ??Ό? ?­? 
	 * @param fullpath ?­? ?  ??Ό? κ²½λ‘
	 * @return ?­?  ?¬λΆ?
	 */
	public static boolean deleteFile(String fullpath) {
		//??Ό ?­?  ?¬λΆ?λ₯? λ¦¬ν΄?  λ³??
		boolean result = false;
		
		//? ?¬? ? μ²? κ²½λ‘λ‘? Fileκ°μ²΄ ??±
		File delFile = new File(fullpath);
		
		//?΄?Ή ??Ό?΄ μ‘΄μ¬?λ©? ?­? 
		if (delFile.isFile()) {
			delFile.delete();
			result = true;
		}
		
		return result;
	}
}
