package cn.jeesns.service.question;

import cn.jeesns.dao.question.IQuestionDao;
import cn.jeesns.model.member.Financial;
import cn.jeesns.model.member.Member;
import cn.jeesns.model.member.ScoreDetail;
import cn.jeesns.model.question.Answer;
import cn.jeesns.model.question.Question;
import cn.jeesns.model.question.QuestionType;
import cn.jeesns.service.member.FinancialService;
import cn.jeesns.service.member.MemberService;
import cn.jeesns.service.member.ScoreDetailService;
import cn.jeesns.core.dto.Result;
import cn.jeesns.core.exception.OpeErrorException;
import cn.jeesns.core.service.BaseService;
import cn.jeesns.core.utils.HtmlUtil;
import cn.jeesns.core.utils.PageUtil;
import cn.jeesns.core.utils.StringUtils;
import cn.jeesns.core.utils.ValidUtill;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by zchuanzhao on 2018/12/7.
 */
@Service("questionService")
public class QuestionService extends BaseService<Question> {

    @Resource
    private IQuestionDao questionDao;
    @Resource
    private QuestionTypeService questionTypeService;
    @Resource
    private MemberService memberService;
    @Resource
    private FinancialService financialService;
    @Resource
    private ScoreDetailService scoreDetailService;
    @Resource
    private AnswerService answerService;


    public Result<Question> list(Integer typeId, String statusName) {
        Integer status = -2;
        if ("close".equalsIgnoreCase(statusName)){
            status = -1;
        }else if ("unsolved".equalsIgnoreCase(statusName)){
            status = 0;
        }else if ("solved".equalsIgnoreCase(statusName)){
            status = 1;
        }
        List<Question> list = questionDao.list(PageUtil.getPage(), typeId, status);
        Result model = new Result(0,PageUtil.getPage());
        model.setData(list);
        return model;
    }

    @Override
    public Question findById(Integer id) {
        return questionDao.findById(id);
    }

    @Override
    @Transactional
    public boolean save(Question question) {
        ValidUtill.checkParam(question.getMemberId() == null, "??????????????????");
        ValidUtill.checkParam(question.getTypeId() == null, "??????????????????");
        ValidUtill.checkParam(question.getTitle() == null, "??????????????????");
        ValidUtill.checkParam(question.getBonus() < 0, "????????????????????????0");
        QuestionType questionType = questionTypeService.findById(question.getTypeId());
        ValidUtill.checkIsNull(questionType, "?????????????????????");
        Member member = memberService.findById(question.getMemberId());
        if (StringUtils.isEmpty(question.getDescription())) {
            String contentStr = HtmlUtil.delHTMLTag(question.getContent());
            if (contentStr.length() > 200) {
                question.setDescription(contentStr.substring(0, 200));
            } else {
                question.setDescription(contentStr);
            }
        }
        super.save(question);
        if (question.getBonus() > 0){
            if (questionType.getBonusType() == 0){
                //??????
                ValidUtill.checkParam(member.getScore().intValue() < question.getBonus().intValue(), "????????????????????????????????????????????????????????????"+member.getScore());
                memberService.updateScore(-question.getBonus(), member.getId());
                ScoreDetail scoreDetail = new ScoreDetail();
                scoreDetail.setType(1);
                scoreDetail.setMemberId(member.getId());
                scoreDetail.setForeignId(question.getId());
                scoreDetail.setScore(-question.getBonus());
                scoreDetail.setRemark("???????????????" + question.getTitle() + "#" + question.getId());
                scoreDetailService.save(scoreDetail);
            }else if (questionType.getBonusType() == 1){
                //??????
                ValidUtill.checkParam(member.getMoney() < question.getBonus().intValue(), "??????????????????????????????????????????????????????"+member.getMoney());
                memberService.updateMoney(-(double)question.getBonus(), member.getId());
                //??????????????????
                Financial financial = new Financial();
                financial.setBalance(member.getMoney() - question.getBonus());
                financial.setForeignId(question.getId());
                financial.setMemberId(member.getId());
                financial.setMoney((double)question.getBonus());
                financial.setType(1);
                //1???????????????
                financial.setPaymentId(1);
                financial.setRemark("???????????????" + question.getTitle() + "#" + question.getId());
                financial.setOperator(member.getName());
                financialService.save(financial);
            }
        }
        return true;
    }

    public boolean update(Member loginMember, Question question) {
        Question findQuestion = findById(question.getId());
        ValidUtill.checkIsNull(findQuestion, "???????????????");
        ValidUtill.checkParam(question.getTitle() == null, "??????????????????");
        if (StringUtils.isEmpty(question.getDescription())) {
            String contentStr = HtmlUtil.delHTMLTag(question.getContent());
            if (contentStr.length() > 200) {
                findQuestion.setDescription(contentStr.substring(0, 200));
            } else {
                findQuestion.setDescription(contentStr);
            }
        }
        findQuestion.setTitle(question.getTitle());
        findQuestion.setContent(question.getContent());
        return super.update(findQuestion);
    }

