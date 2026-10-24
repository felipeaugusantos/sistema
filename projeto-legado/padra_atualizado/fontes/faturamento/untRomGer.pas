unit untRomGer;

interface

uses
  SysUtils, Classes, DB, Uni, UniClientDataSet,
  Variants, Forms, StrUtils, rlTypes, cxProgressBar,
  Controls, untTLock, untTypesSistema, untConstantes,
  System.Generics.Collections;

type
  TInfDocRom = record
    strIncGer: string;
    strTabGer: string;
    strAbrGer: string;
    strTabDet: string;
    strAbrDet: string;
  end;

type
  TTravaRomaneio = Class
  private
    FstrNumRom : String;
    FstrEmpRom : String;
    FobjLock   : TLock;
    FUltimaChaveVerificada : String;
    FblnExibirMensagemAoTravarDocumento : Boolean;
    function fConfirma(pgbStatus: TcxProgressBar): Boolean;
    function fQueryDocumentos(const strNumRom, strEmpRom : String): TUniQuery;
  public
    function fTrava: Boolean;
    procedure pDestrava(strNumRom, strEmpRom: String; objLock: TLock);
    constructor Create(strNumRom, strEmpRom: String; objLock: TLock);
    property blnExibirMensagemAoTravarDocumento : Boolean read FblnExibirMensagemAoTravarDocumento write FblnExibirMensagemAoTravarDocumento;
    property strUltimaChaveVerificada : String read FUltimaChaveVerificada;
  End;

  function fRomaneioExiste(strNumRom: String; strEmpRom: String = ''): Boolean;

  procedure pLimparInformacoesExpedicao(stlLisDoc: TStringList; strNumRom: String='');

  function fRomaneioBaixado(strNumRom: String; tpOrigemRomaneio: TOrigemRomaneio = torIndefinido; strEmpRom: String = ''): Boolean;
  function fRomaneioTransbordo(strNumRom, strNumDoc, strEspDoc, strCodEmp: String): Boolean;

  function fRomaneioAtivo(strNumRom: String): Boolean;

  procedure pImprimirRomaneio(strrNumRom: String);

  function fRemoverDocumento(strNumDoc,
                             strEspDoc,
                             strCodEmp,
                             strCodCli,
                             strNumRom,
                             strCodOpe,
                             strCodMot:String;
                             dtaDtarom,
                             dtaHorRom: TDateTime;
                             strObserv: String;
                             strEmpRom: String = '';
                             strNomFrm: String = ''): Boolean;

  function fRemoverDocumentoOX(strNumDoc,
                               strEspDoc,
                               strCodEmp,
                               strNumRom,
                               strCodOpe,
                               strCodMot:String;
                               dtaDtarom,
                               dtaHorRom: TDateTime;
                               strObserv: String;
                               strEmpRom: String = ''): Boolean;

  function fGetSeqDigOutDigX(strNumRom: String): String;

  function fBaixarDocumento(strNumDoc,
                            strEspDoc,
                            strCodEmp,
                            strCodCli,
                            strNumRom,
                            strNomRec: String;
                            dtaDtaBai,
                            dtaHorBai: TDateTime;
                            strEntreg: String;
                            strBaiApp: String = 'N';
                            strKMIni: String = '';
                            strKMFim: String = '';
                            strEmpRom: String = '';
                            dtaDtaRom: TDateTime = 0;
                            dtaDtaDoc: TDateTime = 0;
                            fltQtdVol: Double = 0): Boolean;

  function fRemoverItemDocto(strNumDoc,
                             strEspDoc,
                             strCodEmp,
                             strCodCli,
                             strNumRom,
                             strCodIte: String;
                             fltValRem,
                             fltQtdRem: Double;
                             strDetInc: String;
                             strNomTab: String): Boolean;

    function fGravaLogRom( Var strAutoincrem : String;
                               strNumRom,
                               strCPOAlt,
                               strInfAnC,
                               strInfNoC: String;
                               strNumDoc: String = '';
                               strEspDoc: String = '';
                               strEmpDoc: String = '';
                               strObserv: String = '';
                               blnObsMan: Boolean = False): Boolean; Overload;

  function fGravaLogRom(strNumRom,
                     strCPOAlt,
                     strInfAnC,
                     strInfNoC: String;
                     strNumDoc: String = '';
                     strEspDoc: String = '';
                     strEmpDoc: String = '';
                     strObserv: String = '';
                     blnObsMan: Boolean = False;
                     strAutoincrem : String  = '';
                     strEmpRom: String = ''): Boolean;Overload;

  Function fRemoverRomDet(strNumRom,
                          strSeqGer,
                          strCodEmp,
                          strAutoIncrem,
                          strNumDoc,
                          strEspDoc,
                          strCodCli,
                          strCodOpe,
                          strCodMot: String;
                          dtaDtaRom,
                          dtaHorRom: TDateTime;
                          strCodIte: String;
                          fltQtdIte: Real;
                          fltQtdBai: Real;
                          strAutInc: String;
                          strEmpRom: String = '';
                          strNomFrm: String = '';
                          dtaDtaDoc: TDateTime = 0;
                          fltQtdVol: Double = 0): Boolean;

  Function fAtualizaTotaisRomGer(strNumRom,
                                 strAutoIncrem,
                                 strCodEmp : String) : Boolean;                        

  Function fGravaRomDel(strNumDoc,
                        strEspDoc,
                        strCodEmp,
                        strCodCli,
                        strNumRom,
                        strCodOpe,
                        strCodMot,
                        strCodCid,
                        strCodReg,
                        strCodAj1,
                        strCodAj2,
                        strCodAj3,
                        strCodAj4,
                        strObsFec,
                        strCodTra,
                        strPlaVei:String;
                        dtaDtarom,
                        dtaHorRom:TDateTime;
                        strObserv:String;
                        strEmpRom: String = ''): Boolean;

  Function fGravaRomDetDel(strNumDoc,
                           strEspDoc,
                           strCodEmp,
                           strCodCli,
                           strNumRom,
                           strCodOpe,
                           strCodMot:String;
                           dtaDtarom,
                           dtaHorRom: TDateTime;
                           strCodIte: String;
                           fltQtdIte,
                           fltQtdBai: Double;
                           strAutInc: String;
                           strEmpRom: String = ''): Boolean;

  Function fNumeroRomaneio(strNumRom: String): String;

  Function fRomaneioTotalmenteFaturado(strNumRom: String): Boolean;

  function fTravaDocsRomaneio(strNumRom: String; objLock: TLock): Boolean;

  function fLock_UnLock_DocRomaneio(strChave: String; strEspDoc: String;
    strEntSai: String; blnTrava: Boolean; blnLoopTravamento: Boolean; objLock: TLock;
    blnExibirMensagemQuandoDocumentoTravado : Boolean = True): Boolean;

  function fDeletaOutDigX(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

  function fGravaRomRet(cdsRomRet: TUniClientDataSet; strNumRom, strCodEmp: String): Boolean;
  function fGravaRota(strAutInc, strLocali, strLibApp, strEvitar, strFilial, strIniPar, strLatLon: String; intOrdImp: Integer; fltDistan, fltTmpEnt: Double; intPriOri: Integer;
    strFstSht, strFinRot: String): Boolean;

  function fRecebeTransbordo(strAutInc: String): Boolean;
  function fBaixaTransbordo(strAutInc: String): Boolean;
  procedure pLimpaBaixaTransbordo(strSeqGer: String);
  function fEmpDesTransbordo(strNumRom: String): String;
  function fRetornaRomaneioEmAberto(strCodMotorista: String): String;
  function fBaixaFeitaPeloAppTaEntregue(strNumRom: String): Boolean;
  function fTemDocumentoNaoLiberadoPelasPendenciasDoPainelDeEntrega(const AstrNumRom: String): Boolean;

  procedure pGravaTabelasDeleteRomaneio(strForm, strNumRom: String);
  function fEntregaIniciadaPeloMotorista(strNumRom, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  function fRetQtdRomDetX(const AIncDoc, ANumRom, ACodEmp: String): Double;
  function fAgrupaPorAutoIncrem(strClaFis: String; blnDocTemItemRepetido: Boolean): Boolean;
  function fEntraBrindeETrocaNoRomaneio: Boolean;
  function fDocumentoTemItemRepetido(strNomTab, strNumDoc, strEspDoc, strEmpDoc: String): Boolean;
  function fRetSQLSeqRotaRegiao(SQLCidade: String): String;

  function fInsereDocRemovidoRomaneioParaConferencia(const ANumRom, AEmpRom, ANumDoc, AEspDoc,
    AEmpDoc, ACodCli: String; ADtaRom, ADtaDoc: TDateTime; AQtdVol: Double): Boolean;
  procedure pRemoveDocRomaneioParaConferencia(const ANumRom, AEmpRom, ANumDoc, AEspDoc, AEmpDoc: String);
  function fVerificaInseriuDocRemovidoParaConferencia(const ANumRom, AEmpRom, ANumDoc, AEspDoc, AEmpDoc: String): Boolean;

implementation

uses
  untTypesCRM,
  untQckRomGer,
  untfuncoesSimples,
  untFatRomaneioImpr,
  untTSituacaoPedidoVenda,
  untAtualizaOcorrenciasCRM, untGravando, untGravaRomaneio;

function fGravaRomRet(cdsRomRet: TUniClientDataSet; strNumRom, strCodEmp: String): Boolean;
var
  qryRomRet: TUniQuery;
begin
  Result := True;

  cdsRomRet.First;

  qryRomRet := fCriaQuery;
  try
    try
      qryRomRet.Close;
      qryRomRet.SQL.Text :=
      ' DELETE FROM ROMRET '+
      ' WHERE '+
      '   RET_NUMROM = :NUMROM AND '+
      '   RET_EMPROM = :EMPROM ';

      qryRomRet.ParamByName('NUMROM').AsString := strNumRom;
      qryRomRet.ParamByName('EMPROM').AsString := strCodEmp;
      qryRomRet.ExecSQL;

      if (cdsRomRet.FieldByName('RET_DISTAN').AsFloat > 0.00) and
         (cdsRomRet.FieldByName('RET_TMPRET').AsFloat > 0.00) then
      begin
        qryRomRet.Close;
        qryRomRet.SQL.Text :=
        ' INSERT INTO ROMRET '+
        '  (AUTOINCREM, '+
        '   RET_DISTAN, '+
        '   RET_TMPRET, '+
        '   RET_NUMROM, '+
        '   RET_EMPROM) '+
        ' VALUES '+
        '  (:AUTINC, '+
        '   :DISTAN, '+
        '   :TMPRET, '+
        '   :NUMROM, '+
        '   :EMPROM) ';

        qryRomRet.ParamByName('AUTINC').AsString := fRetAutoIncrem('ROMRET', strCodEmp);;
        qryRomRet.ParamByName('DISTAN').AsFloat  := cdsRomRet.FieldByName('RET_DISTAN').AsFloat;
        qryRomRet.ParamByName('TMPRET').AsFloat  := cdsRomRet.FieldByName('RET_TMPRET').AsFloat;
        qryRomRet.ParamByName('NUMROM').AsString := strNumRom;
        qryRomRet.ParamByName('EMPROM').AsString := strCodEmp;

        qryRomRet.ExecSQL;
      end;
    except
      Result := False;
    end;
  finally
    cdsRomRet.EmptyDataSet;

    FreeAndNil(qryRomRet);
  end;

end;

function fGravaRota(strAutInc, strLocali, strLibApp, strEvitar, strFilial, strIniPar, strLatLon: String; intOrdImp: Integer; fltDistan, fltTmpEnt: Double; intPriOri: Integer;
  strFstSht, strFinRot: String): Boolean;
var
  qryRomGer: TUniQuery;
begin
  Result := True;

  qryRomGer := fCriaQuery;
  try
    try
      qryRomGer.Close;
      qryRomGer.SQL.Text :=
      ' UPDATE '+
      '   ROMGERX '+
      ' SET '+
      '   GER_ORDIMP = :ORDIMP '+
      '  ,GER_LOCALI = :LOCALI '+
      '  ,GER_DISTAN = :DISTAN '+
      '  ,GER_TMPENT = :TMPENT '+
      '  ,GER_LIBAPP = :LIBAPP '+
      '  ,GER_EVITAR = :EVITAR '+
      '  ,GER_FILIAL = :FILIAL '+
      '  ,GER_INIPAR = :INIPAR '+
      '  ,GER_LATLON = :LATLON '+
      '  ,GER_PRIORI = :PRIORI '+
      '  ,GER_FSTSHT = :FSTSHT '+
      '  ,GER_FINROT = :FINROT '+
      ' WHERE '+
      '   AUTOINCREM = :AUTINC ';

      qryRomGer.ParamByName('ORDIMP').AsInteger := intOrdImp;
      qryRomGer.ParamByName('LOCALI').AsString  := strLocali;
      qryRomGer.ParamByName('LIBAPP').AsString  := strLibApp;
      qryRomGer.ParamByName('EVITAR').AsString  := strEvitar;
      qryRomGer.ParamByName('DISTAN').AsFloat   := fltDistan;
      qryRomGer.ParamByName('TMPENT').AsFloat   := fltTmpEnt;
      qryRomGer.ParamByName('FILIAL').AsString  := strFilial;
      qryRomGer.ParamByName('AUTINC').AsString  := strAutInc;
      qryRomGer.ParamByName('INIPAR').AsString  := strIniPar;
      qryRomGer.ParamByName('LATLON').AsString  := strLatLon;
      qryRomGer.ParamByName('PRIORI').AsInteger := intPriOri;
      qryRomGer.ParamByName('FSTSHT').AsString  := strFstSht;
      qryRomGer.ParamByName('FINROT').AsString  := strFinRot;

      qryRomGer.ExecSQL;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryRomGer);
  end;
end;

function fRomaneioExiste(strNumRom: String; strEmpRom: String = ''): Boolean;
  Var
    strSQL: String;
    qryGenGer: TUniQuery;
begin

  Try
    qryGenGer := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ROMGERX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
      Open;
      Result := (FieldByName('QTD').AsInteger > 0);
      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure pLimparInformacoesExpedicaoTotal(stlLisDoc: TStringList; const strNumRom: String);
Var
  qryGen: TUniQuery;
  i     : Integer;
  stlLisDocAux: TStringList;

  procedure pCarregaLisDoc;
    Var
      qryLis: TUniQuery;
  begin
    If strNumRom.IsEmpty Then
    Begin
      If Assigned(stlLisDoc) Then
        stlLisDocAux.Text := stlLisDoc.Text;
    End
    Else
    Begin
      qryLis := fCriaQuery;
      Try
        qryLis.SQL.Text :=
            'SELECT DISTINCT FDO_SEQGER FROM FATDOR D    '+
            ' INNER JOIN ROMDETX R ON                    '+
            '            D.AUTOINCREM = R.DET_AUTINC AND '+
            '            D.FDO_NUMDOC = R.DET_NUMDOC AND '+
            '            D.FDO_ESPDOC = R.DET_ESPDOC AND '+
            '            D.FDO_CODCLI = R.DET_CODCLI AND '+
            '            D.FDO_CODEMP = R.DET_CODEMP     '+
            ' WHERE                                      '+
            '   R.DET_NUMROM = :NUMROM AND               '+
            '   R.DET_EMPROM = :EMPROM                   ';

        qryLis.ParamByName('NUMROM').Text := strNumRom;
        qryLis.ParamByName('EMPROM').Text := VS_strCodEmp;
        qryLis.Open;

        qryLis.First;
        While Not qryLis.Eof Do
        Begin
          If stlLisDocAux.IndexOf(qryLis.Fields[0].Value) = -1 Then
            stlLisDocAux.Add(qryLis.Fields[0].Value);

          qryLis.Next;
        End;
      Finally
        FreeAndNil(qryLis);
      End;
    End;
  end;

begin
  stlLisDocAux := TStringList.Create;
  try
    pCarregaLisDoc;

    If stlLisDocAux.Count > 0 Then
    Begin
      qryGen := fCriaQuery;
      Try
        For i := 0 To stlLisDocAux.Count - 1 Do
        Begin
          With qryGen Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE ');
            SQL.Add('  FATDOR F ');
            SQL.Add('  INNER JOIN EXTDOR E ON E.FDO_SEQFDO = F.AUTOINCREM ');
            SQL.Add('  INNER JOIN EXTGOR G ON F.FDO_SEQGER = G.FGO_SEQFGO ');
            SQL.Add('SET ');
            SQL.Add('  FGO_DTLBEX = NULL, ');
            SQL.Add('  FGO_HRLBEX = NULL, ');
            SQL.Add('  FDO_QTDEXP = 0,    ');
            SQL.Add('  FDO_SEPEXP = "N"   ');
            SQL.Add('WHERE ');
            SQL.Add('  F.FDO_SEQGER = :AUTINC ');

            ParamByName('AUTINC').AsString := stlLisDocAux[i];

            ExecSQL;
            Close;
          End;
        End;
      Finally
        FreeAndNil(qryGen);
      End;
    End;
  Finally
    FreeAndNil(stlLisDocAux);
  End;
end;

procedure pLimparInformacoesExpedicaoParcial(stlLisDoc: TStringList; const strNumRom: String);

var
  qryUpdate: TUniQuery;
  qrySelect: TUniQuery;
begin
  qrySelect := fCriaQuery;
  qryUpdate := fCriaQuery;
  Try
    // 1 - pego a qtdexp da ROMDETX e atualizo a FATDOR, subtraindo a qtde  e FDO_SEPEXP = 'N'
    qrySelect.Close;
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT D.DET_AUTINC, D.DET_QTDEXP, D.DET_JAFATU');
    qrySelect.SQL.Add('FROM ROMDETX D');
    qrySelect.SQL.Add('INNER JOIN FATDOR F ON D.DET_AUTINC = F.AUTOINCREM');
    qrySelect.SQL.Add('WHERE D.DET_NUMROM = :NUMROM');
    qrySelect.SQL.Add('  AND D.DET_EMPROM = :EMPROM');
    IF Assigned(stlLisDoc) and (stlLisDoc.Count > 0) then
      qrySelect.SQL.Add('  AND F.FDO_SEQGER IN (' + fCommaText(stlLisDoc, True) + ') ');

    qrySelect.ParamByName('NUMROM').AsString := strNumRom;
    qrySelect.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qrySelect.Open;

    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE EXTDOR');
    qryUpdate.SQL.Add('SET ');
    qryUpdate.SQL.Add('  FDO_QTDEXP = FDO_QTDEXP - :QTDEXP,');
    qryUpdate.SQL.Add('  FDO_SEPEXP = "N"');
    qryUpdate.SQL.Add('WHERE FDO_SEQFDO = :SEQFDO');

    while not qrySelect.Eof do
    begin
      if qrySelect.FieldByName('DET_JAFATU').AsInteger = 1 then
        qryUpdate.ParamByName('QTDEXP').AsFloat := 0
      else
        qryUpdate.ParamByName('QTDEXP').AsFloat := qrySelect.FieldByName('DET_QTDEXP').AsFloat;
      qryUpdate.ParamByName('SEQFDO').AsString := qrySelect.FieldByName('DET_AUTINC').AsString;
      qryUpdate.ExecSQL;

      qrySelect.Next;
    end;

    // 2 - faço select agrupando a FATGOR e atualizo FGO_DTLBEX e FGO_HRLBEX
    qrySelect.Close;
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT F.FDO_SEQGER');
    qrySelect.SQL.Add('FROM ROMDETX D ');
    qrySelect.SQL.Add('INNER JOIN FATDOR F ON D.DET_AUTINC = F.AUTOINCREM');
    qrySelect.SQL.Add('WHERE D.DET_NUMROM = :NUMROM');
    qrySelect.SQL.Add('  AND D.DET_EMPROM = :EMPROM');
    IF Assigned(stlLisDoc) and (stlLisDoc.Count > 0) then
      qrySelect.SQL.Add('  AND F.FDO_SEQGER IN (' + fCommaText(stlLisDoc, True) + ') ');

    qrySelect.SQL.Add('  GROUP BY F.FDO_SEQGER');

    qrySelect.ParamByName('NUMROM').AsString := strNumRom;
    qrySelect.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qrySelect.Open;

    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE EXTGOR');
    qryUpdate.SQL.Add('SET ');
    qryUpdate.SQL.Add('  FGO_DTLBEX = NULL,');
    qryUpdate.SQL.Add('  FGO_HRLBEX = NULL');
    qryUpdate.SQL.Add('WHERE FGO_SEQFGO = :SEQFGO');

    while not qrySelect.Eof do
    begin
      qryUpdate.ParamByName('SEQFGO').AsString := qrySelect.FieldByName('FDO_SEQGER').AsString;
      qryUpdate.ExecSQL;

      qrySelect.Next;
    end;

    // 3 - faço update zerando a qtdexp da ROMDETX
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE ');
    qryUpdate.SQL.Add('  ROMDETX D');
    qrySelect.SQL.Add('INNER JOIN FATDOR F ON D.DET_AUTINC = F.AUTOINCREM');
    qryUpdate.SQL.Add('SET ');
    qryUpdate.SQL.Add('  D.DET_QTDEXP = 0');
    qryUpdate.SQL.Add('WHERE D.DET_NUMROM = :NUMROM');
    qryUpdate.SQL.Add('  AND D.DET_EMPROM = :EMPROM');
    qryUpdate.SQL.Add('  AND D.DET_JAFATU = 0');
    IF Assigned(stlLisDoc) and (stlLisDoc.Count > 0) then
      qrySelect.SQL.Add('  AND F.FDO_SEQGER IN (' + fCommaText(stlLisDoc, True) + ') ');

    qryUpdate.ParamByName('NUMROM').AsString := strNumRom;
    qryUpdate.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qrySelect);
    FreeAndNil(qryUpdate);
  End;
