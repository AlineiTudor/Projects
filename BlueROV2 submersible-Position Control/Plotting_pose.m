dimensions=size(out.ROV_pose2)
x=reshape(out.ROV_pose2(1,:,:),[1,dimensions(3)]);
y=reshape(out.ROV_pose2(2,:,:),[1,dimensions(3)]);
z=reshape(out.ROV_pose2(3,:,:),[1,dimensions(3)]);

plot3(x,y,z)