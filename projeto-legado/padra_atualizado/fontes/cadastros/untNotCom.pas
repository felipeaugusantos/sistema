unit untNotCom;

interface

Uses Classes, Uni, SysUtils, Variants, strUtils, DB, untFuncFatTypes, Shared.Functions.Types;

Type
  TTNfeComplementoItemHelper = Record Helper For TNfeComplementoItem
  Public
    Function blnItemTemValor: Boolean;
  End;

Type
  TNFeReferenciada = class
  public
    strChaveAcesso: String;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strSerie : String;
    strTip_FC: String;
    strForCli: String;
    strClaFis: String;
  end;

Type
  TNfeComplementoItensTotais = record
    fltBaseIcms  : Double;
    fltValorIcms : Double;
    fltBaseST    : Double;
    fltValorST   : Double;
    fltBaseIPI   : Double;
    fltValorIPI  : Double;
    fltValorCom  : Double;
    fltBasFcp    : Double;
    fltAlqFcp    : Double;
    fltValFcp    : Double;
    fltBasFcpST  : Double;
    fltAlqFcpST  : Double;
    fltValFcpST  : Double;
    fltIcmsOp    : Double;
    fltPerDif    : Double;
    fltIcmDif    : Double;
    strClaFis1   : String;
    strClaFis2   : String;
    strClaFis3   : String;
    recDifalFCP  : TRecDifalFCP;
  end;

Type
  TNFeComplemento = class
    private
      FNFeRef : TNFeReferenciada;
      FDocOut : Boolean;
      FIncFis : String;
      FCodFaz : String;
      FCpfCon : String;
      FDescri : String;
      FTipoNota: TTipoNotaComplemento;
      FMenNc01: String;
      FMenNc02: String;
      FMenNc03: String;
      FMenNc04: String;
      FMenNc05: String;
      FMenNc06: String;
      FMenNc07: String;
      FMenNc08: String;
      FMenNc09: String;
      FMenNc10: String;
      FItensNFe: TNfeComplementoItens;
      FfltBasFcp: Double;
      FfltValFcp: Double;
      FfltPerFcp: Double;
      FblnVenPre : Boolean;
      FstrTipFre: String;
      FTotFre: Double;
      FPerIcm: Double;
      FIcmsOp: Double;
      FPerDif: Double;
      FIcmDif: Double;
      FValIcm: Double;
      FTipFin: String;
      FCodCst: String;
      FClaTri: String;
      FMesAno: String;
      FBasCal: Double;
      FAlqCBS: Double;
      FAlqIBS: Double;
      FValCBS: Double;
      FValIBS: Double;

      function GetTemItens: Boolean;
      function GetMatrizEstaPreenchida: Boolean;
      function GetTotalItens: TNfeComplementoItensTotais;
      function GetEhNCPorProdutoAndICMCarregada: Boolean;
      function GetEhNCPorProdutoAndValCarregada: Boolean;
      function EhImportacaoFornecedor(const strClaFis, strAutIncFis : String) : Boolean;
    public
      constructor Create;
      destructor Destroy; override;

      procedure pRemoverItens;
      procedure pCarregarItens;
      procedure pRemoverNotaReferenciada;

      function fGravarNotaComplemento: Boolean;

      function fGetVenPreNFRef (strAcesso: String): Boolean;
      function fGetClaFisNFRef (strAcesso: String): String;

      property notaReferenciada   : TNFeReferenciada Read FNFeRef Write FNFeRef;

      property blnDocumentoOutros : Boolean  Read FDocOut    Write FDocOut;

      property strAutIncCadFis    : String   Read FIncFis    Write FIncFis;

      property strCodFaz          : String   Read FCodFaz    Write FCodFaz;
      property strCpfCon          : String   Read FCpfCon    Write FCpfCon;

      property strMenNc01         : String   Read FMenNc01   Write FMenNc01;
      property strMenNc02         : String   Read FMenNc02   Write FMenNc02;
      property strMenNc03         : String   Read FMenNc03   Write FMenNc03;
      property strMenNc04         : String   Read FMenNc04   Write FMenNc04;
      property strMenNc05         : String   Read FMenNc05   Write FMenNc05;
      property strMenNc06         : String   Read FMenNc06   Write FMenNc06;
      property strMenNc07         : String   Read FMenNc07   Write FMenNc07;
      property strMenNc08         : String   Read FMenNc08   Write FMenNc08;
      property strMenNc09         : String   Read FMenNc09   Write FMenNc09;
      property strMenNc10         : String   Read FMenNc10   Write FMenNc10;

      property tncTipoNota        : TTipoNotaComplemento Read FTipoNota Write FTipoNota;

      property strDescricao       : String   Read FDescri    Write FDescri;

      property blnTemItens        : Boolean  Read GetTemItens;
      property blnMatrizEstaPreenchida : Boolean Read GetMatrizEstaPreenchida;
      property TotalItens         : TNfeComplementoItensTotais Read GetTotalItens;
      property arrItensNFe        : TNfeComplementoItens Read FItensNFe Write FItensNFe;

      property blnEhNCPorProdutoAndValCarregada : Boolean  Read GetEhNCPorProdutoAndValCarregada;
      property blnEhNCPorProdutoAndICMCarregada : Boolean  Read GetEhNCPorProdutoAndICMCarregada;

      property fltBasFcp : Double read FfltBasFcp write FfltBasFcp;
      property fltPerFcp : Double read FfltPerFcp write FfltPerFcp;
      property fltValFcp : Double read FfltValFcp write FfltValFcp;
      property blnVenPre : Boolean read FblnVenPre write FblnVenPre;
      property strTipFre : String read FstrTipFre write FstrTipFre;
      property fltTotFre : Double read FTotFre write FTotFre;
      property fltPerIcm : Double read FPerIcm write FPerIcm;
      property fltIcmsOp : Double read FIcmsOp write FIcmsOp;
      property fltPerDif : Double read FPerDif write FPerDif;
      property fltIcmDif : Double read FIcmDif write FIcmDif;
      property fltValIcm : Double read FValIcm write FValIcm;
      property strTipFin : String read FTipFin write FTipFin;
      property strCodCst : String read FCodCst write FCodCst;
      property strClaTri : String read FClaTri write FClaTri;
      property strMesAno : String read FMesAno write FMesAno;
      property fltBasCal : Double read FBasCal write FBasCal;
      property fltAlqCBS : Double read FAlqCBS write FAlqCBS;
      property fltAlqIBS : Double read FAlqIBS write FAlqIBS;
      property fltValCBS : Double read FValCBS write FValCBS;
      property fltValIBS : Double read FValIBS write FValIBS;
  End;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core;
{$ELSE}
  untFuncoesSimples;
{$ENDIF}