end;

procedure pLimparInformacoesExpedicao(stlLisDoc: TStringList; strNumRom: String='');
begin
  if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
    pLimparInformacoesExpedicaoParcial(stlLisDoc, strNumRom)
  else
    pLimparInformacoesExpedicaoTotal(stlLisDoc, strNumRom);
end;

function fRomaneioBaixado(strNumRom: String; tpOrigemRomaneio: TOrigemRomaneio = torIndefinido; strEmpRom: String = ''): Boolean;
  Var
    strSQL : String;
    qryGenGer: TUniQuery;
begin

  Try
    Result := False;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_DTABAI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ROMGERX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

    if ((fCfgSis('BAROPA', varBoolean)) or (fCfgSis('MATDIS', varBoolean))) and
       (tpOrigemRomaneio in [torBaixaRomaneio, torRomaneioInclusao]) then
    begin
      if (tpOrigemRomaneio = torBaixaRomaneio) then
        strSQL := strSQL + ' AND GER_DTABAI IS NULL '
      else
        strSQL := strSQL + ' AND GER_DTABAI IS NOT NULL ';
    end;

    qryGenGer := fCriaQuery;
    With qryGenGer Do
    Begin
      SQL.Add(strSQL);
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
      Open;

      if ((fCfgSis('BAROPA', varBoolean)) or (fCfgSis('MATDIS', varBoolean))) and
         (tpOrigemRomaneio in [torBaixaRomaneio, torRomaneioInclusao]) then
      begin
        if (tpOrigemRomaneio = torBaixaRomaneio) then
          Result := IsEmpty
        else
          Result :=Not IsEmpty
      end
      else
      begin
        If (Not IsEmpty) Then
          Result := Not FieldByName('GER_DTABAI').IsNull;
      end;

      Close;
    End;
  Finally
    FreeAndNil(qryGenGer);
  End;

end;

