function [nacc_ref,nspd_ref,ndis_ref] = add_reference(acc_ref,spd_ref,dis_ref,add_time)

ndis_ref = dis_ref;
nspd_ref = spd_ref;
nacc_ref = acc_ref;
add_data = add_time*200;

add_dis = zeros(add_data,2);
for i = 1:add_data
    add_dis(i,2) = 325;
end    
add_spd = zeros(add_data,2);
add_acc = zeros(add_data,2);

dt = dis_ref(2,1) - dis_ref(1,1);
add_dis(1,1) = dis_ref(16001,1) + dt;
add_spd(1,1) = dis_ref(16001,1) + dt;
add_acc(1,1) = dis_ref(16001,1) + dt;

for i = 2:add_data 
    add_dis(i,1) = add_dis(i-1,1) + dt;
    add_spd(i,1) = add_spd(i-1,1) + dt;
    add_acc(i,1) = add_acc(i-1,1) + dt;
end

for i = 1:add_data
    ndis_ref(16001+i,1) = add_dis(i,1);
    ndis_ref(16001+i,2) = add_dis(i,2);
    nspd_ref(16001+i,1) = add_spd(i,1);
    nspd_ref(16001+i,2) = add_spd(i,2);
    nacc_ref(16001+i,1) = add_acc(i,1);
    nacc_ref(16001+i,2) = add_acc(i,2);
end

end
