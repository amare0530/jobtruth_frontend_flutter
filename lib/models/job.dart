class Job {
  final String id;
  final String title;
  final String company;
  final String description;
  final String location;
  final bool liked;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    this.location = "台灣",
    this.liked = false,
  });

  factory Job.fromJson(Map<String, dynamic> j) {
    return Job(
      id: (j['id'] ?? j['ID'] ?? '0').toString(),
      title: j['title'] ?? j['OCCU_DESC'] ?? '未知職缺',
      company: j['company'] ?? j['COMPNAME'] ?? '未知企業',
      description: j['description'] ?? j['JOB_DETAIL'] ?? '暫無詳細說明',
      location: j['location'] ?? j['CITYNAME'] ?? '台灣',
      liked: j['liked'] ?? false,
    );
  }
}

// 🔹 擴充至 50 筆真實感職缺
final List<Job> allJobs = [
  // 科技/軟體業
  Job(id: "1", title: "AI 模型訓練實習生", company: "Google Taiwan", location: "台北市", description: "協助 LLM 繁體中文語料清洗與模型評估。"),
  Job(id: "2", title: "Frontend Engineering Intern", company: "Meta Taiwan", location: "遠端", description: "使用 React/Next.js 開發內部協作工具。"),
  Job(id: "3", title: "Flutter 行動開發實習生", company: "街口支付", location: "台北市", description: "參與支付模組與金融元件開發維護。"),
  Job(id: "4", title: "網路安全測試助理", company: "趨勢科技", location: "台北市", description: "協助自動化弱點掃描腳本編寫與系統監控。"),
  Job(id: "5", title: "Backend Developer Intern", company: "Line Taiwan", location: "台北市", description: "使用 Go/Java 進行高併發訊息處理優化。"),
  Job(id: "6", title: "雲端架構實習生", company: "Amazon AWS", location: "台北市", description: "協助客戶進行 AWS 雲端遷移與架構優化建議。"),
  Job(id: "7", title: "軟體測試實習生 (QA)", company: "Garena", location: "台北市", description: "負責遊戲平台功能測試與壓力測試腳本編寫。"),
  Job(id: "8", title: "數據平台實習生", company: "Snowflake", location: "台北市", description: "利用 SQL 進行大規模數據清洗與 ETL 流程優化。"),
  Job(id: "9", title: "UI/UX 設計實習生", company: "Pinkoi", location: "台北市", description: "參與電商網站改版設計與使用者行為訪談分析。"),
  Job(id: "10", title: "DevOps 實習工程師", company: "KKBOX", location: "台北市", description: "維護 CI/CD 流程與 Kubernetes 容器化部署環境。"),

  // 金融業
  Job(id: "11", title: "金融科技專案實習生", company: "國泰金控", location: "台北市", description: "參與數位銀行新功能定義與市場競品分析。"),
  Job(id: "12", title: "量化交易分析實習生", company: "元大證券", location: "台北市", description: "利用 Python 進行股市歷史數據分析與策略回測。"),
  Job(id: "13", title: "區塊鏈開發實習生", company: "MaiCoin", location: "台北市", description: "協助智能合約審核與去中心化錢包 API 介接。"),
  Job(id: "14", title: "保險科技(InsureTech)助理", company: "富邦人壽", location: "台北市", description: "協助推動數位投保流程優化與 UI 改進方案。"),
  Job(id: "15", title: "反洗錢(AML)數據助理", company: "玉山銀行", location: "新北", description: "利用資料探勘技術協助識別異常交易模式。"),

  // 硬體/半導體
  Job(id: "16", title: "韌體測試實習生", company: "台積電 (TSMC)", location: "新竹市", description: "協助晶圓生產監控系統的韌體自動化測試。"),
  Job(id: "17", title: "硬體研發助理", company: "聯發科技 (MediaTek)", location: "新竹市", description: "參與手機晶片訊號模擬與電路板佈局協助。"),
  Job(id: "18", title: "韌體開發實習生", company: "鴻海精密 (Foxconn)", location: "新北市", description: "參與電動車充電樁通訊協議開發與測試。"),
  Job(id: "19", title: "系統整合實習生", company: "華碩 (ASUS)", location: "台北市", description: "負責筆電系統 BIOS 更新測試與效能調優。"),
  Job(id: "20", title: "IC 設計輔助助理", company: "瑞昱半導體 (Realtek)", location: "新竹市", description: "協助網路晶片設計與相關驗證工作。"),

  // 電商/行銷/媒體
  Job(id: "21", title: "電商平台營運實習生", company: "蝦皮購物", location: "台北市", description: "參與雙 11 活動檔期規劃與後端訂單數據分析。"),
  Job(id: "22", title: "社群媒體企劃實習生", company: "Dcard", location: "台北市", description: "負責官方帳號內容創作、粉絲互動與熱度分析。"),
  Job(id: "23", title: "數位行銷分析助理", company: "Momo 購物網", location: "台北市", description: "協助管理 Google Ads 廣告帳戶與投放轉換率追蹤。"),
  Job(id: "24", title: "影音剪輯實習生", company: "Vogue Taiwan", location: "台北市", description: "負責時尚活動短片剪輯與社群限時動態設計。"),
  Job(id: "25", title: "產品管理(PM)助理", company: "PChome", location: "台北市", description: "撰寫產品功能需求規格書 (PRD) 與跨部門溝通。"),

  // 更多新創與其他
  Job(id: "26", title: "Python 爬蟲實習生", company: "關鍵評論網", location: "台北市", description: "自動化抓取各類媒體新聞並進行關鍵字輿情分析。"),
  Job(id: "27", title: "產品設計助理", company: "Gogoro", location: "桃園市", description: "參與智慧電池交換站操作介面優化設計。"),
  Job(id: "28", title: "iOS 開發實習生", company: "17Live", location: "台北市", description: "協助直播軟體新功能開發與 Bug 修補。"),
  Job(id: "29", title: "大數據分析實習生", company: "Vpon 威朋", location: "台北市", description: "處理跨國行動數據並產出視覺化商業洞察報告。"),
  Job(id: "30", title: "App 安全測試助理", company: "奧義智慧", location: "台北市", description: "針對移動裝置進行滲透測試與安全漏洞回報。"),
  
  // 繼續填充至 50 筆
  Job(id: "31", title: "HR 招募實習生", company: "LinkedIn Taiwan", location: "台北市", description: "協助篩選履歷與安排面試流程，優化求職者體驗。"),
  Job(id: "32", title: "自動化腳本開發", company: "研華科技", location: "台北市", description: "為工業電腦產線設計自動化測試腳本。"),
  Job(id: "33", title: "行銷數據工程師助理", company: "Appier", location: "台北市", description: "利用 AI 技術協助企業進行精準行銷數據處理。"),
  Job(id: "34", title: "客戶成功(CS)實習生", company: "SurveyCake", location: "台北市", description: "協助企業用戶解決問卷系統操作問題與產品回饋。"),
  Job(id: "35", title: "智慧醫療開發助理", company: "廣達電腦", location: "桃園市", description: "參與 AI 醫療影像辨識系統的數據標記與開發。"),
  Job(id: "36", title: "前端互動實習生", company: "Hahow 好學校", location: "遠端", description: "開發線上課程平台互動組件，提升學習體驗。"),
  Job(id: "37", title: "內容編輯實習生", company: "天下雜誌", location: "台北市", description: "負責專題報導資料蒐集、排版與初稿校對。"),
  Job(id: "38", title: "運籌管理實習生", company: "Lalamove", location: "台北市", description: "分析物流配送效率並提出路徑優化建議方案。"),
  Job(id: "39", title: "AR/VR 內容開發助理", company: "HTC Vive", location: "新北市", description: "協助開發元宇宙教育場景與 3D 模型介接。"),
  Job(id: "40", title: "永續發展(ESG)助理", company: "台泥", location: "台北市", description: "協助產出年度永續報告書與環境影響評估數據。"),
  Job(id: "41", title: "嵌入式系統實習生", company: "Garmin", location: "新北市", description: "參與運動手錶感測器驅動開發與電力管理測試。"),
  Job(id: "42", title: "財務分析實習生", company: "J.P. Morgan", location: "台北市", description: "協助產業研究分析與財務模型基礎建置。"),
  Job(id: "43", title: "法律科技助理", company: "Lawsnote", location: "台北市", description: "協助法律搜尋引擎的數據結構化與相關性優化。"),
  Job(id: "44", title: "旅遊產品開發助理", company: "KKday", location: "台北市", description: "參與跨國行程開發、定價策略與供應商管理。"),
  Job(id: "45", title: "分散式系統助理", company: "AWS Taiwan", location: "台北市", description: "研究雲端微服務架構並協助解決技術問題。"),
  Job(id: "46", title: "區塊鏈研究實習生", company: "幣安 (Binance)", location: "遠端", description: "研究 Web3 生態發展趨勢並撰寫研究報告。"),
  Job(id: "47", title: "人力資源數據助理", company: "104 人力銀行", location: "新北市", description: "分析就業市場趨勢並產出薪資報告統計。"),
  Job(id: "48", title: "智慧城市專案助理", company: "遠傳電信", location: "台北市", description: "參與 5G 智慧路燈與車聯網應用場景規劃。"),
  Job(id: "49", title: "機器學習實習生", company: "聯發科 AI 室", location: "新竹市", description: "負責邊緣運算晶片的語音辨識模型量化優化。"),
  Job(id: "50", title: "遊戲數值設計助理", company: "雷亞遊戲", location: "台北市", description: "協助調整遊戲關卡難度與數值平衡測試。"),

    Job(id: "60", title: "系統工程實習生", company: "Google Taiwan", location: "台北市", description: "協助內部系統維運與效能監控。"),
  Job(id: "61", title: "前端工程助理", company: "Meta Taiwan", location: "台北市", description: "協助前端介面開發與元件維護。"),
  Job(id: "62", title: "後端系統實習生", company: "Line Taiwan", location: "台北市", description: "參與後端服務開發與 API 測試。"),
  Job(id: "63", title: "雲端系統助理", company: "Amazon AWS", location: "台北市", description: "協助雲端服務架構測試與文件整理。"),
  Job(id: "64", title: "平台工程實習生", company: "Microsoft Taiwan", location: "台北市", description: "協助平台系統功能測試與改善。"),

  Job(id: "65", title: "資料分析實習生", company: "Appier", location: "台北市", description: "協助資料分析與模型效能追蹤。"),
  Job(id: "66", title: "資安研究助理", company: "趨勢科技", location: "台北市", description: "分析資安事件並整理研究資料。"),
  Job(id: "67", title: "滲透測試助理", company: "奧義智慧", location: "台北市", description: "協助系統滲透測試與漏洞回報。"),
  Job(id: "68", title: "產品平台實習生", company: "91APP", location: "台北市", description: "協助電商平台功能測試與優化。"),
  Job(id: "69", title: "互動前端實習生", company: "Hahow 好學校", location: "遠端", description: "開發課程平台互動功能。"),

  Job(id: "70", title: "製程資料實習生", company: "台積電", location: "新竹市", description: "協助製程資料分析與流程改善。"),
  Job(id: "71", title: "晶片驗證助理", company: "聯發科技", location: "新竹市", description: "協助晶片功能驗證與測試。"),
  Job(id: "72", title: "韌體測試實習生", company: "華碩", location: "台北市", description: "執行韌體功能測試與問題回報。"),
  Job(id: "73", title: "硬體驗證助理", company: "宏碁", location: "新北市", description: "協助硬體產品驗證與文件整理。"),
  Job(id: "74", title: "穿戴裝置實習生", company: "Garmin", location: "新北市", description: "參與穿戴裝置系統測試與資料分析。"),

  Job(id: "75", title: "平台營運實習生", company: "Shopee 蝦皮", location: "台北市", description: "協助平台營運數據分析。"),
  Job(id: "76", title: "產品管理助理", company: "PChome", location: "台北市", description: "協助產品需求整理與測試。"),
  Job(id: "77", title: "行銷分析實習生", company: "momo 購物網", location: "台北市", description: "分析行銷活動成效。"),
  Job(id: "78", title: "社群數據實習生", company: "Dcard", location: "台北市", description: "分析社群互動數據。"),
  Job(id: "79", title: "視覺設計助理", company: "Pinkoi", location: "台北市", description: "協助設計素材與版型整理。"),

  Job(id: "80", title: "金融系統實習生", company: "國泰金控", location: "台北市", description: "協助金融系統測試與資料分析。"),
  Job(id: "81", title: "數位銀行助理", company: "玉山銀行", location: "台北市", description: "支援數位金融服務測試。"),
  Job(id: "82", title: "市場資料實習生", company: "元大證券", location: "台北市", description: "整理市場交易資料。"),
  Job(id: "83", title: "保險系統助理", company: "富邦金控", location: "台北市", description: "協助保險系統流程測試。"),

  Job(id: "84", title: "通訊系統實習生", company: "中華電信", location: "台北市", description: "協助通訊系統測試與分析。"),
  Job(id: "85", title: "智慧應用助理", company: "遠傳電信", location: "台北市", description: "參與智慧應用專案測試。"),
  Job(id: "86", title: "能源管理實習生", company: "台達電", location: "桃園市", description: "協助能源管理系統測試。"),
  Job(id: "87", title: "工業系統助理", company: "研華科技", location: "新北市", description: "協助工業系統功能測試。"),

  Job(id: "88", title: "區塊鏈研究助理", company: "MaiCoin", location: "台北市", description: "協助區塊鏈應用研究。"),
  Job(id: "89", title: "旅遊系統實習生", company: "KKday", location: "台北市", description: "協助旅遊平台系統測試。"),
  Job(id: "90", title: "直播平台助理", company: "17LIVE", location: "台北市", description: "協助直播功能測試。"),
  Job(id: "91", title: "永續資料實習生", company: "台泥", location: "台北市", description: "協助 ESG 資料整理。"),

  Job(id: "92", title: "軟體測試實習生", company: "Google Taiwan", location: "台北市", description: "執行軟體功能測試與問題回報。"),
  Job(id: "93", title: "資料平台助理", company: "Meta Taiwan", location: "台北市", description: "協助資料平台維運。"),
  Job(id: "94", title: "後端服務實習生", company: "Line Taiwan", location: "台北市", description: "協助後端服務穩定性測試。"),
  Job(id: "95", title: "雲端架構助理", company: "Amazon AWS", location: "台北市", description: "支援雲端架構測試。"),

  Job(id: "96", title: "AI 應用實習生", company: "Microsoft Taiwan", location: "台北市", description: "協助 AI 應用測試與資料整理。"),
  Job(id: "97", title: "數據科學實習生", company: "Appier", location: "台北市", description: "分析模型資料並產出報告。"),
  Job(id: "98", title: "資安系統助理", company: "趨勢科技", location: "台北市", description: "協助資安系統測試。"),
  Job(id: "99", title: "資安工程實習生", company: "奧義智慧", location: "台北市", description: "參與資安專案測試。"),
    Job(id: "100", title: "系統測試實習生", company: "Garena", location: "台北市", description: "協助平台系統測試與問題回報。"),
  Job(id: "101", title: "資料工程助理", company: "Google Taiwan", location: "台北市", description: "協助資料處理流程與品質檢查。"),
  Job(id: "102", title: "前端工程實習生", company: "Meta Taiwan", location: "台北市", description: "協助前端功能模組開發。"),
  Job(id: "103", title: "後端工程助理", company: "Line Taiwan", location: "台北市", description: "支援後端系統維護與測試。"),
  Job(id: "104", title: "雲端系統實習生", company: "Amazon AWS", location: "台北市", description: "協助雲端服務測試與文件整理。"),

  Job(id: "105", title: "AI 研發助理", company: "Microsoft Taiwan", location: "台北市", description: "協助 AI 專案資料整理與測試。"),
  Job(id: "106", title: "資料分析實習生", company: "Appier", location: "台北市", description: "分析數據並產出視覺化報告。"),
  Job(id: "107", title: "資安測試實習生", company: "趨勢科技", location: "台北市", description: "執行資安測試與風險評估。"),
  Job(id: "108", title: "滲透測試助理", company: "奧義智慧", location: "台北市", description: "協助系統滲透測試作業。"),
  Job(id: "109", title: "產品工程實習生", company: "91APP", location: "台北市", description: "協助電商產品測試與優化。"),

  Job(id: "110", title: "互動介面實習生", company: "Hahow 好學校", location: "遠端", description: "開發線上學習互動介面。"),
  Job(id: "111", title: "製程資料助理", company: "台積電", location: "新竹市", description: "協助製程數據整理與分析。"),
  Job(id: "112", title: "晶片驗證實習生", company: "聯發科技", location: "新竹市", description: "協助晶片功能驗證流程。"),
  Job(id: "113", title: "韌體工程助理", company: "華碩", location: "台北市", description: "協助韌體系統測試。"),
  Job(id: "114", title: "硬體測試實習生", company: "宏碁", location: "新北市", description: "協助硬體功能測試。"),

  Job(id: "115", title: "嵌入式系統助理", company: "Garmin", location: "新北市", description: "協助嵌入式系統驗證。"),
  Job(id: "116", title: "營運資料實習生", company: "Shopee 蝦皮", location: "台北市", description: "分析平台營運數據。"),
  Job(id: "117", title: "產品助理(PM)", company: "PChome", location: "台北市", description: "協助產品需求整理。"),
  Job(id: "118", title: "行銷分析助理", company: "momo 購物網", location: "台北市", description: "協助行銷活動成效分析。"),
  Job(id: "119", title: "社群企劃實習生", company: "Dcard", location: "台北市", description: "協助社群內容規劃。"),

  Job(id: "120", title: "視覺設計實習生", company: "Pinkoi", location: "台北市", description: "支援平台視覺設計。"),
  Job(id: "121", title: "金融科技實習生", company: "國泰金控", location: "台北市", description: "協助金融科技專案測試。"),
  Job(id: "122", title: "數位銀行實習生", company: "玉山銀行", location: "台北市", description: "協助數位銀行服務驗證。"),
  Job(id: "123", title: "證券資訊助理", company: "元大證券", location: "台北市", description: "整理市場資訊數據。"),
  Job(id: "124", title: "保險系統實習生", company: "富邦金控", location: "台北市", description: "協助保險系統測試。"),

  Job(id: "125", title: "通訊工程實習生", company: "中華電信", location: "台北市", description: "協助通訊系統測試。"),
  Job(id: "126", title: "智慧應用實習生", company: "遠傳電信", location: "台北市", description: "參與智慧應用專案。"),
  Job(id: "127", title: "能源管理助理", company: "台達電", location: "桃園市", description: "協助能源系統資料整理。"),
  Job(id: "128", title: "工業系統實習生", company: "研華科技", location: "新北市", description: "協助工業系統測試。"),

  Job(id: "129", title: "區塊鏈研究實習生", company: "MaiCoin", location: "台北市", description: "研究區塊鏈技術應用。"),
  Job(id: "130", title: "旅遊平台實習生", company: "KKday", location: "台北市", description: "協助旅遊平台功能測試。"),
  Job(id: "131", title: "直播系統助理", company: "17LIVE", location: "台北市", description: "協助直播系統測試。"),
  Job(id: "132", title: "永續資料助理", company: "台泥", location: "台北市", description: "整理 ESG 相關資料。"),

  Job(id: "133", title: "軟體維運實習生", company: "Google Taiwan", location: "台北市", description: "協助系統維運與監控。"),
  Job(id: "134", title: "資料平台實習生", company: "Meta Taiwan", location: "台北市", description: "支援資料平台功能測試。"),
  Job(id: "135", title: "後端服務助理", company: "Line Taiwan", location: "台北市", description: "協助後端服務測試。"),
  Job(id: "136", title: "雲端技術助理", company: "Amazon AWS", location: "台北市", description: "支援雲端技術測試。"),

  Job(id: "137", title: "AI 系統實習生", company: "Microsoft Taiwan", location: "台北市", description: "協助 AI 系統測試。"),
  Job(id: "138", title: "資料科學助理", company: "Appier", location: "台北市", description: "支援資料分析專案。"),
  Job(id: "139", title: "資安分析實習生", company: "趨勢科技", location: "台北市", description: "分析資安事件資料。"),
  Job(id: "140", title: "資安工程助理", company: "奧義智慧", location: "台北市", description: "協助資安系統驗證。"),

  Job(id: "141", title: "產品測試實習生", company: "91APP", location: "台北市", description: "執行產品功能測試。"),
  Job(id: "142", title: "前端互動助理", company: "Hahow 好學校", location: "遠端", description: "支援互動功能開發。"),

  Job(id: "143", title: "製程工程實習生", company: "台積電", location: "新竹市", description: "協助製程工程資料整理。"),
  Job(id: "144", title: "IC 驗證助理", company: "聯發科技", location: "新竹市", description: "支援 IC 驗證測試。"),
  Job(id: "145", title: "韌體系統實習生", company: "華碩", location: "台北市", description: "協助韌體系統測試。"),
  Job(id: "146", title: "硬體工程助理", company: "宏碁", location: "新北市", description: "支援硬體工程測試。"),
  Job(id: "147", title: "穿戴裝置實習生", company: "Garmin", location: "新北市", description: "協助穿戴裝置系統測試。"),

  Job(id: "148", title: "平台營運助理", company: "Shopee 蝦皮", location: "台北市", description: "支援平台營運分析。"),
  Job(id: "149", title: "產品測試助理", company: "PChome", location: "台北市", description: "協助產品測試流程。"),
  Job(id: "150", title: "行銷系統實習生", company: "momo 購物網", location: "台北市", description: "協助行銷系統測試。"),
  Job(id: "151", title: "社群數據助理", company: "Dcard", location: "台北市", description: "分析社群數據。"),
  Job(id: "152", title: "視覺設計助理", company: "Pinkoi", location: "台北市", description: "支援視覺素材製作。"),

  Job(id: "153", title: "金融資料實習生", company: "國泰金控", location: "台北市", description: "整理金融資料。"),
  Job(id: "154", title: "銀行系統助理", company: "玉山銀行", location: "台北市", description: "支援銀行系統測試。"),
  Job(id: "155", title: "市場分析實習生", company: "元大證券", location: "台北市", description: "協助市場資料分析。"),
  Job(id: "156", title: "保險資訊助理", company: "富邦金控", location: "台北市", description: "整理保險系統資料。"),

  Job(id: "157", title: "通訊測試實習生", company: "中華電信", location: "台北市", description: "協助通訊測試作業。"),
  Job(id: "158", title: "智慧系統助理", company: "遠傳電信", location: "台北市", description: "支援智慧系統專案。"),
  Job(id: "159", title: "能源系統實習生", company: "台達電", location: "桃園市", description: "協助能源系統測試。"),
  Job(id: "160", title: "工業資料助理", company: "研華科技", location: "新北市", description: "整理工業系統資料。"),

  Job(id: "161", title: "區塊鏈工程實習生", company: "MaiCoin", location: "台北市", description: "協助區塊鏈系統測試。"),
  Job(id: "162", title: "旅遊系統助理", company: "KKday", location: "台北市", description: "支援旅遊平台系統。"),
  Job(id: "163", title: "直播功能實習生", company: "17LIVE", location: "台北市", description: "協助直播功能測試。"),
  Job(id: "164", title: "ESG 分析實習生", company: "台泥", location: "台北市", description: "協助 ESG 分析。"),

  Job(id: "165", title: "系統平台實習生", company: "Google Taiwan", location: "台北市", description: "協助平台系統測試。"),
  Job(id: "166", title: "資料整合助理", company: "Meta Taiwan", location: "台北市", description: "支援資料整合作業。"),
  Job(id: "167", title: "後端整合實習生", company: "Line Taiwan", location: "台北市", description: "協助後端系統整合。"),
  Job(id: "168", title: "雲端維運助理", company: "Amazon AWS", location: "台北市", description: "支援雲端維運。"),

  Job(id: "169", title: "AI 平台實習生", company: "Microsoft Taiwan", location: "台北市", description: "協助 AI 平台測試。"),
  Job(id: "170", title: "資料分析助理", company: "Appier", location: "台北市", description: "協助資料分析任務。"),
  Job(id: "171", title: "資安監控實習生", company: "趨勢科技", location: "台北市", description: "協助資安監控作業。"),
  Job(id: "172", title: "資安專案助理", company: "奧義智慧", location: "台北市", description: "支援資安專案。"),

  Job(id: "173", title: "產品系統實習生", company: "91APP", location: "台北市", description: "協助產品系統測試。"),
  Job(id: "174", title: "互動系統助理", company: "Hahow 好學校", location: "遠端", description: "支援互動系統開發。"),

  Job(id: "175", title: "製程測試實習生", company: "台積電", location: "新竹市", description: "協助製程測試。"),
  Job(id: "176", title: "IC 工程助理", company: "聯發科技", location: "新竹市", description: "支援 IC 工程作業。"),
  Job(id: "177", title: "韌體測試助理", company: "華碩", location: "台北市", description: "協助韌體測試。"),
  Job(id: "178", title: "硬體系統實習生", company: "宏碁", location: "新北市", description: "協助硬體系統驗證。"),
  Job(id: "179", title: "裝置測試助理", company: "Garmin", location: "新北市", description: "支援裝置測試。"),

  Job(id: "180", title: "平台分析實習生", company: "Shopee 蝦皮", location: "台北市", description: "分析平台使用數據。"),
  Job(id: "181", title: "產品資料助理", company: "PChome", location: "台北市", description: "整理產品資料。"),
  Job(id: "182", title: "行銷資料實習生", company: "momo 購物網", location: "台北市", description: "協助行銷資料分析。"),
  Job(id: "183", title: "社群系統助理", company: "Dcard", location: "台北市", description: "支援社群系統。"),
  Job(id: "184", title: "設計系統實習生", company: "Pinkoi", location: "台北市", description: "協助設計系統整理。"),

  Job(id: "185", title: "金融系統助理", company: "國泰金控", location: "台北市", description: "支援金融系統作業。"),
  Job(id: "186", title: "銀行資料實習生", company: "玉山銀行", location: "台北市", description: "整理銀行資料。"),
  Job(id: "187", title: "證券分析助理", company: "元大證券", location: "台北市", description: "協助證券分析。"),
  Job(id: "188", title: "保險資料助理", company: "富邦金控", location: "台北市", description: "整理保險資料。"),

  Job(id: "189", title: "通訊資料實習生", company: "中華電信", location: "台北市", description: "協助通訊資料整理。"),
  Job(id: "190", title: "智慧應用實習生", company: "遠傳電信", location: "台北市", description: "支援智慧應用測試。"),
  Job(id: "191", title: "能源資料助理", company: "台達電", location: "桃園市", description: "整理能源系統資料。"),
  Job(id: "192", title: "工業測試實習生", company: "研華科技", location: "新北市", description: "協助工業測試。"),

  Job(id: "193", title: "區塊鏈平台實習生", company: "MaiCoin", location: "台北市", description: "協助區塊鏈平台測試。"),
  Job(id: "194", title: "旅遊資料助理", company: "KKday", location: "台北市", description: "整理旅遊平台資料。"),
  Job(id: "195", title: "直播平台實習生", company: "17LIVE", location: "台北市", description: "協助直播平台測試。"),
   Job(id: "196", title: "平台系統實習生", company: "Google Taiwan", location: "台北市", description: "協助平台系統測試與文件整理。"),
  Job(id: "197", title: "資料分析助理", company: "Appier", location: "台北市", description: "協助資料分析與成效追蹤。"),
  Job(id: "198", title: "後端系統助理", company: "Line Taiwan", location: "台北市", description: "支援後端系統測試。"),
  Job(id: "199", title: "雲端技術實習生", company: "Amazon AWS", location: "台北市", description: "協助雲端技術驗證。"),
  Job(id: "200", title: "軟體工程助理", company: "Microsoft Taiwan", location: "台北市", description: "協助軟體功能測試與維護。"),
];