function fRomaneioTransbordo(strNumRom, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
Var
  strSQL : String;
  qryGenGer: TUniQuery;
begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ROMTRAX.AUTOINCREM ';
  strSQL := strSQL + ' FROM ROMTRAX ';
  strSQL := strSQL + 'INNER JOIN ROMGERX ON ROMGERX.AUTOINCREM = ROMTRAX.TRA_SEQGER ';
  strSQL := strSQL + 'WHERE GER_NUMROM = :NUMROM ';
  strSQL := strSQL + '  AND GER_EMPROM = :EMPROM ';
  strSQL := strSQL + '  AND GER_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '  AND GER_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '  AND GER_CODEMP = :CODEMP ';

  qryGenGer := fCriaQuery;
  Try
    qryGenGer.SQL.Add(strSQL);
    qryGenGer.ParamByName('NUMROM').AsString := strNumRom;
    qryGenGer.ParamByName('EMPROM').AsString := VS_strCodEmp;

    qryGenGer.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGenGer.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGenGer.ParamByName('CODEMP').AsString := strCodEmp;
    qryGenGer.Open;

    If (Not qryGenGer.IsEmpty) Then
      Result := Not qryGenGer.FieldByName('AUTOINCREM').IsNull;
    qryGenGer.Close;
  Finally
    FreeAndNil(qryGenGer);
  End;
end;


function fRomaneioAtivo(strNumRom: String): Boolean;
  Var
    strSQL : String;
    qryGenGer: TUniQuery;
begin

  Try
    Result := False;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_STATUS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ROMGERX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

    qryGenGer := fCriaQuery;
    With qryGenGer Do
    Begin
      SQL.Add(strSQL);
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := VS_strCodEmp;
      Open;

      If (Not IsEmpty) Then
        Result := FieldByName('GER_STATUS').AsString = 'A';

      Close;
    End;
  Finally
    FreeAndNil(qryGenGer);
  End;

end;

function fRemoverDocumento(strNumDoc,
                           strEspDoc,
                           strCodEmp,
                           strCodCli,
                           strNumRom,
                           strCodOpe,
                           strCodMot:String;
                           dtaDtarom,
                           dtaHorRom:TDateTime;
                           strObserv:String;
                           strEmpRom: String = '';
                           strNomFrm: string = ''): Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;
    blnNotGer: Boolean;
    strSeqGer: String;
    fltVlrCon: Double;
    qryGenIte: TUniQuery;
    strAbrGer: String;
    strAbrDet: String;
    strOpcRom: String;
    blnPedido: Boolean;
    strCodCid,
    strCodReg,
    strCodAj1,
    strCodAj2,
    strCodAj3,
    strCodAj4,
    strObsFec,
    strCodTra,
    strPlaVei: String;
    dtaDtaDoc: TDateTime;
    fltQtdVol: Double;
begin
  If (strEspDoc = 'OX') Then
  Begin
    Result := fRemoverDocumentoOX(strNumDoc,
                                  strEspDoc,
                                  strCodEmp,
                                  strNumRom,
                                  strCodOpe,
                                  strCodMot,
                                  dtaDtarom,
                                  dtaHorRom,
                                  strObserv,
                                  strEmpRom);
    Exit;
  End;


  Try
    strOpcRom := fCfgSis('OPCROM');

    {*******************************************}
    {* CONFIGURADO PARA ROMANEIO DE PEDIDOS OU *}
    {* FOR PEDIDO DE RETIRADA.                 *}
    {****************************************PZ*}
    blnPedido := ((Pos(strOpcRom, '1_5_') > 0) Or (strEspDoc = 'PR'));

    {*******************************************}
    {* VERIFICA QUAIS TABELAS TEM (MOV/NOT)GER *}
    {****************************************MV*}
    blnNotGer := (Pos(strOpcRom, '34') > 0);

    If (blnPedido) Then
    Begin
      strAbrGer := 'FGO_';
      strAbrDet := 'FDO_';
    End
    Else
    Begin
      strAbrGer := 'GER_';
      strAbrDet := 'DET_';
    End;

    qryGenGer := fCriaQuery;
    qryGenIte := fCriaQuery;

    With qryGenGer Do
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  AUTOINCREM, ';
      strSQL := strSQL + '  GER_VLRCON, ';
      strSQL := strSQL + '  GER_CIDCON, ';
      strSQL := strSQL + '  GER_CODREG, ';
      strSQL := strSQL + '  GER_CODAJ1, ';
      strSQL := strSQL + '  GER_CODAJ2, ';
      strSQL := strSQL + '  GER_CODAJ3, ';
      strSQL := strSQL + '  GER_CODAJ4, ';
      strSQL := strSQL + '  GER_OBSFEC, ';
      strSQL := strSQL + '  GER_CODTRA, ';
      strSQL := strSQL + '  GER_PLAVEI, ';
      strSQL := strSQL + '  GER_DTAENT, ';
      strSQL := strSQL + '  GER_VOLUME  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ROMGERX ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
      strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
      Open;

      strSeqGer := FieldByName('AUTOINCREM').AsString;
      fltVlrCon := FieldByName('GER_VLRCON').AsFloat;
      strCodCid := FieldByName('GER_CIDCON').AsString;
      strCodReg := FieldByName('GER_CODREG').AsString;
      strCodAj1 := FieldByName('GER_CODAJ1').AsString;
      strCodAj2 := FieldByName('GER_CODAJ2').AsString;
      strCodAj3 := FieldByName('GER_CODAJ3').AsString;
      strCodAj4 := FieldByName('GER_CODAJ4').AsString;
      strObsFec := FieldByName('GER_OBSFEC').AsString;
      strCodTra := FieldByName('GER_CODTRA').AsString;
      strPlaVei := FieldByName('GER_PLAVEI').AsString;
      dtaDtaDoc := FieldByName('GER_DTAENT').AsDateTime;
      fltQtdVol := FieldByName('GER_VOLUME').AsFloat;

      Close;

      strSQL := '';
      strSQL := strSQL + 'UPDATE  ';

      If (blnPedido) Then
        strSQL := strSQL + '  FATGOR '
      Else
        strSQL := strSQL + '  MOVGER ';

      strSQL := strSQL + 'SET ';
      strSQL := strSQL + ' ' + strAbrGer + 'NUMROM = NULL, ';
      strSQL := strSQL + ' ' + strAbrGer + 'DTAROM = NULL, ';
      strSQL := strSQL + ' ' + strAbrGer + 'HORROM = NULL, ';
      strSQL := strSQL + ' ' + strAbrGer + 'OPEROM = NULL, ';
      strSQL := strSQL + ' ' + strAbrGer + 'VALROM = (' + strAbrGer + 'VALROM - :VALREM) ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + ' ' + strAbrGer + 'NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + ' ' + strAbrGer + 'ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + ' ' + strAbrGer + 'CODEMP = :CODEMP AND ';
      strSQL := strSQL + ' ' + strAbrGer + 'CODCLI = :CODCLI     ';

      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('VALREM').AsFloat  := fltVlrCon;
      ExecSQL;

      If (blnNotGer) Then
      Begin
        strSQL := AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('VALREM').AsFloat  := fltVlrCon;
        ExecSQL;
        Close;
      End;

      qryGenIte.Close;
      qryGenIte.SQL.Clear;
      qryGenIte.SQL.Add(' SELECT SQL_NO_CACHE ');
      qryGenIte.SQL.Add('        DET_AUTINC,  ');
      qryGenIte.SQL.Add('        DET_QTDROM   ');
      qryGenIte.SQL.Add('   FROM ROMDETX      ');
      qryGenIte.SQL.Add('  WHERE DET_SEQGER = :SEQGER ');
      qryGenIte.ParamByName('SEQGER').AsString := strSeqGer;
      qryGenIte.Open;

      strSQL := '';
      strSQL := strSQL + 'UPDATE  ';

      If (blnPedido) Then
        strSQL := strSQL + '  FATDOR '
      Else
        strSQL := strSQL + '  MOVDET ';

      strSQL := strSQL + 'SET ';
      strSQL := strSQL + ' ' + strAbrDet + 'QTDROM = (' + strAbrDet + 'QTDROM - :QTDREM) ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + ' ' + strAbrDet + 'NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + ' ' + strAbrDet + 'ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + ' ' + strAbrDet + 'CODCLI = :CODCLI AND ';
      strSQL := strSQL + ' ' + strAbrDet + 'CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

      qryGenIte.First;
      While Not qryGenIte.Eof Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('AUTINC').AsString := qryGenIte.FieldByName('DET_AUTINC').AsString;
        ParamByName('QTDREM').AsFloat  := qryGenIte.FieldByName('DET_QTDROM').AsFloat;
        ExecSQL;
        qryGenIte.Next;
      End;

      If (blnNotGer) Then
      Begin
        qryGenIte.First;
        While Not qryGenIte.Eof Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'));
          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODCLI').AsString := strCodCli;
          ParamByName('CODEMP').AsString := strCodEmp;
          ParamByName('AUTINC').AsString := qryGenIte.FieldByName('DET_AUTINC').AsString;
          ParamByName('QTDREM').AsFloat  := qryGenIte.FieldByName('DET_QTDROM').AsFloat;
          ExecSQL;
          qryGenIte.Next;
        End;
      End;

      if fCfgSis('UTITDE', varBoolean) then
        pLimpaBaixaTransbordo(strSeqGer);

      qryGenIte.Close;

    {***** BEGIN fVerificaIntegridade *****}
    {*** grava documento na del_romgerx ***}
      Close;
      SQL.Clear;
      SQL.Text :=
      ' SELECT * FROM ROMGERX '+
      ' WHERE '+
      '   GER_NUMDOC = :NUMDOC AND '+
      '   GER_ESPDOC = :ESPDOC AND '+
      '   GER_CODEMP = :CODEMP AND '+
      '   GER_CODCLI = :CODCLI AND '+
      '   GER_NUMROM = :NUMROM AND '+
      '   GER_EMPROM = :EMPROM ';
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
      Open;

      fVerificaIntegridade(strNomFrm, 'ROMGERX', qryGenGer);

    {*** grava documento na del_romdetx ***}
      Close;
      SQL.Clear;
      SQL.Text :=
      ' SELECT * FROM ROMDETX '+
      ' WHERE '+
      '   DET_SEQGER = :SEQGER ';
      ParamByName('SEQGER').AsString := strSeqGer;
      Open;

      fVerificaIntegridade(strNomFrm, 'ROMDETX', qryGenGer);

    {*** grava documento na del_romoutx ***}
      Close;
      SQL.Clear;
      SQL.Text :=
      ' SELECT * FROM ROMOUTX '+
      ' WHERE '+
      '   OUT_NUMROM = :NUMROM AND '+
      '   OUT_ROMEMP = :EMPROM ';
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
      Open;

      fVerificaIntegridade(strNomFrm, 'ROMOUTX', qryGenGer);

    {***** END fVerificaIntegridade *****}


      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  ROMGERX ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
      strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
      ExecSQL;

    End;

    fInsereDocRemovidoRomaneioParaConferencia(strNumRom, strEmpRom, strNumDoc, strEspDoc, strCodEmp, strCodCli, dtaDtaRom, dtaDtaDoc, fltQtdVol);

    fGravaRomDel(strNumDoc,
                 strEspDoc,
                 strCodEmp,
                 strCodCli,
                 strNumRom,
                 strCodOpe,
                 strCodMot,
                 strCodCid,
                 strCodReg,
                 strCodAj1,
                 strCodAj2,
                 strCodAj3,
                 strCodAj4,
                 strObsFec,
                 strCodTra,
                 strPlaVei,
                 dtaDtarom,
                 dtaHorRom,
                 strObserv,
                 strEmpRom);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fBaixarDocumento]');
    End;
  End;

  FreeAndNil(qryGenGer);
  FreeAndNil(qryGenIte);
end;

function fRemoverDocumentoOX(strNumDoc,
                             strEspDoc,
                             strCodEmp,
                             strNumRom,
                             strCodOpe,
                             strCodMot:String;
                             dtaDtarom,
                             dtaHorRom: TDateTime;
                             strObserv: String;
                             strEmpRom: String = ''): Boolean;

  Var
    strSQL : String;
    qryGenGer: TUniQuery;
    strSeqDig: String;
begin
  Try
    strSeqDig := fGetSeqDigOutDigX(strNumRom);

    qryGenGer := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE OUTDIGX ';
    strSQL := strSQL + '   SET DIG_NUMROM = NULL, ';
    strSQL := strSQL + '       DIG_EMPROM = NULL, ';
    strSQL := strSQL + '       DIG_DTAROM = NULL, ';
    strSQL := strSQL + '       DIG_HORROM = NULL, ';
    strSQL := strSQL + '       DIG_OPEROM = NULL  ';
    strSQL := strSQL + 'WHERE DIG_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND DIG_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  AND DIG_CODEMP = :CODEMP ';

    With qryGenGer Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ExecSQL;
    End;

    strSQL := '';
    strSQL := strSQL + ' DELETE ';
    strSQL := strSQL + '   FROM ROMGERX ';
    strSQL := strSQL + '  WHERE GER_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '    AND GER_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '    AND GER_CODEMP = :CODEMP ';
    strSQL := strSQL + '    AND GER_NUMROM = :NUMROM ';
    strSQL := strSQL + '    AND GER_EMPROM = :EMPROM ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
      ExecSQL;
    End;

    pDeletaRomOutX(strNumRom, strSeqDig);

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fRemoverDocumentoOX]');
    End;
  End;

  FreeAndNil(qryGenGer);
end;

function fGetSeqDigOutDigX(strNumRom: String): String;
  Var
    qryOutDig : TUniQuery;
begin
  qryOutDig := fCriaQuery;

  With qryOutDig Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT AUTOINCREM ');
    SQL.Add('   FROM OUTDIGX ');
    SQL.Add('  WHERE DIG_NUMROM = :NUMROM ');
    SQL.Add('    AND DIG_EMPROM = :ROMEMP ');
    ParamByName('NUMROM').AsString := strNumRom;
    ParamByName('ROMEMP').AsString := VS_strCodEmp;
    Open;
    Result := FieldByName('AUTOINCREM').AsString;
    Close;
  End;

  FreeAndNil(qryOutDig);
end;

function fBaixarDocumento(strNumDoc,
                          strEspDoc,
                          strCodEmp,
                          strCodCli,
                          strNumRom,
                          strNomRec: String;
                          dtaDtaBai,
                          dtaHorBai: TDateTime;
                          strEntreg: String;
                          strBaiApp: String = 'N';
                          strKMIni: String = '';
                          strKMFim: String = '';
                          strEmpRom: String = '';
                          dtaDtaRom: TDateTime = 0;
                          dtaDtaDoc: TDateTime = 0;
                          fltQtdVol: Double = 0): Boolean;
  Var
    strCodOpe: String;
    strSQL   : String;
    qryGenGer,
    qryRomDet: TUniQuery;
    strNomTab,
    strAbrDet: String;
    strAbrGer: String;
    dicLisIndDocRom: TDictionary<string, TInfDocRom>;
    recInfDocRom: TInfDocRom;
    LItem: TPair<string, TInfDocRom>;
