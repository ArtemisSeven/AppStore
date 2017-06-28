package com.appstore.dao;

import com.appstore.entity.Type;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TypeDao {
    Type getTypeByName(String typeName);
    int saveType(String typeName);
    List<Type> getTypeLimit(@Param("offset") int offset, @Param("limit") int limit);
    List<Type> getAllType();
    int deleteById(int typeId);
    List<Type> searchByKeywordLimit(@Param("offset") int offset, @Param("limit") int limit,@Param("keyword")String keyword);
    List<Type> searchByKeyword(String keyword);
    int updateTypeName(@Param("oldTypeName")String oldTypeName,@Param("newTypeName") String newTypeName);
    Type getTypeById(@Param("id")long id);
}