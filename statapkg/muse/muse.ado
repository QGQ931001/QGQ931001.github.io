*! 调用与存储远端仓库数据集 
cap program drop muse
program define muse
	version 14.0
	if `"`0'"' == "" {
		error 198
	}
	local 0 `"using `0'"'
	syntax using/ [, Clear Web Savetosystem]
	local prefix = substr("`using'", 1, 1)
	local syspath "`c(sysdir_plus)'"
	if "`web'" != ""{
		local url "https://qgq931001.github.io/muse"
		use `"`url'/`prefix'/`using'"', `clear'
	}
	else{
	    disp as text "将从本地仓库调用数据......"
	    disp as text "若未存储数据至本地，需要首先添加" " {bf:Web} 、" " {bf:Savetosystem} 选项，" "并重新执行命令"  
        cap mkdir "`syspath'`prefix'"
		local url "`syspath'"
		use `"`url'/`prefix'/`using'"', `clear'
	}
	if "`savetosystem'" != ""{
		cap mkdir "`syspath'`prefix'"
		save "`syspath'`prefix'/`using'", replace
        disp as text "已将远端仓库数据存至本地，下次可直接调用......"
	}
end