begin
  if (dtaHorBai <> 0) And (dtaDtaBai <> 0) then
    strCodOpe := strLoginUsuarioLogado
  else
    strCodOpe := '';

  Try

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ROMGERX ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  GER_DTABAI = :DTABAI, ';
    strSQL := strSQL + '  GER_HORBAI = :HORBAI, ';
    strSQL := strSQL + '  GER_NOMREC = :NOMREC, ';
    strSQL := strSQL + '  GER_ENTREG = :ENTREG, ';
    strSQL := strSQL + '  GER_BAIAPP = :BAIAPP,  ';
    strSQL := strSQL + '  GER_KMINI = :KMINI,  ';
    strSQL := strSQL + '  GER_KMFIM = :KMFIM,  ';
    strSQL := strSQL + '  GER_OPEBAI = :OPEBAI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';

    If (strEspDoc <> 'OX') Then
      strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';

    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

    qryGenGer := fCriaQuery;
    qryGenGer.SQL.Add(strSQL);

    qryGenGer.ParamByName('ENTREG').AsInteger  := IIF(strEntreg = 'S', 1, 0);

    If (dtaDtaBai = 0) Then
      qryGenGer.ParamByName('DTABAI').Value := NULL
    Else
      qryGenGer.ParamByName('DTABAI').AsDateTime := dtaDtaBai;

    If (dtaHorBai = 0) Then
      qryGenGer.ParamByName('HORBAI').Value := NULL
    Else
      qryGenGer.ParamByName('HORBAI').AsDateTime := dtaHorBai;

    If (dtaHorBai <> 0) And (dtaDtaBai <> 0) and (not fEmptyStr(strCodOpe)) Then
      qryGenGer.ParamByName('OPEBAI').AsString := strCodOpe
    Else
      qryGenGer.ParamByName('OPEBAI').Value := NULL;

    qryGenGer.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGenGer.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGenGer.ParamByName('CODEMP').AsString := strCodEmp;

    If (strEspDoc <> 'OX') Then
      qryGenGer.ParamByName('CODCLI').AsString := strCodCli;

    qryGenGer.ParamByName('NUMROM').AsString := strNumRom;
    qryGenGer.ParamByName('EMPROM').AsString := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);

    If (fEmptyStr(strNomRec)) Then
      qryGenGer.ParamByName('NOMREC').Value := NULL
    Else
      qryGenGer.ParamByName('NOMREC').AsString := strNomRec;

    qryGenGer.ParamByName('BAIAPP').AsString := strBaiApp;

    qryGenGer.ParamByName('KMINI').AsString := strKMIni;
    qryGenGer.ParamByName('KMFIM').AsString := strKMFim;

    qryGenGer.ExecSQL;

    qryGenGer.SQL.Clear;
    qryGenGer.SQL.Add('DELETE ROMGER_RES, ROMDET_RES FROM ROMGER_RES INNER JOIN ROMDET_RES ON ROMGER_RES.GER_CODGER = ROMDET_RES.DET_SEQGER ');
    qryGenGer.SQL.Add(' WHERE ROMGER_RES.GER_NUMROM = :NUMROM AND ROMGER_RES.GER_CODEMP = :EMPROM');
    qryGenGer.ParamByName('NUMROM').AsString  := strNumRom;
    qryGenGer.ParamByName('EMPROM').AsString := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
    qryGenGer.ExecSQL;

    if (dtaDtaBai > 0) then
      fInsereDocRemovidoRomaneioParaConferencia(strNumRom, strEmpRom, strNumDoc, strEspDoc, strCodEmp, strCodCli, dtaDtaRom, dtaDtaDoc, fltQtdVol);

    If (strEspDoc <> 'OX') And
       (dtaHorBai = 0) And
       (dtaDtaBai = 0) Then
    Begin
      pRemoveDocRomaneioParaConferencia(strNumRom, strEmpRom, strNumDoc, strEspDoc, strCodEmp);

      {****************************************************************************}
      {*** Como estamos cancelando a baixa, é necessário retornar a quantidade  ***}
      {*** que estava no campo de controle "FDO/DET_QTDROM" do documento antes  ***}
      {*** da baixa ter sido efetuada                                           ***}
      {*************************************************************************BL*}
      qryRomDet       := nil;
      dicLisIndDocRom := nil;
      try
        qryRomDet       := fCriaQuery;
        dicLisIndDocRom := TDictionary<string, TInfDocRom>.Create;

        strSQL := ' SELECT '+
                  '   GER_NOMTAB, '+
                  '   GER_AUTINC, '+
                  '   DET_AUTINC, '+
                  '   (DET_QTDROM - DET_QTDBAI) AS QTDRET '+
                  ' FROM '+
                  '   ROMDETX '+
                  ' INNER JOIN ROMGERX ON '+
                  '   ROMDETX.DET_SEQGER = ROMGERX.AUTOINCREM '+
                  ' WHERE '+
                  '   DET_NUMDOC = :NUMDOC AND '+
                  '   DET_ESPDOC = :ESPDOC AND '+
                  '   DET_CODEMP = :CODEMP AND '+
                  '   DET_CODCLI = :CODCLI AND '+
                  '   DET_NUMROM = :NUMROM AND '+
                  '   DET_EMPROM = :EMPROM ';

        qryRomDet.Close;
        qryRomDet.SQL.Text := strSQL;
        qryRomDet.ParamByName('NUMDOC').AsString := strNumDoc;
        qryRomDet.ParamByName('ESPDOC').AsString := strEspDoc;
        qryRomDet.ParamByName('CODEMP').AsString := strCodEmp;
        qryRomDet.ParamByName('CODCLI').AsString := strCodCli;
        qryRomDet.ParamByName('NUMROM').AsString := strNumRom;
        qryRomDet.ParamByName('EMPROM').AsString := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
        qryRomDet.Open;
        qryRomDet.First;

        while not qryRomDet.Eof do
        begin
          strNomTab := qryRomDet.FieldByName('GER_NOMTAB').AsString;
          strAbrGer := IIF(strNomTab = 'FATGOR', 'FGO_', 'GER_');
          strAbrDet := IIF(strNomTab = 'FATGOR', 'FDO_', 'DET_');

          strNomTab := AnsiReplaceStr(strNomTab, 'FATGOR', 'FATDOR');
          strNomTab := AnsiReplaceStr(strNomTab, 'MOVGER', 'MOVDET');
          strNomTab := AnsiReplaceStr(strNomTab, 'NOTGER', 'NOTDET');

          if (Not fEmptyStr(qryRomDet.FieldByName('DET_AUTINC').AsString)) then
          begin
            qryGenGer.Close;
            qryGenGer.SQL.Text := ' UPDATE '+
                                      strNomTab+
                                  ' SET '+
                                      strAbrDet+'QTDROM = ('+strAbrDet+'QTDROM + :QTD )'+
                                  ' WHERE '+
                                  '   AUTOINCREM = :AUTINC ';

            qryGenGer.ParamByName('QTD').AsFloat     := qryRomDet.FieldByName('QTDRET').AsFloat;
            qryGenGer.ParamByName('AUTINC').AsString := qryRomDet.FieldByName('DET_AUTINC').AsString;
            qryGenGer.ExecSQL;
          end;

          if not fEmptyStr(qryRomDet.FieldByName('GER_AUTINC').AsString) then
          begin
            recInfDocRom.strIncGer := qryRomDet.FieldByName('GER_AUTINC').AsString;
            recInfDocRom.strTabGer := qryRomDet.FieldByName('GER_NOMTAB').AsString;
            recInfDocRom.strAbrGer := strAbrGer;
            recInfDocRom.strTabDet := strNomTab;
            recInfDocRom.strAbrDet := strAbrDet;

            dicLisIndDocRom.AddOrSetValue(qryRomDet.FieldByName('GER_AUTINC').AsString, recInfDocRom);
          end;

          qryRomDet.Next;
        end;

        for LItem in dicLisIndDocRom do
        begin
          qryGenGer.Close;
          qryGenGer.SQL.Text := ' SELECT '+
                                '   COUNT(AUTOINCREM) AS QTD '+
                                ' FROM  '+
                                    LItem.Value.strTabDet+
                                ' WHERE '+
                                    LItem.Value.strAbrDet+'QTDITE <> '+LItem.Value.strAbrDet+'QTDROM AND '+
                                    LItem.Value.strAbrDet+'SEQGER = :AUTINC ';

          qryGenGer.ParamByName('AUTINC').AsString := LItem.Value.strIncGer;
          qryGenGer.Open;

          if (qryGenGer.FieldByName('QTD').AsFloat = 0) then
          begin
            qryGenGer.Close;
            qryGenGer.SQL.Text := ' UPDATE '+
                                      LItem.Value.strTabGer+
                                  ' SET '+
                                      LItem.Value.strAbrGer+'NUMROM = :NUMROM '+
                                  ' WHERE '+
                                  '   AUTOINCREM = :AUTINC ';

            qryGenGer.ParamByName('NUMROM').AsString := strNumRom;
            qryGenGer.ParamByName('AUTINC').AsString := LItem.Value.strIncGer;
            qryGenGer.ExecSQL;
          end;
        end;
      finally
        If Assigned(qryRomDet) Then
          FreeAndNil(qryRomDet);
        If Assigned(dicLisIndDocRom) Then
          FreeAndNil(dicLisIndDocRom);
      end;

      qryGenGer.Close;
      qryGenGer.SQL.Text :=
      ' UPDATE '+
      '   ROMDETX '+
      ' SET '+
      '   DET_QTDBAI = DET_QTDROM, '+
      '   DET_LIBERA = "N" '+
      ' WHERE '+
      '   DET_NUMDOC = :NUMDOC AND '+
      '   DET_ESPDOC = :ESPDOC AND '+
      '   DET_CODEMP = :CODEMP AND '+
      '   DET_CODCLI = :CODCLI AND '+
      '   DET_NUMROM = :NUMROM AND '+
      '   DET_EMPROM = :EMPROM ';

      qryGenGer.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGenGer.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGenGer.ParamByName('CODEMP').AsString := strCodEmp;
      qryGenGer.ParamByName('CODCLI').AsString := strCodCli;
      qryGenGer.ParamByName('NUMROM').AsString := strNumRom;
      qryGenGer.ParamByName('EMPROM').AsString := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
      qryGenGer.ExecSQL;
    End;

    FreeAndNil(qryGenGer);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fBaixarDocumento]');
    End;
  End;
end;

function fRemoverItemDocto(strNumDoc,
                           strEspDoc,
                           strCodEmp,
                           strCodCli,
                           strNumRom,
                           strCodIte: String;
                           fltValRem,
                           fltQtdRem: Double;
                           strDetInc: String;
                           strNomTab: String): Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;
    strAbrGer: String;
    strAbrDet: String;
begin
  Try
    strAbrGer := IIF(strNomTab = 'FATGOR', 'FGO_', 'GER_');
    strAbrDet := IIF(strNomTab = 'FATGOR', 'FDO_', 'DET_');

    qryGenGer := fCriaQuery;
    With qryGenGer Do
    Begin
      strSQL := '';
      strSQL := strSQL + ' UPDATE  ';
      strSQL := strSQL + strNomTab;
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + ' ' + strAbrGer + 'NUMROM = NULL, ';
      strSQL := strSQL + ' ' + strAbrGer + 'DTAROM = NULL, ';
      strSQL := strSQL + ' ' + strAbrGer + 'HORROM = NULL, ';
      strSQL := strSQL + ' ' + strAbrGer + 'OPEROM = NULL, ';
      strSQL := strSQL + ' ' + strAbrGer + 'VALROM = (' + strAbrGer + 'VALROM - :VALREM) ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + ' ' + strAbrGer + 'NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + ' ' + strAbrGer + 'ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + ' ' + strAbrGer + 'CODEMP = :CODEMP AND ';
      strSQL := strSQL + ' ' + strAbrGer + 'CODCLI = :CODCLI     ';

      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('VALREM').AsFloat  := fltValRem;
      ExecSQL;

      strNomTab := AnsiReplaceStr(strNomTab, 'FATGOR', 'FATDOR');
      strNomTab := AnsiReplaceStr(strNomTab, 'MOVGER', 'MOVDET');
      strNomTab := AnsiReplaceStr(strNomTab, 'NOTGER', 'NOTDET');

      strSQL := '';
      strSQL := strSQL + ' UPDATE  ';
      strSQL := strSQL + strNomTab;
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + ' ' + strAbrDet + 'QTDROM = (' + strAbrDet + 'QTDROM - :QTDREM) ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + ' ' + strAbrDet + 'NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + ' ' + strAbrDet + 'ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + ' ' + strAbrDet + 'CODCLI = :CODCLI AND ';
      strSQL := strSQL + ' ' + strAbrDet + 'CODITE = :CODITE AND ';
      strSQL := strSQL + ' ' + strAbrDet + 'CODEMP = :CODEMP AND ';
      {********************************************************************************************************}
      {* FOI ADICIONADO O FILTRO DO "AUTOINCREM" POIS EM UM DOCUMENTO QUE POSSUI O MESMO ITEM MAIS DE UMA VEZ *}
      {* ESTAVA SUBTRAINDO O QTDROM DO ITEM ERRADO                                                            *}
      {*****************************************************************************************************RN*}
      strSQL := strSQL + ' AUTOINCREM = :DETINC ';

      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('QTDREM').AsFloat  := fltQtdRem;
      ParamByName('DETINC').AsString := strDetInc;
      ExecSQL;
    End;
    FreeAndNil(qryGenGer);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function fGravaLogRom(Var strAutoincrem : String;
                          strNumRom,
                          strCPOAlt,
                          strInfAnC,
                          strInfNoC: String;
                          strNumDoc: String = '';
                          strEspDoc: String = '';
                          strEmpDoc: String = '';
                          strObserv: String = '';
                          blnObsMan: Boolean = False): Boolean;
begin

  strAutoincrem := fRetAutoIncrem('LOGROM',VS_strCodEmp);

  Result := fGravaLogRom(strNumRom,
                         strCPOAlt,
                         strInfAnC,
                         strInfNoC,
                         strNumDoc,
                         strEspDoc,
                         strEmpDoc,
                         strObserv,
                         blnObsMan,
                         strAutoincrem);
end;


function fGravaLogRom(strNumRom,
                   strCPOAlt,
                   strInfAnC,
                   strInfNoC: String;
                   strNumDoc: String = '';
                   strEspDoc: String = '';
                   strEmpDoc: String = '';
                   strObserv: String = '';
                   blnObsMan: Boolean = False;
                   strAutoincrem : String  = '';
                   strEmpRom: String = ''): Boolean;
Var
  strSQL : String;
  qryGenGer: TUniQuery;
