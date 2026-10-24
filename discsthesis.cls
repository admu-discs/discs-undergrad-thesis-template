%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% discsthesis.cls -- DISCS undergraduate thesis class
%%%
%%% Reproduces the layout of the official Word template
%%% "CS Thesis Template (with biblio in PCSC-ACM format) A4 v202102":
%%%
%%%   * A4; margins 1in top/bottom/right, 1.5in left
%%%   * Times 12pt, double spaced, justified, 0.5in paragraph indent
%%%   * page number top right (0.5in from the edge); none on the first page
%%%     of a chapter, the bibliography, or an appendix
%%%   * roman page numbers in the front matter, arabic from Chapter I
%%%   * "CHAPTER I" / "TITLE" headings, bold and centred
%%%   * bold "1.1 Title" sections, preceded by one blank line
%%%   * bold centred captions: figures below, tables above
%%%   * ACM reference format with numeric citations
%%%
%%% Based on discsthesis.cls v3.1 (Coronel, Estuar, Vergara, Vidal, 2005),
%%% itself based on admuthesis.cls (F. P. Muga II).
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{discsthesis}[2026/10/24 v4.0 DISCS thesis (Word template v202102 layout)]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[12pt,a4paper,oneside]{report}

%%% Page layout ---------------------------------------------------------------
\RequirePackage[a4paper,top=1in,bottom=1in,left=1.5in,right=1in,
                headheight=15pt,headsep=21pt,footskip=0pt]{geometry}

%%% Fonts (Times New Roman) ---------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage{newtxtext,newtxmath}

%%% Spacing -------------------------------------------------------------------
%%% Word's "double" spacing for 12pt Times New Roman is 27.6pt per line
%%% (25 lines per page); 1.9 x 14.5pt gives the same.  Word's single
%%% spacing is 13.8pt, so "single" (tables, TOC, \singlespacing) is 0.952.
\RequirePackage{setspace}
\renewcommand\setspace@singlespace{0.952}
\setstretch{1.9}
\setlength{\topskip}{14.2pt} % first baseline where Word puts it
\setlength{\parindent}{0.5in}
\setlength{\parskip}{0pt}

%%% Lists: number at 0.25in, text at 0.5in; no extra space ------------------
\RequirePackage[shortlabels]{enumitem}
\setlist{nosep}
\setlist[enumerate,1]{label=\arabic*., labelindent=0.25in, leftmargin=0.5in,
                      labelsep=*, align=left}
\setlist[enumerate,2]{label=\alph*., labelindent=0.25in, leftmargin=0.5in,
                      labelsep=*, align=left}
\setlist[itemize]{labelindent=0.25in, leftmargin=0.5in, labelsep=*, align=left}

%%% Page style: page number at the top right ----------------------------------
\def\ps@thesis{%
  \let\@mkboth\@gobbletwo
  \def\@oddhead{\hfil\thepage}\let\@evenhead\@oddhead
  \let\@oddfoot\@empty\let\@evenfoot\@empty}
\pagestyle{thesis}

%%% Numbering -----------------------------------------------------------------
%%% Chapters are shown in roman numerals (CHAPTER I) but sections, figures and
%%% tables use the arabic chapter number (1.1, Figure 2.1).  In the appendices
%%% everything uses the letter (APPENDIX A, A.1, Figure A.1).
\newcommand\thesis@chapnum{\arabic{chapter}}
\renewcommand\thechapter{\Roman{chapter}}
\renewcommand\thesection{\thesis@chapnum.\arabic{section}}
\renewcommand\thefigure{\thesis@chapnum.\arabic{figure}}
\renewcommand\thetable{\thesis@chapnum.\arabic{table}}
\renewcommand\theequation{\thesis@chapnum.\arabic{equation}}

\renewcommand\chaptername{Chapter}
\renewcommand\appendixname{Appendix}
\renewcommand\contentsname{TABLE OF CONTENTS}
\renewcommand\listfigurename{LIST OF FIGURES}
\renewcommand\listtablename{LIST OF TABLES}
\renewcommand\bibname{BIBLIOGRAPHY}

%%% Headings ------------------------------------------------------------------
\RequirePackage{titlesec}
\titleformat{\chapter}[display]{\normalfont\normalsize\bfseries\centering}
  {\MakeUppercase{\chaptertitlename}\ \thechapter}{0pt}{\MakeUppercase}
\titleformat{name=\chapter,numberless}[block]
  {\normalfont\normalsize\bfseries\centering}{}{0pt}{\MakeUppercase}
