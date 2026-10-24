unit untCaixaLogCheckOut;

interface

uses
  Uni, System.SysUtils, Data.DB, UniClientDataSet;

function fGravaCheckout(AintChkOut : Integer;
                        strOpeRcx : String;
                        strCodCli : String;
                        strCodVen : String;
                        strCodBar : String;
                        strCodIte : String;
                        strDesIte : String;
                        strDesUni : String;
                        fltQtdIte: Double;
                        fltUniTar: Double;
                        fltTotIte : Double;
                        strNomMaq : String;
                        strNumIp : String;
                        strNomUsu : String;
                        strTpLanc : String;
                        blnConclusao : Boolean;
                        var AcdsChkOut, AcdsLogChk : TUniClientDataSet) : Integer;

procedure pGravaLogChkOut(AintChkOut : Integer;
                          strOpeRcx : String;
                          strCodCli : String;
                          strCodVen : String;
                          strCodBar : String;
                          strCodIte : String;
                          strDesIte : String;
                          strDesUni : String;
                          fltQtdIte: Double;
                          fltUniTar: Double;
                          fltTotIte : Double;
                          strNomMaq : String;
                          strNumIp : String;
                          strNomUsu : String;
                          strTpLanc : String;
                          blnConclusao : Boolean;
                          var AcdsChkOut, AcdsLogChk : TUniClientDataSet);

function fGravaChkOut(AintChkOut : Integer;
                      strOpeRcx : String;
                      strCodCli : String;
                      strCodVen : String;
                      strCodBar : String;
                      strCodIte : String;
                      strDesIte : String;
                      strDesUni : String;
                      fltQtdIte: Double;
                      fltUniTar: Double;
                      fltTotIte : Double;
                      strNomMaq : String;
                      strNumIp : String;
                      strNomUsu : String;
                      var AcdsChkOut : TUniClientDataSet) : Integer;

procedure pRemoveChkOut(const AintChkOut : Integer; var AcdsChkOut: TUniClientDataSet);

function fRetornaDescMovimento(strTpLanc : String) : String;

function fVerificaJaExisteAutoIncrem(strTabela, strAutoIncrem : String) : Boolean;

function fCriaCdsChkOut(): TUniClientDataSet ;
function fCriaCdsLogChk(): TUniClientDataSet ;
procedure pGravaArquivoCdsChkOut(const Acds: TUniClientDataSet; const AstrTabela: String) ;
procedure pPersisteChkOut(const Acds: TUniClientDataSet; const AstrTabela: String; const AblnExcluir: Boolean = True) ;
procedure pCarregaXMLChkOut(const AstrArquivo: String) ;
procedure pDesligamentoInesperadoChkOut ;

implementation

uses
  untFuncoesSimples, Vcl.Forms, IOUtils, Classes, System.Types, System.StrUtils;

function fVerificaJaExisteAutoIncrem(strTabela, strAutoIncrem : String) : Boolean;
  var
    qryLogChkOut : TUniQuery;
begin
  qryLogChkOut := fCriaQuery(Nil);
  try
    qryLogChkOut.Close;
    qryLogChkOut.SQL.Clear;
    qryLogChkOut.SQL.Add('SELECT AUTOINCREM FROM '+strTabela+' WHERE AUTOINCREM = :AUTOINCREM ');
    qryLogChkOut.ParamByName('AUTOINCREM').AsString := strAutoIncrem;
    qryLogChkOut.Open;

    Result := not qryLogChkOut.IsEmpty;
  finally
    FreeAndNil(qryLogChkOut);
  end;
end;

procedure pGravaLogChkOut(AintChkOut : Integer;
                          strOpeRcx : String;
                          strCodCli : String;
                          strCodVen : String;
                          strCodBar : String;
                          strCodIte : String;
                          strDesIte : String;
                          strDesUni : String;
                          fltQtdIte: Double;
                          fltUniTar: Double;
                          fltTotIte : Double;
                          strNomMaq : String;
                          strNumIp : String;
                          strNomUsu : String;
                          strTpLanc : String;
                          blnConclusao : Boolean;
                          var AcdsChkOut, AcdsLogChk : TUniClientDataSet);