begin
  Try

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO LOGROM(';
    strSQL := strSQL + '    AUTOINCREM,    ';
    If Not strNumRom.IsEmpty  Then
      strSQL := strSQL + '  GER_NUMROM,    ';
    strSQL := strSQL + '    GER_CODEMP,    ';
    strSQL := strSQL + '    GER_DTAALT,    ';
    strSQL := strSQL + '    GER_HORALT,    ';
    strSQL := strSQL + '    GER_OPEALT,    ';
    strSQL := strSQL + '    GER_CPOALT,    ';
    strSQL := strSQL + '    GER_INFANC,    ';
    strSQL := strSQL + '    GER_INFNOC,    ';
    strSQL := strSQL + '    GER_NUMDOC,    ';
    strSQL := strSQL + '    GER_ESPDOC,    ';
    strSQL := strSQL + '    GER_EMPDOC,    ';
    strSQL := strSQL + '    GER_OBSMAN,    ';
    strSQL := strSQL + '    GER_OBSERV)    ';
    strSQL := strSQL + 'VALUES(            ';
    strSQL := strSQL + ' :AUTOIN,          ';
    If Not strNumRom.IsEmpty  Then
      strSQL := strSQL + '  :NUMROM,       ';
    strSQL := strSQL + '    :CODEMP,       ';
    strSQL := strSQL + '    :DTAALT,       ';
    strSQL := strSQL + '    :HORALT,       ';
    strSQL := strSQL + '    :OPEALT,       ';
    strSQL := strSQL + '    :CPOALT,       ';
    strSQL := strSQL + '    :INFANC,       ';
    strSQL := strSQL + '    :INFNOC,       ';
    strSQL := strSQL + '    :NUMDOC,       ';
    strSQL := strSQL + '    :ESPDOC,       ';
    strSQL := strSQL + '    :EMPDOC,       ';
    strSQL := strSQL + '    :OBSMAN,       ';
    strSQL := strSQL + '    :OBSERV)       ';

    qryGenGer := fCriaQuery;
    qryGenGer.SQL.Add(strSQL);

    if strAutoincrem.IsEmpty then
      strAutoincrem := fRetAutoIncrem('LOGROM',VS_strCodEmp);

    qryGenGer.ParamByName('AUTOIN').AsString   := strAutoincrem;

    If Not strNumRom.IsEmpty  Then
      qryGenGer.ParamByName('NUMROM').AsString := strNumRom;
    qryGenGer.ParamByName('CODEMP').AsString   := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
    qryGenGer.ParamByName('DTAALT').AsDateTime := VS_Date;
    qryGenGer.ParamByName('HORALT').AsDateTime := fTime();
    qryGenGer.ParamByName('OPEALT').AsString   := strLoginUsuarioLogado;
    qryGenGer.ParamByName('CPOALT').AsString   := strCpoAlt;
    qryGenGer.ParamByName('INFANC').AsString   := strInfAnC;
    qryGenGer.ParamByName('INFNOC').Value      := strInfNoC;

    qryGenGer.ParamByName('NUMDOC').AsString   := strNumDoc;
    qryGenGer.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryGenGer.ParamByName('EMPDOC').AsString   := strEmpDoc;
    qryGenGer.ParamByName('OBSMAN').AsString   := IIF(blnObsMan,'S','N');
    qryGenGer.ParamByName('OBSERV').AsString   := strObserv;

    qryGenGer.ExecSQL;
    FreeAndNil(qryGenGer);

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaLogRom]');
    End;
  End;

end;

function fInsereDocRemovidoRomaneioParaConferencia(const ANumRom, AEmpRom, ANumDoc, AEspDoc,
  AEmpDoc, ACodCli: String; ADtaRom, ADtaDoc: TDateTime; AQtdVol: Double): Boolean;
var
  LQry: TUniQuery;
begin
  Result := True;

  if (not fUtilizaConferenciaDocsRemovidosRomaneio) then
    Exit;

  if fVerificaInseriuDocRemovidoParaConferencia(ANumRom, AEmpRom, ANumDoc, AEspDoc, AEmpDoc) then
    Exit;

  LQry := fCriaQuery;

  try
    try
      LQry.SQL.Add('INSERT INTO ROMCNF ');
      LQry.SQL.Add('  (AUTOINCREM, RCF_NUMROM, RCF_EMPROM, RCF_NUMDOC, RCF_ESPDOC, RCF_EMPDOC, RCF_CODCLI, RCF_DTAROM, RCF_DTADOC, RCF_QTDVOL) ');
      LQry.SQL.Add('VALUES ');
      LQry.SQL.Add('  (:AUTINC, :NUMROM, :EMPROM, :NUMDOC, :ESPDOC, :EMPDOC, :CODCLI, :DTAROM, :DTADOC, :QTDVOL) ');

      LQry.ParamByName('AUTINC').AsString   := fRetAutoIncrem('ROMCNF', VS_strCodEmp);
      LQry.ParamByName('NUMROM').AsString   := ANumRom;
      LQry.ParamByName('EMPROM').AsString   := IIF(fEmptyStr(AEmpRom), VS_strCodEmp, AEmpRom);
      LQry.ParamByName('NUMDOC').AsString   := ANumDoc;
      LQry.ParamByName('ESPDOC').AsString   := AEspDoc;
      LQry.ParamByName('EMPDOC').AsString   := AEmpDoc;
      LQry.ParamByName('CODCLI').AsString   := ACodCli;
      LQry.ParamByName('DTAROM').AsDateTime := ADtaRom;
      LQry.ParamByName('DTADOC').AsDateTime := ADtaDoc;
      LQry.ParamByName('QTDVOL').AsFloat    := AQtdVol;

      LQry.ExecSQL;
    except on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[fInsereDocRemovidoRomaneioParaConferencia]');
      end;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;


procedure pRemoveDocRomaneioParaConferencia(const ANumRom, AEmpRom, ANumDoc, AEspDoc, AEmpDoc: String);
var
  LQry: TUniQuery;
begin
  if (not fUtilizaConferenciaDocsRemovidosRomaneio) then
    Exit;

  LQry := fCriaQuery;

  try
    try
      LQry.SQL.Add('DELETE FROM ROMCNF ');
      LQry.SQL.Add('WHERE RCF_NUMROM = :NUMROM ');
      LQry.SQL.Add('  AND RCF_EMPROM = :EMPROM ');
      LQry.SQL.Add('  AND RCF_NUMDOC = :NUMDOC ');
      LQry.SQL.Add('  AND RCF_ESPDOC = :ESPDOC ');
      LQry.SQL.Add('  AND RCF_EMPDOC = :EMPDOC ');

      LQry.ParamByName('NUMROM').AsString   := ANumRom;
      LQry.ParamByName('EMPROM').AsString   := IIF(fEmptyStr(AEmpRom), VS_strCodEmp, AEmpRom);
      LQry.ParamByName('NUMDOC').AsString   := ANumDoc;
      LQry.ParamByName('ESPDOC').AsString   := AEspDoc;
      LQry.ParamByName('EMPDOC').AsString   := AEmpDoc;
      LQry.ExecSQL;
    except on E: Exception do
      begin
        pMensagensErro(E.Message, '[fRemoveDocRomaneioParaConferencia]');
      end;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

function fVerificaInseriuDocRemovidoParaConferencia(const ANumRom, AEmpRom, ANumDoc, AEspDoc, AEmpDoc: String): Boolean;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;

  try
    LQry.SQL.Add('SELECT COUNT(1) QTD FROM ROMCNF ');
    LQry.SQL.Add('WHERE RCF_NUMROM = :NUMROM ');
    LQry.SQL.Add('  AND RCF_EMPROM = :EMPROM ');
    LQry.SQL.Add('  AND RCF_NUMDOC = :NUMDOC ');
    LQry.SQL.Add('  AND RCF_ESPDOC = :ESPDOC ');
    LQry.SQL.Add('  AND RCF_EMPDOC = :EMPDOC ');
    LQry.ParamByName('NUMROM').AsString   := ANumRom;
    LQry.ParamByName('EMPROM').AsString   := IIF(fEmptyStr(AEmpRom), VS_strCodEmp, AEmpRom);
    LQry.ParamByName('NUMDOC').AsString   := ANumDoc;
    LQry.ParamByName('ESPDOC').AsString   := AEspDoc;
    LQry.ParamByName('EMPDOC').AsString   := AEmpDoc;
    LQry.Open;

    Result := (LQry.FieldByName('QTD').AsInteger > 0);
  finally
    FreeAndNil(LQry);
  end;
end;

Function fRemoverRomDet(strNumRom,
                        strSeqGer,
                        strCodEmp,
                        strAutoIncrem: String;
                        strNumDoc,
                        strEspDoc,
                        strCodCli,
                        strCodOpe,
                        strCodMot: String;
                        dtaDtaRom,
                        dtaHorRom: TDateTime;
                        strCodIte: String;
                        fltQtdIte: Real;
                        fltQtdBai: Real;
                        strAutInc: String;
                        strEmpRom: String = '';
                        strNomFrm: String = '';
                        dtaDtaDoc: TDateTime = 0;
                        fltQtdVol: Double = 0): Boolean;
  Var
    qryGenGer: TUniQuery;
    blnVaiAtualizar: Boolean;
Begin
  blnVaiAtualizar := ((fltQtdBai <> fltQtdIte) And (fltQtdBai > 0));

  qryGenGer := fCriaQuery(Nil);

  Try
    With qryGenGer Do
    Begin
      If Not blnVaiAtualizar Then
      Begin
        {*** grava documento na del_romdetx ***}
        Close;
        SQL.Clear;
        SQL.Text :=
        ' SELECT * FROM ROMDETX '+
        '  WHERE DET_NUMROM = :NUMROM '+
        '    AND DET_SEQGER = :SEQGER '+
        '    AND DET_CODEMP = :CODEMP '+
        '    AND AUTOINCREM = :AUTINC ';

        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('SEQGER').AsString := strSeqGer;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('AUTINC').AsString := strAutoIncrem;
        Open;

        fVerificaIntegridade(strNomFrm, 'ROMDETX', qryGenGer);
      end;

      Close;
      SQL.Clear;

      If blnVaiAtualizar Then
      Begin
        SQL.Add(' UPDATE ');
        SQL.Add('   ROMDETX ');
        SQL.Add(' SET ');
        SQL.Add('   DET_QTDBAI = :QTDBAI ');
      End
      Else
      Begin
        SQL.Add(' DELETE ');
        SQL.Add('   FROM ROMDETX ');
      End;

      SQL.Add('  WHERE DET_NUMROM = :NUMROM ');
      SQL.Add('    AND DET_SEQGER = :SEQGER ');
      SQL.Add('    AND DET_CODEMP = :CODEMP ');
      SQL.Add('    AND AUTOINCREM = :AUTINC ');

      If (fltQtdBai <> fltQtdIte) And (fltQtdBai > 0) Then
        ParamByName('QTDBAI').AsFloat := fltQtdBai;

      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('SEQGER').AsString := strSeqGer;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('AUTINC').AsString := strAutoIncrem;
      ExecSQL;

      if fCfgSis('UTITDE', varBoolean) then
        pLimpaBaixaTransbordo(strSeqGer);

      Result := fGravaRomDetDel(strNumDoc,
                                strEspDoc,
                                strCodEmp,
                                strCodCli,
                                strNumRom,
                                strCodOpe,
                                strCodMot,
                                dtaDtaRom,
                                dtaHorRom,
                                strCodIte,
                                fltQtdIte,
                                fltQtdBai,
                                strAutInc,
                                strEmpRom);

      Result := Result and
        fInsereDocRemovidoRomaneioParaConferencia(strNumRom, strEmpRom, strNumDoc, strEspDoc, strCodEmp, strCodCli, dtaDtaRom, dtaDtaDoc, fltQtdVol);

      If (Result) Then
        Result := fAtualizaTotaisRomGer(strNumRom, strSeqGer, strCodEmp);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fRemoverRomDet]');
    End;
  End;

  FreeAndNil(qryGenGer);
End;

Function fAtualizaTotaisRomGer(strNumRom,
                               strAutoIncrem,
                               strCodEmp : String) : Boolean;

  Function fTotPro: String;
  Begin
    Result :=          ' IFNULL(  ';
    Result := Result + ' (SELECT SUM( IFNULL(DET_TOTITE,0) ) ';
    Result := Result + '   FROM ROMDETX              ';
    Result := Result + '  WHERE DET_NUMROM = :NUMROM ';
    Result := Result + '    AND DET_SEQGER = :AUTINC ';
    Result := Result + '    AND DET_CODEMP = :CODEMP) ';
    Result := Result + '       ,0)                    ';
  End;

  Function fVlrCon: String;
  Begin
    Result :=          ' IFNULL(   ';
    Result := Result + ' (SELECT SUM(IFNULL(DET_TOTITE,0) - IFNULL(DET_DESESP,0) + ';
    Result := Result + '            IFNULL(DET_TOTFRE,0) + IFNULL(DET_DESACE,0) + ';
    Result := Result + '            IFNULL(DET_VALIPI,0) + IFNULL(DET_VALRET,0) + ';
    Result := Result + '            IFNULL(DET_VALCBS,0) + IFNULL(DET_VALIBS,0) + IFNULL(DET_VAL_IS,0) ) ';
    Result := Result + '   FROM ROMDETX  ';
    Result := Result + '  WHERE DET_NUMROM = :NUMROM ';
    Result := Result + '    AND DET_SEQGER = :AUTINC ';
    Result := Result + '    AND DET_CODEMP = :CODEMP) ';
    Result := Result + '       ,0)                   ';  
  End;

  Function fPesBru: String;
  Begin
    Result :=          ' IFNULL(  ';
    Result := Result + ' (SELECT SUM( IFNULL(DET_TOTPES,0) ) ';
    Result := Result + '   FROM ROMDETX              ';
    Result := Result + '  WHERE DET_NUMROM = :NUMROM ';
    Result := Result + '    AND DET_SEQGER = :AUTINC ';
    Result := Result + '    AND DET_CODEMP = :CODEMP) ';
    Result := Result + '       ,0)                    ';
  End;

  Function fPesLiq: String;
  Begin
    Result :=          ' IFNULL(  ';
    Result := Result + ' (SELECT SUM( IFNULL(DET_PESLIQ,0) ) ';
    Result := Result + '   FROM ROMDETX              ';
    Result := Result + '  WHERE DET_NUMROM = :NUMROM ';
    Result := Result + '    AND DET_SEQGER = :AUTINC ';
    Result := Result + '    AND DET_CODEMP = :CODEMP) ';
    Result := Result + '       ,0)                    ';
  End;

  Var
    qryGenGer: TUniQuery;                               