{ TNFeComplemento }

function TNFeComplemento.GetEhNCPorProdutoAndICMCarregada: Boolean;
  Var
    itemNFe: TNfeComplementoItem;
begin
  Result := False;

  For itemNFe In FItensNFe Do
  Begin
    Result := (itemNFe.tncTipoItemNotaComplemento = tncComplementoICMS);
    If Result Then
      Break;
  End
end;

function TNFeComplemento.GetEhNCPorProdutoAndValCarregada: Boolean;
  Var
    itemNFe: TNfeComplementoItem;
begin
  Result := False;

  For itemNFe In FItensNFe Do
  Begin
    Result := (itemNFe.tncTipoItemNotaComplemento = tncComplementoValor);
    If Result Then
      Break;
  End
end;

function TNFeComplemento.GetTemItens: Boolean;
  Var
    itemNFe: TNfeComplementoItem;
begin
  Result := False;
  For itemNFe In FItensNFe Do
    If itemNFe.blnItemTemValor Then
      Result := True;
end;

function TNFeComplemento.GetMatrizEstaPreenchida: Boolean;
begin
  Result := Length(FItensNFe) > 0;
end;

function TNFeComplemento.GetTotalItens: TNfeComplementoItensTotais;
  Var
    itemNFe  : TNfeComplementoItem;
    stlClaFis: TStringList;
