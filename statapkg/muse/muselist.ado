*! 显示数据库中的所有数据集
cap prog drop muselist
prog define muselist
	di "Data index: Nunn and Qian(2014)"
	di in yellow "---------------------" in g "Data" in yellow "-----------------------------" 
	di in green "1. {stata muse nunn_qian_2014.dta, c w s: 点击加载数据集1}:" in green "nunn_qian_2014.dta "
	di "2. {stata muse nunn_qian_2014_2.dta, c w s: 点击加载数据集2}:" in green "nunn_qian_2014_2.dta"
	di in yellow "--------------------" in g "Dofile" in yellow "----------------------------" 
	di in green`"1. {view "https://qgq931001.github.io/muse/n/nunn_qian_2014.do": 点击预览do文档}："' in green "nunn_qian_2014.do"
	di `"2. {stata "copy https://qgq931001.github.io/muse/n/nunn_qian_2014.do nunn_qian_2014.do,replace" : 点击下载do文档}："' in green "nunn_qian_2014.do"
	di "3. {stata doedit nunn_qian_2014.do: 请下载后再点击打开do文档}：" in green "nunn_qian_2014.do"
	di in yellow "------------------------------------------------------"
end