\titlespacing*{\chapter}{0pt}{-\baselineskip}{\baselineskip} % on the first line
\assignpagestyle{\chapter}{empty}

\titleformat{\section}[hang]{\normalfont\normalsize\bfseries\raggedright}{\thesection}{0.5em}{}
\titleformat{\subsection}[hang]{\normalfont\normalsize\bfseries\raggedright}{\thesubsection}{0.5em}{}
\titleformat{\subsubsection}[hang]{\normalfont\normalsize\bfseries\raggedright}{\thesubsubsection}{0.5em}{}
\titlespacing*{\section}{0pt}{\baselineskip}{0pt}
\titlespacing*{\subsection}{0pt}{\baselineskip}{0pt}
\titlespacing*{\subsubsection}{0pt}{\baselineskip}{0pt}

%%% Front-matter page title (ABSTRACT, TABLE OF CONTENTS, ...): these pages
%%% keep their page number, unlike chapter pages.
\newcommand\thesis@frontheading[1]{%
  \clearpage
  {\centering\bfseries#1\par}\nobreak
  \@afterindentfalse\@afterheading}

%%% Floats and captions -------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{caption}
\captionsetup{labelsep=space, font=bf, justification=centering}
\captionsetup[figure]{font={bf,stretch=1.9}, skip=4pt}
\captionsetup[table]{position=top, font={bf,stretch=0.952}, skip=10pt}

%%% Bibliography: ACM Reference Format, numeric citations ---------------------
\RequirePackage{url}
\RequirePackage[numbers,square,sort&compress]{natbib}
\bibliographystyle{ACM-Reference-Format}
\urlstyle{same}
% As in Word: "[n]" ends at the margin, the entry text starts 0.25in in
\AtBeginDocument{\def\@bibsetup#1{%
  \setlength\leftmargin{0.25in}\setlength\labelsep{0.25in}%
  \setlength\labelwidth{0.5in}\setlength\itemindent\z@
  \setlength\itemsep\z@\setlength\parsep\z@}}
\renewcommand\bibsection{%
  \chapter*{\bibname}%
  \phantomsection\addcontentsline{toc}{plainchapter}{\bibname}}

%%% Table of contents ---------------------------------------------------------
%%% Single spaced, a blank line between groups; the chapter numeral sits in
%%% its own 0.68in column, with the title and its sections aligned after it.
\setcounter{tocdepth}{1}
\newlength\thesis@tocnumwidth
\setlength\thesis@tocnumwidth{0.68in}
\newif\if@thesistocfirst

\newcommand\thesis@tocgap{%
  \if@thesistocfirst\global\@thesistocfirstfalse
  \else\addvspace{\baselineskip}\fi}

