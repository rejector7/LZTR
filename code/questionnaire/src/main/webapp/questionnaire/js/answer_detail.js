
function AddText(str0,str1,str2,str3,str4)
{
	var asheet = document.getElementById("ASheet");
	var line = "<tr><td>"+str0+"</td><td>"+str1+"</td><td>"+str2+"</td><td>"+str3+"</td><td>"+str4+"</tr>";
	asheet.innerHTML += line;
};

function Size(json)
{
	var len = 0;
	for (var i in json){
		len += 1;
	}
	return len;
}

function Execute(arg1, arg2, arg3, arg4, quesid)
{
	var Tques = arg1;
	//只去除问题和回答的部分，然后加入到表格中。两者应该是相同长度的
	var quess = Tques.questions;
	var answs = arg2;
	$("#quesid").append(quesid);
	$("#quesname").append(arg3);
	$("#userid").append(arg4);
	$("#reply").attr("data-rid",arg4);
	//开始添加
	var len = Size(quess);
	for (var i = 0; i < len; ++i){
		
		var ques = quess[i];
		var answ = answs[i];
	
		//主观题
		if (ques.type == "Subjective"){
			if (ques.required == true){
				AddText(i+1,ques.stem,'填空题','必答',answ.words);
			}
			else{
				AddText(i+1,ques.stem,'填空题','非必答',answ.words);
			}
		}
		//单选题
		else if(ques.type == "Single"){
			if (ques.required == true){
				if (ques.options[answ.option].hasWords == false){
					AddText(i+1,ques.stem,'单选题','必答',ques.options[answ.option].option);
				}
				else{
					AddText(i+1,ques.stem,'单选题','必答',ques.options[answ.option].option + '  ' + answ.words);
				}
			}
			else{
				if (ques.options[answ.option].hasWords == false){
					AddText(i+1,ques.stem,'单选题','非必答',ques.options[answ.option].option);
				}
				else{
					AddText(i+1,ques.stem,'单选题','非必答',ques.options[answ.option].option + '  ' + answ.words);
				}
			}
		}
		//滑动条
		else if (ques.type == "Slider"){
			if (ques.required == true){
				AddText(i+1,ques.stem,'滑动条','必答',answ.number);
			}
			else{
				if(answ.number!=undefined)
				AddText(i+1,ques.stem,'滑动条','非必答',answ.number);
				else 
					AddText(i+1,ques.stem,'滑动条','非必答',"");
			}
		}
		//多选题
		else{
			if (ques.required == true){
				var set = answ.option.split(',');
				var answer = '';
				if (Size(set) == 0){
					AddText(i+1,ques.stem,'多选题','必答','');
				}
				else{
					var count = -1;
					for(var j = 0; j < Size(set); ++j){
						count += 1;
						if (set[j] != ''){
							if (ques.options[set[j]].hasWords == false){
								count -= 1;
								answer += ques.options[set[j]].option;
							}
							else{
								answer += ques.options[set[j]].option + ' ' + answ.words[count].word;
							}
							answer += ' ;';
						}
					}
					AddText(i+1,ques.stem,'多选题','必答',answer);
				}
			}
			else{
				var set = answ.option.split(',');
				var answer = '';
				if (Size(set) == 0){
					AddText(i+1,ques.stem,'多选题','非必答','');
				}
				else{
					var count = -1;
					for(var j = 0; j < Size(set); ++j){
						count += 1;
						if (set[j] != ''){
							if (ques.options[set[j]].hasWords == false){
								count -= 1;
								answer += ques.options[set[j]].option;
							}
							else{
								answer += ques.options[set[j]].option + ' ' + answ.words[count].word;
							}
							answer += ' ;';
						}
					}
					AddText(i+1,ques.stem,'多选题','非必答',answer);
				}
			}
		}	
	}
}

function downloadAnswerWord(){
	var content="";
	var headers = document.getElementsByTagName("p");
	content += "<p>"+headers[0].innerHTML+"</p>";
	content += "<p>"+headers[1].innerHTML+"</p>";
	content += "<p>"+headers[2].innerHTML+"</p>";
	var style = "table {border-collapse: collapse;}table, td, th {border: thin solid black;}";
	var table = $("div.dataTable_wrapper").html();
	content += table;
	var name = headers[1].getElementsByTagName("strong")[0].innerHTML.split("：")[1];
	exportDoc(content,style,name);
}

function getcontent(ansid, quesid){
	jQuery.ajax({
		url : 'getQuesAndAnsStatistic',  //get content
		processData : true,
		dataType : "json",
		data : {
			id : ansid,
			quesid : quesid
		},
		success : function(data) { //把title，id都放在里面
			Execute(data["Qques"],data["anst"],data["name"],data["userid"],quesid);
		}
	});
}