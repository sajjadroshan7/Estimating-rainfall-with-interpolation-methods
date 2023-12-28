function d = isinside(p,a,b,c)

    % Test if a point p(x,y) is inside a triangle
    % with vertices a(x,y), b(x,y) and c(x,y)

    v0 = c - a;
    v1 = b - a;
    v2 = p - a;

    A = [dot(v0,v0) dot(v1,v0);dot(v0,v1) dot(v1,v1)];
    b = [dot(v2,v0); dot(v2,v1)];

    x  = A\b;

    % Check if point is in triangle
    if (x(1) > 0) && (x(2) > 0) && (sum(x) < 1)
        d = true;
    else
        d = false;
    end