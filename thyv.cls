\ProvidesClass{thyv}[1st CV class by thyriaen]

\NeedsTeXFormat{LaTeX2e}
\LoadClass[11pt]{article}
\RequirePackage[a4paper]{geometry}

\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}

\RequirePackage{tikz}
\usetikzlibrary{shapes, backgrounds}
\usetikzlibrary{decorations.text}

\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{color}

\RequirePackage{xifthen}
\RequirePackage{setspace}
\RequirePackage{xstring}
\RequirePackage{calc}

\RequirePackage{doi}
\RequirePackage{url}
\hypersetup{breaklinks,colorlinks,
            %linkcolor=black,urlcolor=black,
            %anchorcolor=black,citecolor=black,
            linkcolor=thyThird,urlcolor=thyThird,
            anchorcolor=thyThird,citecolor=thyThird,
            %draft
            }

\RequirePackage[%
    linewidth = 1pt,
    middlelinecolor = black,
    middlelinewidth = 1pt,
    roundcorner = 1pt,
    topline = false,
    rightline = false,
    bottomline = false,
    leftline = false,
    rightmargin = 0pt,
    skipabove = 0pt,
    skipbelow = 0pt,
    innerleftmargin = 0.5cm,
    innerrightmargin = 0pt,
    innertopmargin = 0pt,
    innerbottommargin = 0pt,
]{mdframed}

