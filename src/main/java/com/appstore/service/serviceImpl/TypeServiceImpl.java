package com.appstore.service.serviceImpl;

import com.appstore.dao.TypeDao;
import com.appstore.entity.Type;
import com.appstore.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TypeServiceImpl implements TypeService {

    @Autowired
    private TypeDao typeDao;

    public boolean checkTypeExist(String typeName) {
        Type type=typeDao.getTypeByName(typeName);
        if(type!=null) return true;
        else return false;
    }

    public Type saveType(String typeName) {
        int result=typeDao.saveType(typeName);
        if (result>=1) {
            return typeDao.getTypeByName(typeName);
        }
        else return null;
    }

    public List<Type> getTypeLimit(int offset,int limit) {
        return typeDao.getTypeLimit(offset,limit);
    }

    public List<Type> getAllType() {
        return typeDao.getAllType();
    }

    public Boolean deleteById(int typeId) {
        if (typeDao.deleteById(typeId)>0) return true;
        else {
            System.out.println("删除类型"+typeId+"失败");
            return false;
        }
    }

    public List<Type> searchByKeywordLimit(int offset, int limit, String keyword) {
        return typeDao.searchByKeywordLimit(offset,limit,keyword);
    }

    public List<Type> searchByKeyword(String keyword) {
        return typeDao.searchByKeyword(keyword);
    }

    public boolean updateTypeName(String oldTypeName, String newTypeName) {
        if(typeDao.updateTypeName(oldTypeName,newTypeName)>0) return true;
        else return false;
    }

    public Type getTypeById(long id) {
        return typeDao.getTypeById(id);
    }
}
