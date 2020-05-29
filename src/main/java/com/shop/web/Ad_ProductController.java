package com.shop.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.domain.CategoryVO;
import com.shop.domain.ProductDTO;
import com.shop.domain.ProductVO;
import com.shop.domain.QnADTO;
import com.shop.service.Ad_ProductService;
import com.shop.util.CategoryCriteria;
import com.shop.util.Criteria;
import com.shop.util.MediaUtils;
import com.shop.util.PageMaker;
import com.shop.util.UploadFileUtils;

@Controller
@RequestMapping("/admin/product/*")
public class Ad_ProductController {
	private static final Logger logger = LoggerFactory.getLogger(Ad_ProductController.class);

	@Inject
	private Ad_ProductService service;
	
	@Resource(name = "uploadPath")
	private String uploadPath;

	/* 페이지 */

	// 상품 등록 페이지
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public void insert(Model model) throws Exception {

		logger.info("상품등록 페이지");
		model.addAttribute("cateList", service.categoryList());

	}

	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String productInsert(ProductVO vo, RedirectAttributes rttr) throws Exception {
		logger.info("상품등록" + vo.toString());

		vo.setProduct_image(
				UploadFileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1().getBytes()));

		service.productInsert(vo);
		rttr.addFlashAttribute("msg", "pro_insert");

