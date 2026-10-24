unit untMovMeTypes;

interface

type
  TArrScheduleIds = array of string;

type
  TrecCli = record
    strCodCli: String;
    strNomFan: String;
    strRazSoc: String;
    strNomEst: String;
    strNomCid: String;
    strEndere: String;
    strBairro: String;
    strComple: String;
    strE_mail: String;
    strCpfCnp: String;
    strC_e_p_: String;
    strFone01: String;
    strCelula: String;
  End;

type
  TrecSchedule = record
    blnActive :Boolean;
    strActivitiesOrigin,
    strAgent,
    strServiceLocal,
    strAlternativeIdentifier,
    strDate,
    strHour,
    strNF,
    strPlaVei :String;
  End;

type
  TrecScheduleItem = record
    strItemId : String;
    strScheduleAltId : String;
    strCustomQtdProd : String;
    strCustomNroNF : String;
  end;

type
  TrecScheduleRouting = record
    agentId : String;
    arrScheduleIds : TArrScheduleIds;
  end;

type
  TrecNF = record
    strNumDoc : String;
    strNumRom : String;
    strCodCli : String;
    strPaisNF : String;
    strEstado : String;
    strCidade : String;
    strBairNF : String;
    strTipEnd : String;
    strEndere : String;
    strNumEnd : String;
    strComple : String;
    strC_e_p_ : String;
    dtaDtEntr : TDateTime;
    dtaDtaEmi : TDateTime;
  end;

type
  TrecIte = record
    strCodIte : String;
    strDesIte : String;
    strCodEan : String;
    strUnidad : String;
    blnIteAti : Boolean;
    fltUnitar : Double;
    strLinGru : String;
  end;

type
  TrecIteNF = record
    strNumDoc : String;
    strNumRom : String;
    strCodIte : String;
    fltQtdIte : Double;
    strDescription : String;
  end;

type
  TrecLinGru = record
    strCodigo : String;
    strDescri : String;
  end;

type
  TrecRetornoTarefa = record
    strSituacao :String;
    strStatusTarefa :String;
    // Caso a entrega não tenha sido efetuada,
    // armazena o motivo
    strMotivoNaoEntrega :String;
    blnRealizada :Boolean;
    strGeoLoc :String;
    strImgFachada :String;
    strImgFotoCanhoto :String;
    strNomeRecebedor :String;
    strItensDevolvidos :Array of String;
    dtDataEntrega,
    dtHoraEntrega :TDateTime;
  end;

type
  TArrCli = Array Of TrecCli;

type
  TArrNF = Array Of TrecNF;

type
  TArrIteNF = Array of TrecIteNF;

type
  TArrIte = Array Of TrecIte;

type
  TArrLinGru = Array Of TrecLinGru;

type
  TArrSchedules = Array Of TrecSchedule;

type
  TArrScheduleItems = Array Of TrecScheduleItem;

type
  TArrScheduleRoutings = Array Of TrecScheduleRouting;

implementation

end.
