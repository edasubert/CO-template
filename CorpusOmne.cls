\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CorpusOmne}

\DeclareOption{12pt}{
  \PassOptionsToClass{\CurrentOption}{extarticle}
}

%% Fallback
\DeclareOption*{
  \ClassWarning{CorpusOmne}{Unknown option '\CurrentOption'}
}

\ExecuteOptions{10pt}

\ProcessOptions\relax

\LoadClass[twoside,11pt]{extarticle}

\RequirePackage[utf8]{inputenc}
\RequirePackage[IL2]{fontenc}

\RequirePackage[czech]{babel}
\RequirePackage{multicol}
\RequirePackage{fancyhdr}
\RequirePackage{tocloft}
\RequirePackage{eso-pic}
\RequirePackage{graphicx}
\RequirePackage{lmodern}
\RequirePackage{needspace}
\RequirePackage{wrapfig}
\RequirePackage{soul}
\RequirePackage{array}
\RequirePackage[a4paper, top=15mm, bottom=25mm, left=15mm, right=15mm]{geometry}
\RequirePackage{suffix}
\RequirePackage{ifthen}
\RequirePackage{xstring}

\setlength{\headsep}{3mm}

\fancyhead{} 
\fancyhead[LO,LE]{\textbf{\COsectionHeadSTR}}
\fancyfoot{} 
\fancyfoot[LE,RO]{\thepage}
\fancyfoot[LO,RE]{\includegraphics[width=14pt]{icon/logo}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\fancypagestyle{plain}{%
\fancyhf{} % clear all header and footer fields
\fancyfoot{} % except the center
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}
\pagestyle{fancy}

% Section, no output, just for table of contents
\newcommand{\COsectionHeadSTR}{}
\newcommand{\COsection}[1]{%\addcontentsline{toc}{section}{#1}
\renewcommand{\COsectionHeadSTR}{#1}}

% Head for article
\newcommand\COarticle[2][EMPTY]{%
\ifthenelse{ \equal{#1}{EMPTY} }{%
  \addcontentsline{toc}{section}{#2}%
}{%
  \addcontentsline{toc}{section}{#1}%
}%
%
\begin{center}
\needspace{50mm}%
\noindent\rule{\linewidth}{0.5mm} \\[1mm]%
%\phantom{x}\hspace{3mm}%
\bfseries \fontsize{10mm}{11mm}\selectfont #2 \\[-6mm]%
\rule{\linewidth}{0.5mm}%
\end{center}
\renewcommand\COauthorCheck{first}% for multiple authors
}

% Head for article * (not listed)
\WithSuffix\newcommand\COarticle*[1]{%
\begin{center}
\needspace{50mm}%
\noindent\rule{\linewidth}{0.5mm} \\[1mm]%
%\phantom{x}\hspace{3mm}%
\bfseries \fontsize{10mm}{11mm}\selectfont #1 \\[-6mm]%
\rule{\linewidth}{0.5mm}%
\end{center}
\renewcommand\COauthorCheck{first}% for multiple authors
}

% Head for article CUSTOM
\newcommand\COarticleCustom[2]{%
\addcontentsline{toc}{section}{#1}%
%
\needspace{50mm}%
#2%
\renewcommand\COauthorCheck{first}% for multiple authors
}

% Head for article CUSTOM * (not listed)
\WithSuffix\newcommand\COarticleCustom*[1]{%
\needspace{50mm}%
#1%
\renewcommand\COauthorCheck{first}% for multiple authors
}

\newcommand{\COyoutube}{%
\hspace{5mm}\includegraphics{icon/youtube}%
}

%Head for editorial
\newcommand{\COeditorial}[1][Slovo šéfredaktorky]{%
\needspace{50mm}%
\noindent\rule{\linewidth}{0.5mm} \\[3mm]%
\phantom{x}\hspace{3mm}%
\textbf{\fontsize{10mm}{1em}\selectfont \hfill #1 \hfill} \\[-0.5mm]%
\rule{\linewidth}{0.5mm}%
}

% columns (default 3)
\newenvironment{COcolumn}[1][3]{\begin{multicols}{#1}}{\end{multicols}}

% Masthead definition LoA
\newcommand\COauthorCheck{first}
\newcommand{\COlistofauthors}{Tiráž}
\newlistof{COcategory}{loa}{\COlistofauthors}
\newlistentry{COauthor}{loa}{1}
\newcommand{\COLOAcategory}[1]{ \refstepcounter{COcategory} \addcontentsline{loa}{COcategory}{#1} }

\newcommand\COauthor[2]{%
\refstepcounter{COauthor}
\addcontentsline{loa}{COauthor}{#1 \hfill -#2-}
\ifthenelse{ \equal{\COauthorCheck}{first} }{%
  \vfill\hfill%
  \renewcommand\COauthorCheck{other}%
}{}%
-#2-%
}

\WithSuffix\newcommand\COauthor*[2]{
\ifthenelse{ \equal{\COauthorCheck}{first} }{%
  \vfill\hfill%
  \renewcommand\COauthorCheck{other}%
}{}%
-#2-%
}
\newcommand\COeditor[1]{ \refstepcounter{COauthor} \addcontentsline{loa}{COauthor}{#1} }

% Table of contents
\newcommand{\COtableofcontents}[2]{%
	\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
	\COarticle*{Obsah}{10}%
\begin{center}%
\begin{minipage}[c]{#2\linewidth}%
%
\ifthenelse{ \equal{#1}{1} }{%
	\@starttoc{toc}%
}{%
\begin{COcolumn}[#1]%
	\@starttoc{toc}%
\end{COcolumn}%
}%
%
\end{minipage}
\end{center}
\thispagestyle{fancy}%
\vfill%
}

% Masthead
\newcommand{\COmasthead}{%
\cftpagenumbersoff{COauthor}%
\cftpagenumbersoff{COcategory}%
\setcounter{loadepth}{2}
	\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
	\@starttoc{loa}%
\thispagestyle{fancy}%
\vspace{5mm}%
}

% Title page definition
\newenvironment{COtitlepage}[2][0]{%
\newgeometry{top=10mm,bottom=10mm,right=15mm,left=15mm}%
\begin{titlepage}%
\begin{center}%
%
\AddToShipoutPicture*{%
\put(0,#1){%
\parbox[b][\paperheight]{\paperwidth}{%
\vfill%
\centering%
\includegraphics[width=0.95\paperwidth,keepaspectratio]{#2}%
\vfill%
}}}%
%
}{%
%
\end{center}%
\end{titlepage}%
\newgeometry{top=15mm, bottom=25mm, left=15mm, right=15mm}%
}

\newcommand{\COtitle}[1]{%
\noindent\rule{\linewidth}{1mm}\\[4mm]%
%\textbf{\fontsize{26mm}{1em}\selectfont Corpus Omne}\\[2mm]%
\includegraphics[width=0.95\linewidth,keepaspectratio]{icon/head}\\[2mm]%
\textbf{\fontsize{5mm}{1em}\selectfont \textit{Vítěz ankety nejoblíbenější jaderňácký časopis již od roku 2007} }\\[0mm]%
\noindent\rule{\linewidth}{1mm}\\[2mm]%
\textbf{\fontsize{4mm}{1em}\selectfont #1}\\%
}

\newcommand{\COtitleBottom}[2]{%
\noindent\rule{\linewidth}{1mm}\\[2mm]%
\end{center}%
\textbf{\textit{\fontsize{5mm}{1em}\selectfont"#1"}}%
\begin{center}%
\hfill \textbf{\fontsize{5mm}{1em}\selectfont #2}\\%
}

% quote
\newcommand{\COquote}[1]{%
\par\medskip\noindent\minipage{\linewidth}%
\rule{\linewidth}{0.5mm}
	\centering\textbf{\textit{#1}}\par%
\rule{\linewidth}{0.5mm}
\endminipage\par\medskip%
}

% floating picture
\newcommand\COfloatPicture[5][EMPTY]{%
\begin{wrapfigure}[#5]{#3}{#4}%
	\centering%
		\includegraphics[width=#4]{#2}%\\[1mm]%
		%
		\ifthenelse{ \equal{#1}{EMPTY} }{}{
			\centering#1\\ \rule{\linewidth}{0.5mm}%
		}%
\end{wrapfigure}%
}

% picture in column
\newcommand\COpicture[2][EMPTY]{%
\par\medskip\noindent\minipage{\linewidth}%
	\includegraphics[width=\linewidth]{#2}\\[1mm]%
	\ifthenelse{ \equal{#1}{EMPTY} }{}{
		\centering#1\\ \rule{\linewidth}{0.5mm}%
	}%
\endminipage\par\medskip%
}

% whole page picture
\newcommand{\COpagePicture}[1]{%
\newgeometry{top=0mm,bottom=0mm,right=0mm,left=0mm}%
\phantom{x}
\vfill%
\AddToShipoutPicture*{%
\put(0,0){%
\parbox[b][\paperheight]{\paperwidth}{%
\vfill%
\centering%
\includegraphics[width=0.95\paperwidth,keepaspectratio]{#1}%
\vfill%
}}}%
\vfill
\clearpage
\newgeometry{top=15mm, bottom=25mm, left=15mm, right=15mm}%
\pagebreak
}

% social networks
\newenvironment{COsocial}{%
\begin{tabular}{m{0.05\textwidth}m{0.95\textwidth}}%
}{%
\end{tabular}%
}

\newcommand{\COsocialFacebook}[1]{\includegraphics{icon/facebook}	& \Large\texttt{facebook.com/#1}\\}
\newcommand{\COsocialMail}[1]{\includegraphics{icon/mail}	& \Large\texttt{#1}\\}
\newcommand{\COsocialYoutube}[1]{\includegraphics{icon/youtube}	& \Large\texttt{youtube.com/#1}\\}
\newcommand{\COsocialTwitter}[1]{\includegraphics{icon/twitter}	& \Large\texttt{twitter.com/#1}\\}
\newcommand{\COsocialWeb}[1]{\includegraphics{icon/web}	& \Large\texttt{#1}\\}

% zodiac
\newcommand{\COzodiac}{%
\needspace{100mm}%
\COarticle{HOROSKOP}{10}%
\COpicture{icon/horoskop}%
}

% cover
\newcommand{\COcover}[1][Pro chvíle oddechu a nudy]{%
\pagebreak%
\COarticle*{#1}{10}%
\renewcommand{\COsectionHeadSTR}{}%
\pagestyle{plain}
}

\endinput
