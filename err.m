function F = err(p,xc,X)
    alpha = 10*p(1); beta = 10*p(2); gama = 10*p(3); t1 = 10*p(4)*10^round(log10(range(X(:,1))));...
        t2 = 10*p(5)*10^round(log10(range(X(:,2)))); t3 = 100*p(6)*10^round(log10(range(X(:,1))));     % 认为相机坐标系下Z为X，Y的10倍，步长也要是10倍
%     alpha = p(1)*10; beta = p(2)*10; gama = p(3)*10; t1 = p(4)*10^6; t2 = p(5)*10^6; t3 = p(6)*10^7;
%     alpha = p(1); beta = p(2); gama = p(3); t1 = p(4); t2 = p(5); t3 = p(6);
    Rz = [cos(alpha), -sin(alpha), 0;...
        sin(alpha), cos(alpha), 0;...
        0, 0, 1];
    Ry = [cos(beta), 0, sin(beta);...
        0, 1, 0;...
        -sin(beta), 0, cos(beta)];
    Rx = [1, 0, 0;...
        0, cos(gama), -sin(gama);...
        0, sin(gama), cos(gama)];
%     R = [cos(alpha)*cos(gama)-cos(beta)*sin(alpha)*sin(gama), -cos(beta)*cos(gama)*sin(alpha)-cos(alpha)*sin(gama), sin(alpha)*sin(beta);...
%         cos(gama)*sin(alpha)+cos(alpha)*cos(beta)*sin(gama), cos(alpha)*cos(beta)*cos(gama)-sin(alpha)*sin(gama), -cos(alpha)*sin(beta);...
%         sin(beta)*sin(gama), cos(gama)*sin(beta), cos(beta)];
    R = Rx*Ry*Rz;
    t = [t1, t2, t3]';
    x1 = transpose([R, t]*X');
    x1 = x1./repmat(x1(:,3), 1, 3);
    k = 1:size(xc, 1);
    F = double((xc(k, 1) - x1(k, 1)).*(xc(k, 1) - x1(k, 1)) + (xc(k, 2) - x1(k, 2)).*(xc(k, 2) - x1(k, 2)));
end