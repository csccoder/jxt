package cn.jxt.service;

import cn.jxt.bean.Guardian;

import java.util.List;

public interface GuardianService {
    public Guardian queryById(String id);

    void registerGuardian(Guardian guardian);

    void updateGuardian(Guardian guardian);

    List<Guardian> getGuadianListByStudentIds(List<Integer> studentIds);
}