begin
  Try
    FillChar(Result, SizeOf(Result), #0);

    stlClaFis            := TStringList.Create;
    stlClaFis.Sorted     := True;
    stlClaFis.Duplicates := dupIgnore;

    For itemNFe In FItensNFe Do
    Begin
      Result.fltBaseIcms  := Result.fltBaseIcms  + itemNFe.fltBasIcm;
      Result.fltValorIcms := Result.fltValorIcms + itemNFe.fltValIcm;
      Result.fltBaseST    := Result.fltBaseST    + itemNFe.fltBasRet;
      Result.fltValorST   := Result.fltValorST   + itemNFe.fltValRet;
      Result.fltBaseIPI   := Result.fltBaseIPI   + itemNFe.fltBasIpi;
      Result.fltValorIPI  := Result.fltValorIPI  + itemNFe.fltValIpi;
      Result.fltValorCom  := Result.fltValorCom  + itemNFe.fltValCom;
      Result.fltBasFCP    := Result.fltBasFcp    + itemNFe.fltBasFcp;
      Result.fltValFcp    := Result.fltValFcp    + itemNFe.fltValFcp;
      Result.fltBasFcpST  := Result.fltBasFcpST  + itemNFe.fltBasFcpST;
      Result.fltValFcpST  := Result.fltValFcpST  + itemNFe.fltValFcpST;
      Result.fltIcmsOp    := Result.fltIcmsOp    + itemNFe.fltIcmsOp;
      Result.fltIcmDif    := Result.fltIcmDif    + itemNFe.fltIcmDif;

      Result.recDifalFCP.fltBasFcp := Result.recDifalFCP.fltBasFcp + itemNFe.recDifalFCP.fltBasFcp;
      Result.recDifalFCP.fltValFcp := Result.recDifalFCP.fltValFcp + itemNFe.recDifalFCP.fltValFcp;

      Result.recDifalFCP.fltBcuFde := Result.recDifalFCP.fltBasFcp + itemNFe.recDifalFCP.fltBcuFde;
      Result.recDifalFCP.fltDifDes := Result.recDifalFCP.fltValFcp + itemNFe.recDifalFCP.fltDifDes;

      stlClaFis.Add(itemNFe.strClaFis);
    End;

    If stlClaFis.Count > 0 Then Result.strClaFis1 := stlCLaFis[0];
    If stlClaFis.Count > 1 Then Result.strClaFis2 := stlCLaFis[1];
    If stlClaFis.Count > 2 Then Result.strClaFis3 := stlCLaFis[2];

  Finally
    FreeAndNil(stlClaFis);
  End;
end;

procedure TNFeComplemento.pCarregarItens;
  Var
    qryItens : TUniQuery;
    itemNFe  : TNfeComplementoItem;
    strOrdIte: String;

  procedure pSetaParametros;
  begin
    qryItens.ParamByName('NUMDOC').AsString := Self.notaReferenciada.strNumDoc;
    qryItens.ParamByName('ESPDOC').AsString := Self.notaReferenciada.strEspDoc;
    qryItens.ParamByName('CODEMP').AsString := Self.notaReferenciada.strCodEmp;
    qryItens.ParamByName('FORCLI').AsString := Self.notaReferenciada.strForCli;
  end;

begin
  Try
    qryItens := fCriaQuery;

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT ');
    qryItens.SQL.Add('  MOVDET.AUTOINCREM, ');
    qryItens.SQL.Add('  DET_CODITE, ');
    qryItens.SQL.Add('  DET_DESCRI, ');
    qryItens.SQL.Add('  DET_REFERE, ');
    qryItens.SQL.Add('  DET_CLAFIS, ');
    qryItens.SQL.Add('  DET_CODFIS, ');
    qryItens.SQL.Add('  DET_UNIDAD, ');
    qryItens.SQL.Add('  UNI_SIGUNI, ');
    qryItens.SQL.Add('  ITE_COMLUB, ');
    qryItens.SQL.Add('  DET_BASICM, ');
    qryItens.SQL.Add('  DET_ALQICM, ');
    qryItens.SQL.Add('  DET_VALICM, ');
    qryItens.SQL.Add('  DET_BASRET, ');
    qryItens.SQL.Add('  DET_ALQRET, ');
    qryItens.SQL.Add('  DET_VALRET, ');
    qryItens.SQL.Add('  DET_BASIPI, ');
    qryItens.SQL.Add('  DET_ALQIPI, ');
    qryItens.SQL.Add('  DET_VALIPI, ');
    qryItens.SQL.Add('  DET_QTDITE, ');
    qryItens.SQL.Add('  DET_DESESP, ');
    qryItens.SQL.Add('  DET_UNITAR, ');
    qryItens.SQL.Add('  DET_TOTITE, ');
    qryItens.SQL.Add('  DET_INCPIS, ');
    qryItens.SQL.Add('  DET_DTAENT, ');
    qryItens.SQL.Add('  IF(IFNULL(DET_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS DET_LOCFIS, ');
    qryItens.SQL.Add('  ICD_BCUFDE, ');
    qryItens.SQL.Add('  ICD_PERFCP, ');
    qryItens.SQL.Add('  ICD_ALQUFD, ');
    qryItens.SQL.Add('  ICD_ALQINE, ');
    qryItens.SQL.Add('  ICD_PERPAR, ');
    qryItens.SQL.Add('  ICD_VALFCP, ');
    qryItens.SQL.Add('  ICD_VALDES, ');
    qryItens.SQL.Add('  ICD_BASFCP, ');
    qryItens.SQL.Add('  ICD_VALORI, ');
    qryItens.SQL.Add('  ICD_SEQGER, ');
    qryItens.SQL.Add('  ITE_CLAIPI, ');
    qryItens.SQL.Add('  DET_PROEMB, ');
    qryItens.SQL.Add('  IF(A.IMP_SEQDET IS NULL, B.IMP_NUM_DI, A.IMP_NUM_DI) AS IMP_NUM_DI, ');
    qryItens.SQL.Add('  IF(A.IMP_SEQDET IS NULL, B.IMP_DTA_DI, A.IMP_DTA_DI) AS IMP_DTA_DI, ');
    qryItens.SQL.Add('  IF(A.IMP_SEQDET IS NULL, B.IMP_LCDESE, A.IMP_LCDESE) AS IMP_LCDESE, ');
    qryItens.SQL.Add('  IF(A.IMP_SEQDET IS NULL, B.IMP_UFDESE, A.IMP_UFDESE) AS IMP_UFDESE, ');
    qryItens.SQL.Add('  IF(A.IMP_SEQDET IS NULL, B.IMP_DTDESE, A.IMP_DTDESE) AS IMP_DTDESE, ');
    qryItens.SQL.Add('  IF(A.IMP_SEQDET IS NULL, B.IMP_VTRINT, A.IMP_VTRINT) AS IMP_VTRINT, ');
    qryItens.SQL.Add('  IF(A.IMP_SEQDET IS NULL, B.IMP_VAFRMM, A.IMP_VAFRMM) AS IMP_VAFRMM, ');
    qryItens.SQL.Add('  IF(A.IMP_SEQDET IS NULL, B.IMP_FORIMP, A.IMP_FORIMP) AS IMP_FORIMP, ');
    qryItens.SQL.Add('  IF(A.IMP_SEQDET IS NULL, B.IMP_CGCADQ, A.IMP_CGCADQ) AS IMP_CGCADQ, ');
    qryItens.SQL.Add('  IF(A.IMP_SEQDET IS NULL, B.IMP_UF_ADQ, A.IMP_UF_ADQ) AS IMP_UF_ADQ  ');
    qryItens.SQL.Add('FROM ');
    qryItens.SQL.Add('  MOVDET ');
    qryItens.SQL.Add('  INNER JOIN CADITE C ON C.ITE_CODITE = DET_CODITE ');
    qryItens.SQL.Add('  INNER JOIN CADUNI U ON U.UNI_CODUNI = DET_UNIDAD ');
    qryItens.SQL.Add('  LEFT  JOIN CADLOT L ON L.LOT_NUMLOT = DET_NUMLOT ');
    qryItens.SQL.Add('                     AND L.LOT_CODITE = DET_CODITE ');
    qryItens.SQL.Add('                     AND L.LOT_CODEMP = DET_CODEMP ');
    qryItens.SQL.Add('  LEFT  JOIN ITEGER I ON I.ITE_CODITE = DET_CODITE ');
    qryItens.SQL.Add('                     AND I.ITE_CODEMP = DET_CODEMP ');
    qryItens.SQL.Add('  LEFT JOIN MOVICD ON ICD_SEQGER = MOVDET.AUTOINCREM ');
    qryItens.SQL.Add('  LEFT JOIN DOCIMP A ON A.IMP_SEQDET = MOVDET.AUTOINCREM ');
    qryItens.SQL.Add('  LEFT JOIN DOCIMP B ON B.IMP_SQMVDT = MOVDET.AUTOINCREM ');
    qryItens.SQL.Add('WHERE ');
    qryItens.SQL.Add('  IFNULL(DET_PROEMB, "") <> "S" AND ');
    qryItens.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
    qryItens.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
    qryItens.SQL.Add('  DET_CODEMP = :CODEMP AND ');

    If Self.notaReferenciada.strTip_FC = 'C' Then
      qryItens.SQL.Add('  DET_CODCLI = :FORCLI ')
    Else
      qryItens.SQL.Add('  DET_CODFOR = :FORCLI ');

    strOrdIte := fCfgSis('ORDALF', varString);

    If (strOrdIte = 'A') Then      //ORDEM (A)LFABETICA
      qryItens.SQL.Add('  ORDER BY DET_DESCRI, MOVDET.AUTOINCREM ')
    Else If (strOrdIte = 'C') Then //ORDEM (C)ODIGO DO ITEM
      qryItens.SQL.Add('  ORDER BY DET_CODITE, MOVDET.AUTOINCREM ')
    Else If (strOrdIte = 'U') Then //ORDEM (U)NIDADE + DESCRIÇÃO
      qryItens.SQL.Add('  ORDER BY UNI_SIGUNI, DET_DESCRI, MOVDET.AUTOINCREM ')
    Else If (strOrdIte = 'F') Then // ORDEM (F)ORNECEDOR DO ITEM
      qryItens.SQL.Add('  ORDER BY DET_FORITE, MOVDET.AUTOINCREM ')
    Else If (strOrdIte = 'L') Then // ORDEM (L)OCALIZACAO FISICA
      qryItens.SQL.Add('  ORDER BY DET_LOCFIS, MOVDET.AUTOINCREM ')
    Else If (strOrdIte = 'P') Then // ORDEM (P)ESO UNIDADE + UNIDADE + DESCRIÇÃO DO PRODUTO
      qryItens.SQL.Add('  ORDER BY UNI_PESLIT, UNI_SIGUNI, DET_DESCRI, MOVDET.AUTOINCREM ');

    pSetaParametros;
    qryItens.Open;

    If qryItens.IsEmpty Then
    Begin
      qryItens.SQL.Text := AnsiReplaceStr(AnsiReplaceStr(qryItens.SQL.Text, 'MOVDET', 'NOTDET'), 'MOVICD', 'NOTICD');
      pSetaParametros;
      qryItens.Open;
    End;

    SetLength(FItensNFe, 0);

    qryItens.First;

    While Not qryItens.Eof Do
    Begin
      itemNFe.strAutInc := qryItens.FieldByName('AUTOINCREM').AsString;
      itemNFe.strCodIte := qryItens.FieldByName('DET_CODITE').AsString;
      itemNFe.strDesIte := qryItens.FieldByName('DET_DESCRI').AsString;
      itemNFe.strRefere := qryItens.FieldByName('DET_REFERE').AsString;
      itemNFe.strClaFis := qryItens.FieldByName('DET_CLAFIS').AsString;
      itemNFe.strUnidad := qryItens.FieldByName('DET_UNIDAD').AsString;
      itemNFe.strSigUni := qryItens.FieldByName('UNI_SIGUNI').AsString;
      itemNFe.strComLub := qryItens.FieldByName('ITE_COMLUB').AsString;
      itemNFe.strCstOri := qryItens.FieldByName('DET_CODFIS').AsString;
      itemNFe.strCodFis := qryItens.FieldByName('DET_CODFIS').AsString;
      itemNFe.strClaIpi := qryItens.FieldByName('ITE_CLAIPI').AsString;

      itemNFe.fltQtdIte := qryItens.FieldByName('DET_QTDITE').AsFloat;
      itemNFe.fltDesEsp := qryItens.FieldByName('DET_DESESP').AsFloat;
      itemNFe.fltValUni := qryItens.FieldByName('DET_UNITAR').AsFloat;
      itemNFe.fltTotIte := qryItens.FieldByName('DET_TOTITE').AsFloat;

      itemNFe.fltBasIcm := 0.00;
      itemNFe.fltAlqIcm := 0.00;
      itemNFe.fltValIcm := 0.00;

      itemNFe.fltBasRet := 0.00;
      itemNFe.fltAlqRet := 0.00;
      itemNFe.fltValRet := 0.00;

      itemNFe.fltBasFcpST := 0.00;
      itemNFe.fltAlqFcpST := 0.00;
      itemNFe.fltValFcpST := 0.00;

      itemNFe.fltBasFcp := 0.00;
      itemNFe.fltAlqFcp := 0.00;
      itemNFe.fltValFcp := 0.00;

      itemNFe.fltBasIpi := 0.00;
      itemNFe.fltAlqIpi := 0.00;
      itemNFe.fltValIpi := 0.00;

      itemNFe.fltSICMEF := 0.00;
      itemNFe.fltBSTANT := 0.00;
      itemNFe.fltVSTANT := 0.00;

      itemNFe.fltValCom := 0.00;

      itemNFe.fltBasIcmOri := qryItens.FieldByName('DET_BASICM').AsFloat;
      itemNFe.fltAlqIcmOri := qryItens.FieldByName('DET_ALQICM').AsFloat;
      itemNFe.fltValIcmOri := qryItens.FieldByName('DET_VALICM').AsFloat;

      itemNFe.fltBasRetOri := qryItens.FieldByName('DET_BASRET').AsFloat;
      itemNFe.fltAlqRetOri := qryItens.FieldByName('DET_ALQRET').AsFloat;
      itemNFe.fltValRetOri := qryItens.FieldByName('DET_VALRET').AsFloat;

      itemNFe.fltBasIpiOri := qryItens.FieldByName('DET_BASIPI').AsFloat;
      itemNFe.fltAlqIpiOri := qryItens.FieldByName('DET_ALQIPI').AsFloat;
      itemNFe.fltValIpiOri := qryItens.FieldByName('DET_VALIPI').AsFloat;

      itemNFe.strCstPis := '';
      itemNFe.fltBasPis := 0;
      itemNFe.fltAlqPis := 0;
      itemNFe.fltValPis := 0;

      itemNFe.strCstCof := '';
      itemNFe.fltBasCof := 0;
      itemNFe.fltAlqCof := 0;
      itemNFe.fltValCof := 0;

      itemNFe.strIncPis := qryItens.FieldByName('DET_INCPIS').AsString;
      itemNFe.dtaDtaEnt := qryItens.FieldByName('DET_DTAENT').AsDateTime;

      itemNFe.tncTipoItemNotaComplemento := tncNenhum;

      itemNFe.recDifalFCP.fltDifDes := qryItens.FieldByName('ICD_VALDES').AsFloat;
      itemNFe.recDifalFCP.fltDifOri := qryItens.FieldByName('ICD_VALORI').AsFloat;
      itemNFe.recDifalFCP.fltValFcp := qryItens.FieldByName('ICD_VALFCP').AsFloat;
      itemNFe.recDifalFCP.fltPerFcp := qryItens.FieldByName('ICD_PERFCP').AsFloat;
      itemNFe.recDifalFCP.fltAlqIne := qryItens.FieldByName('ICD_ALQINE').AsFloat;
      itemNFe.recDifalFCP.fltAlqUfd := qryItens.FieldByName('ICD_ALQUFD').AsFloat;
      itemNFe.recDifalFCP.fltBcuFde := qryItens.FieldByName('ICD_BCUFDE').AsFloat;
      itemNFe.recDifalFCP.fltPerPar := qryItens.FieldByName('ICD_PERPAR').AsFloat;
      itemNFe.recDifalFCP.fltBasFcp := qryItens.FieldByName('ICD_BASFCP').AsFloat;
      itemNFe.recDifalFCP.blnGrvInf := (Not fEmptyStr(qryItens.FieldByName('ICD_SEQGER').AsString));

      itemNFe.strNum_DI := qryItens.FieldByName('IMP_NUM_DI').AsString;
      itemNFe.dtaDta_DI := qryItens.FieldByName('IMP_DTA_DI').AsDateTime;
      itemNFe.strLcdEse := qryItens.FieldByName('IMP_LCDESE').AsString;
      itemNFe.strUfdEse := qryItens.FieldByName('IMP_UFDESE').AsString;
      itemNFe.dtaDtdEse := qryItens.FieldByName('IMP_DTDESE').AsDateTime;
      itemNFe.strVtrInt := qryItens.FieldByName('IMP_VTRINT').AsString;
      itemNFe.fltVaFRMM := qryItens.FieldByName('IMP_VAFRMM').AsFloat;
      itemNFe.strForImp := qryItens.FieldByName('IMP_FORIMP').AsString;
      itemNFe.strCgcAdq := qryItens.FieldByName('IMP_CGCADQ').AsString;
      itemNFe.strUf_Adq := qryItens.FieldByName('IMP_UF_ADQ').AsString;

      SetLength(FItensNFe, Length(FItensNFe) + 1);
      FItensNFe[Length(FItensNFe) - 1] := itemNFe;

      qryItens.Next;
    End;

  Finally
    FreeAndNil(qryItens);
  End;
end;

procedure TNFeComplemento.pRemoverItens;
begin
  SetLength(FItensNFe, 0);
end;

procedure TNFeComplemento.pRemoverNotaReferenciada;
begin
  notaReferenciada.strChaveAcesso := '';
  notaReferenciada.strNumDoc := '';
  notaReferenciada.strEspDoc := '';
  notaReferenciada.strCodEmp := '';
  notaReferenciada.strSerie  := '';
  notaReferenciada.strTip_FC := '';
  notaReferenciada.strForCli := '';
  notaReferenciada.strClaFis := '';
end;

constructor TNFeComplemento.Create;
begin
  inherited;
  FNFeRef := TNFeReferenciada.Create;
end;

destructor TNFeComplemento.Destroy;
begin
  FreeAndNil(FNFeRef);
  inherited;
end;

function TNFeComplemento.EhImportacaoFornecedor(const strClaFis, strAutIncFis: String): Boolean;
begin
  Result := False;
  If fEmptyStr(strClaFis) Then
    Exit;
  If (LeftStr(strClaFis, 1) <> '3') Then
    Exit;
  If (fEmptyStr(strAutIncFis)) Then
    Exit;
  Result := (fCampoTabela('FIS_TIP_FC', 'CADFIS', ['AUTOINCREM'], [strAutIncFis], True) = 'F');
end;

function TNFeComplemento.fGetVenPreNFRef(strAcesso: String): Boolean;
  Var
    qryCadFis : TUniQuery;
begin
  Result := False;

  if fEmptyStr(strAcesso) then
    exit;

  qryCadFis := fCriaQuery(nil);
  Try
    qryCadFis.Close;
    qryCadFis.SQL.Clear;
    qryCadFis.SQL.Add(' SELECT AUX_VENPRE ');
    qryCadFis.SQL.Add('   FROM CADFIS ');
    qryCadFis.SQL.Add('   JOIN MOVGER ON FIS_NUMDOC = GER_NUMDOC ');
    qryCadFis.SQL.Add('              AND FIS_ESPDOC = GER_ESPDOC ');
    qryCadFis.SQL.Add('              AND FIS_CODEMP = GER_CODEMP ');
    qryCadFis.SQL.Add('              AND FIS_FORCLI = GER_CODCLI ');
    qryCadFis.SQL.Add('              AND FIS_SERIE_ = GER_SERIE_ ');
    qryCadFis.SQL.Add('              AND FIS_TIP_FC = "C" ');
    qryCadFis.SQL.Add('   JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ');
    qryCadFis.SQL.Add('  WHERE FIS_ACESSO = :ACESSO ');
    qryCadFis.ParamByName('ACESSO').AsString := strAcesso;
    qryCadFis.Open;

    if qryCadFis.isEmpty then
    begin
      qryCadFis.Close;
      qryCadFis.SQL.Text := AnsiReplaceStr(AnsiReplaceStr(qryCadFis.SQL.Text, 'MOVGER', 'NOTGER'), 'AUXMOV', 'AUXNOT');
      qryCadFis.ParamByName('ACESSO').AsString := strAcesso;
      qryCadFis.Open;
    end;

    Result := (qryCadFis.FieldByName('AUX_VENPRE').AsString = 'S');

    qryCadFis.Close;
  Finally
    FreeAndNil(qryCadFis);
  End;
end;

function TNFeComplemento.fGetClaFisNFRef(strAcesso: String): String;
  Var
    qryCadFis : TUniQuery;
begin
  Result := '';

  if fEmptyStr(strAcesso) then
    exit;

  qryCadFis := fCriaQuery(nil);
  Try
    qryCadFis.Close;
    qryCadFis.SQL.Clear;
    qryCadFis.SQL.Add(' SELECT GER_CLAFIS ');
    qryCadFis.SQL.Add('   FROM CADFIS ');
    qryCadFis.SQL.Add('   JOIN MOVGER ON FIS_NUMDOC = GER_NUMDOC ');
    qryCadFis.SQL.Add('              AND FIS_ESPDOC = GER_ESPDOC ');
    qryCadFis.SQL.Add('              AND FIS_CODEMP = GER_CODEMP ');
    qryCadFis.SQL.Add('              AND ((FIS_FORCLI = GER_CODFOR) OR (FIS_FORCLI = GER_CODCLI)) ');
    qryCadFis.SQL.Add('              AND FIS_SERIE_ = GER_SERIE_ ');
    qryCadFis.SQL.Add('              AND FIS_TIP_FC = GER_TIP_FC ');
    qryCadFis.SQL.Add('   JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ');
    qryCadFis.SQL.Add('  WHERE FIS_ACESSO = :ACESSO ');
    qryCadFis.ParamByName('ACESSO').AsString := strAcesso;
    qryCadFis.Open;

    if qryCadFis.isEmpty then
    begin
      qryCadFis.Close;
      qryCadFis.SQL.Text := AnsiReplaceStr(AnsiReplaceStr(qryCadFis.SQL.Text, 'MOVGER', 'NOTGER'), 'AUXMOV', 'AUXNOT');
      qryCadFis.ParamByName('ACESSO').AsString := strAcesso;
      qryCadFis.Open;
    end;

    If Not qryCadFis.IsEmpty Then
      Result := (qryCadFis.FieldByName('GER_CLAFIS').AsString);

    qryCadFis.Close;
  Finally
    FreeAndNil(qryCadFis);
  End;
end;

function TNFeComplemento.fGravarNotaComplemento: Boolean;
  Var
    qryNotCom: TUniQuery;
    qryIteCom: TUniQuery;
    qryComIcd: TUniQuery;
    itemNFeComp: TNfeComplementoItem;
begin
  Result := True;
  Try
    Try
      qryNotCom := fCriarQuery('SELECT * FROM NOTCOM WHERE FALSE');

      With qryNotCom Do
      Begin
        Open;
        Append;
        FieldByName('GER_CODEMP').AsString := VS_strCodEmp;
        FieldByName('GER_SEQGER').AsString := Self.strAutIncCadFis;
        FieldByName('GER_DOCORI').AsString := Self.notaReferenciada.strNumDoc;

        If fEmptyStr(Self.notaReferenciada.strCodEmp) Then
          FieldByName('GER_EMPORI').AsString := VS_strCodEmp
        Else
          FieldByName('GER_EMPORI').AsString := Self.notaReferenciada.strCodEmp;

        FieldByName('GER_ESPORI').AsString := Self.notaReferenciada.strEspDoc;
        FieldByName('GER_SERORI').AsString := Self.notaReferenciada.strSerie;
        FieldByName('GER_ACEORI').AsString := Self.notaReferenciada.strChaveAcesso;
        FieldByName('GER_DESITE').AsString := Self.strDescricao;
        FieldByName('GER_MENC01').AsString := Self.strMenNc01;
        FieldByName('GER_MENC02').AsString := Self.strMenNc02;
        FieldByName('GER_MENC03').AsString := Self.strMenNc03;
        FieldByName('GER_MENC04').AsString := Self.strMenNc04;
        FieldByName('GER_MENC05').AsString := Self.strMenNc05;
        FieldByName('GER_MENC06').AsString := Self.strMenNc06;
        FieldByName('GER_MENC07').AsString := Self.strMenNc07;
        FieldByName('GER_MENC08').AsString := Self.strMenNc08;
        FieldByName('GER_MENC09').AsString := Self.strMenNc09;
        FieldByName('GER_MENC10').AsString := Self.strMenNc10;

        If fEmptyStr(Self.strCpfCon) Then
          qryNotCom.FieldByName('GER_CPFCON').Value := Null
        Else
          qryNotCom.FieldByName('GER_CPFCON').AsString := Self.strCpfCon;

        If fEmptyStr(strCodFaz) Then
          qryNotCom.FieldByName('GER_CODFAZ').Value := Null
        Else
          qryNotCom.FieldByName('GER_CODFAZ').AsString := strCodFaz;

        FieldByName('GER_CREICM').AsString := IIF(Self.tncTipoNota In [tncCreditoICMS], 'S', 'N');

        FieldByName('GER_TRAICM').AsString := IIF(Self.tncTipoNota In [tncTransferenciaCredorICMS,
                                                                       tncTransferenciaDevedorICMS], 'S', 'N');

        FieldByName('GER_COMICM').AsString := IIF(Self.tncTipoNota In [tncComplementoICMS,
                                                                       tncComplementoIPI], 'S', 'N');

        FieldByName('GER_COMVAL').AsString := IIF(Self.blnTemItens, 'S', 'N');

        FieldByName('GER_RESICM').AsString := IIF(Self.tncTipoNota In [tncRestIcmsStEstoque], 'S', 'N');

        FieldByName('GER_COMEST').AsString := IIF(Self.tncTipoNota In [tncEstornoDeCredito], 'S', 'N');

        FieldByName('GER_COMDFL').AsString := IIF(Self.tncTipoNota In [tncComplementoDifalFcp], 'S', 'N');

        FieldByName('GER_COMCNC').AsString := IIF(Self.tncTipoNota In [tncComplementoStPerfilCnc], 'S', 'N');

        FieldByName('GER_AJUMAI').AsString := IIF(Self.tncTipoNota In [tncNFAjusteICMSaMaior], 'S', 'N');

        FieldByName('GER_COMFRE').AsString := IIF(Self.tncTipoNota In [tncComplementoFrete], 'S', 'N');

        If Assigned(FindField('GER_FINDEB')) then
          FieldByName('GER_FINDEB').AsString := IIF(Self.tncTipoNota In [tncReformaTributariaDebito], 'S', 'N');

        If Assigned(FindField('GER_FINCRE')) then
          FieldByName('GER_FINCRE').AsString := IIF(Self.tncTipoNota In [tncReformaTributariaCredito], 'S', 'N');

        If Assigned(FindField('GER_TIPFIN')) then
          FieldByName('GER_TIPFIN').AsString := strTipFin;

        If Assigned(FindField('GER_CODCST')) then
          FieldByName('GER_CODCST').AsString := strCodCst;

        If Assigned(FindField('GER_CLATRI')) then
          FieldByName('GER_CLATRI').AsString := strClaTri;

        If Assigned(FindField('GER_MESANO')) then
          FieldByName('GER_MESANO').AsString := strMesAno;

        If Assigned(FindField('GER_BASCAL')) then
          FieldByName('GER_BASCAL').AsFloat := fltBasCal;

        If Assigned(FindField('GER_ALQCBS')) then
          FieldByName('GER_ALQCBS').AsFloat := fltAlqCBS;

        If Assigned(FindField('GER_ALQIBS')) then
          FieldByName('GER_ALQIBS').AsFloat := fltAlqIBS;

        If Assigned(FindField('GER_VALCBS')) then
          FieldByName('GER_VALCBS').AsFloat := fltValCBS;

        If Assigned(FindField('GER_VALIBS')) then
          FieldByName('GER_VALIBS').AsFloat := fltValIBS;

        If Assigned(FindField('GER_PERFCP')) then
          FieldByName('GER_PERFCP').AsFloat := fltPerFcp;

        If Assigned(FindField('GER_VALFCP')) then
          FieldByName('GER_VALFCP').AsFloat := fltValFcp;

        If Assigned(FindField('GER_BASFCP')) then
          FieldByName('GER_BASFCP').AsFloat := fltBasFcp;

        If Assigned(FindField('GER_VENPRE')) then
          FieldByName('GER_VENPRE').AsString := IIF(blnVenPre, 'S', 'N');

        If Assigned(FindField('GER_TIPFRE')) then
          FieldByName('GER_TIPFRE').AsString := strTipFre;

        If Assigned(FindField('GER_TOTFRE')) then
          FieldByName('GER_TOTFRE').AsFloat := fltTotFre;

        If Assigned(FindField('GER_PERICM')) then
          FieldByName('GER_PERICM').AsFloat := fltPerIcm;

        If Assigned(FindField('GER_ICMSOP')) then
          FieldByName('GER_ICMSOP').AsFloat := fltIcmsOp;

        If Assigned(FindField('GER_PERDIF')) then
          FieldByName('GER_PERDIF').AsFloat := fltPerDif;

        If Assigned(FindField('GER_ICMDIF')) then
          FieldByName('GER_ICMDIF').AsFloat := fltIcmDif;

        If Assigned(FindField('GER_VALICM')) then
          FieldByName('GER_VALICM').AsFloat := fltValIcm;

        Post;
      End;

    Finally
      FreeAndNil(qryNotCom);
    End;

    If Self.blnTemItens Then
    Begin
      Try
        qryIteCom := fCriarQuery('SELECT * FROM ITECOM WHERE FALSE');
        qryComIcd := fCriarQuery('SELECT * FROM COMICD WHERE FALSE');

        With qryIteCom Do
        Begin
          Open;

          qryComIcd.Open;

          For itemNfeComp In Self.arrItensNFe Do
          Begin
            If Not itemNfeComp.blnItemTemValor Then
              Continue;

            Append;

            FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ITECOM', VS_strCodEmp);
            FieldByName('ITC_SEQFIS').AsString := Self.strAutIncCadFis;
            FieldByName('ITC_CODITE').AsString := itemNfeComp.strCodIte;
            FieldByName('ITC_DESCRI').AsString := itemNfeComp.strDesIte;
            FieldByName('ITC_REFERE').AsString := itemNfeComp.strRefere;
            FieldByName('ITC_CODFIS').AsString := itemNfeComp.strCodFis;
            FieldByName('ITC_CLAFIS').AsString := itemNfeComp.strClaFis;
            FieldByName('ITC_UNIDAD').AsString := itemNfeComp.strUnidad;
            FieldByName('ITC_QTDITE').AsFloat  := itemNfeComp.fltQtdIte;
            FieldByName('ITC_UNITAR').AsFloat  := itemNfeComp.fltUnitar;
            FieldByName('ITC_BASICM').AsFloat  := itemNfeComp.fltBasIcm;
            FieldByName('ITC_ALQICM').AsFloat  := itemNfeComp.fltAlqIcm;
            FieldByName('ITC_VALICM').AsFloat  := itemNfeComp.fltValIcm;
            FieldByName('ITC_BASRET').AsFloat  := itemNfeComp.fltBasRet;
            FieldByName('ITC_ALQRET').AsFloat  := itemNfeComp.fltAlqRet;
            FieldByName('ITC_VALRET').AsFloat  := itemNfeComp.fltValRet;
            FieldByName('ITC_BASIPI').AsFloat  := itemNfeComp.fltBasIpi;
            FieldByName('ITC_ALQIPI').AsFloat  := itemNfeComp.fltAlqIpi;
            FieldByName('ITC_VALIPI').AsFloat  := itemNfeComp.fltValIpi;
            FieldByName('ITC_VALCOM').AsFloat  := itemNfeComp.fltValCom;
            FieldByName('ITC_CSTPIS').AsString := itemNfeComp.strCstPis;
            FieldByName('ITC_BASPIS').AsFloat  := itemNfeComp.fltBasPis;
            FieldByName('ITC_ALQPIS').AsFloat  := itemNfeComp.fltAlqPis;
            FieldByName('ITC_VALPIS').AsFloat  := itemNfeComp.fltValPis;
            FieldByName('ITC_CSTCOF').AsString := itemNfeComp.strCstCof;
            FieldByName('ITC_BASCOF').AsFloat  := itemNfeComp.fltBasCof;
            FieldByName('ITC_ALQCOF').AsFloat  := itemNfeComp.fltAlqCof;
            FieldByName('ITC_VALCOF').AsFloat  := itemNfeComp.fltValCof;
            FieldByName('ITC_BFCPST').AsFloat  := itemNfeComp.fltBasFcpST;
            FieldByName('ITC_PFCPST').AsFloat  := itemNfeComp.fltAlqFcpST;
            FieldByName('ITC_VFCPST').AsFloat  := itemNfeComp.fltValFcpST;
            FieldByName('ITC_SICMEF').AsFloat  := itemNfeComp.fltSICMEF;
            FieldByName('ITC_BSTANT').AsFloat  := itemNfeComp.fltBSTANT;
            FieldByName('ITC_VSTANT').AsFloat  := itemNfeComp.fltVSTANT;
            FieldByName('ITC_OUTICM').AsFloat  := itemNfeComp.fltOutIcm;
            FieldByName('ITC_ISEICM').AsFloat  := itemNfeComp.fltIseIcm;
            FieldByName('ITC_ICMSOP').AsFloat  := itemNfeComp.fltIcmsOp;
            FieldByName('ITC_PERDIF').AsFloat  := itemNfeComp.fltPerDif;
            FieldByName('ITC_ICMDIF').AsFloat  := itemNfeComp.fltIcmDif;
            FieldByName('ITC_NUM_DI').AsString   := itemNfeComp.strNum_DI;
            FieldByName('ITC_DTA_DI').AsDateTime := itemNfeComp.dtaDta_DI;
            FieldByName('ITC_LCDESE').AsString   := itemNfeComp.strLcdEse;
            FieldByName('ITC_UFDESE').AsString   := itemNfeComp.strUfdEse;
            FieldByName('ITC_DTDESE').AsDateTime := itemNfeComp.dtaDtdEse;
            FieldByName('ITC_VTRINT').AsString   := itemNfeComp.strVtrInt;
            FieldByName('ITC_VAFRMM').AsFloat    := itemNfeComp.fltVaFRMM;
            FieldByName('ITC_FORIMP').AsString   := itemNfeComp.strForImp;
            FieldByName('ITC_CGCADQ').AsString   := itemNfeComp.strCgcAdq;
            FieldByName('ITC_UF_ADQ').AsString   := itemNfeComp.strUf_Adq;

            Post;

            If Not EhImportacaoFornecedor(itemNfeComp.strClaFis, Self.strAutIncCadFis) Then
            Begin
              qryComIcd.Insert;
              qryComIcd.FieldByName('ICD_SEQITE').AsString := qryIteCom.FieldByName('AUTOINCREM').AsString;
              qryComIcd.FieldByName('ICD_ALQINE').AsFloat := itemNfeComp.recDifalFCP.fltAlqIne;
              qryComIcd.FieldByName('ICD_ALQUFD').AsFloat := itemNfeComp.recDifalFCP.fltAlqUfd;
              qryComIcd.FieldByName('ICD_BCUFDE').AsFloat := itemNfeComp.recDifalFCP.fltBcuFde;
              qryComIcd.FieldByName('ICD_PERFCP').AsFloat := itemNfeComp.recDifalFCP.fltPerFcp;
              qryComIcd.FieldByName('ICD_PERPAR').AsFloat := itemNfeComp.recDifalFCP.fltPerPar;
              qryComIcd.FieldByName('ICD_VALDES').AsFloat := itemNfeComp.recDifalFCP.fltDifDes;
              qryComIcd.FieldByName('ICD_VALFCP').AsFloat := itemNfeComp.recDifalFCP.fltValFcp;
              qryComIcd.FieldByName('ICD_VALORI').AsFloat := itemNfeComp.recDifalFCP.fltDifOri;
              qryComIcd.FieldByName('ICD_BASFCP').AsFloat := itemNfeComp.recDifalFCP.fltBasFcp;
              qryComIcd.Post;
            End;
          End;

        End;

      Finally
        FreeAndNil(qryIteCom);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravarNotaComplemento]');
    End;
  End;
end;

{ TTNfeComplementoItemHelper }

Function TTNfeComplementoItemHelper.blnItemTemValor: Boolean;
begin
  Result := (fltValIcm + fltValRet + fltValFcpST + fltValIpi + fltValCom + recDifalFCP.fltValFcp + recDifalFCP.fltDifDes + fltVSTANT + fltSICMEF) > 0;
end;

end.
