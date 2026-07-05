usepackage("amsmath");
    import graph3;
    bool incolor;
    incolor = true;
    pen apexmeshpen=rgb(0,0,.7);
    pen blackmeshpen=rgb(0,0,0);
    pen surfacepen=rgb(.6,.6,1)+opacity(.7);
    pen surfacepen2=rgb(1,.6,.6)+opacity(1);
    material simplesurfacepen=emissive(rgb(.6,.6,1)+opacity(0.7));
    material simplesurfacepen2=emissive(rgb(1,.6,.6)+opacity(0.7));
    material simplesurfacepen3=emissive(rgb(.5,.9,.5)+opacity(0.7));
    pen bluepen=blue;
    pen bluemeshpen=rgb(0,0,.5);
    pen bluecurvepen=rgb(.1,.1,.7);
    pen dotblue=rgb(.6,.6,1);
    pen redpen=red;
    pen redmeshpen=rgb(.7,0,0);
    pen redmeshpen2=rgb(.5,0,0);
    pen redcurvepen=rgb(.9,0,0);
    pen greenmeshpen=rgb(0,.5,0);
    pen greencurvepen=rgb(0,.7,0);
    pen curvepen=.4mm+bluepen;
    pen curvepen2=.4mm+redpen;
    pen darksurfacepen=rgb(.2,.2,1)+opacity(.7);
    if(settings.outformat == "html") currentlight.background=opacity(0.0);
