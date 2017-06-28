package com.appstore.service;

import com.appstore.entity.Comment;

import java.util.List;


public interface CommentService {
    boolean save(Comment comment);
    List<Comment> getAllCommentByAppId(long appId);
    List<Comment> getAllCommentByUserId(long userId);
}