begin
  //gravando o log check out
  if not blnConclusao then
  begin
    AcdsLogChk.Append;
    AcdsLogChk.FieldByName('LGK_DTAMOV').AsDateTime := VS_Date;
    AcdsLogChk.FieldByName('LGK_HRAMOV').AsDateTime := fTime();

    pAtribuirDesconsiderandoVazio(AcdsLogChk.FieldByName('LGK_CODOPE'), strOpeRcx);
    pAtribuirDesconsiderandoVazio(AcdsLogChk.FieldByName('LGK_CODCLI'), strCodCli);
    pAtribuirDesconsiderandoVazio(AcdsLogChk.FieldByName('LGK_CODVEN'), strCodVen);
    pAtribuirDesconsiderandoVazio(AcdsLogChk.FieldByName('LGK_CODITE'), strCodIte);

    AcdsLogChk.FieldByName('LGK_ITEBAR').AsString   := strCodBar;
    AcdsLogChk.FieldByName('LGK_DESITE').AsString   := strDesIte;
    AcdsLogChk.FieldByName('LGK_DESUNI').AsString   := strDesUni;
    AcdsLogChk.FieldByName('LGK_QTDITE').AsFloat    := fltQtdIte;
    AcdsLogChk.FieldByName('LGK_UNITAR').AsFloat    := fltUniTar;
    AcdsLogChk.FieldByName('LGK_TOTITE').AsFloat    := fltTotIte;
    AcdsLogChk.FieldByName('LGK_NOMMAQ').AsString   := strNomMaq;
    AcdsLogChk.FieldByName('LGK_NUM_IP').AsString   := strNumIp;
    AcdsLogChk.FieldByName('LGK_NOMUSU').AsString   := strNomUsu;
    AcdsLogChk.FieldByName('LGK_TPLANC').AsString   := fRetornaDescMovimento(strTpLanc);
    AcdsLogChk.Post;
    pGravaArquivoCdsChkOut(AcdsLogChk, 'LOGCHK') ;
  end
  else
  begin
    if not AcdsChkOut.FindKey([AintChkOut]) then
      Exit ;

    AcdsLogChk.Append;
    AcdsLogChk.FieldByName('LGK_DTAMOV').AsDateTime := VS_Date;
    AcdsLogChk.FieldByName('LGK_HRAMOV').AsDateTime := fTime();

    pAtribuirDesconsiderandoVazio(AcdsLogChk.FieldByName('LGK_CODOPE'), AcdsChkOut.FieldByName('CHK_CODOPE').AsString);
    pAtribuirDesconsiderandoVazio(AcdsLogChk.FieldByName('LGK_CODCLI'), AcdsChkOut.FieldByName('CHK_CODCLI').AsString);
    pAtribuirDesconsiderandoVazio(AcdsLogChk.FieldByName('LGK_CODVEN'), AcdsChkOut.FieldByName('CHK_CODVEN').AsString);
    pAtribuirDesconsiderandoVazio(AcdsLogChk.FieldByName('LGK_CODITE'), AcdsChkOut.FieldByName('CHK_CODITE').AsString);

    AcdsLogChk.FieldByName('LGK_ITEBAR').AsString := AcdsChkOut.FieldByName('CHK_ITEBAR').AsString;
    AcdsLogChk.FieldByName('LGK_DESITE').AsString := AcdsChkOut.FieldByName('CHK_DESITE').AsString;
    AcdsLogChk.FieldByName('LGK_DESUNI').AsString := AcdsChkOut.FieldByName('CHK_DESUNI').AsString;
    AcdsLogChk.FieldByName('LGK_QTDITE').AsFloat := AcdsChkOut.FieldByName('CHK_QTDITE').AsFloat;
    AcdsLogChk.FieldByName('LGK_UNITAR').AsFloat := AcdsChkOut.FieldByName('CHK_UNITAR').AsFloat;
    AcdsLogChk.FieldByName('LGK_TOTITE').AsFloat := AcdsChkOut.FieldByName('CHK_TOTITE').AsFloat;
    AcdsLogChk.FieldByName('LGK_NOMMAQ').AsString := AcdsChkOut.FieldByName('CHK_NOMMAQ').AsString;
    AcdsLogChk.FieldByName('LGK_NUM_IP').AsString := AcdsChkOut.FieldByName('CHK_NUM_IP').AsString;
    AcdsLogChk.FieldByName('LGK_NOMUSU').AsString := AcdsChkOut.FieldByName('CHK_NOMUSU').AsString;
    AcdsLogChk.FieldByName('LGK_TPLANC').AsString := fRetornaDescMovimento('C');
    AcdsLogChk.Post;
    pGravaArquivoCdsChkOut(AcdsLogChk, 'LOGCHK') ;
  end;