Begin
  qryGenGer := fCriaQuery(Nil);

  Try
    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE ROMGERX ');
      SQL.Add('    SET GER_TOTPRO = ' + fTotPro + ', ' );
      SQL.Add('        GER_VLRCON = ' + fVlrCon + ', ');
      SQL.Add('        GER_PESBRU = ' + fPesBru + ', ');
      SQL.Add('        GER_PESLIQ = ' + fPesLiq );
      SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
      SQL.Add('    AND AUTOINCREM = :AUTINC ');
      SQL.Add('    AND GER_CODEMP = :CODEMP ');
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('AUTINC').AsString := strAutoIncrem;
      ParamByName('CODEMP').AsString := strCodEmp;
      ExecSQL;

      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtualizaTotaisRomGer]');
    End;
  End;  

  FreeAndNil(qryGenGer);  
End;

Function fGravaRomDel(strNumDoc,
                      strEspDoc,
                      strCodEmp,
                      strCodCli,
                      strNumRom,
                      strCodOpe,
                      strCodMot,
                      strCodCid,
                      strCodReg,
                      strCodAj1,
                      strCodAj2,
                      strCodAj3,
                      strCodAj4,
                      strObsFec,
                      strCodTra,
                      strPlaVei:String;
                      dtaDtarom,
                      dtaHorRom:TDateTime;
                      strObserv:String;
                      strEmpRom: String = ''): Boolean;
  Var
    strSQL : String;
    qryGenGer: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ROMDELX ( ';
    strSQL := strSQL + '         AUTOINCREM,  ';
    strSQL := strSQL + '         DEL_NUMDOC,  ';
    strSQL := strSQL + '         DEL_ESPDOC,  ';
    strSQL := strSQL + '         DEL_CODEMP,  ';
    strSQL := strSQL + '         DEL_CODCLI,  ';
    strSQL := strSQL + '         DEL_NUMROM,  ';
    strSQL := strSQL + '         DEL_EMPROM,  ';
    strSQL := strSQL + '         DEL_DTAROM,  ';
    strSQL := strSQL + '         DEL_HORROM,  ';
    strSQL := strSQL + '         DEL_CODVEN,  ';
    strSQL := strSQL + '         DEL_CODMOT,  ';
    strSQL := strSQL + '         DEL_CIDCON,  ';
    strSQL := strSQL + '         DEL_CODREG,  ';
    strSQL := strSQL + '         DEL_CODAJ1,  ';
    strSQL := strSQL + '         DEL_CODAJ2,  ';
    strSQL := strSQL + '         DEL_CODAJ3,  ';
    strSQL := strSQL + '         DEL_CODAJ4,  ';
    strSQL := strSQL + '         DEL_OBSFEC,  ';
    strSQL := strSQL + '         DEL_CODTRA,  ';
    strSQL := strSQL + '         DEL_OBSERV,  ';
    strSQL := strSQL + '         DEL_DTABAI,  ';
    strSQL := strSQL + '         DEL_HORBAI,  ';
    strSQL := strSQL + '         DEL_PLAVEI ) ';
    strSQL := strSQL + 'VALUES( :AUTOIN,      ';
    strSQL := strSQL + '        :NUMDOC,      ';
    strSQL := strSQL + '        :ESPDOC,      ';
    strSQL := strSQL + '        :CODEMP,      ';
    strSQL := strSQL + '        :CODCLI,      ';
    strSQL := strSQL + '        :NUMROM,      ';
    strSQL := strSQL + '        :EMPROM,      ';
    strSQL := strSQL + '        :DTAROM,      ';
    strSQL := strSQL + '        :HORROM,      ';
    strSQL := strSQL + '        :CODVEN,      ';
    strSQL := strSQL + '        :CODMOT,      ';
    strSQL := strSQL + '        :CIDCON,      ';
    strSQL := strSQL + '        :CODREG,      ';
    strSQL := strSQL + '        :CODAJ1,      ';
    strSQL := strSQL + '        :CODAJ2,      ';
    strSQL := strSQL + '        :CODAJ3,      ';
    strSQL := strSQL + '        :CODAJ4,      ';
    strSQL := strSQL + '        :OBSFEC,      ';
    strSQL := strSQL + '        :CODTRA,      ';
    strSQL := strSQL + '        :OBSERV,      ';
    strSQL := strSQL + '        :DTABAI,      ';
    strSQL := strSQL + '        :HORBAI,      ';
    strSQL := strSQL + '        :PLAVEI )     ';

    qryGenGer := fCriaQuery;
    qryGenGer.SQL.Add(strSQL);

    qryGenGer.ParamByName('AUTOIN').AsString   := fRetAutoIncrem('ROMDELX', VS_strCodEmp);
    qryGenGer.ParamByName('NUMDOC').AsString   := strNumDoc;
    qryGenGer.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryGenGer.ParamByName('CODEMP').AsString   := strCodEmp;
    qryGenGer.ParamByName('CODCLI').AsString   := strCodCli;
    qryGenGer.ParamByName('NUMROM').AsString   := strNumRom;
    qryGenGer.ParamByName('EMPROM').AsString   := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
    qryGenGer.ParamByName('DTAROM').AsDateTime := dtaDtarom;
    qryGenGer.ParamByName('HORROM').AsDateTime := dtaHorRom;
    qryGenGer.ParamByName('CODVEN').AsString   := strCodOpe;
    qryGenGer.ParamByName('CODMOT').AsString   := strCodMot;
    qryGenGer.ParamByName('CIDCON').AsString   := strCodCid;
    qryGenGer.ParamByName('CODREG').AsString   := strCodReg;
    qryGenGer.ParamByName('CODAJ1').AsString   := strCodAj1;
    qryGenGer.ParamByName('CODAJ2').AsString   := strCodAj2;
    qryGenGer.ParamByName('CODAJ3').AsString   := strCodAj3;
    qryGenGer.ParamByName('CODAJ4').AsString   := strCodAj4;
    qryGenGer.ParamByName('OBSFEC').AsString   := strObsFec;
    qryGenGer.ParamByName('CODTRA').AsString   := strCodTra;
    qryGenGer.ParamByName('PLAVEI').AsString   := strPlaVei;
    qryGenGer.ParamByName('OBSERV').AsString   := strObserv;
    qryGenGer.ParamByName('DTABAI').AsDateTime := VS_Date;
    qryGenGer.ParamByName('HORBAI').AsDateTime := fTime();

    qryGenGer.ExecSQL;
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaRomDel]');
    End;
  End;

  FreeAndNil(qryGenGer);
end;

Function fGravaRomDetDel(strNumDoc,
                         strEspDoc,
                         strCodEmp,
                         strCodCli,
                         strNumRom,
                         strCodOpe,
                         strCodMot:String;
                         dtaDtarom,
                         dtaHorRom: TDateTime;
                         strCodIte: String;
                         fltQtdIte,
                         fltQtdBai: Double;
                         strAutInc: String;
                         strEmpRom: String = ''): Boolean;
  Var
    qryGenDet : TUniQuery;
    strSQL    : String;
Begin

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO ROMITEX ( ';
  strSQL := strSQL + '         AUTOINCREM,  ';
  strSQL := strSQL + '         DET_NUMDOC,  ';
  strSQL := strSQL + '         DET_ESPDOC,  ';
  strSQL := strSQL + '         DET_CODEMP,  ';
  strSQL := strSQL + '         DET_CODCLI,  ';
  strSQL := strSQL + '         DET_NUMROM,  ';
  strSQL := strSQL + '         DET_EMPROM,  ';
  strSQL := strSQL + '         DET_DTAROM,  ';
  strSQL := strSQL + '         DET_HORROM,  ';
  strSQL := strSQL + '         DET_CODVEN,  ';
  strSQL := strSQL + '         DET_CODMOT,  ';
  strSQL := strSQL + '         DET_DTABAI,  ';
  strSQL := strSQL + '         DET_HORBAI,  ';
  strSQL := strSQL + '         DET_CODITE,  ';
  strSQL := strSQL + '         DET_QTDITE,  ';
  strSQL := strSQL + '         DET_QTDBAI,  ';
  strSQL := strSQL + '         DET_AUTINC ) ';
  strSQL := strSQL + 'VALUES( :AUTOIN,      ';
  strSQL := strSQL + '        :NUMDOC,      ';
  strSQL := strSQL + '        :ESPDOC,      ';
  strSQL := strSQL + '        :CODEMP,      ';
  strSQL := strSQL + '        :CODCLI,      ';
  strSQL := strSQL + '        :NUMROM,      ';
  strSQL := strSQL + '        :EMPROM,      ';
  strSQL := strSQL + '        :DTAROM,      ';
  strSQL := strSQL + '        :HORROM,      ';
  strSQL := strSQL + '        :CODVEN,      ';
  strSQL := strSQL + '        :CODMOT,      ';
  strSQL := strSQL + '        :DTABAI,      ';
  strSQL := strSQL + '        :HORBAI,      ';
  strSQL := strSQL + '        :CODITE,      ';
  strSQL := strSQL + '        :QTDITE,      ';
  strSQL := strSQL + '        :QTDBAI,      ';
  strSQL := strSQL + '        :AUTINC    )  ';

  qryGenDet := fCriaQuery(Nil);

  Try
    With qryGenDet Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTOIN').AsString   := fRetAutoIncrem('ROMITEX', VS_strCodEmp);
      ParamByName('NUMDOC').AsString   := strNumDoc;
      ParamByName('ESPDOC').AsString   := strEspDoc;
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('CODCLI').AsString   := strCodCli;
      ParamByName('NUMROM').AsString   := strNumRom;
      ParamByName('EMPROM').AsString   := IIF(fEmptyStr(strEmpRom), VS_strCodEmp, strEmpRom);
      ParamByName('DTAROM').AsDateTime := dtaDtarom;
      ParamByName('HORROM').AsDateTime := dtaHorRom;
      ParamByName('CODVEN').AsString   := strCodOpe;
      ParamByName('CODMOT').AsString   := strCodMot;
      ParamByName('DTABAI').AsDateTime := VS_Date;
      ParamByName('HORBAI').AsDateTime := fTime();
      ParamByName('CODITE').AsString   := strCodite;
      ParamByName('QTDITE').AsFloat    := fltQtdIte;
      ParamByName('QTDBAI').AsFloat    := fltQtdBai;
      ParamByName('AUTINC').AsString   := strAutInc;

      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaRomDetDel]');
    End;
  End;

  FreeAndNil(qryGenDet);
End;

Function fNumeroRomaneio(strNumRom: String): String;
Begin
  {***************************************************}
  {* SE FOR CÓD. DE BARRAS, EXTRAI O Nº DO DOCUMENTO *}
  {************************************************MM*}
  if Length(strNumRom) <= 6 then
    Result := RightStr(strNumRom, 6)
  else
    Result := Copy(strNumRom,2,6)

End;

function fRomaneioTotalmenteFaturado(strNumRom: String): Boolean;
  Var
    strSQL : String;
    qryGenGer: TUniQuery;
begin

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  DET_NUMFAT, DET_TIPFAT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ROMDETX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  DET_EMPROM = :EMPROM AND ';
    strSQL := strSQL + '  DET_JAFATU = 0 ';

    qryGenGer := fCriaQuery;
    With qryGenGer Do
    Begin
      SQL.Add(strSQL);
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := VS_strCodEmp;
      Open;

      Result := IsEmpty;

      Close;
    End;
  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure pImprimirRomaneio(strrNumRom: String);
  Var
    blnImprimi   : Boolean;
    blnIteDoc    : Boolean;
    blnImpVal    : Boolean;
    blnMenExp    : Boolean;
    blnEndEnt    : Boolean;
    blnProdutos  : Boolean;
    blnEmbalagens: Boolean;
    blnDocumentos: Boolean;
    blnFormas    : Boolean;
    blnItemCli   : Boolean;
    blnInfItem   : Boolean;
    blnTotEspDoc : Boolean;
    blnMosMar    : Boolean;
    blnCarCar    : Boolean;
    blnImpKm     : Boolean;
    blnVolume    : Boolean;
    blnOrdLoc    : Boolean;
    blnEmbVolume : Boolean;
    blnCliVolume : Boolean;
    strCliOrdUni : String;
    strOrdRel    : String;
    blnLocAssRec : Boolean;
    blnRotaViagem: Boolean;
