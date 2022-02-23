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

\RequirePackage{titlesec}

\RequirePackage{xifthen}
\RequirePackage{setspace}
\RequirePackage{array}
\RequirePackage{graphicx}
\RequirePackage{wrapfig}

\RequirePackage{xstring}
\RequirePackage{doi}
\RequirePackage{url}
\hypersetup{breaklinks,colorlinks,
            %linkcolor=black,urlcolor=black,
            %anchorcolor=black,citecolor=black,
            linkcolor=thyFirst,urlcolor=thyFirst,
            anchorcolor=thyFirst,citecolor=thyFirst,
            %draft
            }
\RequirePackage[shortlabels]{enumitem}
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

    \geometry{top=1cm, bottom=1cm, left=6cm, right=1cm}
    \setlength{\TPHorizModule}{1cm} % Left margin
    \setlength{\TPVertModule}{1cm} % Top margin

    \newlength\imagewidth
    \newlength\imagescale
    \pgfmathsetlength{\imagewidth}{5cm}
    \pgfmathsetlength{\imagescale}{\imagewidth/600}

    \providecommand*\emaillink[1]{\nolinkurl{#1}}
    \providecommand*\email[1]{\href{mailto:#1}{\emaillink{#1}}}
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
    \titleformat{\section}
        {\Large\scshape\raggedright}
        {}{0cm} % prefix
        {}      % insert code before header
        %[\titlerule]
    %\titlespacing*{<command>}{<left>}{<before-sep>}{<after-sep>}
    %<left> increases the left margin; <before-sep> controls the vertical space before the title; <after-sep> controls the vertical space after the title. 
    \titlespacing{\section}{0pt}{0pt}{0pt}


%%% LISTS

    % This macro alters a list by removing some of the space that follows the list
    % (is used by lists below)
    \newcommand*\fixendlist[1]{%
        \expandafter\let\csname preFixEndListend#1\expandafter\endcsname\csname end#1\endcsname
        \expandafter\def\csname end#1\endcsname{\csname preFixEndListend#1\endcsname\vspace{-0.6\baselineskip}}}

    % These macros help ensure that items in outer-type lists do not get
    % separated from the next line by a page break
    % (they are used by lists below)
    \let\originalItem\item
    \newcommand*\fixouterlist[1]{%
        \expandafter\let\csname preFixOuterList#1\expandafter\endcsname\csname #1\endcsname
        \expandafter\def\csname #1\endcsname{\let\oldItem\item\def\item{\pagebreak[2]\oldItem}\csname preFixOuterList#1\endcsname}
        \expandafter\let\csname preFixOuterListend#1\expandafter\endcsname\csname end#1\endcsname
        \expandafter\def\csname end#1\endcsname{\let\item\oldItem\csname preFixOuterListend#1\endcsname}}
    \newcommand*\fixinnerlist[1]{%
        \expandafter\let\csname preFixInnerList#1\expandafter\endcsname\csname #1\endcsname
        \expandafter\def\csname #1\endcsname{\let\oldItem\item\let\item\originalItem\csname preFixInnerList#1\endcsname}
        \expandafter\let\csname preFixInnerListend#1\expandafter\endcsname\csname end#1\endcsname
        \expandafter\def\csname end#1\endcsname{\csname preFixInnerListend#1\endcsname\let\item\oldItem}}

    % An itemize-style list with lots of space between items
    %
    % Usage:
    %   \begin{outerlist}
    %       \item ...    % (or \item[] for no bullet)
    %   \end{outerlist}
    \newlist{outerlist}{itemize}{3}
        \setlist[outerlist]{label=\enskip\textbullet,leftmargin=*}
        \fixendlist{outerlist}
        \fixouterlist{outerlist}

    % An environment IDENTICAL to outerlist that has better pre-list spacing
    % when used as the first thing in a \section
    %
    % Usage:
    %   \begin{lonelist}
    %       \item ...    % (or \item[] for no bullet)
    %   \end{lonelist}
    \newlist{lonelist}{itemize}{3}
        \setlist[lonelist]{label=\enskip\textbullet,leftmargin=*,partopsep=0pt,topsep=0pt}
        \fixendlist{lonelist}
        \fixouterlist{lonelist}

    % An itemize-style list with little space between items
    %
    % Usage:
    %   \begin{innerlist}
    %       \item ...    % (or \item[] for no bullet)
    %   \end{innerlist}
    \newlist{innerlist}{itemize}{3}
        \setlist[innerlist]{label=\enskip\textbullet,leftmargin=*,parsep=0pt,itemsep=0pt,topsep=0pt,partopsep=0pt}
        \fixinnerlist{innerlist}

    % An environment IDENTICAL to innerlist that has better pre-list spacing
    % when used as the first thing in a \section
    %
    % Usage:
    %   \begin{loneinnerlist}
    %       \item ...    % (or \item[] for no bullet)
    %   \end{loneinnerlist}
    \newlist{loneinnerlist}{itemize}{3}
        \setlist[loneinnerlist]{label=\enskip\textbullet,leftmargin=*,parsep=0pt,itemsep=0pt,topsep=0pt,partopsep=0pt}
        \fixendlist{loneinnerlist}
        \fixinnerlist{loneinnerlist}

    \newcommand{\cvskill}[2]{%
    \textcolor{black}{\textbf{#1}}\hfill
    \foreach \x in {1,...,5}{%
      \space{\ifnumgreater{\x}{#2}{\color{body!30}}{\color{accent}}\faCircle}}\par%
    }
    \def\Cplusplus{C\raisebox{0.5ex}{\tiny\textbf{++}}}
    \newcommand\scalemath[2]{\scalebox{#1}{\mbox{\ensuremath{\displaystyle #2}}}}

    \def\OneOfFour{$\scalemath{1.5}{{\bullet}\mskip\medmuskip{\circ}\mskip\medmuskip{\circ}\mskip\medmuskip{\circ}}$}
    \def\TwoOfFour{$\scalemath{1.5}{{\bullet}\mskip\medmuskip{\bullet}\mskip\medmuskip{\circ}\mskip\medmuskip{\circ}}$}
    \def\ThreeOfFour{$\scalemath{1.5}{{\bullet}\mskip\medmuskip{\bullet}\mskip\medmuskip{\bullet}\mskip\medmuskip{\circ}}$}
    \def\FourOfFour{$\scalemath{1.5}{{\bullet}\mskip\medmuskip{\bullet}\mskip\medmuskip{\bullet}\mskip\medmuskip{\bullet}}$}