end;

function fGravaChkOut(AintChkOut : Integer;
                      strOpeRcx : String;
                      strCodCli : String;
                      strCodVen : String;
                      strCodBar : String;
                      strCodIte : String;
                      strDesIte : String;
                      strDesUni : String;
                      fltQtdIte: Double;
                      fltUniTar: Double;
                      fltTotIte : Double;
                      strNomMaq : String;
                      strNumIp : String;
                      strNomUsu : String;
                      var AcdsChkOut : TUniClientDataSet) : Integer;
begin
  Result := 0;
  //incluindo ou excluindo check out
  if AintChkOut <> 0 then
  begin
    pRemoveChkOut(AintChkOut, AcdsChkOut);
  end
  else
  begin
    AcdsChkOut.Append;
    AcdsChkOut.FieldByName('CHK_DTALAN').AsDateTime := Date;
    AcdsChkOut.FieldByName('CHK_HRALAN').AsDateTime := fTime();
    if not fEmptyStr(strOpeRcx) then
      AcdsChkOut.FieldByName('CHK_CODOPE').AsString := strOpeRcx;
    if not fEmptyStr(strCodCli) then
      AcdsChkOut.FieldByName('CHK_CODCLI').AsString := strCodCli;
    if not fEmptyStr(strCodVen) then
      AcdsChkOut.FieldByName('CHK_CODVEN').AsString := strCodVen;
    AcdsChkOut.FieldByName('CHK_ITEBAR').AsString   := strCodBar;
    if not fEmptyStr(strCodIte) then
      AcdsChkOut.FieldByName('CHK_CODITE').AsString := strCodIte;
    AcdsChkOut.FieldByName('CHK_DESITE').AsString   := strDesIte;
    AcdsChkOut.FieldByName('CHK_DESUNI').AsString   := strDesUni;
    AcdsChkOut.FieldByName('CHK_QTDITE').AsFloat    := fltQtdIte;
    AcdsChkOut.FieldByName('CHK_UNITAR').AsFloat    := fltUniTar;
    AcdsChkOut.FieldByName('CHK_TOTITE').AsFloat    := fltTotIte;
    AcdsChkOut.FieldByName('CHK_NOMMAQ').AsString   := strNomMaq;
    AcdsChkOut.FieldByName('CHK_NUM_IP').AsString   := strNumIp;
    AcdsChkOut.FieldByName('CHK_NOMUSU').AsString   := strNomUsu;
    AcdsChkOut.Post;
    Result :=  AcdsChkOut.FieldByName('AUTOINCREM').AsInteger ;
    pGravaArquivoCdsChkOut(AcdsChkOut, 'CHKOUT') ;
  end;
end;

function fGravaCheckout(AintChkOut : Integer;
                        strOpeRcx : String;
                        strCodCli : String;
                        strCodVen : String;
                        strCodBar : String;
                        strCodIte : String;
                        strDesIte : String;
                        strDesUni : String;
                        fltQtdIte: Double;
                        fltUniTar: Double;
                        fltTotIte : Double;
                        strNomMaq : String;
                        strNumIp : String;
                        strNomUsu : String;
                        strTpLanc : String;
                        blnConclusao : Boolean;
                        var AcdsChkOut, AcdsLogChk : TUniClientDataSet) : Integer;
begin
  //gravando o log check out
  pGravaLogChkOut(AintChkOut,
                  strOpeRcx,
                  strCodCli,
                  strCodVen,
                  strCodBar,
                  strCodIte,
                  strDesIte,
                  strDesUni,
                  fltQtdIte,
                  fltUniTar,
                  fltTotIte,
                  strNomMaq,
                  strNumIp,
                  strNomUsu,
                  strTpLanc,
                  blnConclusao,
                  AcdsChkOut,
                  AcdsLogChk);

  //incluindo ou excluindo check out
  Result := fGravaChkOut(AintChkOut,
                         strOpeRcx,
                         strCodCli,
                         strCodVen,
                         strCodBar,
                         strCodIte,
                         strDesIte,
                         strDesUni,
                         fltQtdIte,
                         fltUniTar,
                         fltTotIte,
                         strNomMaq,
                         strNumIp,
                         strNomUsu,
                         AcdsChkOut);
end;

