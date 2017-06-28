package com.appstore.dao;


import com.appstore.entity.Comment;

import java.util.List;

public interface CommentDao {
    int save(Comment comment);
    List<Comment> getAllCommentByAppId(long appId);
    List<Comment> getAllCommentByUserId(long userId);
}