package cn.jxt.typehandler;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class
SexTypeHandler implements TypeHandler<Character> {

    @Override
    public void setParameter(PreparedStatement preparedStatement, int i, Character character, JdbcType jdbcType) throws SQLException {
        char data=character.equals('男')?'m':'f';
        preparedStatement.setObject(i,data);
    }

    @Override
    public Character getResult(ResultSet resultSet, String s) throws SQLException {
        Character character= (Character) resultSet.getObject(s);
        return character.equals('m')?'男':'女';

    }

    @Override
    public Character getResult(ResultSet resultSet, int i) throws SQLException {
        Character character= (Character) resultSet.getObject(i);
        return character.equals('m')?'男':'女';
    }

    @Override
    public Character getResult(CallableStatement callableStatement, int i) throws SQLException {
        Character character= (Character) callableStatement.getObject(i);
        return character.equals('m')?'男':'女';
    }
}
