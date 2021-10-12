{smcl}
{* 2021年10月10日}
{hline}
{cmd:help muse}{right: }
{hline}

{title:标题(Title)}

{phang}
{bf:muse} {hline 2} 人大农发马门的stata数据仓库调用命令：缪斯。{p_end}

{title:语法(Syntax)}

{p 8 18 2}
{cmdab:muse} {cmd: filename} {cmd:,} [{cmd:{opt c:lear}} {cmd:{opt w:eb}} {cmd:{opt s:avetosystem}}]


{title:描述(Description)}
{pstd}{space 3}{cmd: filename}: 数据集名称。{p_end}

{marker options}{...}
{title:选项(Options)}

{phang}
{cmd:{opt c:lear}}: 是否清空当前数据。{p_end}

{phang}
{cmd:{opt w:eb}}: 是否从远端仓库调用数据集，默认调用本地数据。{p_end}

{phang}
{cmd:{opt s:avetosystem}}: 指定是否需要将该数据集存入系统文件夹中，以方便下次直接调用。{p_end}

{title:示例(Examples)}

{phang}
{stata `"muse nunn_qian_2014, c"'}
{p_end}
{phang}
{stata `"muse nunn_qian_2014, c w"'}
{p_end}
{phang}
{stata `"muse nunn_qian_2014, c w s"'}
{p_end}

{title:作者(Author)}

{pstd}秦国庆{p_end}
{pstd}人大农发·西农经管{p_end}
{pstd}{browse "https://qgq931001.github.io/":个人博客}{p_end}
{pstd}Email {browse "mailto:zhupaiqgq@nwafu.edu.cn":zhupaiqgq@nwafu.edu.cn}{p_end}

{title:Also see}
{phang}
{stata `"help muselist"'}
{p_end}