%----------------------------------------------------------------------------------------
%    MISC
%----------------------------------------------------------------------------------------  
    \pagestyle{empty}			% no header, footer
    \setlength{\parindent}{0pt}	% no paragraph indentation

    \geometry{top=1.5cm, bottom=0.5cm, left=6cm, right=1cm}
    \setlength{\TPHorizModule}{1cm} % Left margin
    \setlength{\TPVertModule}{1cm} % Top margin

    \newlength\imagewidth
    \newlength\imagescale
    \pgfmathsetlength{\imagewidth}{5cm}
    \pgfmathsetlength{\imagescale}{\imagewidth/600}

    \providecommand*\emaillink[1]{\nolinkurl{#1}}
    \providecommand*\email[1]{\href{mailto:#1}{\emaillink{#1}}}

    \def\Cplusplus{C\raisebox{0.5ex}{\tiny\textbf{++}}}
    \def\CplusplusSpace{C\raisebox{0.5ex}{\tiny\textbf{++}} }
%----------------------------------------------------------------------------------------
%    COLORS
%----------------------------------------------------------------------------------------

    \definecolor{thyFirst}{RGB}{132,70,132}
    \definecolor{thySecond}{RGB}{70,70,132}
    \definecolor{thyThird}{RGB}{170,60,60}

    \definecolor{thyWhite}{RGB}{255,255,255}
    \definecolor{thyBlack}{RGB}{0,0,0}
    \definecolor{thyGrey}{RGB}{100,100,100}

    \definecolor{thySidebar}{RGB}{230,230,230}

    \pagecolor{thyWhite}
    \definecolor{firstcol}{rgb}{132,70,132}
    \definecolor{thirdcol}{rgb}{70,70,132}
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
                \def\boxContent{\textFormat\textcolor{thyBlack}{##2}}
            }{
                \def\boxContent{\textFormat\textcolor{thyGrey}{##4} \textcolor{thyBlack}{##2}}
            }

            \ifthenelse{\equal{##3}{thyThird}}{
                \def\distance{0}
            }{
                \ifthenelse{\equal{##3}{thySecond}}{
                    \def\distance{-0.65}
                }{
                    \def\distance{-0.25}
                }
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

    % draw timeline
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

            % main timeline
            \draw[draw=thyBlack, line width=2pt] (0,0.25*\yearlength) -- (0,\todayX);
            \draw[draw=thyBlack, dashed, line width=2pt] (0,\todayX) -- (0,#3-0.25*\yearlength);

            % big start and end indicator
            \draw[draw=thyBlack, line width=2pt] (0,0.25*\yearlength) -- (-1,0.25*\yearlength);
            \draw[draw=thyBlack, dashed, line width=2pt] (0,#3-0.25*\yearlength) -- (-1,#3-0.25*\yearlength);

            % small new-year indicators
            \whiledo{\value{yearcount} < \fullrange}{
                \draw[draw=thyBlack, line width=1pt] 
                    (0,\yearlength*\value{yearcount}) -- 
                    (0.2,\yearlength*\value{yearcount});
                \stepcounter{yearcount}
            }

            % year text
            \node[label=\textcolor{thyBlack}{\textbf{#1}}] at (-0.6,0.25*\yearlength-0.1) {};
            \node[label=\textcolor{thyBlack}{\textbf{\enddate}}] at (-0.6,#3-0.75*\yearlength) {};
    }{
        \end{tikzpicture}
    }

    % 1: text
    % 2: width
    % 3: color
    \newcommand{\thyLegend}[3]{\parbox{#2}{\textcolor{#3}{\rule{#2}{3pt}}\\#1}}
%----------------------------------------------------------------------------------------
%   Barchart
%---------------------------------------------------------------------------------------- 
    \newcounter{barcount}

    % Environment to hold a new bar chart
    \newenvironment{barchart}[1]{ % The only parameter is the maximum bar width, in cm
        \newcommand{\barwidth}{0.35}
        \newcommand{\barsep}{0.2}
        
        % Command to add a bar to the bar chart
        \newcommand{\baritem}[2]{ % The first argument is the bar label and the second is the percentage the current bar should take up of the total width
            \pgfmathparse{##2}
            \let\perc\pgfmathresult
            
            \pgfmathparse{#1}
            \let\barsize\pgfmathresult
            
            \pgfmathparse{\barsize*##2/100}
            \let\barone\pgfmathresult
            
            \pgfmathparse{(\barwidth*\thebarcount)+(\barsep*\thebarcount)}
            \let\barx\pgfmathresult
            
            \filldraw[fill=thySecond, draw=none] (0,-\barx) rectangle (\barone,-\barx-\barwidth);
            
            \node [label=180:\textcolor{thyBlack}{##1}] at (0,-\barx-0.175) {};
            \addtocounter{barcount}{1}
        }
        \begin{tikzpicture}
            \setcounter{barcount}{0}
    }{
        \end{tikzpicture}
    }
%----------------------------------------------------------------------------------------
%   FONTS
%----------------------------------------------------------------------------------------

    \usepackage[utf8]{inputenc} % Required for inputting international characters
    \usepackage[T1]{fontenc} % Output font encoding for international characters

    %\usepackage[default]{raleway}
    %\usepackage[defaultsans]{droidsans}
    %\usepackage{cmbright}
    %\usepackage{fetamont}
    %\usepackage[default]{gillius}
    %\usepackage{roboto}

    \renewcommand*\familydefault{\sfdefault} % Force the sans-serif version of any font used

    %------------------------------------------------

    \usepackage{fontawesome5} % Required for FontAwesome icons

    % 1 :: FontAwesome icon name
    % 2 :: box size
    % 3 :: text
    \newcommand{\icon}[3]{
        \makebox(#2, #2){\textcolor{thyBlack}{\large\csname fa#1\endcsname}}
        %\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt, text=thyBlack] (char) {#1};
        \hspace{0.2cm}
        \textcolor{thyBlack}{#3}
    }
%----------------------------------------------------------------------------------------
%   TitleFormat
%----------------------------------------------------------------------------------------
    \newcommand{\thyVsection}[2]{% The only parameter is the section text
        \vspace{\baselineskip} % Whitespace before the section title
        \colorbox{#2}{ \textcolor{thyWhite}{\texttt{\textbf{#1}}} }
        \textcolor{#2}{\hrule width0.6\textwidth}
        \vspace{\baselineskip}
        % Section title
    }

    %\titleformat{\section}
    %    {\Large\scshape\raggedright}
    %    {}{0cm} % prefix
    %    {}      % insert code before header
    %    %[\titlerule]
    %\titlespacing*{<command>}{<left>}{<before-sep>}{<after-sep>}
    %<left> increases the left margin; <before-sep> controls the vertical space before the title; <after-sep> controls the vertical space after the title. 
    %\titlespacing{\section}{0pt}{0pt}{0pt}

    \newcommand{\slashsep}{\textbackslash\hspace{2mm}}

    \newcommand{\thyntry}[5]{\textbf{#1}
        \hfill{\footnotesize \textbf{#2}}\\
        #4 \\ \texttt{#5}\hfill\textcolor{thyGrey}{#3}\\}

    \newcommand{\thyntrySmall}[4]{\textbf{#1}
        \hfill{\footnotesize \textbf{#2}}\\
        #4 \hfill\textcolor{thyGrey}{#3}}

    \newcommand{\thyntryLast}[5]{\textbf{#1}
        \hfill{\footnotesize \textbf{#2}}\\
        #4 \\ \texttt{#5}\hfill\textcolor{thyGrey}{#3}}
%----------------------------------------------------------------------------------------
%   Pie Chart
%----------------------------------------------------------------------------------------
    
    \def\innerCirc{1.5}
    \def\outerCirc{3}

    \newenvironment{thyChart} {
        \begin{tikzpicture}[x=0.85cm, y=0.85cm]
            \draw[draw=thyWhite, fill=thyBlack,thick, line width=6pt] 
                (0:\innerCirc) -- (0:\outerCirc) arc (0:36:\outerCirc) -- (36:\innerCirc) arc (36:0:\innerCirc);
            \draw[draw=thyWhite, fill=thyThird,thick, line width=6pt] 
                (36:\innerCirc) -- (36:\outerCirc) arc (36:108:\outerCirc) -- (108:\innerCirc) arc (108:36:\innerCirc);
            \draw[draw=thyWhite, fill=thyFirst,thick, line width=6pt] 
                (108:\innerCirc) -- (108:\outerCirc) arc (108:216:\outerCirc) -- (216:\innerCirc) arc (216:108:\innerCirc);
            \draw[draw=thyWhite, fill=thySecond,thick, line width=6pt] 
                (216:\innerCirc) -- (216:\outerCirc) arc (216:360:\outerCirc) -- (360:\innerCirc) arc (360:216:\innerCirc);    

            \draw[decoration={
                text format delimiters={[}{]},
                text color=thyWhite,
                text along path,
                text={[\footnotesize\tt\bfseries]Design},
                text align={center},
                raise=-0.5cm,
                reverse path},
                decorate] (0:\outerCirc) arc (0:36:\outerCirc);
            \draw[decoration={
                text format delimiters={[}{]},
                text color=thyWhite,
                text along path,
                text={[\footnotesize\tt\bfseries]Implementation},
                text align={center},
                raise=-0.5cm,
                reverse path},
                decorate] (36:\outerCirc) arc (36:108:\outerCirc);          
            \draw[decoration={
                text format delimiters={[}{]},
                text color=thyWhite,
                text along path,
                text={[\footnotesize\tt\bfseries]Research},
                text align={center},
                raise=-0.5cm,
                reverse path},
                decorate] (108:\outerCirc) arc (108:216:\outerCirc); 
            \draw[decoration={
                text format delimiters={[}{]},
                text color=thyWhite,
                text along path,
                text={[\footnotesize\tt\bfseries]Development},
                text align={center},
                raise=0.3cm},
                decorate] (216:\outerCirc) arc (216:360:\outerCirc); 
        \end{tikzpicture}
    }

