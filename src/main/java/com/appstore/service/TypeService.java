package com.appstore.service;

import com.appstore.entity.Type;
import org.springframework.stereotype.Service;

import java.util.List;



public interface TypeService {
    boolean checkTypeExist(String typeName);
    Type saveType(String typeName);
    List<Type> getTypeLimit(int offset,int limit);
    List<Type> getAllType();
    Boolean deleteById(int typeId);
    List<Type> searchByKeywordLimit(int offset,int limit,String keyword);
    List<Type> searchByKeyword(String keyword);
    boolean  updateTypeName(String oldTypeName,String newTypeName);
    Type getTypeById(long id);
}
