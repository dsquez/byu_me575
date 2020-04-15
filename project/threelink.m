function robot = threelink(max_height,a1,a2,a3,a4,a5)
    L(1) = Link('theta', 0, 'a', 0, 'alpha', 0, 'qlim', [0 max_height], 'standard');
    L(2) = Link([ 0     0   a1  0], 'standard');
    L(3) = Link([ 0     0   a2  0], 'standard');
    L(4) = Link([ 0 0 a3 pi/2], 'standard');
    L(5) = Link([ 0     a4   0  pi/2], 'standard');
%     L(5) = Link('revolute', 'd', 1, 'alpha', 0, 'a', a3);
    L(6) = Link('revolute', 'd', a5, 'alpha', pi/2);
    % defining the robot now
    robot = SerialLink(L, 'name', 'threelink on linear actuator');
    
end