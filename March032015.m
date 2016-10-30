% March 3rd 2015

%% Implicit Curves and Surfaces
% In some earlier posts (
% <http://blogs.mathworks.com/graphics/2014/12/04/tie-a-ribbon-round-it-parametric-curves-part-1/ part1>, 
% <http://blogs.mathworks.com/graphics/2014/12/04/tie-a-ribbon-round-it-parametric-curves-part-2/ part2>)  
% we explored how to draw parametric curves using MATLAB Graphics. Now lets 
% turn our attention to implicit curves.
%
% We know that the implicit equation for the unit circle is the following:
% 
% $$x^2 + y^2 = 1$$
%
% We can convert that into a parametric form, and then draw it using the 
% techniques we learned earlier.
t = linspace(0,2*pi,120);
plot(cos(t),sin(t))
axis equal

%%
% But converting from implicit form to parametric form can be pretty 
% complicated, even for a curve as simple as the unit circle. And there are 
% implicit curves which don't have a parametric form. It'd be awfully nice 
% if we could plot it directly without converting it to parametric form.
%
% There is actually an easy way to do this, using the <http://www.mathworks.com/help/matlab/ref/contour.html contour function>. The
% basic idea is that we create a 2D array from the left hand side of the 
% equation, and then contour it with one contour level which is equal to
% the right hand side of the equation.
[x,y] = meshgrid(linspace(-1,1,120));
contour(x,y,x.^2 + y.^2,'LevelList',1);
axis equal

%%
% One problem with this approach is that it only works when the right
% hand side is a constant. To handle a function like this:
%
% $$x^4 + y^3 = 2 x y$$
%
% We'll have to transform it so that all of the non-constant terms are on
% the left:
%
% $$x^4 + y^3 - 2 x y = 0$$
%
[x,y] = meshgrid(linspace(-2*pi,2*pi,120));
contour(x,y,x.^4 + y.^3 - 2*x.*y,'LevelList',0);

%%
% MATLAB Graphics actually provides a function which will take care of this 
% for you. It's called <http://www.mathworks.com/help/matlab/ref/ezplot.html ezplot>. 
ezplot('x^4 + y^3 = 2*x*y')

%%
% If you've ever used ezplot and looked at its return value, you might have
% noticed that it returns different types of objects for different types of
% equations. That's because it's doing exactly what I described above. If
% we call ezplot with a parametric equation, we get a Line object:
h = ezplot('cos(t)','sin(t)')

%%
% But if we call it with an implicit equation, we get a Contour object:
h = ezplot('x^2 + y^2 = 1',[-1 1])
axis equal

%%
% What about implicit equations in 3D? Neither the ezplot function or its 
% companion ezsurf can do this. But now that we know how ezplot 
% works for 2D implicit equations, we can use the same technique. We just 
% need to switch from the contour function to the <http://www.mathworks.com/help/matlab/ref/isosurface.html isosurface function>. The 
% isosurface function does for a 3D array what the contour function does 
% for a 2D array.
%
% For example, <http://www.mathworks.com/matlabcentral/answers/156942-how-to-plot-a-3d-ecuation Guillermo asked on MATLAB Answers> how to draw the 
% following surface.
%
% $$(y-z)^2 + (z-x)^2 + (x-y)^2 = 3 R^2$$
%
% Where R is a positive integer.
%
% We can generate a 3D grid of the left hand side using ndgrid.
[y,x,z] = ndgrid(linspace(-5,5,64));
f = (y-z).^2 + (z-x).^2 + (x-y).^2;

%%
% Once we have that, we can use the isosurface function to figure out where
% that function is equal to the right hand side for various values of R.
cla reset
r = 1;
isosurface(x,y,z,f,3*r^2)
r = 2;
isosurface(x,y,z,f,3*r^2)
r = 3;
isosurface(x,y,z,f,3*r^2)
view(3)
camlight


%%
% Here's a slightly more complex implicit surface from this
% <http://math.stackexchange.com/questions/152256/implicit-equation-for-double-torus-genus-2-orientable-surface
% Stack Exchange post>.
%
% $$(x(x-1)^2(x-2) + y^2)^2 + z^2 = .01$$
%
[y,x,z] = ndgrid(linspace(-.75,.75,100),linspace(-.1,2.1,100),linspace(-.2,.2,100));
f = (x.*(x-1).^2.*(x-2) + y.^2).^2 + z.^2;
cla
isosurface(x,y,z,f,.01);
view(3);
camlight
axis equal

%%
% But some implicit surfaces are very complex and can be rather tricky to render. 
% One of my favorite challenges are the famous <http://en.wikipedia.org/wiki/Barth_surface Barth surfaces>. 
% For example, the equation for the sextic is the following:
%
% $$4(\phi^2 x^2 - y^2)(\phi^2 y^2 - x^2)(\phi^2 z^2 - x^2) = (1+2 \phi)(x^2 + y^2 + z^2 - w^2)^2 w^2$$
%
% Here's a picture I made of it for w=1.
%
% <<barth_sextic.png>>
%
% Can you create a better picture of this challenging surface or one of its 
% relatives?


%%
% _Copyright 2015 The MathWorks, Inc._