begin
  blnIteDoc     := False;
  blnImpVal     := False;
  blnMenExp     := False;
  blnEndEnt     := False;
  blnItemCli    := False;
  blnInfItem    := False;
  blnProdutos   := False;
  blnEmbalagens := False;
  blnDocumentos := False;
  blnFormas     := False;
  blnTotEspDoc  := False;
  blnMosMar     := False;
  blnCarCar     := False;
  blnImpKm      := False;
  blnVolume     := False;
  blnOrdLoc     := False;
  blnEmbVolume  := False;
  blnCliVolume  := False;
  blnLocAssRec  := False;
  blnRotaViagem := False;

  Try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    blnImprimi := false;

    If fRomaneioExiste(strrNumRom) Then
    Begin
      Try
        pCriarFormularios(TfrmFatRomaneioImpr, frmFatRomaneioImpr);
        frmFatRomaneioImpr.ShowModal;
        blnImprimi    := frmFatRomaneioImpr.blnImprimi;
        blnProdutos   := frmFatRomaneioImpr.blnProdutos;
        blnEmbalagens := frmFatRomaneioImpr.blnEmbalagens;
        blnDocumentos := frmFatRomaneioImpr.blnDocumentos;
        blnFormas     := frmFatRomaneioImpr.blnFormas;
        blnItemCli    := frmFatRomaneioImpr.blnItemCli;
        blnInfItem    := frmFatRomaneioImpr.blnInfItem;
        blnTotEspDoc  := frmFatRomaneioImpr.blnTotEspDoc;
        blnMosMar     := frmFatRomaneioImpr.blnMosMar;
        blnCarCar     := frmFatRomaneioImpr.blnCarCar;
        blnImpKm      := frmFatRomaneioImpr.blnImpKm;
        blnVolume     := frmFatRomaneioImpr.edtQtdVol.Text = 'V';
        blnOrdLoc     := frmFatRomaneioImpr.edtDesLoc.Text = 'L';
        blnEmbVolume  := frmFatRomaneioImpr.edtEmbQV.Text  = 'V';
        blnCliVolume  := frmFatRomaneioImpr.edtCliQV.Text  = 'V';
        strCliOrdUni  := frmFatRomaneioImpr.edtCliOrd.Text;
        blnIteDoc     := frmFatRomaneioImpr.blnIteDoc;
        blnImpVal     := frmFatRomaneioImpr.blnImpVal;
        blnMenExp     := frmFatRomaneioImpr.blnMenExp;
        blnEndEnt     := frmFatRomaneioImpr.blnEndEnt;
        strOrdRel     := frmFatRomaneioImpr.edtDocEnd.Text;
        blnLocAssRec  := frmFatRomaneioImpr.chkLocAss.Checked;
        blnRotaViagem := frmFatRomaneioImpr.chkRotViagem.Checked;       
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmFatRomaneio.btnReimprimeRomaneioClick]');
        End;
      End;

      pFreeAndNil(frmFatRomaneioImpr);

      If blnImprimi Or blnIteDoc Or blnEndEnt Or blnItemCli Then
      Begin
        pImprimeRomaneio(strrNumRom,
                         False,
                         blnProdutos,
                         blnEmbalagens,
                         blnDocumentos,
                         blnFormas,
                         blnItemCli,
                         blnInfItem,
                         blnTotEspDoc,
                         blnMosMar,
                         blnCarCar,
                         blnImpKm,
                         blnVolume,
                         blnOrdLoc,
                         blnEmbVolume,
                         blnCliVolume,
                         strCliOrdUni,
                         blnIteDoc,
                         blnEndEnt,
                         strOrdRel,
                         blnLocAssRec,
                         blnRotaViagem,
                         blnImpVal,
                         blnMenExp);
      End;
    End
    Else
    Begin
      fMensagem('', 'Esse romaneio não está cadastrado!', ['&Ok']);
    End;

  Finally
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
  End;
end;

function fTravaDocsRomaneio(strNumRom: String; objLock: TLock): Boolean;
  Var
   TravaRomaneio: TTravaRomaneio;
begin
  Result := True;

  If (Not fEmptyStr(strNumRom)) Then
  Begin
    TravaRomaneio := TTravaRomaneio.Create(strNumRom, VS_strCodEmp, objLock);
    Try
      Result := TravaRomaneio.fTrava;
    Finally
      FreeAndNil(TravaRomaneio)
    End;
  End;
end;

{******************************************************************************}
{* UTILIZAR SEMPRE ESSA FUNÇÃO PARA TRAVAR DOCUMENTOS AQUI NO ROMANEIO        *}
{* MOTIVO: AS TROCAS PODEM TER DOIS DOCUMENTOS (ENTRADA E SAÍDA)              *}
{***************************************************************************RN*}
function fLock_UnLock_DocRomaneio(strChave: String; strEspDoc: String;
  strEntSai: String; blnTrava: Boolean; blnLoopTravamento: Boolean; objLock: TLock;
  blnExibirMensagemQuandoDocumentoTravado : Boolean = True): Boolean;

  Var
    strEntSaiInv : String;

begin
  If (strEspDoc = 'TR') Then
  Begin
    strEntSaiInv := IIF(strEntSai = 'E', 'S', 'E');

    If (blnTrava) Then
    Begin
      // Verifica a chave principal
      Result := objLock.fLock_Unlock(strChave, blnTrava, blnLoopTravamento, False, '', True, '', True, True, False, False, False);

      // Chave principa travada!
      If (Not Result) Then
      Begin
        // Se a chave do entsai oposto está travada, significa que não foi travado pelo faturamento e sim pelo romaneio!
        // Permite selecionar
        If (Not fEmptyStr(fGetHostLock(strChave + strEntSaiInv))) And
           (    fEmptyStr(fGetHostLock(strChave + strEntSai   ))) Then
          Result := objLock.fLock_Unlock(strChave + strEntSai, blnTrava, blnLoopTravamento, False, '', True, '', True, True, False, False, False);
      End
      Else
        Result := objLock.fLock_Unlock(strChave + strEntSai, blnTrava, blnLoopTravamento, False, '', True, '', True, True, False, False, False);
    End
    Else
    Begin
      // Caso houver a trava do registro oposto ao passado não remove a chave principal!
      If Not fEmptyStr(fGetHostLock(strChave + strEntSaiInv)) Then
        Result := objLock.fLock_Unlock(strChave + strEntSai, blnTrava, blnLoopTravamento, False, '', True, '', True, True, False, False, False)
      Else
      Begin
        // Remove a chave (ent/sai)
        Result := objLock.fLock_Unlock(strChave + strEntSai, blnTrava, blnLoopTravamento, False, '', True, '', True, True, False, False, False) And
        // Remove a chave principal
                  objLock.fLock_Unlock(strChave,             blnTrava, blnLoopTravamento, False, '', True, '', True, True, False, False, False)
      End;
    End;
  End
  Else
  Begin
    If blnTrava Then
    Begin
      Result := objLock.fLock_Unlock(strChave, blnTrava, blnLoopTravamento, False, '', True, '', True, True, False, False, False);

      If (Not Result) Then
      Begin
        Result := (fVerificaLockAtivo(strChave + STR_TRAVA_CONFERENCIA)) And
                  (Not fVerificaLockAtivo(strChave + STR_TRAVA_ROMANEIO));

        If Result Then
          objLock.pAdicionaTrava(strChave);
      End;

      If (Result) Then
        objLock.fLock_Unlock(strChave + STR_TRAVA_ROMANEIO, blnTrava, blnLoopTravamento, False, '', True, '', True, True, False, False, False);
    End
    Else
    Begin
      If (Not fVerificaLockAtivo(strChave + STR_TRAVA_CONFERENCIA)) Then
        objLock.fLock_Unlock(strChave, blnTrava, blnLoopTravamento, False, '', True, '', True, True, False, True, False);

      objLock.fLock_Unlock(strChave + STR_TRAVA_ROMANEIO, blnTrava, blnLoopTravamento, False, '', True, '', True, True, False, False, False);

      Result := True;
    End;
  End;

  If (blnTrava) And (Not Result) And (blnExibirMensagemQuandoDocumentoTravado) Then
    fMensagem('ATENÇÃO!', Format('Este documento [%s] do romaneio está sendo utilizado por outra estação: ' + fGetHostLock(strChave), [strChave]), ['&OK']);
end;

function fDeletaOutDigX(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    qryOutDigX : TUniQuery;
begin
  Try 
    qryOutDigX := fCriaQuery(Nil);
    Try
      With qryOutDigX Do
      Begin
        SQL.Add(' DELETE ');
        SQL.Add('   FROM OUTDIGX ');
        SQL.Add('  WHERE DIG_NUMDOC = :NUMDOC ');
        SQL.Add('    AND DIG_ESPDOC = :ESPDOC ');
        SQL.Add('    AND DIG_CODEMP = :CODEMP ');
      
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        
        ExecSQL;

        Result := True;
      End;
    Finally
      FreeAndNil(qryOutDigX);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fDeletaOutDigX]');
    End;
  End;
end;

//TProcessCRM

{ TTravaRomaneio }

constructor TTravaRomaneio.Create(strNumRom, strEmpRom: String; objLock: TLock);
begin
  FstrNumRom := strNumRom;
  FstrEmpRom := strEmpRom;
  FobjLock := objLock;
  FblnExibirMensagemAoTravarDocumento := True;
  FUltimaChaveVerificada := EmptyStr;
end;

function TTravaRomaneio.fConfirma(pgbStatus: TcxProgressBar): Boolean;
Var
  qryAux : TUniQuery;
begin
  Result := True;

  qryAux := fQueryDocumentos(Self.FstrNumRom, Self.FstrEmpRom);
  Try
    qryAux.First;
    While Not qryAux.Eof Do
    Begin
      pInformacao('Bloqueando ' + qryAux.FieldByName('NUMDOC').AsString + '-' + qryAux.FieldByName('ESPDOC').AsString + ' para uso...', pgbStatus);
      pProgresso(qryAux.RecNo, qryAux.RecordCount, pgbStatus);

      Result := (fLock_Unlock_DocRomaneio(qryAux.FieldByName('CHALCK').AsString,
                                          qryAux.FieldByName('ESPDOC').AsString,
                                          qryAux.FieldByName('ENTSAI').AsString,
                                          True,
                                          False,
                                          Self.FobjLock,
                                          FblnExibirMensagemAoTravarDocumento));

      FUltimaChaveVerificada := qryAux.FieldByName('CHALCK').AsString;

      If (Not Result) Then
        Break;

      qryAux.Next;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TTravaRomaneio.fQueryDocumentos(const strNumRom,
  strEmpRom: String): TUniQuery;
begin
  Result := fCriaQuery;
  Result.SQL.Clear;
  Result.SQL.Add('SELECT ');
  Result.SQL.Add('  CONCAT(IF(GER_NOMTAB = "","FATGOR",GER_NOMTAB), GER_NUMDOC, GER_ESPDOC, GER_CODEMP) AS CHALCK, ');
  Result.SQL.Add('  GER_NUMDOC NUMDOC, ');
  Result.SQL.Add('  GER_ESPDOC ESPDOC, ');
  Result.SQL.Add('  GER_ENTSAI ENTSAI, ');
  Result.SQL.Add('  CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS DOCUME ');
  Result.SQL.Add('FROM ');
  Result.SQL.Add('  ROMGERX ');
  Result.SQL.Add('WHERE ');
  Result.SQL.Add('  GER_EMPROM = :CODEMP AND ');
  Result.SQL.Add('  GER_NUMROM = :NUMDOC ');
  Result.ParamByName('CODEMP').AsString := strEmpRom;
  Result.ParamByName('NUMDOC').AsString := strNumRom;
  Result.Open;
end;

function TTravaRomaneio.fTrava: Boolean;
  Var
    LfrmGravando : TfrmGravando;
begin
  pCriarFormularios(TfrmGravando,LfrmGravando);
  Try
    LfrmGravando.lblGravando.Caption := 'Aguarde... Carregando.';
    LfrmGravando.strChave := 'PEDCOM';
    LfrmGravando.fExecutarAcao := fConfirma;
    LfrmGravando.ShowModal;
    Result := LfrmGravando.blnConfirma;
  finally
    pFreeAndNil(LfrmGravando);
  end;
end;

procedure TTravaRomaneio.pDestrava(strNumRom, strEmpRom: String;
  objLock: TLock);
begin
  fExecutarModal(
    function(pgbProgresso: TcxProgressBar): Boolean
      Var
        qryDocumentos : TUniQuery;
    begin
      qryDocumentos := fQueryDocumentos(strNumRom, strEmpRom);
      Try
        Result := True;
        qryDocumentos.First;
        While Not qryDocumentos.Eof Do
        Begin
          pInformacao('Destravando ' + qryDocumentos.FieldByName('NUMDOC').AsString + '-' + qryDocumentos.FieldByName('ESPDOC').AsString + ' para uso...', pgbProgresso);
          pProgresso(qryDocumentos.RecNo, qryDocumentos.RecordCount, pgbProgresso);

          If (Not objLock.fLocalizaTrava(qryDocumentos.FieldByName('CHALCK').AsString)) Then
          Begin
            qryDocumentos.Next;
            Continue;
          End;

          objLock.pDestravaChave(qryDocumentos.FieldByName('CHALCK').AsString);
          objLock.pDestravaChave(qryDocumentos.FieldByName('CHALCK').AsString + STR_TRAVA_ROMANEIO);

          qryDocumentos.Next;
        End;
      Finally
        FreeAndNil(qryDocumentos);
      End;
    end,
  'Aguarde, destravando documentos do romaneio...', '');
end;

function fRecebeTransbordo(strAutInc: String): Boolean;
var
  qryRomTra: TUniQuery;
begin
  Result := True;

  qryRomTra := fCriaQuery;
  try
    try
      qryRomTra.SQL.Text := 'SELECT * FROM ROMTRAX WHERE AUTOINCREM = :AUTOINC';
      qryRomTra.ParamByName('AUTOINC').AsString := strAutInc;
      qryRomTra.Open;

      qryRomTra.Edit;
      qryRomTra.FieldByName('TRA_DTAREC').AsDateTime := fNow;
      qryRomTra.FieldByName('TRA_HRAREC').AsDateTime := fNow;
      qryRomTra.FieldByName('TRA_OPEREC').AsString   := strLoginUsuarioLogado;
      qryRomTra.Post;
    except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fRecebeTransbordo]');
        Result := False;
      End;
    end;
  finally
    FreeAndNil(qryRomTra);
  end;
end;