function fRetornaDescMovimento(strTpLanc : String) : String;
const
  MOVIMENTO_INCLUSAO = 'INCLUSAO';
  MOVIMENTO_EXCLUSAO = 'EXCLUSAO';
  MOVIMENTO_CONCLUSAO = 'CONCLUSAO';
begin
  if strTpLanc = 'I' then
    Result := MOVIMENTO_INCLUSAO
  else if strTpLanc = 'E' then
    Result := MOVIMENTO_EXCLUSAO
  else
    Result := MOVIMENTO_CONCLUSAO;
end;

procedure pRemoveChkOut(const AintChkOut : Integer; var AcdsChkOut: TUniClientDataSet);
begin
  if AcdsChkOut.FindKey([AintChkOut]) then
  begin
    AcdsChkOut.Delete ;
    pGravaArquivoCdsChkOut(AcdsChkOut, 'CHKOUT') ;
  end ;
end;

procedure pCriaCamposCds(var ACds: TUniClientDataSet; const AQryOrigem: TUniQuery) ;
var
  LintCnt: Integer ;
begin
  ACds.FieldDefs.Add('AUTOINCREM', ftAutoInc);
  for LintCnt := 0 to AQryOrigem.Fields.Count-1 do
  begin
    if AQryOrigem.Fields.Fields[LintCnt].FieldName <> 'AUTOINCREM' then
      ACds.FieldDefs.Add(AQryOrigem.Fields.Fields[LintCnt].FieldName, AQryOrigem.Fields.Fields[LintCnt].DataType, AQryOrigem.Fields.Fields[LintCnt].Size);
  end ;
end ;

procedure pCriaDirTemp(const AstrPathBase: string) ;
begin
  if not DirectoryExists(AstrPathBase) then
    CreateDir(AstrPathBase) ;
end ;

function fRetornaCaminhoArquivoXML(const AstrTabela: String = ''):string ;
const
  DIRTEMP = 'temp' ;
var
  LstrPath : string ;
begin
  LstrPath := ExtractFilePath(Application.ExeName)+DIRTEMP ;
  pCriaDirTemp(LstrPath) ;
  if fEmptyStr(AstrTabela) then
    result := LstrPath
  else
    result := LstrPath+'\'+AstrTabela+'_'+VS_strCodEmp+'_'+strLoginUsuarioLogado+'_'+VS_ProcessId+'.xml' ;
end ;

function fCriaCdsChkOut(): TUniClientDataSet ;
var
  LqryChkOut : TUniQuery;
begin
  result := TUniClientDataSet.Create(Nil) ;
  LqryChkOut := fCriaQuery(Nil);
  try
    LqryChkOut.Close;
    LqryChkOut.SQL.Clear;
    LqryChkOut.SQL.Add('SELECT * FROM CHKOUT WHERE FALSE');
    LqryChkOut.Open;

    pCriaCamposCds(Result, LqryChkOut) ;

    result.CreateDataSet ;
    result.LogChanges := False ;
    result.IndexFieldNames := 'AUTOINCREM' ;
    result.Open ;
  finally
    FreeAndNil(LqryChkOut) ;
  end ;
end ;

function fCriaCdsLogChk(): TUniClientDataSet ;
var
  LqryLogChk : TUniQuery;
begin
  result := TUniClientDataSet.Create(Nil) ;
  LqryLogChk := fCriaQuery(Nil);
  try
    LqryLogChk.Close;
    LqryLogChk.SQL.Clear;
    LqryLogChk.SQL.Add('SELECT * FROM LOGCHK WHERE FALSE');
    LqryLogChk.Open;

    pCriaCamposCds(Result, LqryLogChk) ;

    result.CreateDataSet ;
    result.LogChanges := False ;
    result.IndexFieldNames := 'AUTOINCREM' ;
    result.Open ;
  finally
    FreeAndNil(LqryLogChk) ;
  end ;
end ;

procedure pGravaArquivoCdsChkOut(const Acds: TUniClientDataSet; const AstrTabela: String) ;
var
  LstrPathArq: String ;
begin
  try
    LstrPathArq := fRetornaCaminhoArquivoXML(AstrTabela) ;
    Acds.DisableControls ;
    try
      Acds.SaveToFile(LstrPathArq);
    finally
      Acds.EnableControls ;
    end ;
  Except
    // silencioso
  End;
end ;

function fArquivoValidoChkOut(const AstrArquivo: string):boolean ;
var
  LlstVerifica: TStringList ;