		return "redirect:/admin/product/list";
	}

	// 상품 리스트
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void list(@ModelAttribute("cri") CategoryCriteria cri, Model model) throws Exception {
		logger.info("상품목록 , " + cri.toString());
		logger.info(service.count_QnA().toString());
		model.addAttribute("products", service.productList(cri));
		model.addAttribute("cateList", service.categoryList());
		model.addAttribute("QnA", service.count_QnA());
		PageMaker pm = new PageMaker();

		pm.setCri(cri);
		pm.setTotalCount(service.productCount(cri));

		model.addAttribute("pageMaker", pm);
	}

	// 리스트에서 수정버튼 클릭(수정페이지)
	@RequestMapping(value = "/modify/{code}", method = RequestMethod.GET)
	public String proRead(@PathVariable("code") int code, CategoryCriteria cri, Model model) throws Exception {
		logger.info("수정페이지");
		ProductVO vo = service.proRead(code);
		String fileName = service.selectImage(code);
		
		String imgsrc = uploadPath+fileName;
		
		
		model.addAttribute("cateList", service.categoryList());
		model.addAttribute("subCate", service.subCateList(vo.getParents_code()));
		model.addAttribute("product", vo);
		model.addAttribute("imgsrc",imgsrc);

		PageMaker pm = new PageMaker();
		pm.setCri(cri);

		model.addAttribute("pageMaker", pm);

		return "admin/product/modify";
	}

	// 수정작업
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String proUpdate(ProductVO vo, RedirectAttributes rttr) throws Exception {
		logger.info("상품 수정 작업" + vo.toString());

		if (!vo.getFile1().getOriginalFilename().equals("")) {
			vo.setProduct_image(UploadFileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(),
					vo.getFile1().getBytes()));
			deleteFiles(service.selectImage(vo.getProduct_code()));
		} else {
			logger.info(service.selectImage(vo.getProduct_code()));
			vo.setProduct_image(service.selectImage(vo.getProduct_code()));
		}
		service.proUpdate(vo);

		rttr.addFlashAttribute("msg", "pro_update");

		return "redirect:/admin/product/list";
	}
	
	//QnA
	@RequestMapping(value = "/QnA", method = RequestMethod.GET)
	public void qnalist(Criteria cri,Model model)throws Exception{
		PageMaker pm = new PageMaker();
		
		pm.setCri(cri);
		pm.setTotalCount(service.totalQnA());
		model.addAttribute("QnAList", service.QnAList(cri));
		model.addAttribute("pageMaker", pm);
		logger.info("qna");
	}


	
	
	
	/* 기능 */

	// 하위 카테고리
	@ResponseBody
	@RequestMapping(value = "/subCateList/{mainCate}", method = RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> subCateList(@PathVariable("mainCate") String mainCate) throws Exception {

		ResponseEntity<List<CategoryVO>> entity = null;

		try {
			entity = new ResponseEntity<List<CategoryVO>>(service.subCateList(mainCate), HttpStatus.OK);
		} catch (Exception ex) {
			ex.printStackTrace();
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 에디터 이미지 업로드
	@RequestMapping("/imgUpload")
	public void imgUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) throws Exception {
		OutputStream out = null;
		PrintWriter printWriter = null;

		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=utf-8");

		try {
			String filename = UploadFileUtils.reName(upload.getOriginalFilename());
			byte[] bytes = upload.getBytes();

			// 스프링 프로젝트가 배포된 실 운영서버의 물리적 경로를 참조하는 구문
			String uploadPath = req.getSession().getServletContext().getRealPath("/");
			uploadPath += "resources\\upload\\" + filename;
			out = new FileOutputStream(new File(uploadPath));

			out.write(bytes);

			printWriter = res.getWriter();
			String fileUrl = "/upload/" + filename;

			printWriter.println("{\"filename\":\"" + filename + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (printWriter != null) {
					printWriter.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	// 썸네일 보여주기
	@ResponseBody
	@RequestMapping("/displayImage")
	public ResponseEntity<byte[]> displayImage(String filename) throws Exception {

		InputStream in = null;
		ResponseEntity<byte[]> entity = null;

		try {

			String formatType = filename.substring(filename.indexOf(".") + 1);

			MediaType mType = MediaUtils.getMediaType(formatType);

			HttpHeaders headers = new HttpHeaders();

			in = new FileInputStream(uploadPath + filename);

			headers.setContentType(mType);

			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}

		return entity;
	}
	
	// 삭제
	@ResponseBody
	@Transactional
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ResponseEntity<String> delete(int code) throws Exception {
		logger.info(service.selectImage(code));
		
		ResponseEntity<String> entity = null;
		
		try {
		String filename = service.selectImage(code);
		service.delete(code);
		deleteFiles(filename);
		
		entity = new ResponseEntity<String>("success",HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;			
	}
	// 복수 삭제
	@ResponseBody
	@Transactional
	@RequestMapping(value = "/deleteArr", method = RequestMethod.POST)
	public ResponseEntity<String> deleteArr(@RequestParam(value = "codeArr[]")List<Integer> codeArr) throws Exception {
		ResponseEntity<String> entity = null;
		logger.info(codeArr.toString());
		try {
		for(int code : codeArr) {
			String filename = service.selectImage(code);
			service.delete(code);
			deleteFiles(filename);
		}
		
		entity = new ResponseEntity<String>("success",HttpStatus.OK	);
		
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;			
	}

	@ResponseBody
	@RequestMapping(value = "/quickModify" , method = RequestMethod.POST)
	public ResponseEntity<String> quickModify(@RequestParam(value = "codeArr[]")List<Integer> codeArr,@RequestParam(value = "buyArr[]")List<String> buyArr,
												@RequestParam(value = "nameArr[]")List<String> nameArr,@RequestParam(value = "priArr[]")List<Integer> priArr,
												@RequestParam(value = "amoArr[]")List<Integer> amoArr) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		ProductDTO dto = new ProductDTO();
		try {
		for(int i=0 ; i<codeArr.size() ; i++) {
			dto.setCode(codeArr.get(i));
			dto.setBuy(buyArr.get(i));
			dto.setName(nameArr.get(i));
			dto.setPrice(priArr.get(i));
			dto.setAmount(amoArr.get(i));
			
			service.quickModify(dto);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		}
		
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}

	//사진 파일 삭제
	public void deleteFiles(String fileName) {
		
		String front = fileName.substring(0, 12);
		String end = fileName.substring(14);
		
		//섬네일 삭제
		new File(uploadPath+fileName.replace('/', File.separatorChar)).delete();
		//원본 삭제
		new File(uploadPath+(front+end).replace('/', File.separatorChar)).delete();
	}
	
	@ResponseBody
	@RequestMapping(value = "/readQnA/{board_num}" , method = RequestMethod.GET)
	public ResponseEntity<QnADTO> readQnA(@PathVariable(value = "board_num")int board_num)throws Exception{
		ResponseEntity<QnADTO> entity = null;
		
		try {
			entity = new ResponseEntity<QnADTO>(service.readQnA(board_num),HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<QnADTO>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
