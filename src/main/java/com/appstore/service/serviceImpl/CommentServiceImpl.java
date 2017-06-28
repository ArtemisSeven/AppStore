package com.appstore.service.serviceImpl;

import com.appstore.dao.CommentDao;
import com.appstore.entity.Comment;
import com.appstore.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentDao commentDao;

    public boolean save(Comment comment) {
        if (commentDao.save(comment)>0) return true;
        else return false;
    }

    public List<Comment> getAllCommentByAppId(long appId) {
        return commentDao.getAllCommentByAppId(appId);
    }

    public List<Comment> getAllCommentByUserId(long userId) {
        return commentDao.getAllCommentByUserId(userId);
    }
}