texpreamble("\newcommand{\ds}{\displaystyle}
  \newcommand{\fp}{f'}
  \newcommand{\fpp}{f''}

  
  
  \newcommand{\lz}[2]{\frac{d#1}{d#2}}
  
  
  
  \newcommand{\lzn}[3]{\frac{d^{#1}#2}{d#3^{#1}}}
  
  
  
  \newcommand{\lzo}[1]{\frac{d}{d#1}}
  
  
  
  \newcommand{\lzoo}[2]{{\frac{d}{d#1}}{\left(#2\right)}}
  
  
  
  \newcommand{\lzon}[2]{\frac{d^{#1}}{d#2^{#1}}}
  
  
  
  \newcommand{\lzoa}[3]{\left.{\frac{d#1}{d#2}}\right|_{#3}}
  
  
  
  \newcommand{\plz}[2]{\frac{\partial#1}{\partial#2}}
  
  
  
  \newcommand{\plzoa}[3]{\left.{\frac{\partial#1}{\partial#2}}\right|_{#3}}

  
  
  \newcommand{\inflim}[1][n]{\lim\limits_{#1 \to \infty}}

  
  
  \newcommand{\infser}[1][1]{\sum_{n=#1}^\infty}

  \newcommand{\Fp}{F\primeskip'}
  \newcommand{\Fpp}{F\primeskip''}
  \newcommand{\yp}{y\primeskip'}
  \newcommand{\gp}{g\primeskip'}
  \newcommand{\dx}{\Delta x}
  \newcommand{\dy}{\Delta y}
  \newcommand{\ddz}{\Delta z}
  \newcommand{\thet}{\theta}
  \newcommand{\norm}[1]{\left\lVert#1\right\rVert}
  \newcommand{\vnorm}[1]{\left\lVert\vec #1\right\rVert}
  \newcommand{\snorm}[1]{\left|\left|\,#1\,\right|\right|}
  \newcommand{\la}{\left\langle}
  \newcommand{\ra}{\right\rangle}
  \newcommand{\dotp}[2]{\vec #1 \cdot \vec #2}
  \newcommand{\proj}[2]{\text{proj}_{\,\vec #2}{\,\vec #1}}
  \newcommand{\crossp}[2]{\vec #1 \times \vec #2}
  \newcommand{\veci}{\vec i}
  \newcommand{\vecj}{\vec j}
  \newcommand{\veck}{\vec k}
  \newcommand{\vecu}{\vec u}
  \newcommand{\vecv}{\vec v}
  \newcommand{\vecw}{\vec w}
  \newcommand{\vecx}{\vec x}
  \newcommand{\vecy}{\vec y}
  \newcommand{\vrp}{\vec r\hskip0.75pt '}
  \newcommand{\vrpp}{\vec r\hskip0.75pt ''}
  \newcommand{\vsp}{\vec s\hskip0.75pt '}
  \newcommand{\vrt}{\vec r(t)}
  \newcommand{\vst}{\vec s(t)}
  \newcommand{\vvt}{\vec v(t)}
  \newcommand{\vat}{\vec a(t)}
  \newcommand{\px}{\partial x}
  \newcommand{\py}{\partial y}
  \newcommand{\pz}{\partial z}
  \newcommand{\pf}{\partial f}
  \newcommand{\unittangent}{\vec{{}T}}
  \newcommand{\unitnormal}{\vec{N}}
  \newcommand{\unittangentprime}{\vec{{}T}\hskip0.75pt '}
  \newcommand{\R}{mathbb{R}}
  \newcommand{\mathN}{\mathbb{N}}
  \newcommand{\surfaceS}{\mathcal{S}}
  \newcommand{\zerooverzero}{\ds \raisebox{8pt}{\text{``\ }}\frac{0}{0}\raisebox{8pt}{\textit{ ''}}}
  \newcommand{\deriv}[2]{\myds\frac{d}{dx}\left(#1\right)=#2}
  \newcommand{\myint}[2]{\myds\int #1\, dx= {\ds #2}}
  \newcommand{\primeskip}{\hskip.75pt}
  \newcommand{\abs}[1]{\left\lvert #1\right\rvert}
  \newcommand{\sech}{\operatorname{sech}}
  \newcommand{\csch}{\operatorname{csch}}
  \newcommand{\curl}{\operatorname{curl}}
  \newcommand{\divv}{\operatorname{div}}
  \newcommand{\Hess}{\operatorname{Hess}}
\newcommand{\lt}{<}
\newcommand{\gt}{>}
\newcommand{\amp}{&}
");





              //ASY file for figparsurf1_3D.asy in Chapter 13

              size(200,200,IgnoreAspect);
              //currentprojection=perspective(7,2,1);
              currentprojection=orthographic(11.9,9.6,17.8);
              defaultrender.merge=true;

              // setup and draw the axes
              real[] myxchoice={-3,3};
              real[] myychoice={-3,3};
              real[] myzchoice={5,10};
              defaultpen(0.5mm);

              pair xbounds=(-3.5,3.5);
              pair ybounds=(-3.5,3.5);
              pair zbounds=(-1,12);

              xaxis3("",xbounds.x,xbounds.y,black,OutTicks(myxchoice),Arrow3(size=3mm));
              yaxis3("",ybounds.x,ybounds.y,black,OutTicks(myychoice),Arrow3(size=3mm));
              zaxis3("",zbounds.x,zbounds.y,black,OutTicks(myzchoice),Arrow3(size=3mm));

              label("$x$",(xbounds.y+0.05*(xbounds.y-xbounds.x),0,0));
              label("$y$",(0,ybounds.y+0.05*(ybounds.y-ybounds.x),0));
              label("$z$",(0,0,zbounds.y+0.05*(zbounds.y-zbounds.x)));


              //Draw the top half of the surface z^2 = x^2+2y^2
              triple f(pair t) {
                return (2*t.y*cos(t.x),2*t.y*sin(t.x),(2*t.y*cos(t.x))^2+2*(2*t.y*sin(t.x))^2);//
              }
              surface s=surface(f,(0,0),(2pi,1),16,16,usplinetype=new splinetype[] {notaknot,notaknot,monotonic},vsplinetype=new splinetype[] {notaknot,notaknot,monotonic});
              pen p=apexmeshpen;
              draw(s,surfacepen,meshpen=p);


              triple g(real t) {
                return (2*cos(t),2*sin(t),0);
                }

              //triple g(real t) {return(cos(t),sin(t),t/(2*pi));}
              path3 mypath=graph(g,0,2pi,operator ..);
              draw(surface(mypath--cycle),curvepen+opacity(.5));
              draw(mypath,curvepen);


            