begin
  Result := False ;

  if lowerCase(ExtractFileExt(AstrArquivo)) <> '.xml' then
    exit ;

  LlstVerifica := TStringList.Create ;
  try
    LlstVerifica.StrictDelimiter := True ;
    LlstVerifica.Delimiter := '_' ;
    LlstVerifica.DelimitedText := AstrArquivo ;
    if LlstVerifica.Count < 4 then
      exit ;

    if pos('CHK', upperCase(LlstVerifica.Strings[0])) <= 0 then
      exit ;

    if LlstVerifica.Strings[1] <> VS_strCodEmp then
      exit ;

    if LlstVerifica.Strings[2] <> strLoginUsuarioLogado then
      exit ;

  finally
    FreeAndNil(LlstVerifica) ;
  end ;
  Result := True ;
end ;

procedure pDesligamentoInesperadoChkOut ;
var
  LstrPathArq: string ;
  LstrPathTemp: string ;
  LlstXml: TStringList ;
  LDynArq: TStringDynArray ;
  LstrArqValido: string ;
begin
  LstrPathTemp := fRetornaCaminhoArquivoXML ;
  LlstXml := TStringList.Create ;
  try
    LDynArq := TDirectory.GetFiles(LstrPathTemp) ;
    for LstrPathArq in LDynArq  do
    begin
      LstrArqValido := ExtractFileName(LstrPathArq) ;
      if fArquivoValidoChkOut(LstrArqValido) then
      begin
        pCarregaXMLChkOut(LstrArqValido) ;
      end ;
    end ;
  finally
    FreeAndNil(LlstXml) ;
  end ;
end ;

procedure pPersisteChkOut(const Acds: TUniClientDataSet; const AstrTabela: String; const AblnExcluir: Boolean = True) ;
var
  LqryChkOut : TUniQuery;
  LstrAutInc : String;
  LintTentativas : Integer;
  LintCnt : Integer ;
  LstrPathArq : String ;
begin
  if not Acds.Active then
    exit ;

  LqryChkOut := fCriaQuery(Nil);
  try
    LqryChkOut.Close;
    LqryChkOut.SQL.Clear;
    LqryChkOut.SQL.Add('SELECT * FROM ' + AstrTabela + ' WHERE FALSE');
    LqryChkOut.Open;

    Acds.First ;
    while not Acds.Eof do
    begin
      LintTentativas := 0;
      repeat
        LstrAutInc := fRetAutoIncrem(AstrTabela, VS_strCodEmp);
        Inc(LintTentativas);
      until (not fVerificaJaExisteAutoIncrem(AstrTabela, LstrAutInc)) or (LintTentativas = 5);

      LqryChkOut.Append ;
      LqryChkOut.FieldByName('AUTOINCREM').AsString   := LstrAutInc;
      for LintCnt := 0 to LqryChkOut.Fields.Count-1 do
      begin
        if LqryChkOut.Fields.Fields[LintCnt].FieldName = 'AUTOINCREM' then
          continue ;

        LqryChkOut.FieldByName(LqryChkOut.Fields.Fields[LintCnt].FieldName).AsVariant := Acds.FieldByName(LqryChkOut.Fields.Fields[LintCnt].FieldName).AsVariant ;
      end ;
      LqryChkOut.Post ;

      Acds.Next ;
    end ;
    //limpa o cds
    Acds.EmptyDataSet ;
    // apaga arquivo XML
    if AblnExcluir then
      begin
      try
        LstrPathArq := fRetornaCaminhoArquivoXML(AstrTabela) ;
        DeleteFile(LstrPathArq) ;
      except
        // silencioso
      end ;
    end ;
  finally
    FreeAndNil(LqryChkOut);
  end ;
end ;

procedure pCarregaXMLChkOut(const AstrArquivo: String) ;
var
  LstrPathArq: String ;
  Lcds: TUniClientDataSet ;
  LstrTabela: String ;
begin
  LstrPathArq := fRetornaCaminhoArquivoXML+'\'+AstrArquivo ;

  if FileExists(LstrPathArq) then
  begin
    Lcds := TUniClientDataSet.Create(Nil) ;
    try
      try
        Lcds.LoadFromFile(LstrPathArq);
        LstrTabela := SplitString(AstrArquivo, '_')[0] ;
        pPersisteChkOut(Lcds, LstrTabela, False) ;

        DeleteFile(LstrPathArq) ;

      except
        // silencioso
      end ;
    finally
      FreeAndNil(Lcds) ;
    end ;

  end ;

end ;

end.
