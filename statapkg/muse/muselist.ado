*! 显示数据库中的所有数据集
cap prog drop muselist
prog define muselist
	di "Data index: Nunn and Qian(2014) "
	di in yellow "---------------------" in g "Data" in yellow "-----------------------------" 
	di in green "1. {stata muse nunn_qian_2014.dta, c w s: 点击加载数据集1}:" in green "nunn_qian_2014.dta "
	di "2. {stata muse nunn_qian_2014_2.dta, c w s: 点击加载数据集2}:" in green "nunn_qian_2014_2.dta"
	di in yellow "--------------------" in g "Dofile" in yellow "----------------------------" 
	di in green`"1. {view "https://qgq931001.github.io/muse/n/nunn_qian_2014.do": 点击预览do文档}："' in green "nunn_qian_2014.do"
	di `"2. {stata "copy https://qgq931001.github.io/muse/n/nunn_qian_2014.do nunn_qian_2014.do,replace" : 点击下载do文档}："' in green "nunn_qian_2014.do"
	di "3. {stata doedit nunn_qian_2014.do: 请下载后再点击打开do文档}：" in green "nunn_qian_2014.do"
	di in yellow "------------------------------------------------------"

	di in white "Data index: Beck et al.(2010) "
	di in yellow "---------------------" in g "Data" in yellow "-----------------------------" 
	di in white "1.  在dofile中可直接调用"
	di in white "2.  作者提供数据不全"
	di in yellow "--------------------" in g "Dofile" in yellow "----------------------------" 
	di in green`"1. {view "https://qgq931001.github.io/muse/b/bbb_table.do": 点击预览do文档}："' in green "bbb_table.do"
	di `"2. {view "https://qgq931001.github.io/muse/b/bbb_figure.do": 点击预览do文档}："' in green "bbb_figure.do"
	di `"3. {view "https://qgq931001.github.io/muse/b/bbb_appendix.do": 点击预览do文档}："' in green "bbb_appendix.do"
	di `"4. {stata "copy https://qgq931001.github.io/muse/b/bbb_table.do bbb_table.do,replace" : 点击下载do文档}："' in green "bbb_table.do"
	di `"5. {stata "copy https://qgq931001.github.io/muse/b/bbb_figure.do bbb_figure.do,replace" : 点击下载do文档}："' in green "bbb_figure.do"
	di `"6. {stata "copy https://qgq931001.github.io/muse/b/bbb_appendix.do bbb_appendix.do,replace" : 点击下载do文档}："' in green "bbb_appendix.do"
	di "7. {stata doedit bbb_table.do: 请下载后再点击打开do文档}：" in green "bbb_table.do"
    di "8. {stata doedit bbb_figure.do: 请下载后再点击打开do文档}：" in green "bbb_figure.do"
	di "9. {stata doedit bbb_appendix.do: 请下载后再点击打开do文档}：" in green "bbb_appendix.do"
	di in yellow "------------------------------------------------------"
end
