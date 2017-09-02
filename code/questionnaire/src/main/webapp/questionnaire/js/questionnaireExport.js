function exportXls(table,style,name,filename){
			var uri = 'data:application/vnd.ms-excel;base64,'
				  , template = '<head><!--[if gte mso 9]><?xml version="1.0" encoding="UTF-8" standalone="yes"?><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]-->'+
					  '<style>{style}</style></head>'+
				  '<body><table>{table}</table></body>'
				  , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))); }
				  , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }); };
			var ctx = { worksheet: name || 'Worksheet', table: table ,style : style};
		    download((uri + base64(format(template, ctx))), (filename+".xls"), "text/plain");
};
/*function exportDoc(content,filename){
	var uri = 'data:application/vnd.ms-word;base64,',
		
		 * template ='<html xmlns:v="urn:schemas-microsoft-com:vml"xmlns:o="urn:schemas-microsoft-com:office:office"xmlns:w="urn:schemas-microsoft-com:office:word"xmlns:m="http://schemas.microsoft.com/office/2004/12/omml"xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><w:WordDocument><w:View>Print</w:View><w:TrackMoves>false</w:TrackMoves><w:TrackFormatting/><w:ValidateAgainstSchemas/><w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid><w:IgnoreMixedContent>false</w:IgnoreMixedContent><w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText><w:DoNotPromoteQF/><w:LidThemeOther>EN-US</w:LidThemeOther><w:LidThemeAsian>ZH-CN</w:LidThemeAsian><w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript><w:Compatibility><w:BreakWrappedTables/><w:SnapToGridInCell/><w:WrapTextWithPunct/><w:UseAsianBreakRules/><w:DontGrowAutofit/><w:SplitPgBreakAndParaMark/><w:DontVertAlignCellWithSp/><w:DontBreakConstrainedForcedTables/><w:DontVertAlignInTxbx/><w:Word11KerningPairs/><w:CachedColBalance/><w:UseFELayout/></w:Compatibility><w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel><m:mathPr><m:mathFont m:val="Cambria Math"/><m:brkBin m:val="before"/><m:brkBinSub m:val="--"/><m:smallFrac m:val="off"/><m:dispDef/><m:lMargin m:val="0"/> <m:rMargin m:val="0"/><m:defJc m:val="centerGroup"/><m:wrapIndent m:val="1440"/><m:intLim m:val="subSup"/><m:naryLim m:val="undOvr"/></m:mathPr></w:WordDocument></xml><![endif]--></head>'+
		'<body><div>{content}</div></body></html>'
		 
		, base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))); }
		, format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }); };
	var ctx = { content:content };
	download((uri + base64(format(template, ctx))), (filename+".doc"),"text/plain");
};*/
function exportBackup(content,id){
	var d = new Date();
	if(id==0){
		id="all";
	}
	var name = d.toLocaleDateString()+d.toLocaleTimeString().split()[0]+"_"+"questionnaire:"+id+"_backup";
	download(content, (name+".txt"),"text/plain");
};