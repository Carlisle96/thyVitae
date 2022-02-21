\ProvidesClass{thyv}[1st CV class by thyriaen]

\NeedsTeXFormat{LaTeX2e}
\LoadClass[12pt]{article}

\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\usetikzlibrary{shapes, backgrounds}

\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{color}
\RequirePackage[a4paper]{geometry}
\RequirePackage{calc}

\RequirePackage{xifthen}
\RequirePackage{setspace}
\RequirePackage{array}
\RequirePackage{graphicx}
\RequirePackage{wrapfig}

\RequirePackage{xstring}

\renewcommand{\familydefault}{\sfdefault}    

%\pagestyle{empty}			% no header, footer
\setlength{\parindent}{0pt}	% no paragraph indentation

\geometry{top=1cm, bottom=1cm, left=6cm, right=1cm}
\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\definecolor{thyFirst}{RGB}{132,70,132}
\definecolor{thySecond}{RGB}{70,70,132}
\definecolor{thyThird}{RGB}{170,60,60}

\definecolor{thyWhite}{RGB}{255,255,255}
\definecolor{thyBlack}{RGB}{0,0,0}
\definecolor{thyGrey}{RGB}{160,160,160}

\definecolor{thySidebar}{RGB}{230,230,230}

\pagecolor{thyWhite}
\definecolor{firstcol}{rgb}{132,70,132}
\definecolor{thirdcol}{rgb}{70,70,132}
\definecolor{textcol}{rgb}{0,0,0}
%----------------------------------------------------------------------------------------
%	 SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

%----------------------------------------------------------------------------------------
%   TIMELINE CHART
%----------------------------------------------------------------------------------------
% 1 :: start year
% 2 :: end year
% 3 :: overall height
% 4 :: width of textboxes 
\newenvironment{thyV}[4]{
    
    \def\textFormat{\setstretch{0.9}\footnotesize}

    % 1 :: start date
    % 2 :: end date
    % 3 :: if empty print close to timeline
    \newcommand{\thyDrawTime}[3]{

        \StrCut{##1}{/}{\monthf}{\yearf}
        \StrCut{##2}{/}{\montht}{\yeart}
        \pgfmathparse{\yearlength*((\yearf-#1)+(\monthf/12))}
        \let\startX\pgfmathresult

        \pgfmathparse{\yearlength*((\yeart-#1)+(\montht/12))}
        \let\endX\pgfmathresult

        \ifthenelse{\equal{##3}{}}{
            \def\drawCol{thyFirst}
            \def\catDistance{-0.25}            
        }{
            \def\drawCol{thySecond}
            \def\catDistance{-0.65}
        }
        \filldraw[fill=\drawCol, draw=none, opacity=1]
            (\catDistance, \startX)
                rectangle
            (\catDistance-0.2,\endX);

    }

    % 1 :: date
    % 2 :: text
    % 3 :: color   
    % 4 :: grey text 
    \newcommand{\thyDrawEvent}[4]{

        \StrCut{##1}{/}{\monthf}{\yearf}
        \pgfmathparse{\yearlength*((\yearf-#1)+(\monthf/12))}
        \let\startX\pgfmathresult

        \ifthenelse{\equal{##4}{}}{
            \def\boxContent{\textFormat\textcolor{textcol}{##2}}
        }{
            \def\boxContent{\textFormat\textcolor{thyGrey}{##4} \textcolor{textcol}{##2}}
        }

        \draw[draw=##3, line width=1.5pt] (0, \startX) -- (0.5,\startX);

        \node[label={
            [label distance=-10]0:\colorbox{##3}{\textFormat\strut}
            \parbox{#4}{\textFormat\boxContent}
        }] at (0.5, \startX) {};
    }

    % 1 :: name of event
    % 2 :: date 1
    % 3 :: date 2
    % 4 :: position date
    \newcommand{\thyVentWork}[4]{

        \ifthenelse{\equal{##4}{}}{
            \StrCut{##2}{/}{\monthf}{\yearf}
            \StrCut{##3}{/}{\montht}{\yeart}

            \pgfmathparse{((\yeart-\yearf)*12+\montht-\monthf)*0.5+\monthf}
            \let\monthDiff\pgfmathresult

            \def\positionDate{\monthDiff/\yearf}
        }{
            \def\positionDate{##4}
        }

        \thyDrawTime{##2}{##3}{1}
        \thyDrawEvent{\positionDate}{##1}{thySecond}{}
    }


    % 1 :: name of event
    % 2 :: date 1
    % 3 :: date 2
    % 4 :: position date
    \newcommand{\thyVentEdu}[4]{

        \ifthenelse{\equal{##4}{}}{
            \StrCut{##2}{/}{\monthf}{\yearf}
            \StrCut{##3}{/}{\montht}{\yeart}

            \pgfmathparse{((\yeart-\yearf)*12+\montht-\monthf)*0.5+\monthf}
            \let\monthDiff\pgfmathresult

            \def\positionDate{\monthDiff/\yearf}
        }{
            \def\positionDate{##4}
        }

        \thyDrawTime{##2}{##3}{}
        \thyDrawEvent{\positionDate}{##1}{thyFirst}{}
    }

    % 1 :: name of event
    % 2 :: date 1
    \newcommand{\thyVent}[2]{
        \thyDrawEvent{##2}{##1}{thyThird}{##2}
    }

\begin{tikzpicture}
        \newcounter{yearcount}
        \setcounter{yearcount}{1}

        \pgfmathparse{(#2-#1)}
        \let\fullrange\pgfmathresult
        \pgfmathparse{#3/\fullrange}
        \let\yearlength\pgfmathresult
        \pgfmathparse{\yearlength*((\year-#1)+(\month/12))}
        \let\todayX\pgfmathresult
        \pgfmathparse{(2023)}
        \let\enddate\pgfmathresult

        \draw[draw=textcol, line width=2pt] (0,0.25*\yearlength) -- (0,\todayX);
        \draw[draw=textcol, dashed, line width=2pt] (0,\todayX) -- (0,#3-0.25*\yearlength);

        \draw[draw=textcol, line width=2pt] (0,0.25*\yearlength) -- (-1,0.25*\yearlength);
        \draw[draw=textcol, dashed, line width=2pt] (0,#3-0.25*\yearlength) -- (-1,#3-0.25*\yearlength);

        \whiledo{\value{yearcount} < \fullrange}{
            \draw[draw=textcol, line width=1pt] 
                (0,\yearlength*\value{yearcount}) -- 
                (0.2,\yearlength*\value{yearcount});
            \stepcounter{yearcount}
        }

        \node[label=\textcolor{textcol}{\textbf{#1}}] at (-0.6,0.25*\yearlength-0.1) {};
        \node[label=\textcolor{textcol}{\textbf{\enddate}}] at (-0.6,#3-0.75*\yearlength) {};

}{
    \end{tikzpicture}
}