    public boolean delete(Member loginMember, Integer id) {
        Question findQuestion = findById(id);
        ValidUtill.checkParam(findQuestion.getAnswerCount() > 0, "???????????????????????????????????????");
        if(loginMember.getId().intValue() == findQuestion.getMember().getId().intValue() || loginMember.getIsAdmin() > 0){
            return super.deleteById(id);
        }
        throw new OpeErrorException("????????????");
    }

    public void close(Member loginMember, Integer id) {
        Question question = findById(id);
        ValidUtill.checkParam(question.getAnswerCount() > 0, "???????????????????????????????????????");
        if(loginMember.getId().intValue() == question.getMember().getId().intValue() || loginMember.getIsAdmin() > 0){
            updateStatus(-1, question);
            //??????????????????????????????
            if (question.getBonus() > 0){
                if (question.getQuestionType().getBonusType() == 0){
                    //??????
                    memberService.updateScore(question.getBonus(), question.getMemberId());
                    ScoreDetail scoreDetail = new ScoreDetail();
                    scoreDetail.setType(1);
                    scoreDetail.setMemberId(question.getMemberId());
                    scoreDetail.setForeignId(question.getId());
                    scoreDetail.setScore(question.getBonus());
                    scoreDetail.setRemark("??????????????????????????????" + question.getTitle() + "#" + question.getId());
                    scoreDetailService.save(scoreDetail);
                }else if (question.getQuestionType().getBonusType() == 1){
                    //??????
                    memberService.updateMoney((double)question.getBonus(), question.getMemberId());
                    Member member = memberService.findById(question.getMemberId());
                    //??????????????????
                    Financial financial = new Financial();
                    financial.setBalance(member.getMoney() + question.getBonus());
                    financial.setForeignId(question.getId());
                    financial.setMemberId(member.getId());
                    financial.setMoney((double)question.getBonus());
                    financial.setType(0);
                    //1???????????????
                    financial.setPaymentId(1);
                    financial.setRemark("??????????????????????????????" + question.getTitle() + "#" + question.getId());
                    financial.setOperator(member.getName());
                    financialService.save(financial);
                }
            }
        }else {
            throw new OpeErrorException("????????????");
        }
    }

    @Transactional
    public void bestAnswer(Member loginMember, Integer answerId, Integer id) {
        Question question = findById(id);
        ValidUtill.checkParam(question.getStatus() == 1, "???????????????????????????????????????????????????");
        ValidUtill.checkParam(question.getStatus() == -1, "?????????????????????????????????");
        if(loginMember.getId().intValue() == question.getMember().getId().intValue()){
            Answer answer = answerService.findById(answerId);
            //??????ID??????????????????ID?????????
            ValidUtill.checkParam(answer.getQuestionId().intValue() != id, "????????????");
            ValidUtill.checkParam(answer.getMemberId().intValue() == question.getMemberId().intValue(), "????????????????????????????????????");
            //??????????????????
            setBestAnswer(answerId, id);
            //???????????????????????????????????????
            if (question.getBonus() > 0){
                if (question.getQuestionType().getBonusType() == 0){
                    //??????
                    memberService.updateScore(question.getBonus(), answer.getMemberId());
                    ScoreDetail scoreDetail = new ScoreDetail();
                    scoreDetail.setType(1);
                    scoreDetail.setMemberId(answer.getMemberId());
                    scoreDetail.setForeignId(answer.getId());
                    scoreDetail.setScore(question.getBonus());
                    scoreDetail.setRemark("??????????????????" + question.getTitle() + "#" + question.getId());
                    scoreDetailService.save(scoreDetail);
                }else if (question.getQuestionType().getBonusType() == 1){
                    //??????
                    memberService.updateMoney((double)question.getBonus(), answer.getMemberId());
                    Member member = memberService.findById(answer.getMemberId());
                    //??????????????????
                    Financial financial = new Financial();
                    financial.setBalance(member.getMoney() + question.getBonus());
                    financial.setForeignId(answer.getId());
                    financial.setMemberId(member.getId());
                    financial.setMoney((double)question.getBonus());
                    financial.setType(0);
                    //1???????????????
                    financial.setPaymentId(1);
                    financial.setRemark("??????????????????" + question.getTitle() + "#" + question.getId());
                    financial.setOperator(member.getName());
                    financialService.save(financial);
                }
            }
        }else {
            throw new OpeErrorException("????????????");
        }
    }

    public void updateStatus(Integer status, Question question) {
        ValidUtill.checkParam(question.getStatus() != 0, "?????????????????????????????????");
        questionDao.updateStatus(status, question.getId());
    }

    public Integer updateAnswerCount(Integer id) {
        return questionDao.updateAnswerCount(id);
    }

    public Integer setBestAnswer(Integer answerId, Integer id) {
        return questionDao.setBestAnswer(answerId, id);
    }

    public void updateViewCount(Integer id) {
        questionDao.updateViewCount(id);
    }
}