% #1 left indent, #2 entry text, #3 page number
\newcommand\thesis@tocline[3]{%
  \begingroup
    \parindent\z@ \leftskip#1\relax
    \rightskip\@tocrmarg plus 1fil \parfillskip-\@tocrmarg
    \hyphenpenalty\@M \exhyphenpenalty\@M
    \leavevmode#2\nobreak
    \leaders\hbox to 0.25em{\hss.\hss}\hfill
    \nobreak\hbox{\normalfont\,#3}\par
  \endgroup}

% Group labels "CHAPTER" and "APPENDIX"
\newcommand\thesis@toclabel[1]{%
  \thesis@tocgap{\noindent#1\par}\nobreak}

% Numbered chapters and appendices
\renewcommand*\l@chapter[2]{%
  \thesis@tocgap
  \begingroup
    \def\numberline##1{\hskip-\thesis@tocnumwidth
      \hb@xt@\dimexpr\thesis@tocnumwidth-10.8pt{\hss##1\hss}\hskip10.8pt}%
    \thesis@tocline{\thesis@tocnumwidth}{\MakeUppercase{#1}}{#2}%
  \endgroup\nobreak}

% Unnumbered entries: ABSTRACT, ..., BIBLIOGRAPHY
\newcommand*\l@plainchapter[2]{%
  \thesis@tocgap\thesis@tocline{\z@}{\MakeUppercase{#1}}{#2}}

% Sections ("1.1 Title") are aligned with the chapter title
\renewcommand*\l@section[2]{%
  \ifnum\c@tocdepth>\z@\begingroup
    \def\numberline##1{##1\space}%
    \thesis@tocline{\thesis@tocnumwidth}{#1}{#2}%
  \endgroup\fi}
\renewcommand*\l@subsection[2]{%
  \ifnum\c@tocdepth>\@ne\begingroup
    \def\numberline##1{##1\space}%
    \thesis@tocline{\dimexpr\thesis@tocnumwidth+0.3in\relax}{#1}{#2}%
  \endgroup\fi}

\renewcommand\tableofcontents{%
  \thesis@frontheading{\contentsname}%
  \begingroup
    \setstretch{\setspace@singlespace}\vspace{\baselineskip}%
    \@thesistocfirsttrue
    \@starttoc{toc}%
  \endgroup}

%%% List of figures / tables: double spaced, "Figure 2.1 Caption ..... 6"
\renewcommand*\l@figure[2]{%
  \begingroup
    \def\numberline##1{\figurename\ ##1\space}%
    \thesis@tocline{\z@}{#1}{#2}%
  \endgroup}
\renewcommand*\l@table[2]{%
  \begingroup
    \def\numberline##1{\tablename\ ##1\space}%
    \thesis@tocline{\z@}{#1}{#2}%
  \endgroup}

\newcommand\thesis@listof[2]{% #1 title, #2 file extension
  \thesis@frontheading{#1}%
  \phantomsection\addcontentsline{toc}{plainchapter}{#1}%
  \begingroup
    \let\addvspace\@gobble % no gap between chapters
    \@starttoc{#2}%
  \endgroup}
\renewcommand\listoffigures{\thesis@listof{\listfigurename}{lof}}
\renewcommand\listoftables{\thesis@listof{\listtablename}{lot}}

%%% Title page ----------------------------------------------------------------
\newcommand\ThesisTitle[1]{\gdef\@ThesisTitle{#1}}
\newcommand\ThesisAuthor[1]{\gdef\@ThesisAuthor{#1}}
\newcommand\ThesisDefenseYear[1]{\gdef\@ThesisDefenseYear{#1}}
\newcommand\ThesisDegree[1]{\gdef\@ThesisDegree{#1}}
\newcommand\ThesisDepartment[1]{\gdef\@ThesisDepartment{#1}}
\newcommand\ThesisUniversity[1]{\gdef\@ThesisUniversity{#1}}
\ThesisTitle{THESIS TITLE}
\ThesisAuthor{Author Name}
\ThesisDefenseYear{\the\year}
\ThesisDegree{Bachelor of Science in Computer Science}
\ThesisDepartment{Department of Information Systems\\and Computer Science}
\ThesisUniversity{Ateneo de Manila University}

\newcommand\ThesisTitlePage{%
  \pagenumbering{roman}%
  \begin{titlepage}
    \centering
    \mbox{}\par\mbox{}\par
    \textbf{\@ThesisTitle}\par
    \vspace{2\baselineskip}
    A Thesis\\
    Presented to the\\
    \@ThesisDepartment\\
    \@ThesisUniversity\par
    \vspace{2\baselineskip}
    In Partial Fulfillment\\
    of the Requirements for the Degree\\
    \@ThesisDegree\par
    \vspace{2\baselineskip}
    by\\
    \textbf{\@ThesisAuthor}\\
    \@ThesisDefenseYear\par
  \end{titlepage}%
  \setcounter{page}{2}}
\let\maketitle\ThesisTitlePage

%%% Main matter and appendices ----------------------------------------------
\newcommand\mainmatter{%
  \clearpage\pagenumbering{arabic}%
  \addtocontents{toc}{\protect\thesis@toclabel{CHAPTER}}}
\renewcommand\appendix{%
  \clearpage
  \setcounter{chapter}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\Alph{chapter}}%
  \gdef\thesis@chapnum{\Alph{chapter}}%
  \addtocontents{toc}{\protect\thesis@toclabel{APPENDIX}}}

\newenvironment{thesisabstract}
  {\thesis@frontheading{ABSTRACT}%
   \phantomsection\addcontentsline{toc}{plainchapter}{ABSTRACT}%
   \vspace{\baselineskip}\@afterheading}
  {\clearpage}
\newenvironment{acknowledgments}
  {\thesis@frontheading{ACKNOWLEDGEMENTS}%
   \phantomsection\addcontentsline{toc}{plainchapter}{ACKNOWLEDGEMENTS}%
   \vspace{\baselineskip}\@afterheading}
  {\clearpage}

%%% Clickable TOC, list of figures/tables, citations and URLs ---------------
\RequirePackage{xcolor}
\RequirePackage[linktoc=all,bookmarksnumbered]{hyperref}
\hypersetup{colorlinks, linkcolor={black}, citecolor={blue!50!black},
            urlcolor={blue!80!black}}
\pdfstringdefDisableCommands{\let\MakeUppercase\relax}
\def\toclevel@plainchapter{0}

\endinput
