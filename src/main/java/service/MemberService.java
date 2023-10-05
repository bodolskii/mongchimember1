package service;

import dao.MemberDAO;
import domain.MemberVO;
import dto.MemberDTO;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.beanutils.BeanUtils;
import org.modelmapper.ModelMapper;
import util.MapperUtil;

import java.sql.SQLException;

@Log4j2
public enum MemberService {
    INSTANCE;

    private MemberDAO memberDAO;
    private ModelMapper modelMapper;

    MemberService() {
        memberDAO =new MemberDAO();
        modelMapper= MapperUtil.INSTANCE.getInstance();
    }

    public void insertMember (MemberVO memberVO) throws Exception{
        memberDAO.insertMember(memberVO);
    }
    public void modifyMember (MemberDTO memberDTO) throws Exception {
        memberDAO.updateMember(memberDTO);
    }

    public MemberDTO login(String emailId, String password) throws Exception {
        MemberVO memberVO=memberDAO.getWithPassword(emailId, password);
        MemberDTO memberDTO = modelMapper.map(memberVO, MemberDTO.class);
        log.info(memberDTO + "===memberDTO service ===");

        return memberDTO;
    }
    public void modifyUuid(String emailId, String uuid) throws Exception {
        // 자동 로그인 사용하는 경우 임의의 문자열 저장
        memberDAO.updateUuid(emailId, uuid);
    }

    public MemberDTO getByUuid(String uuid) throws Exception {
        MemberVO memberVO = memberDAO.selectUuid(uuid);
        MemberDTO memberDTO = modelMapper.map(memberVO, MemberDTO.class);

        return memberDTO;
    }
    public void removeMember(String emailId) throws Exception {
        memberDAO.deleteMember(emailId);
    }
    public void modifyPassword (String emailId,String password) throws SQLException {
        memberDAO.updatePassword(emailId,password);
    }

}