procedure pLimpaBaixaTransbordo(strSeqGer: String);
var
  qryRomTrax: TUniQuery;
begin
  qryRomTrax := fCriaQuery;
  try
    qryRomTrax.Close;
    qryRomTrax.SQL.Text :=
    ' UPDATE '+
    '   ROMTRAX '+
    ' SET '+
    '   TRA_SEQ_BX = NULL '+
    ' WHERE '+
    '   AUTOINCREM = (SELECT GER_SEQTRA FROM ROMGERX WHERE AUTOINCREM = :AUTINC) ';

    qryRomTrax.ParamByName('AUTINC').AsString := strSeqGer;
    qryRomTrax.ExecSQL;
  finally
    FreeAndNil(qryRomTrax);
  end;
end;

function fBaixaTransbordo(strAutInc: String): Boolean;
var
  qryRomTra: TUniQuery;
begin
  Result := True;

  qryRomTra := fCriaQuery;
  try
    try
      qryRomTra.SQL.Text := 'SELECT * FROM ROMTRAX WHERE AUTOINCREM = :AUTOINC';
      qryRomTra.ParamByName('AUTOINC').AsString := strAutInc;
      qryRomTra.Open;

      qryRomTra.Edit;
      qryRomTra.FieldByName('TRA_SEQ_BX').AsString := 'S';
      qryRomTra.Post;
    except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fBaixaTransbordo]');
        Result := False;
      End;
    end;
  finally
    FreeAndNil(qryRomTra);
  end;
end;

function fEmpDesTransbordo(strNumRom: String): String;
Var
  strSQL : String;
  qryGenGer: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ROMTRAX.TRA_EMPDES ';
  strSQL := strSQL + ' FROM ROMTRAX ';
  strSQL := strSQL + 'INNER JOIN ROMGERX ON ROMGERX.AUTOINCREM = ROMTRAX.TRA_SEQGER ';
  strSQL := strSQL + 'WHERE GER_NUMROM = :NUMROM ';
  strSQL := strSQL + '  AND GER_EMPROM = :EMPROM ';

  qryGenGer := fCriaQuery;
  Try
    qryGenGer.SQL.Add(strSQL);
    qryGenGer.ParamByName('NUMROM').AsString := strNumRom;
    qryGenGer.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryGenGer.Open;

    Result := qryGenGer.FieldByName('TRA_EMPDES').AsString;
  Finally
    FreeAndNil(qryGenGer);
  End;

end;

function fRetornaRomaneioEmAberto(strCodMotorista: String): String;
  Var
    qryRomaneio: TUniQuery;
begin
  Result := '';
  qryRomaneio := fCriaQuery;

  Try
    Try
      qryRomaneio.Close;
      qryRomaneio.SQL.Clear;
      qryRomaneio.SQL.Text := ' SELECT                        '+
                              '    GER_NUMROM                 '+
                              '  FROM                         '+
                              '    ROMGERX                    '+
                              '  WHERE GER_DTABAI IS NULL     '+
                              '    AND GER_CODMOT = :CODMOT   ';

      qryRomaneio.ParamByName('CODMOT').AsString := strCodMotorista;
      qryRomaneio.Open;

      Result := qryRomaneio.FieldByName('GER_NUMROM').AsString;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[fRetornaRomaneioEmAberto]');
    End;
  Finally
    FreeAndNil(qryRomaneio);
  End;
end;

function fBaixaFeitaPeloAppTaEntregue(strNumRom: String): Boolean;
var
  qryRomGer: TUniQuery;
begin
  qryRomGer := fCriaQuery;
  try
    qryRomGer.SQL.Text :=
     ' SELECT '+
     '  GER_BAIAPP '+
     'FROM '+
     '  ROMGERX '+
     'WHERE '+
     '  GER_NUMROM = :NUMROM AND '+
     '  GER_EMPROM = :EMPROM '+

     ' UNION '+

     ' SELECT '+
     '  GER_BAIAPP '+
     'FROM '+
     '  DEL_ROMGERX '+
     'WHERE '+
     '  GER_NUMROM = :NUMROM AND '+
     '  GER_EMPROM = :EMPROM ';

    qryRomGer.ParamByName('NUMROM').AsString := strNumRom;
    qryRomGer.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryRomGer.Open;

    Result := qryRomGer.FieldByName('GER_BAIAPP').AsString = 'S';
  finally
    FreeAndNil(qryRomGer);
  end;
end;

function fTemDocumentoNaoLiberadoPelasPendenciasDoPainelDeEntrega(const AstrNumRom: String): Boolean;
var
  qryRomDet: TUniQuery;
begin
  qryRomDet := fCriaQuery;
  try
    qryRomDet.Close;
    qryRomDet.SQL.Text :=
    ' SELECT '+
    '   COUNT(ROMDETX.AUTOINCREM) AS QTD '+
    ' FROM '+
    '   ROMDETX '+
    ' INNER JOIN ROMGERX '+
    '   ON DET_SEQGER = ROMGERX.AUTOINCREM '+
    ' WHERE '+
    '   DET_NUMROM = :NUMROM AND '+
    '   DET_EMPROM = :EMPROM AND '+
    '   DET_QTDROM <> DET_QTDBAI AND '+
    '   DET_LIBERA = "N"     AND '+
    '   GER_BAIAPP = "S" ';

    qryRomDet.ParamByName('NUMROM').AsString := AstrNumRom;
    qryRomDet.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryRomDet.Open;

    Result := (qryRomDet.FieldByName('QTD').AsInteger > 0);
  finally
    FreeAndNil(qryRomDet);
  end;
end;

procedure pGravaTabelasDeleteRomaneio(strForm, strNumRom: String);
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  try
    qryAux.SQL.Text := 'SELECT * FROM ROMDETX WHERE DET_NUMROM = :NUMROM AND DET_EMPROM = :EMPROM ';
    qryAux.ParamByName('NUMROM').AsString := strNumRom;
    qryAux.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryAux.Open;

    if (not qryAux.IsEmpty) then
    begin
      qryAux.First;

      while not qryAux.Eof do
      begin
        fVerificaIntegridade(strForm, 'ROMDETX', qryAux);
        qryAux.Next;
      end;
    end;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'SELECT * FROM ROMGERX WHERE GER_NUMROM = :NUMROM AND GER_EMPROM = :EMPROM ';
    qryAux.ParamByName('NUMROM').AsString := strNumRom;
    qryAux.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryAux.Open;

    if (not qryAux.IsEmpty) then
    begin
      qryAux.First;

      while not qryAux.Eof do
      begin
        fInsereDocRemovidoRomaneioParaConferencia(
          qryAux.FieldByName('GER_NUMROM').AsString,
          qryAux.FieldByName('GER_EMPROM').AsString,
          qryAux.FieldByName('GER_NUMDOC').AsString,
          qryAux.FieldByName('GER_ESPDOC').AsString,
          qryAux.FieldByName('GER_CODEMP').AsString,
          qryAux.FieldByName('GER_CODCLI').AsString,
          qryAux.FieldByName('GER_DTAROM').AsDateTime,
          qryAux.FieldByName('GER_DTADOC').AsDateTime,
          qryAux.FieldByName('GER_VOLUME').AsFloat);

        fVerificaIntegridade(strForm, 'ROMGERX', qryAux);
        qryAux.Next;
      end;
    end;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'SELECT * FROM ROMOUTX WHERE OUT_NUMROM = :NUMROM AND OUT_ROMEMP = :EMPROM ';
    qryAux.ParamByName('NUMROM').AsString := strNumRom;
    qryAux.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryAux.Open;

    if (not qryAux.IsEmpty) then
    begin
      qryAux.First;

      while not qryAux.Eof do
      begin
        fVerificaIntegridade(strForm, 'ROMOUTX', qryAux);
        qryAux.Next;
      end;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

function fEntregaIniciadaPeloMotorista(strNumRom, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
begin
  Result := False;

  if (not fCfgSis('MATDIS', varBoolean)) then
    Exit;

  Result := fCampoTabela('GER_DTAINI', 'ROMGERX',
                          ['GER_NUMROM','GER_EMPROM','GER_NUMDOC','GER_ESPDOC','GER_CODEMP'],
                          [strNumRom, VS_strCodEmp, strNumDoc, strEspDoc, strCodEmp]) > 0;
end;

function fRetQtdRomDetX(const AIncDoc, ANumRom, ACodEmp: String): Double;
  Var
    qrySql: TUniQuery;
begin
  qrySql := fCriaQuery;
  try
    qrySql.SQL.Add(' SELECT DET_QTDITE');
    qrySql.SQL.Add('   FROM ROMDETX');
    qrySql.SQL.Add('  WHERE DET_AUTINC = :AUTINC ');
    qrySql.SQL.Add('    AND DET_NUMROM = :NUMROM ');
    qrySql.SQL.Add('    AND DET_EMPROM = :CODEMP ');
    qrySql.ParamByName('AUTINC').AsString := AIncDoc;
    qrySql.ParamByName('NUMROM').AsString := ANumRom;
    qrySql.ParamByName('CODEMP').AsString := ACodEmp;
    qrySql.Open;
    Result := qrySql.FieldByName('DET_QTDITE').AsFloat;
  finally
    FreeAndNil(qrySql);
  end;
end;

function fAgrupaPorAutoIncrem(strClaFis: String; blnDocTemItemRepetido: Boolean): Boolean;
begin
  Result := (Pos(strClaFis, CLAFIS_ENTFUT_VEN) > 0) Or
            (blnDocTemItemRepetido) Or
            (fUtilizaVendaMadeiraOuVidroOuMetroLinear) Or
            (fCfgSis('USPRRO', varBoolean));
end;

function fEntraBrindeETrocaNoRomaneio: Boolean;
begin
  Result := False;

  If Not (fCfgSis('TRBRRO', varBoolean)) Then
    Exit;

  If Not (fCfgSis('TIPEXP', varString) <> '5') Then
    Exit;

  Result := True;
end;

function fDocumentoTemItemRepetido(strNomTab, strNumDoc, strEspDoc, strEmpDoc: String): Boolean;
Var
  strSQL,
  strOpcRom: String;
  qryConsulta: TUniQuery;

  function fEhBrindeOuTroca : Boolean;
  begin

    Result := False;

    If Not fEntraBrindeETrocaNoRomaneio Then
      Exit;

    If Not (Pos(strEspDoc, 'BR_TR_') > 0) Then
      Exit;

    Result := True;

  end;

  function fValidaNoPedido : Boolean;
  begin

    Result := False;

    If fEhBrindeOuTroca Then
      Exit;

    Result := (Pos(strOpcRom, '1_5_') > 0) Or (SameText(strNomTab, 'FATGOR'));

  end;

begin
  strOpcRom := fCfgSis('OPCROM');
  strSQL := '';

  If (fValidaNoPedido) Then
  Begin
    strSQL := strSQL + 'SELECT FDO_CODITE ';
    strSQL := strSQL + 'FROM FATDOR ';
    strSQL := strSQL + 'WHERE FDO_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND FDO_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  AND FDO_CODEMP = :CODEMP ';
    strSQL := strSQL + 'GROUP BY FDO_CODITE, FDO_DESCRI, IFNULL(FDO_NUMLOT, "") ';
    strSQL := strSQL + 'HAVING COUNT(1) > 1 ';
  End
  Else If (strOpcRom = '2') Then
  Begin
    strSQL := strSQL + 'SELECT DET_CODITE ';
    strSQL := strSQL + 'FROM MOVDET ';
    strSQL := strSQL + 'WHERE DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';
    strSQL := strSQL + 'GROUP BY DET_CODITE, DET_DESCRI, IFNULL(DET_NUMLOT, "") ';
    strSQL := strSQL + 'HAVING COUNT(1) > 1 ';
  End
  Else
  Begin
    strSQL := strSQL + 'SELECT DET_CODITE ';
    strSQL := strSQL + 'FROM MOVDET ';
    strSQL := strSQL + 'WHERE DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';
    strSQL := strSQL + 'GROUP BY DET_CODITE, DET_DESCRI, IFNULL(DET_NUMLOT, "") ';
    strSQL := strSQL + 'HAVING COUNT(1) > 1 ';
    strSQL := strSQL + '  ';
    strSQL := strSQL + 'UNION ALL ';
    strSQL := strSQL + '  ';
    strSQL := strSQL + 'SELECT DET_CODITE ';
    strSQL := strSQL + 'FROM NOTDET ';
    strSQL := strSQL + 'WHERE DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';
    strSQL := strSQL + 'GROUP BY DET_CODITE, DET_DESCRI, IFNULL(DET_NUMLOT, "") ';
    strSQL := strSQL + 'HAVING COUNT(1) > 1 ';
  End;

  qryConsulta := fCriaQuery;
  try
    qryConsulta.SQL.Text := strSQL;
    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strEmpDoc;
    Result := fQueryEmCacheTrouxeAlgumRegistro(qryConsulta);
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function fRetSQLSeqRotaRegiao(SQLCidade: String): String;
begin
  Result := ' ';
  if fCfgSis('ROTREG', varBoolean) then
  begin
    if fEmptyStr(SQLCidade) then
      Result := ' "0" '
    else
      Result := ' ( '+
                ' SELECT REC_SEQUEN FROM ROTREC '+
                '   WHERE '+
                '     ROTREC.REC_CODCID = '+ SQLCidade +' AND '+
                '     ROTREC.REC_CODREG = CADREG.REG_CODREG '+
                '   LIMIT 1 '+
                ' ) ';

     Result := ' CAST(IFNULL('+Result+', "0") AS UNSIGNED) AS GER_SEQUEN, ';
  end;
end;

end.
