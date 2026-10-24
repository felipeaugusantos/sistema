unit untFatOrdProTintaMaquina;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  UniClientDataSet, frxClass, frxDMPClass, Forms,
  ComCtrls, UniDataSetProvider,
{$ENDIF}
  Uni, SysUtils,
  StrUtils, Math, Variants,
  untIFatOrdProTintaMaquina, untTipoTinta, untTypesSistema;

Type
  TFatOrdProTintaMaquina = class(TInterfacedObject, IFatOrdProTintaMaquina)
    private
      FNumDoc: String;
      FEspDoc: String;
      FCodEmp: String;
      FCodCli: String;
      FFila  : String;
      FTipImp: String;
      FNomFrm: String;

      FTemFormula: Boolean;
      FTemLayOut: Boolean;
      FImob,
      FAuto: Boolean;


      qryFormulas: TUniQuery;
      cdsFormulas: TUniClientDataSet;
      dspFormulas: TUniDataSetProvider;
      cdsFormulacao: TUniClientDataSet;


      function fRetLinhaColorPro(strCodLin: String): String;

      function fRetDescBase(strNumDoc, strEspDoc, strItetin : String) : String;

      procedure pRetDadosAdicionais(strCodAca, strEmpAca, strEspDoc, strIdePro: String;
        Var fltVolPro: Double; Var strDesEmb: String);

      {$IFNDEF LINUX}
      function fRetFila(strNomFrm: String; Var strTipImp: String; blnPreImp: Boolean): String;
      function fRetFilaTipo(strTipTin: String; Var strTipImp: String): String;
      function fRetLayPadrao(TipoDoc: TTipoEtiqueta; strTipTin: String): Boolean;
      procedure pImprimirLayoutOrdemProducao(strEmpPrd, strNomImp: String);
      {$ENDIF}

      function fGetTemFormula: Boolean;

      procedure pMarcaTipoTinta;

      function fRetornaDescricaoItemBase(strIteTin, strIdePro: String): String;
      function fRetornaItemBaseCoralImob(strIteTin: String): String;
      function fRetornaProdutoBase(strCodBas, strUnidad, strDescri: String): String;

      function fFormataEspecifico(fltQtdIte: Double; strIdePro: String): Double;
      function fCasasDecimais(strIdePro: String): Integer;
      function fColoranteTemEmbalagem(strIdePro: String): Boolean;
      function fRetornaEmbalagemColorante(strIdePro, strCodCol: String): Double;
      function fRetornarTipoFormulacao(intIdx : Integer) : String;
    protected

    public

      constructor Create; reintroduce;
      destructor Destroy; override;

      {$IFNDEF LINUX}
      procedure pImprimir(strNomFil, strTipImp: String; blnVideo: Boolean = False);
      {$ENDIF}

      procedure pSetaDocumento(strNumDoc, strEspDoc, strCodEmp, strCodCli, strEmpPrd, strCodAca, strEmpAca: String);
      procedure pImprimeOrdProdTmp(blnVideo: Boolean = False; strEmpPrd: String = ''; strCodAca: String = '');

      property blnTemFormula: Boolean Read FTemFormula;
      property Imobiliaria: Boolean Read FImob;
      property Automotiva: Boolean Read FAuto;
  end;

implementation

uses
{$IFDEF LINUX}
  untFuncoesGenerica,
{$ELSE}
  untfuncoesSimples, untQckOrdProTintaMaquina, untCfgRel,
  TypesRel, untEditorFastImpressao,
  untImpOrdemProducao,
{$ENDIF}
  DB, untFuncTinta, Classes, untConstantes, untMovGer;

{ TFatOrdProTintaMaquina }

constructor TFatOrdProTintaMaquina.Create;
begin
  inherited Create;
  cdsFormulas := nil;
  cdsFormulacao := nil;
  qryFormulas := nil;
  dspFormulas := nil;
end;

destructor TFatOrdProTintaMaquina.Destroy;
begin
  if Assigned(cdsFormulas) then FreeAndNil(cdsFormulas);
  if Assigned(cdsFormulacao) then FreeAndNil(cdsFormulacao);
  if Assigned(qryFormulas) then FreeAndNil(qryFormulas);
  if Assigned(dspFormulas) then FreeAndNil(dspFormulas);
  inherited Destroy;
end;

function TFatOrdProTintaMaquina.fCasasDecimais(strIdePro: String): Integer;
begin
  Result := 2;

  If Pos(strIdePro, 'DUP_ALA_BLA_') > 0 Then
    Result := strToIntDef(fGetConfTinta(strIdePro).fGet('DECFOR'), 1)
  Else If Pos(strIdePro, 'PPG_NEX_PPX_') > 0 Then
    Result := strToIntDef(fGetConfTinta(strIdePro).fGet('DECNFM'), 2)
end;

function TFatOrdProTintaMaquina.fColoranteTemEmbalagem(
  strIdePro: String): Boolean;
begin
  Result := False;
  //Imobiliarias por enquanto
  If fTintaBaixaProduto(strIdePro) Then
  Begin
    Result := fCampoExiste(fRetornaTabelaColoranteTinta(strIdePro), 'COL_EMBALA', True);
  End;
end;

function TFatOrdProTintaMaquina.fFormataEspecifico(fltQtdIte: Double; strIdePro: String): Double;
begin
  Result := fltQtdIte;

  If strIdePro = 'SKY' Then
    Result :=  fFormataFloatSky(fltQtdIte);
end;

function TFatOrdProTintaMaquina.fGetTemFormula: Boolean;
begin
  Result := FTemFormula;
end;

function TFatOrdProTintaMaquina.fRetDescBase(strNumDoc,strEspDoc, strItetin: String): String;
Var
  qryAux : TUniQuery;
  strSQL : String;
begin
  Try
    qryAux := fCriaQuery;

    If Pos(strEspDoc, '_OR_PD_') <= 0 Then
    Begin
      strSQL := 'SELECT ITE_DESITE'+
                '  FROM TINDET'+
                ' INNER JOIN CADITE ON ITE_CODITE = DET_CODITE'+
                ' WHERE DET_NUMDOC = :NUMDOC '+
                '   AND DET_ESPDOC = :ESPDOC '+
                '   AND DET_CODEMP = :CODEMP '+
                '   AND DET_ITETIN = :ITETIN ';
    End
    Else
    Begin
      strSQL := 'SELECT ITE_DESITE'+
                '  FROM TINDOR'+
                ' INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE'+
                ' WHERE FDO_NUMDOC = :NUMDOC '+
                '   AND FDO_ESPDOC = :ESPDOC '+
                '   AND FDO_CODEMP = :CODEMP '+
                '   AND FDO_ITETIN = :ITETIN ';
    End;

    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ParamByName('ITETIN').AsString := strItetin;
    qryAux.Open;

    Result := qryAux.FieldByName('ITE_DESITE').AsString;
  Finally
    FreeAndNil(qryAux);
  End;

end;

{$IFNDEF LINUX}
function TFatOrdProTintaMaquina.fRetFila(strNomFrm: String; Var strTipImp: String; blnPreImp: Boolean): String;
Var
  qryCfgRel: TUniQuery;
begin
  Result := '';
  FNomFrm := strNomFrm;

  Try
    qryCfgRel := fCriaQuery;
    pCarregaConfImpr(qryCfgRel, strNomFrm);

    If Not blnPreImp Then
    Begin
      Result    := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
    End
    Else
      fPreImpressao(qryCfgRel, Result, strTipImp, False);
  Finally
    FreeAndNil(qryCfgRel);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
function TFatOrdProTintaMaquina.fRetFilaTipo(strTipTin: String;
  var strTipImp: String): String;
begin
  Result    := '';
  strTipImp := '';

  If (strTipTin = 'A') Then
    Result := fRetFila('frmFatVendas_OP_AUT', strTipImp, False)
  Else
    Result := fRetFila('frmFatVendas_OP_IMO', strTipImp, False);

  If (fEmptyStr(Result)) Then
  Begin
    If (fEmptyStr(FFila)) Then
    Begin
      Result  := fRetFila('frmFatVendas_OP', strTipImp, True);
      FFila   := Result;
      FTipImp := strTipImp;
    End
    Else
    Begin
      Result    := FFila;
      strTipImp := FTipImp;
    End;
  End;

end;
{$ENDIF}

{$IFNDEF LINUX}
function TFatOrdProTintaMaquina.fRetLayPadrao(TipoDoc: TTipoEtiqueta; strTipTin: String): Boolean;
Var
  qryLayEti: TUniQuery;
  strSQL: String;
begin
  Try

    If strTipTin = 'I' Then
      TipoDoc := tpeOrdProImobiliaria
    Else
      TipoDoc := tpeOrdProAutomotiva;


    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    LAY_PADRAO,       ';
    strSQL := strSQL + '    LAY_GERPDF        ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    LAYETI            ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    LAY_PADRAO = "S" AND          ';
    strSQL := strSQL + '    LAY_CODEMP = :CODEMP  AND     ';
    strSQL := strSQL + '    LAY_TIPLAY = :TIPLAY          ';

    qryLayEti := fCriaQuery();
    qryLayEti.Close;
    qryLayEti.SQL.Clear;
    qryLayEti.SQL.Add(strSQL);
    qryLayEti.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryLayEti.ParamByName('TIPLAY').AsInteger := ARR_CODIGO_ETIQUETA[TipoDoc];
    qryLayEti.Open;

    Result := (Not qryLayEti.IsEmpty);
  Finally
	FreeAndNil(qryLayEti);
  End;
end;
{$ENDIF}

function TFatOrdProTintaMaquina.fRetLinhaColorPro(strCodLin: String): String;
begin
  Result := '';

  If strCodLin = '1' Then
    Result := 'Autobase Plus 100:50'
  Else If strCodLin = '4' Then
    Result := 'Wandabase HS'
  Else If strCodLin = '6' Then
    Result := 'Wandalac'
  Else If strCodLin = '8' Then
    Result := 'Wanda PU HS'
  Else If strCodLin = '9' Then
    Result := 'Wandacar'
  Else If strCodLin = '11' Then
    Result := 'Single Stage Converter'
  Else If strCodLin = '59' Then
    Result := 'Autocoat BT90'
  Else If strCodLin = '13' Then
    Result := 'Autocoat BT100'
  Else If strCodLin = '15' Then
    Result := 'Autocoat BT110'
  Else If strCodLin = '16' Then
    Result := 'Autocoat BT120'
  Else If strCodLin = '17' Then
    Result := 'Autocoat BT130'
  Else If strCodLin = '14' Then
    Result := 'Autobase Plus 100:80'
  Else If strCodLin = '58' Then
    Result := 'Wanda PU MS'
  Else If strCodLin = '27' Then
    Result := 'Autowave MM'
  Else If strCodLin = '67' Then
    Result := 'Autowave MM 2.0'
  Else If strCodLin = '72' Then
    Result := 'Tech Fleet PU'
  Else If strCodLin = '74' Then
    Result := 'Tech Fleet Epoxy'
  Else If strCodLin = '75' Then
    Result := 'Tech Fleet Sintetico'
  Else If strCodLin = '76' Then
    Result := 'Tech Fleet Laca';

  Result := AnsiUpperCase(Result);

end;

{$IFDEF LINUX}
procedure TFatOrdProTintaMaquina.pImprimeOrdProdTmp(blnVideo: Boolean = False; strEmpPrd: String = ''; strCodAca: String = '');
begin
  raise Exception.Create('TFatOrdProTintaMaquina.pImprimeOrdProdTmp não possui implementacao para compilacao linux');
end;
{$ELSE}
procedure TFatOrdProTintaMaquina.pImprimeOrdProdTmp(blnVideo: Boolean = False; strEmpPrd: String = ''; strCodAca: String = '');
Var
  strNomFil: String;
  strTipImp: String;

  procedure pEnviaImpressao(strTipTin: String);
  Begin
    cdsFormulas.Filter   := 'TIPTIN = ' + QuotedStr(strTipTin);

    If Not fEmptyStr(strCodAca) Then
    Begin
      cdsFormulas.Filter := cdsFormulas.Filter + ' AND CODACA = ' + QuotedStr(strCodAca);
    End;

    cdsFormulas.Filtered := True;

    FTemLayOut := fRetLayPadrao(tpeNenhum, strTipTin);

    If (Not cdsFormulas.IsEmpty) Then
    Begin
      strNomFil := fRetFilaTipo(strTipTin, strTipImp);
      If (Not FTemLayOut) Then
      Begin
        If (Not fEmptyStr(strNomFil)) Then
          pImprimir(strNomFil, strTipImp, blnVideo);
      End
      Else
      Begin
        pImprimirLayoutOrdemProducao(strEmpPrd, strNomFil);
      End;
    End;

    cdsFormulas.Filtered := False;
    cdsFormulas.Filter   := '';
  End;

begin
  pEnviaImpressao('A');
  pEnviaImpressao('I');
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFatOrdProTintaMaquina.pImprimir(strNomFil, strTipImp: String; blnVideo: Boolean = False);
  Var
    intContador: Integer;
    strCodCol: String;
    fltTotAcu: Double;
    strSalto : String;
    intCont  : Integer;
    dicRetorno: TDicionario;
    fltVolPro: Double;
    strDesEmb: String;
    fltQtdFormul: Double;
    recInfTin: TRecInfoImpressaoOPTinta;

    intDecimaisFormul: Integer;
    strCodIte: string;
    strDescriCol: string;
    strCodColRet: string;
    fltQuantidadeExibida: Double;
    fltChildHeight : Double;
    blnColEmb: Boolean;

  procedure pConfiguraFilaImpressao(Var objReport: TfrxReport);
  begin
    If fEmptyStr(strNomFil) Then
      objReport.PrintOptions.ShowDialog := True
    Else
    Begin
      objReport.PrintOptions.ShowDialog := False;
      objReport.PrintOptions.Printer := AnsiReplaceText(strNomFil, '\\' + fRetNomeRede + '\', '');
    End;
  end;
begin

  If (Not FTemFormula) Then
    Exit;

  {*******************************************}
  {* PROCESSA TODAS AS FÓRMULAS DO DOCUMENTO *}
  {***xx/xx/xxxx***************************MV*}
  cdsFormulas.First;
  dicRetorno := TDicionario.Create;

  While (Not cdsFormulas.Eof) Do
  Begin
    cdsFormulacao.EmptyDataSet;

    //Colorante tem embalagem no cadastro de colorantes
    blnColEmb := fColoranteTemEmbalagem(cdsFormulas.FieldByName('IDEPRO').AsString);

    {*******************************************}
    {* PROCESSA OS COLORANTES DA FÓRMULA       *}
    {***xx/xx/xxxx***************************MV*}
    fltTotAcu := 0.0;
    For intContador := 1 To 20 Do
    Begin

      if not Assigned(cdsFormulas.FindField('FORM' + fStrZero(intContador, 2))) then
        Break;


      strCodCol := cdsFormulas.FieldByName('FORM' + fStrZero(intContador, 2)).AsString;
      If (fEmptyStr(strCodCol)) Or (strCodCol = '_') Then
        //Break;
        Continue;

//      If cdsFormulas.FieldByName('QTDB' + fStrZero(intContador, 2)).AsFloat <= 0 Then
//        Continue;

      strDescriCol := '';

      pRetItemEDescricaoColorante(cdsFormulas.FieldByName('IDEPRO').AsString,
        strCodCol,
        strCodIte,
        strCodColRet,
        strDescriCol,
        VS_strCodEmp);

      //if (not fEmptyStr(strDescriCol)) and (Length(strCodColRet + '-' + strDescriCol) <= 11) then
      if (not fEmptyStr(strDescriCol)) then
        strCodCol := strCodColRet + '-' + strDescriCol;

      If Pos(cdsFormulas.FieldByName('IDEPRO').AsString,'IQU_AJA_SHE_REN_ANN_INK_DOX_SUV_') > 0 Then
        intDecimaisFormul := -3
      Else If cdsFormulas.FieldByName('IDEPRO').AsString = 'REC' Then
        intDecimaisFormul := -4
      Else If Pos(cdsFormulas.FieldByName('IDEPRO').AsString, 'DUP_PPG_NEX_PPX_') > 0  Then
        intDecimaisFormul := - fCasasDecimais(cdsFormulas.FieldByName('IDEPRO').AsString)
      Else
        intDecimaisFormul := -2;

      If fTintaBaixaProduto(cdsFormulas.FieldByName('IDEPRO').AsString) And (cdsFormulas.FieldByName('IDEPRO').AsString <> 'ADT') Then
      Begin
        fltTotAcu :=  RoundTo(cdsFormulas.FieldByName('QTDB' + fStrZero(intContador, 2)).AsFloat / fGetFatorML(cdsFormulas.FieldByName('IDEPRO').AsString),intDecimaisFormul);

        fltQtdFormul := cdsFormulas.FieldByName('QTDITE').AsFloat;
      End
      Else
      Begin
        If (fGetConfTinta(cdsFormulas.FieldByName('IDEPRO').AsString).fGet('ACUABS') = '2') Then
          fltTotAcu := 0.0;

        fltTotAcu := fltTotAcu + RoundTo(cdsFormulas.FieldByName('QTDB' + fStrZero(intContador, 2)).AsFloat / fGetFatorML(cdsFormulas.FieldByName('IDEPRO').AsString), intDecimaisFormul);

        If (cdsFormulas.FieldByName('IDEPRO').AsString = 'ADT') Then
          fltQtdFormul := cdsFormulas.FieldByName('QTDITE').AsFloat
        Else If cdsFormulas.FieldByName('QTDEMB').AsFloat > cdsFormulas.FieldByName('QTDITE').AsFloat Then
          fltQtdFormul := cdsFormulas.FieldByName('QTDITE').AsFloat
        Else If cdsFormulas.FieldByName('QTDEMB').AsFloat > 0 Then
          fltQtdFormul := cdsFormulas.FieldByName('QTDEMB').AsFloat
        Else
          fltQtdFormul := cdsFormulas.FieldByName('QTDITE').AsFloat;
      End;


      cdsFormulacao.Append;
      cdsFormulacao.FieldByName('DOCUMENTO').AsString := cdsFormulas.FieldByName('NUMDOC').AsString;
      cdsFormulacao.FieldByName('ESPECIE').AsString   := cdsFormulas.FieldByName('ESPDOC').AsString;
      cdsFormulacao.FieldByName('EMPRESA').AsString   := cdsFormulas.FieldByName('CODEMP').AsString;

      If (fCfgSis('IMPDOP') = '2') Then
        cdsFormulacao.FieldByName('COLORANTE').AsString := strCodColRet + ' - ' + fRetNomProduto(strCodIte)
      Else
        cdsFormulacao.FieldByName('COLORANTE').AsString := strCodCol;


      fltQuantidadeExibida := fltTotAcu / fltQtdFormul;
      if fCfgSis('TOTPRD', varBoolean) then
        fltQuantidadeExibida := fltQuantidadeExibida * fltQtdFormul;

      If (fTipoTinta(cdsFormulas.FieldByName('IDEPRO').AsString) = ttAutomotiva) Or (Pos(cdsFormulas.FieldByName('IDEPRO').AsString, 'KIN_') > 0) Then
        cdsFormulacao.FieldByName('QUANTIDADE').AsString := FloatToStrF(fFormataEspecifico(fltQuantidadeExibida, cdsFormulas.FieldByName('IDEPRO').AsString), ffNumber, 12, fCasasDecimais(cdsFormulas.FieldByName('IDEPRO').AsString))
      else
        cdsFormulacao.FieldByName('QUANTIDADE').AsString := fGetQuantidadeOncaPulsoMl(fltQuantidadeExibida, cdsFormulas.FieldByName('IDEPRO').AsString, strCodColRet);


      If blnColEmb Then
        cdsFormulacao.FieldByName('EMBALAGEM').AsString := FloatToStrF(fRetornaEmbalagemColorante(
          cdsFormulas.FieldByName('IDEPRO').AsString, strCodColRet), ffNumber, 12, 4);


      if Pos(cdsFormulas.FieldByName('IDEPRO').AsString, 'CIA_SHE_') > 0 Then
        cdsFormulacao.FieldByName('QTDFORMUL').AsString := FloatToStrF(fltQtdFormul, ffNumber, 12, 3)
      else
        cdsFormulacao.FieldByName('QTDFORMUL').AsString := FloatToStrF(fltQtdFormul, ffNumber, 12, 2);

      cdsFormulacao.FieldByName('CLIENTE').AsString   := cdsFormulas.FieldByName('NOMCLI').AsString;

      if cdsFormulas.FieldByName('IDEPRO').AsString = 'CIM' then
        cdsFormulacao.FieldByName('FORMULA').AsString := cdsFormulas.FieldByName('IDEPRO').AsString + ' - ' + cdsFormulas.FieldByName('DESCRI').AsString +
          fRetornaDescricaoItemBase(cdsFormulas.FieldByName('ITETIN').AsString,cdsFormulas.FieldByName('IDEPRO').AsString)
      else
        If cdsFormulas.FieldByName('IDEPRO').AsString = 'MEG' then
          cdsFormulacao.FieldByName('FORMULA').AsString := cdsFormulas.FieldByName('IDEPRO').AsString + ' - ' +
            cdsFormulas.FieldByName('DESCRI').AsString +' - '+ fRetDescBase(cdsFormulas.FieldByName('NUMDOC').AsString
                                                                          , cdsFormulas.FieldByName('ESPDOC').AsString
                                                                          , cdsFormulas.FieldByName('ITETIN').AsString)
        else
          cdsFormulacao.FieldByName('FORMULA').AsString := cdsFormulas.FieldByName('IDEPRO').AsString + ' - ' + cdsFormulas.FieldByName('DESCRI').AsString;

      If strTipImp = 'M' Then
      Begin
        cdsFormulacao.FieldByName('VENDEDOR').AsString  := fTiraCaracNota(cdsFormulas.FieldByName('NOMOPE').AsString);
        cdsFormulacao.FieldByName('DIGITADOR').AsString := fTiraCaracNota(cdsFormulas.FieldByName('NOMDIG').AsString);
      End
      Else
      Begin
        cdsFormulacao.FieldByName('VENDEDOR').AsString  := cdsFormulas.FieldByName('NOMOPE').AsString;
        cdsFormulacao.FieldByName('DIGITADOR').AsString := cdsFormulas.FieldByName('NOMDIG').AsString;
      End;

      cdsFormulacao.FieldByName('DATA').AsDateTime    := cdsFormulas.FieldByName('DTAENT').AsDateTime;
      cdsFormulacao.FieldByName('HORA').AsDateTime    := cdsFormulas.FieldByName('HORENT').AsDateTime;

      cdsFormulacao.FieldByName('OBSCOL').AsString    := cdsFormulas.FieldByName('OBSCOL').AsString;
      cdsFormulacao.FieldByName('TIPFOR').AsString    := fRetornarTipoFormulacao(cdsFormulas.FieldByName('TIPFOR').AsInteger);


      If (FEspDoc <> 'OR') Then
        cdsFormulacao.FieldByName('UNITAR').AsString    := cdsFormulas.FieldByName('UNITAR').AsString
      Else
        cdsFormulacao.FieldByName('UNITAR').AsString    := cdsFormulas.FieldByName('TOTITE').AsString;

      cdsFormulacao.FieldByName('TIPEMB').AsString    := cdsFormulas.FieldByName('VOLPRO').AsString +' '+ cdsFormulas.FieldByName('TIPEMB').AsString;

      If (fEmptyStr(cdsFormulas.FieldByName('DILCON').AsString)) Then
        cdsFormulacao.FieldByName('DILCON').AsString := ''
      Else
        cdsFormulacao.FieldByName('DILCON').AsString := IIF(cdsFormulas.FieldByName('DILCON').AsString = 'C', 'CONCENTRADO', 'DILUIDO');

      cdsFormulacao.FieldByName('ANOCOR').AsString := cdsFormulas.FieldByName('ANOCOR').AsString;

      cdsFormulacao.Post;
    End;
    {*******************************************}
    {* IMPRIME A FORMULAÇÃO                    *}
    {***xx/xx/xxxx***************************MV*}
    cdsFormulacao.First;

    dicRetorno.Limpar;
    pRetornaDadosTinta(cdsFormulas.FieldByName('IDEPRO').AsString,
                       cdsFormulas.FieldByName('ITETIN').AsString,
                       dicRetorno);

    pRetDadosAdicionais(cdsFormulas.FieldByName('CODACA').AsString,
                        cdsFormulas.FieldByName('EMPACA').AsString,
                        cdsFormulas.FieldByName('ESPDOC').AsString,
                        cdsFormulas.FieldByName('IDEPRO').AsString,
                        fltVolPro,
                        strDesEmb);

    recInfTin.strMontad := dicRetorno['montad'];
    recInfTin.strMarTin := fRetLinhaColorPro(dicRetorno['martin']);
    recInfTin.strDesemb := strDesEmb;
    recInfTin.strVariac := IIF(dicRetorno['variac'] = Null, '', dicRetorno['variac']);
    recInfTin.fltVolPro := fltVolPro;
    recInfTin.blnImobil := fTintaBaixaProduto(cdsFormulas.FieldByName('IDEPRO').AsString);
    recInfTin.blnColEmb := blnColEmb;

    If (strTipImp = 'M') And (Not blnVideo) And (Not VS_SpoolImpressaoCitel) Then
    Begin
      If fCfgSis('MOIMOP', varInteger) = 1 Then // 80 colunas
      Begin
        TImpOrdemProducao.Create(strNomFil, False).pImprimeOrdemProducaoTintaMaquina(cdsFormulacao,
                                                                      cdsFormulas.FieldByName('NUMDOC').AsString,
                                                                      cdsFormulas.FieldByName('ESPDOC').AsString,
                                                                      recInfTin,
                                                                      recInfTin.strDesEmb);
      End
      Else
      Begin // 40 colunas
        Try
          pCriarFormularios(TfrmQckOrdProTintaMaquina, frmQckOrdProTintaMaquina);
          frmQckOrdProTintaMaquina.frxDataset.DataSet := cdsFormulacao;
          strSalto := '';
          {*******************************************}
          {* CONTROLA O SALTO                        *}
          {****************************************LU*}
          If fCfgSis('QTDSAL', varInteger) > 0 Then
          Begin
            For intCont := 1 To fCfgSis('QTDSAL', varInteger) Do
            Begin
              strSalto := strSalto + '       ' + #13#10;
            End;
          End;

          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['NOMTIN']    := AnsiUpperCase(fRetornaNomeTinta(cdsFormulas.FieldByName('IDEPRO').AsString));
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['CODTIN']    := dicRetorno['codtin'];
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MONTAD']    := recInfTin.strMontad;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MARTIN']    := recInfTin.strMarTin;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['LITROS']    := recInfTin.fltVolPro;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['DESEMBALA'] := recInfTin.strDesEmb;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['VARIAC']    := recInfTin.strVariac;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['DEST']      := cdsFormulas.FieldByName('FDO_ENTRET').AsString;
          If ((fCfgSis('EXIDOC') = 'PD') OR (fCfgSis('EXIDOC') = 'OR') ) Then
          Begin
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEXP']    := fCampoTabela('FGO_MENEXP', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX2']    := fCampoTabela('FGO_MENEX2', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX3']    := fCampoTabela('FGO_MENEX3', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX4']    := fCampoTabela('FGO_MENEX4', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
          End
          Else
          Begin
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEXP']    := fCampoTabela('GER_MENEXP', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX2']    := fCampoTabela('GER_MENEX2', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX3']    := fCampoTabela('GER_MENEX3', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX4']    := fCampoTabela('GER_MENEX4', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
          End;

          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('DMPMemo11').Visible := fCfgSis('IMPVFR', varBoolean);
          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('DMPMemo15').Visible := fCfgSis('IMPVFR', varBoolean);

          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['OBSCOL'] := cdsFormulas.FieldByName('OBSCOL').AsString;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['TIPFOR'] := fRetornarTipoFormulacao(cdsFormulas.FieldByName('TIPFOR').AsInteger);

          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memObsCol').Visible   := true;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memTipFor').Visible   := true;

          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memDbObsCol').Visible := true;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memDbTipFor').Visible := true;

          {*****************************************}
          {* CASO FOR IMOBILIARIA                  *}
          {**************************************MV*}
          If fTintaBaixaProduto(cdsFormulas.FieldByName('IDEPRO').AsString) Then
          Begin
{
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllMontad').Visible   := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllDtMontad').Visible := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllMarca').Visible    := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllDtMarca').Visible  := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllLitros').Visible   := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllDtLitros').Visible := False;
            //frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllQuant').Visible    := False;
            //frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllDtQuant').Visible  := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllEmbala').Visible   := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllDtEmbala').Visible := False;
}

            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllLitros').Visible   := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllDtLitros').Visible := False;

            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memObsCol').Visible   := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memTipFor').Visible   := False;

            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memDbObsCol').Visible := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memDbTipFor').Visible := False;


            TfrxReportTitle(frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('Titulo')).Height := 126;

            TfrxMemoView(frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllEmbala')).Text := 'Base.....:';
          End;

          frmQckOrdProTintaMaquina.strSalto := strSalto;

          pConfiguraFilaImpressao(frmQckOrdProTintaMaquina.frxOrdPro40Col);

            If frmQckOrdProTintaMaquina.frxOrdPro40Col.PrepareReport Then
              pPrintReport(FNomFrm, 'Ordem de Produção Tintométrico', strNomFil, frmQckOrdProTintaMaquina.frxOrdPro40Col);
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[TFatOrdProTintaMaquina.pImprimir]');
          End;
        End;
        pFreeAndNil(frmQckOrdProTintaMaquina);
      End;

    End
    Else If (strTipImp = 'M') And (Not blnVideo) And (VS_SpoolImpressaoCitel) Then
    Begin
      Try
        pCriarFormularios(TfrmQckOrdProTintaMaquina, frmQckOrdProTintaMaquina);
        frmQckOrdProTintaMaquina.frxDataset.DataSet := cdsFormulacao;

        if fCfgSis('MOIMOP', varInteger) = 1 then
        begin
            If (fCfgSis('LAY_OP') = '1') Then
              TfrxDMPCommand(frmQckOrdProTintaMaquina.frxReportM.FindObject('DMPCommandPagina')).Command := '#27#67#44';

          frmQckOrdProTintaMaquina.frxReportM.PrintOptions.Printer := AnsiReplaceText(strNomFil, '\\' + fRetNomeRede + '\', '');

          frmQckOrdProTintaMaquina.frxReportM.Script.Variables['NOMTIN']    := AnsiUpperCase(fRetornaNomeTinta(cdsFormulas.FieldByName('IDEPRO').AsString));
          frmQckOrdProTintaMaquina.frxReportM.Script.Variables['CODTIN']    := dicRetorno['codtin'];
          frmQckOrdProTintaMaquina.frxReportM.Script.Variables['MONTAD']    := recInfTin.strMontad;
          frmQckOrdProTintaMaquina.frxReportM.Script.Variables['MARTIN']    := recInfTin.strMarTin;
          frmQckOrdProTintaMaquina.frxReportM.Script.Variables['LITROS']    := recInfTin.fltVolPro;
          frmQckOrdProTintaMaquina.frxReportM.Script.Variables['DESEMBALA'] := recInfTin.strDesEmb;
          frmQckOrdProTintaMaquina.frxReportM.Script.Variables['VARIAC']    := recInfTin.strVariac;
          frmQckOrdProTintaMaquina.frxReportM.Script.Variables['DEST']      := cdsFormulas.FieldByName('FDO_ENTRET').AsString;

          If ((fCfgSis('EXIDOC') = 'PD') OR (fCfgSis('EXIDOC') = 'OR') ) Then
          Begin
            frmQckOrdProTintaMaquina.frxReportM.Script.Variables['MENEXP']    := fCampoTabela('FGO_MENEXP', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReportM.Script.Variables['MENEX2']    := fCampoTabela('FGO_MENEX2', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReportM.Script.Variables['MENEX3']    := fCampoTabela('FGO_MENEX3', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReportM.Script.Variables['MENEX4']    := fCampoTabela('FGO_MENEX4', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
          End
          Else
          Begin
            frmQckOrdProTintaMaquina.frxReportM.Script.Variables['MENEXP']    := fCampoTabela('GER_MENEXP', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReportM.Script.Variables['MENEX2']    := fCampoTabela('GER_MENEX2', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReportM.Script.Variables['MENEX3']    := fCampoTabela('GER_MENEX3', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReportM.Script.Variables['MENEX4']    := fCampoTabela('GER_MENEX4', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
          End;

          frmQckOrdProTintaMaquina.frxReportM.Script.Variables['OBSCOL'] := cdsFormulas.FieldByName('OBSCOL').AsString;
          frmQckOrdProTintaMaquina.frxReportM.Script.Variables['TIPFOR'] := cdsFormulas.FieldByName('TIPFOR').AsString;

          frmQckOrdProTintaMaquina.frxReportM.Script.Variables['BASE_IMOB'] := recInfTin.strDesEmb;

          frmQckOrdProTintaMaquina.frxReportM.FindObject('DMPLine3').Visible  := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReportM.FindObject('DMPMemo2').Visible  := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReportM.FindObject('DMPMemo3').Visible  := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReportM.FindObject('DMPMemo4').Visible  := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReportM.FindObject('DMPMemo5').Visible  := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReportM.FindObject('DMPMemo9').Visible  := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReportM.FindObject('DMPMemo10').Visible := fCfgSis('IMPAMR', varBoolean);


          frmQckOrdProTintaMaquina.frxReportM.FindObject('DMPMemo11').Visible := fCfgSis('IMPVFR', varBoolean);
          frmQckOrdProTintaMaquina.frxReportM.FindObject('DMPMemo13').Visible := fCfgSis('IMPVFR', varBoolean);

          frmQckOrdProTintaMaquina.frxReportM.FindObject('memObsCol').Visible    := True;
          frmQckOrdProTintaMaquina.frxReportM.FindObject('memTipFor').Visible    := True;

          frmQckOrdProTintaMaquina.frxReportM.FindObject('memDbObsCol').Visible  := True;
          frmQckOrdProTintaMaquina.frxReportM.FindObject('memDbTipFor').Visible  := True;

          frmQckOrdProTintaMaquina.frxReportM.FindObject('memBase').Visible    := false;
          frmQckOrdProTintaMaquina.frxReportM.FindObject('DbmemBase').Visible  := false;

          {*****************************************}
          {* CASO FOR IMOBILIARIA                  *}
          {**************************************LA*}
          If fTintaBaixaProduto(cdsFormulas.FieldByName('IDEPRO').AsString) Then
          Begin
            frmQckOrdProTintaMaquina.frxReportM.FindObject('ChildAutomotivas').Visible := False;

            frmQckOrdProTintaMaquina.frxReportM.FindObject('DbMemEmbVinc').Visible := False;
            frmQckOrdProTintaMaquina.frxReportM.FindObject('LbMemEmbVinc').Visible := False;

            frmQckOrdProTintaMaquina.frxReportM.FindObject('memObsCol').Visible    := False;
            frmQckOrdProTintaMaquina.frxReportM.FindObject('memTipFor').Visible    := False;

            frmQckOrdProTintaMaquina.frxReportM.FindObject('memDbObsCol').Visible  := False;
            frmQckOrdProTintaMaquina.frxReportM.FindObject('memDbTipFor').Visible  := False;

            frmQckOrdProTintaMaquina.frxReportM.FindObject('memBase').Visible    := True;
            frmQckOrdProTintaMaquina.frxReportM.FindObject('DbmemBase').Visible  := True;
          End;

          If blnVideo Then
            pPreviewReport(FNomFrm, 'Ordem de Produção Tintométrico', frmQckOrdProTintaMaquina.frxReportM)
          Else
          Begin
            frmQckOrdProTintaMaquina.frxReportM.PrepareReport;
            pPrintReport(FNomFrm, 'Ordem de Produção Tintométrico', strNomFil, frmQckOrdProTintaMaquina.frxReportM);
          End;
        end
        else
        begin
          pCriarFormularios(TfrmQckOrdProTintaMaquina, frmQckOrdProTintaMaquina);
          frmQckOrdProTintaMaquina.frxDataset.DataSet := cdsFormulacao;
          strSalto := '';
          {*******************************************}
          {* CONTROLA O SALTO                        *}
          {****************************************LU*}
          If fCfgSis('QTDSAL', varInteger) > 0 Then
          Begin
            For intCont := 1 To fCfgSis('QTDSAL', varInteger) Do
            Begin
              strSalto := strSalto + '       ' + #13#10;
            End;
          End;

          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['NOMTIN']    := AnsiUpperCase(fRetornaNomeTinta(cdsFormulas.FieldByName('IDEPRO').AsString));
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['CODTIN']    := dicRetorno['codtin'];
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MONTAD']    := recInfTin.strMontad;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MARTIN']    := recInfTin.strMarTin;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['LITROS']    := recInfTin.fltVolPro;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['DESEMBALA'] := recInfTin.strDesEmb;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['VARIAC']    := recInfTin.strVariac;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['DEST']      := cdsFormulas.FieldByName('FDO_ENTRET').AsString;
          If ((fCfgSis('EXIDOC') = 'PD') OR (fCfgSis('EXIDOC') = 'OR') ) Then
          Begin
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEXP']    := fCampoTabela('FGO_MENEXP', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX2']    := fCampoTabela('FGO_MENEX2', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX3']    := fCampoTabela('FGO_MENEX3', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX4']    := fCampoTabela('FGO_MENEX4', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
          End
          Else
          Begin
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEXP']    := fCampoTabela('GER_MENEXP', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX2']    := fCampoTabela('GER_MENEX2', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX3']    := fCampoTabela('GER_MENEX3', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['MENEX4']    := fCampoTabela('GER_MENEX4', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
          End;

          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('DMPMemo11').Visible := fCfgSis('IMPVFR', varBoolean);
          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('DMPMemo15').Visible := fCfgSis('IMPVFR', varBoolean);

          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['OBSCOL'] := cdsFormulas.FieldByName('OBSCOL').AsString;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.Script.Variables['TIPFOR'] := fRetornarTipoFormulacao(cdsFormulas.FieldByName('TIPFOR').AsInteger);

          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memObsCol').Visible   := true;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memTipFor').Visible   := true;

          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memDbObsCol').Visible := true;
          frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memDbTipFor').Visible := true;

          {*****************************************}
          {* CASO FOR IMOBILIARIA                  *}
          {**************************************MV*}
          If fTintaBaixaProduto(cdsFormulas.FieldByName('IDEPRO').AsString) Then
          Begin
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllLitros').Visible   := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllDtLitros').Visible := False;

            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memObsCol').Visible   := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memTipFor').Visible   := False;

            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memDbObsCol').Visible := False;
            frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('memDbTipFor').Visible := False;


            TfrxReportTitle(frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('Titulo')).Height := 126;

            TfrxMemoView(frmQckOrdProTintaMaquina.frxOrdPro40Col.FindObject('rllEmbala')).Text := 'Base.....:';
          End;

          frmQckOrdProTintaMaquina.strSalto := strSalto;
		
		  pConfiguraFilaImpressao(frmQckOrdProTintaMaquina.frxOrdPro40Col);

            If frmQckOrdProTintaMaquina.frxOrdPro40Col.PrepareReport Then
              pPrintReport(FNomFrm, 'Ordem de Produção Tintométrico', strNomFil, frmQckOrdProTintaMaquina.frxOrdPro40Col);
        end;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TFatOrdProTintaMaquina.pImprimir_1]');
        End;
      End;
      pFreeAndNil(frmQckOrdProTintaMaquina);
    End
    Else
    Begin
      Try
        pCriarFormularios(TfrmQckOrdProTintaMaquina, frmQckOrdProTintaMaquina);
        frmQckOrdProTintaMaquina.frxDataset.DataSet := cdsFormulacao;

        if fCfgSis('MOIMOP', varInteger) = 1 then
        begin
          pConfiguraFilaImpressao(frmQckOrdProTintaMaquina.frxReport);

          frmQckOrdProTintaMaquina.frxReport.Script.Variables['NOMTIN']    := AnsiUpperCase(fRetornaNomeTinta(cdsFormulas.FieldByName('IDEPRO').AsString));
          frmQckOrdProTintaMaquina.frxReport.Script.Variables['CODTIN']    := dicRetorno['codtin'];
          frmQckOrdProTintaMaquina.frxReport.Script.Variables['MONTAD']    := recInfTin.strMontad;
          frmQckOrdProTintaMaquina.frxReport.Script.Variables['MARTIN']    := recInfTin.strMarTin;
          frmQckOrdProTintaMaquina.frxReport.Script.Variables['LITROS']    := recInfTin.fltVolPro;
          frmQckOrdProTintaMaquina.frxReport.Script.Variables['DESEMBALA'] := recInfTin.strDesEmb;
          frmQckOrdProTintaMaquina.frxReport.Script.Variables['VARIAC']    := recInfTin.strVariac;
          frmQckOrdProTintaMaquina.frxReport.Script.Variables['DEST']      := cdsFormulas.FieldByName('FDO_ENTRET').AsString;

          If ((fCfgSis('EXIDOC') = 'PD') OR (fCfgSis('EXIDOC') = 'OR') ) Then
          Begin
            frmQckOrdProTintaMaquina.frxReport.Script.Variables['MENEXP']    := fCampoTabela('FGO_MENEXP', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReport.Script.Variables['MENEX2']    := fCampoTabela('FGO_MENEX2', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReport.Script.Variables['MENEX3']    := fCampoTabela('FGO_MENEX3', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReport.Script.Variables['MENEX4']    := fCampoTabela('FGO_MENEX4', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
          End
          Else
          Begin
            frmQckOrdProTintaMaquina.frxReport.Script.Variables['MENEXP']    := fCampoTabela('GER_MENEXP', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReport.Script.Variables['MENEX2']    := fCampoTabela('GER_MENEX2', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReport.Script.Variables['MENEX3']    := fCampoTabela('GER_MENEX3', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxReport.Script.Variables['MENEX4']    := fCampoTabela('GER_MENEX4', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
          End;

          frmQckOrdProTintaMaquina.frxReport.Script.Variables['OBSCOL'] := cdsFormulas.FieldByName('OBSCOL').AsString;
          frmQckOrdProTintaMaquina.frxReport.Script.Variables['TIPFOR'] := cdsFormulas.FieldByName('TIPFOR').AsString;

          frmQckOrdProTintaMaquina.frxReport.Script.Variables['BASE_IMOB'] := recInfTin.strDesEmb;

          frmQckOrdProTintaMaquina.frxReport.FindObject('Memo47').Visible := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReport.FindObject('Memo46').Visible := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReport.FindObject('Memo45').Visible := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReport.FindObject('Memo44').Visible := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReport.FindObject('Memo43').Visible := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReport.FindObject('Memo42').Visible := fCfgSis('IMPAMR', varBoolean);
          frmQckOrdProTintaMaquina.frxReport.FindObject('Memo41').Visible := fCfgSis('IMPAMR', varBoolean);


          frmQckOrdProTintaMaquina.frxReport.FindObject('Memo38').Visible := fCfgSis('IMPVFR', varBoolean);
          frmQckOrdProTintaMaquina.frxReport.FindObject('Memo39').Visible := fCfgSis('IMPVFR', varBoolean);

          frmQckOrdProTintaMaquina.frxReport.FindObject('memObsCol').Visible    := True;
          frmQckOrdProTintaMaquina.frxReport.FindObject('memTipFor').Visible    := True;

          frmQckOrdProTintaMaquina.frxReport.FindObject('memDbObsCol').Visible  := True;
          frmQckOrdProTintaMaquina.frxReport.FindObject('memDbTipFor').Visible  := True;

          frmQckOrdProTintaMaquina.frxReport.FindObject('memBase').Visible    := false;
          frmQckOrdProTintaMaquina.frxReport.FindObject('DbmemBase').Visible  := false;

          {*****************************************}
          {* CASO FOR IMOBILIARIA                  *}
          {**************************************LA*}
          If fTintaBaixaProduto(cdsFormulas.FieldByName('IDEPRO').AsString) Then
          Begin
            frmQckOrdProTintaMaquina.frxReport.FindObject('ChildAutomotivas').Visible := False;

            frmQckOrdProTintaMaquina.frxReport.FindObject('DbMemEmbVinc').Visible := False;
            frmQckOrdProTintaMaquina.frxReport.FindObject('LbMemEmbVinc').Visible := False;

            frmQckOrdProTintaMaquina.frxReport.FindObject('memObsCol').Visible    := False;
            frmQckOrdProTintaMaquina.frxReport.FindObject('memTipFor').Visible    := False;

            frmQckOrdProTintaMaquina.frxReport.FindObject('memDbObsCol').Visible  := False;
            frmQckOrdProTintaMaquina.frxReport.FindObject('memDbTipFor').Visible  := False;

            frmQckOrdProTintaMaquina.frxReport.FindObject('memBase').Visible    := True;
            frmQckOrdProTintaMaquina.frxReport.FindObject('DbmemBase').Visible  := True;
          End;

          If blnVideo Then
            pPreviewReport(FNomFrm, 'Ordem de Produção Tintométrico', frmQckOrdProTintaMaquina.frxReport)
          Else
          Begin
            frmQckOrdProTintaMaquina.frxReport.PrepareReport;
            pPrintReport(FNomFrm, 'Ordem de Produção Tintométrico', strNomFil, frmQckOrdProTintaMaquina.frxReport);
          End;
        end
        else
        begin
          pConfiguraFilaImpressao(frmQckOrdProTintaMaquina.frxOrdPro40ColJ);

          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['NOMTIN']    := AnsiUpperCase(fRetornaNomeTinta(cdsFormulas.FieldByName('IDEPRO').AsString));
          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['CODTIN']    := dicRetorno['codtin'];
          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['MONTAD']    := recInfTin.strMontad;
          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['MARTIN']    := recInfTin.strMarTin;
          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['LITROS']    := recInfTin.fltVolPro;
          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['DESEMBALA'] := recInfTin.strDesEmb;
          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['VARIAC']    := recInfTin.strVariac;
          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['DEST']      := cdsFormulas.FieldByName('FDO_ENTRET').AsString;

          If ((fCfgSis('EXIDOC') = 'PD') OR (fCfgSis('EXIDOC') = 'OR') ) Then
          Begin
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['MENEXP']    := fCampoTabela('FGO_MENEXP', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['MENEX2']    := fCampoTabela('FGO_MENEX2', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['MENEX3']    := fCampoTabela('FGO_MENEX3', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['MENEX4']    := fCampoTabela('FGO_MENEX4', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
          End
          Else
          Begin
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['MENEXP']    := fCampoTabela('GER_MENEXP', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['MENEX2']    := fCampoTabela('GER_MENEX2', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['MENEX3']    := fCampoTabela('GER_MENEX3', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['MENEX4']    := fCampoTabela('GER_MENEX4', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [FNumDoc, FEspDoc, FCodEmp], False);
          End;

          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('DMPMemo11').Visible := fCfgSis('IMPVFR', varBoolean);
          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('DMPMemo15').Visible := fCfgSis('IMPVFR', varBoolean);

          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['OBSCOL'] := cdsFormulas.FieldByName('OBSCOL').AsString;
          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.Script.Variables['TIPFOR'] := fRetornarTipoFormulacao(cdsFormulas.FieldByName('TIPFOR').AsInteger);

          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('memObsCol').Visible   := true;
          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('memTipFor').Visible   := true;

          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('memDbObsCol').Visible := true;
          frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('memDbTipFor').Visible := true;

          If fTintaBaixaProduto(cdsFormulas.FieldByName('IDEPRO').AsString) Then
          Begin
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('rllLitros').Visible   := False;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('rllDtLitros').Visible := False;

            TfrxReportTitle(frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('Titulo')).Height := 126;

            TfrxMemoView(frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('rllEmbala')).Text := 'Base.......:';

            TfrxMemoView(frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('rllDtEmbala')).Left :=
              TfrxMemoView(frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('rllDtQuant')).Left;

            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('memObsCol').Visible   := False;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('memTipFor').Visible   := False;

            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('memDbObsCol').Visible := False;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('memDbTipFor').Visible := False;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('Rodape').Height := 140;

          End;


          If Pos(cdsFormulas.FieldByName('IDEPRO').AsString, '_ADT_REN_SUV_BAU_QUA_CIA_CIM_REI_CID_SHE_BZI_LKS_LKC_DAC_SHE_FUT_MZI_KIL_COL_EUC_ADV_UNI_MAZ_RSI_ANJ_WEG_' +
                                                             'ALE_VEL_SAY_HYD_INT_CAL_IQU_LIK_REC_KRE_GLO_AJA_REN_ANN_LEC_MAX_MAE_SIN_') > 0 Then
          begin
            fltChildHeight := (frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('Child1').Height / 2 );
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('rllEmbala').top   := frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('rllMontad').Top;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('rllDtEmbala').top := frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('rllMontad').Top;

            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('rllMontad').Visible := false;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('rllMarca').Visible  := false;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('DMPMemo30').Visible := false;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('DMPMemo31').Visible := false;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('DMPMemo28').Visible := false;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('DMPMemo24').Visible := false;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('Child1').Height     := fltChildHeight;
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.FindObject('Line3').Visible     := true;
          end;

          frmQckOrdProTintaMaquina.strSalto := strSalto;

          If blnVideo Then
            pPreviewReport(FNomFrm, 'Ordem de Produção Tintométrico', frmQckOrdProTintaMaquina.frxOrdPro40ColJ)
          Else
          Begin
            frmQckOrdProTintaMaquina.frxOrdPro40ColJ.PrepareReport;
            pPrintReport(FNomFrm, 'Ordem de Produção Tintométrico', strNomFil, frmQckOrdProTintaMaquina.frxOrdPro40ColJ);
          End;
        end;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TFatOrdProTintaMaquina.pImprimir_1]');
        End;
      End;
      pFreeAndNil(frmQckOrdProTintaMaquina);
    End;
    cdsFormulas.Next;
  End;

  FreeAndNil(dicRetorno);

end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFatOrdProTintaMaquina.pImprimirLayoutOrdemProducao(strEmpPrd, strNomImp: String);
Var
  blnLayOut: Boolean;
  objImpressao: TEditorFastImpressao;
begin
  If cdsFormulas.IsEmpty Then
    Exit;

  While Not cdsFormulas.Eof Do
  Begin


    If fTipoTinta(cdsFormulas.FieldByName('IDEPRO').AsString) In [ttImobiliaria, ttIndustrial] Then
    Begin
      blnLayOut := fRetLayPadrao(tpeOrdProImobiliaria, 'I');

      If Not blnLayOut Then
      Begin
        fMensagem('ATENÇÃO', 'Não existe Layout de "Ordem de produção para Tintas Imobiliaria/Industrial" ativo!', ['&Ok']);
        cdsFormulas.Next;
        Continue;
      End
    End
    Else
    Begin
      blnLayOut := fRetLayPadrao(tpeOrdProAutomotiva, 'A');

      If Not blnLayOut Then
      Begin
        fMensagem('ATENÇÃO', 'Não existe Layout de "Ordem de produção para Tintas Automotivas" ativo!', ['&Ok']);
        cdsFormulas.Next;
        Continue;
      End;
    End;

    Try
      objImpressao := TEditorFastImpressao.Create(Nil);

      With objImpressao Do
      Begin
        If fTipoTinta(cdsFormulas.FieldByName('IDEPRO').AsString) In [ttImobiliaria, ttIndustrial] Then
          recDocume.blnOrdProImo := True
        Else
          recDocume.blnOrdProAut := True;

        recDocume.strNumDoc := cdsFormulas.FieldByName('NUMDOC').AsString;
        recDocume.strEspDoc := cdsFormulas.FieldByName('ESPDOC').AsString;
        recDocume.strCodEmp := cdsFormulas.FieldByName('CODEMP').AsString;
        recDocume.strCodCli := cdsFormulas.FieldByName('CODCLI').AsString;
        recDocume.strEmpPrd := strEmpPrd;
        recDocume.strCodAca := cdsFormulas.FieldByName('CODACA').AsString;
        recDocume.strEmpAca := cdsFormulas.FieldByName('EMPACA').AsString;
        recDocume.strNomImp := strNomImp;

        fImprimeDocumento(tpaNormal);
      End;
    Finally
      FreeAndNil(objImpressao);
    End;

    cdsFormulas.Next;
  End;

end;
{$ENDIF}

procedure TFatOrdProTintaMaquina.pRetDadosAdicionais(strCodAca,
  strEmpAca, strEspDoc, strIdePro: String; Var fltVolPro: Double;
  Var strDesEmb: String);
  Var
    qryAux: TUniQuery;
    strTblDet: String;
begin

  If (Pos(strEspDoc, 'OR_PD_') > 0) Then
  Begin
    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  FDO_IDEPRO, ');
    qryAux.SQL.Add('  FDO_VOLPRO, ');
    qryAux.SQL.Add('  FDO_QTDEMB, ');
    qryAux.SQL.Add('  FDO_QTDITE, ');
    qryAux.SQL.Add('  ITE_DESITE ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  FATDOR ');
    If fTintaBaixaProduto(strIdePro) Then
      qryAux.SQL.Add('JOIN CADITE ON ITE_CODITE = FDO_CODITE ')
    Else
      qryAux.SQL.Add('JOIN CADITE ON ITE_CODITE = FDO_ITEEMB ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  FDO_CODACA = :CODACA AND ');
    qryAux.SQL.Add('  FDO_EMPACA = :EMPACA ');

    qryAux.ParamByName('CODACA').AsString := strCodAca;
    qryAux.ParamByName('EMPACA').AsString := strEmpAca;
    qryAux.Open;

    fltVolPro := qryAux.FieldByName('FDO_VOLPRO').AsFloat;

    strDesEmb := qryAux.FieldByName('ITE_DESITE').AsString;

    qryAux.Close;
    FreeAndNil(qryAux);
  End
  Else
  Begin
    strTblDet := 'MOVDET';

    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  DET_IDEPRO, ');
    qryAux.SQL.Add('  DET_VOLPRO, ');
    qryAux.SQL.Add('  DET_QTDEMB, ');
    qryAux.SQL.Add('  DET_QTDITE, ');
    qryAux.SQL.Add('  ITE_DESITE ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  ' + strTblDet + ' ');
    If fTintaBaixaProduto(strIdePro) Then
      qryAux.SQL.Add('JOIN CADITE ON ITE_CODITE = DET_CODITE ')
    Else
      qryAux.SQL.Add('JOIN CADITE ON ITE_CODITE = DET_ITEEMB ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  DET_CODACA = :CODACA AND ');
    qryAux.SQL.Add('  DET_EMPACA = :EMPACA ');

    If fTintaBaixaProduto(strIdePro) Then
    Begin
      qryAux.SQL.Add('  AND DET_ESPDOC NOT IN ("ML","PR","RO") ');
    End;

    qryAux.ParamByName('CODACA').AsString := strCodAca;
    qryAux.ParamByName('EMPACA').AsString := strEmpAca;
    qryAux.Open;

    fltVolPro := qryAux.FieldByName('DET_VOLPRO').AsFloat;
    strDesEmb := qryAux.FieldByName('ITE_DESITE').AsString;

    qryAux.Close;
    FreeAndNil(qryAux);

  End;

end;

procedure TFatOrdProTintaMaquina.pSetaDocumento(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strEmpPrd, strCodAca, strEmpAca: String);
  Var
    strTabelaDet: String;
    strTabelaGer: String;
    intContador : Integer;
begin
  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;
  FCodEmp := strCodEmp;
  FCodCli := strCodCli;

  qryFormulas := fCriaQuery(Nil);
  cdsFormulas := TUniClientDataSet.Create(Nil);
  dspFormulas := TUniDataSetProvider.Create(Nil);

  dspFormulas.DataSet := qryFormulas;
  cdsFormulas.SetProvider(dspFormulas);

  If Pos(strEspDoc, '_OR_PD_') <= 0 Then
  Begin
    strTabelaDet := 'MOVDET';
    strTabelaGer := 'MOVGER';

    qryFormulas.SQL.Add('SELECT ');
    qryFormulas.SQL.Add(            ' " "        AS TIPTIN, ');
    qryFormulas.SQL.Add('TINDET.DET_NUMDOC AS NUMDOC, ');
    qryFormulas.SQL.Add('TINDET.DET_ESPDOC AS ESPDOC, ');
    qryFormulas.SQL.Add('TINDET.DET_CODEMP AS CODEMP, ');
    qryFormulas.SQL.Add('TINDET.DET_QTDEMB AS QTDEMB, ');
    qryFormulas.SQL.Add('TINDET.DET_DESCRI AS DESCRI, ');
    qryFormulas.SQL.Add('TINDET.DET_DTAENT AS DTAENT, ');
    qryFormulas.SQL.Add('TINDET.DET_HORENT AS HORENT, ');
    qryFormulas.SQL.Add('TINDET.DET_IDEPRO AS IDEPRO, ');
    qryFormulas.SQL.Add('TINDET.DET_ITETIN AS ITETIN, ');
    qryFormulas.SQL.Add('TINDET.DET_CODACA AS CODACA, ');
    qryFormulas.SQL.Add('TINDET.DET_EMPACA AS EMPACA, ');
    qryFormulas.SQL.Add('TINDET.DET_A_N_O_ AS ANOCOR, ');
    qryFormulas.SQL.Add('TINDET.DET_TIPPRE AS DILCON, ');
    qryFormulas.SQL.Add('TINDET.DET_QTDITE AS QTDITE, ');
    qryFormulas.SQL.Add('TINDET.DET_TIPEMB AS TIPEMB, ');
    qryFormulas.SQL.Add('TINDET.DET_CODCLI AS CODCLI, ');
    qryFormulas.SQL.Add('DET.DET_TOTITE AS UNITAR, ');
    qryFormulas.SQL.Add('DET.DET_VOLPRO AS VOLPRO, ');

    qryFormulas.SQL.Add('  CASE MOVGER.GER_ENTFAT           ');
    qryFormulas.SQL.Add('    WHEN "N" THEN                  ');
    qryFormulas.SQL.Add('      "RETIRADA"                   ');
    qryFormulas.SQL.Add('    ELSE                           ');
    qryFormulas.SQL.Add('      "ENTREGA"                    ');
    qryFormulas.SQL.Add('  END AS FDO_ENTRET,               ');

    qryFormulas.SQL.Add('  TINDET.DET_TIPFOR AS TIPFOR,     ');
    qryFormulas.SQL.Add('  TINDET.DET_OBSCOL AS OBSCOL,     ');


    For intContador := 1 To 20 Do
    Begin
      qryFormulas.SQL.Add('TINDET.DET_FORM' + fStrZero(intContador, 2) + ' AS FORM' + fStrZero(intContador, 2) + ', ');
      qryFormulas.SQL.Add('TINDET.DET_QTDB' + fStrZero(intContador, 2) + ' AS QTDB' + fStrZero(intContador, 2) + ', ');
    End;

    qryFormulas.SQL.Add('  CONCAT(TINDET.DET_CODVEN, "-", VEN.OPE_NOMOPE) AS NOMOPE, ');
    qryFormulas.SQL.Add('  CONCAT(TINDET.DET_CODDIV, "-", DIG.OPE_NOMOPE) AS NOMDIG, ');
    qryFormulas.SQL.Add('  CONCAT(TINDET.DET_CODCLI, "-", IF(GER.GER_NOMCON = "" OR GER.GER_NOMCON IS NULL, CLI.CLI_NOMCLI, GER.GER_NOMCON)) AS NOMCLI, ');
    qryFormulas.SQL.Add('  IFNULL(TINDET.DET_EMPPRD, TINDET.DET_EMPPRD) AS EMPPRD ');

    qryFormulas.SQL.Add('FROM ');
    qryFormulas.SQL.Add('TINDET ');
    qryFormulas.SQL.Add('JOIN TINGER AS GER ON GER.AUTOINCREM = TINDET.DET_SEQGER ');
    qryFormulas.SQL.Add('JOIN ' + strTabelaDet + ' AS DET ON DET.DET_NUMDOC = TINDET.DET_NUMDOC AND ');
    qryFormulas.SQL.Add('                                    DET.DET_ESPDOC = TINDET.DET_ESPDOC AND ');
    qryFormulas.SQL.Add('                                    DET.DET_CODEMP = TINDET.DET_CODEMP AND ');
    qryFormulas.SQL.Add('                                    DET.DET_CODCLI = TINDET.DET_CODCLI AND ');
    qryFormulas.SQL.Add('                                    DET.DET_CODACA = TINDET.DET_CODACA AND ');
    qryFormulas.SQL.Add('                                    DET.DET_EMPACA = TINDET.DET_EMPACA ');
    qryFormulas.SQL.Add('JOIN CADOPE AS VEN ON TINDET.DET_CODVEN = VEN.OPE_CODOPE ');
    qryFormulas.SQL.Add('LEFT JOIN CADOPE AS DIG ON TINDET.DET_CODDIG = DIG.OPE_CODOPE ');
    qryFormulas.SQL.Add('JOIN CADCLI AS CLI ON TINDET.DET_CODCLI = CLI.CLI_CODCLI ');
    qryFormulas.SQL.Add('JOIN ' + strTabelaGer + ' AS MOVGER ON MOVGER.AUTOINCREM = DET.DET_SEQGER ');

    qryFormulas.SQL.Add('WHERE ');
    qryFormulas.SQL.Add('  DET.DET_CLAFIS >= 5000 AND ');
    qryFormulas.SQL.Add('  DET.DET_PROEMB <> "S" AND  ');
    qryFormulas.SQL.Add('  TINDET.DET_NUMDOC = :NUMDOC AND ');
    qryFormulas.SQL.Add('  TINDET.DET_ESPDOC = :ESPDOC AND ');
    qryFormulas.SQL.Add('  TINDET.DET_CODEMP = :CODEMP AND ');
    qryFormulas.SQL.Add('  TINDET.DET_EMPPRD = :EMPPRD     ');
    If (Not fEmptyStr(strCodAca)) And (Not fEmptyStr(strEmpAca)) And ((Not (fCfgSis('EMIOPR', varBoolean))) Or (fCfgSis('IMPTIN', varBoolean))) Then
    Begin
      qryFormulas.SQL.Add(' AND TINDET.DET_CODACA = :CODACA  ');
      qryFormulas.SQL.Add(' AND TINDET.DET_EMPACA = :EMPACA  ');
    End;
    qryFormulas.SQL.Add('  GROUP BY DET.DET_CODACA, DET.DET_EMPACA');

  End
  Else
  Begin
    qryFormulas.SQL.Add('SELECT ');
    qryFormulas.SQL.Add(' " "              AS TIPTIN, ');
    qryFormulas.SQL.Add('TINDOR.FDO_NUMDOC AS NUMDOC, ');
    qryFormulas.SQL.Add('TINDOR.FDO_ESPDOC AS ESPDOC, ');
    qryFormulas.SQL.Add('TINDOR.FDO_CODEMP AS CODEMP, ');
    qryFormulas.SQL.Add('TINDOR.FDO_QTDEMB AS QTDEMB, ');
    qryFormulas.SQL.Add('TINDOR.FDO_DESCRI AS DESCRI, ');
    qryFormulas.SQL.Add('TINDOR.FDO_DTAENT AS DTAENT, ');
    qryFormulas.SQL.Add('TINDOR.FDO_HORENT AS HORENT, ');
    qryFormulas.SQL.Add('TINDOR.FDO_IDEPRO AS IDEPRO, ');
    qryFormulas.SQL.Add('TINDOR.FDO_ITETIN AS ITETIN, ');
    qryFormulas.SQL.Add('TINDOR.FDO_CODACA AS CODACA, ');
    qryFormulas.SQL.Add('TINDOR.FDO_EMPACA AS EMPACA, ');
    qryFormulas.SQL.Add('TINDOR.FDO_A_N_O_ AS ANOCOR, ');
    qryFormulas.SQL.Add('TINDOR.FDO_TIPPRE AS DILCON, ');
    qryFormulas.SQL.Add('TINDOR.FDO_QTDITE AS QTDITE, ');
    qryFormulas.SQL.Add('TINDOR.FDO_UNITAR AS UNITAR, ');
    qryFormulas.SQL.Add('TINDOR.FDO_TIPEMB AS TIPEMB, ');
    qryFormulas.SQL.Add('TINDOR.FDO_CODCLI AS CODCLI, ');
    qryFormulas.SQL.Add('TINDOR.FDO_TOTITE AS TOTITE, ');
    qryFormulas.SQL.Add('FATDOR.FDO_VOLPRO AS VOLPRO, ');

    qryFormulas.SQL.Add(' CASE EXTDOR.FDO_ENTRET      ');
    qryFormulas.SQL.Add('   WHEN "E" THEN             ');
    qryFormulas.SQL.Add('     "ENTREGA"               ');
    qryFormulas.SQL.Add('   ELSE                      ');
    qryFormulas.SQL.Add('     "RETIRADA"              ');
    qryFormulas.SQL.Add(' END AS FDO_ENTRET,          ');

    qryFormulas.SQL.Add('  TINDOR.FDO_TIPFOR AS TIPFOR,  ');
    qryFormulas.SQL.Add('  TINDOR.FDO_OBSCOL AS OBSCOL,  ');


    For intContador := 1 To 20 Do
    Begin
      qryFormulas.SQL.Add('TINDOR.FDO_FORM' + fStrZero(intContador, 2) + ' AS FORM' + fStrZero(intContador, 2) + ', ');
      qryFormulas.SQL.Add('TINDOR.FDO_QTDB' + fStrZero(intContador, 2) + ' AS QTDB' + fStrZero(intContador, 2) + ', ');
    End;

    qryFormulas.SQL.Add('  CONCAT(TINDOR.FDO_CODVEN, "-", VEN.OPE_NOMOPE) AS NOMOPE, ');
    qryFormulas.SQL.Add('  CONCAT(TINDOR.FDO_CODDIV, "-", DIG.OPE_NOMOPE) AS NOMDIG, ');
    qryFormulas.SQL.Add('  CONCAT(TINDOR.FDO_CODCLI, "-", IF(FGO_NOMCON = "" OR FGO_NOMCON IS NULL, CLI.CLI_NOMCLI, FGO_NOMCON)) AS NOMCLI ');
    qryFormulas.SQL.Add('FROM ');
    qryFormulas.SQL.Add(' TINDOR ');
    qryFormulas.SQL.Add('INNER JOIN TINGOR AS GOR ON GOR.AUTOINCREM = TINDOR.FDO_SEQGER ');
    qryFormulas.SQL.Add('INNER JOIN CADOPE AS VEN ON TINDOR.FDO_CODVEN = VEN.OPE_CODOPE ');
    qryFormulas.SQL.Add('LEFT  JOIN CADOPE AS DIG ON TINDOR.FDO_CODDIG = DIG.OPE_CODOPE ');
    qryFormulas.SQL.Add('INNER JOIN CADCLI AS CLI ON TINDOR.FDO_CODCLI = CLI.CLI_CODCLI ');

    qryFormulas.SQL.Add('INNER JOIN FATDOR       ON FATDOR.FDO_NUMDOC = TINDOR.FDO_NUMDOC AND ');
    qryFormulas.SQL.Add('                           FATDOR.FDO_ESPDOC = TINDOR.FDO_ESPDOC AND ');
    qryFormulas.SQL.Add('                           FATDOR.FDO_CODEMP = TINDOR.FDO_CODEMP AND ');
    qryFormulas.SQL.Add('                           FATDOR.FDO_CODCLI = TINDOR.FDO_CODCLI AND ');
    qryFormulas.SQL.Add('                           FATDOR.FDO_CODACA = TINDOR.FDO_CODACA AND ');
    qryFormulas.SQL.Add('                           FATDOR.FDO_EMPACA = TINDOR.FDO_EMPACA ');

    qryFormulas.SQL.Add('LEFT JOIN EXTDOR        ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ');

    qryFormulas.SQL.Add('WHERE ');
    qryFormulas.SQL.Add('  TINDOR.FDO_NUMDOC = :NUMDOC AND ');
    qryFormulas.SQL.Add('  TINDOR.FDO_ESPDOC = :ESPDOC AND ');
    qryFormulas.SQL.Add('  TINDOR.FDO_CODEMP = :CODEMP     ');
    If (Not fEmptyStr(strCodAca)) And (Not fEmptyStr(strEmpAca)) And ((Not (fCfgSis('EMIOPR', varBoolean))) Or (fCfgSis('IMPTIN', varBoolean))) Then
    Begin
      qryFormulas.SQL.Add('  AND TINDOR.FDO_CODACA = :CODACA ');
      qryFormulas.SQL.Add('  AND TINDOR.FDO_EMPACA = :EMPACA ');
    End;
    qryFormulas.SQL.Add(' GROUP BY TINDOR.FDO_CODACA, TINDOR.FDO_EMPACA ');
  End;

  qryFormulas.ParamByName('NUMDOC').AsString := strNumDoc;
  qryFormulas.ParamByName('ESPDOC').AsString := strEspDoc;
  qryFormulas.ParamByName('CODEMP').AsString := strCodEmp;

  if Assigned(qryFormulas.Params.FindParam('EMPPRD')) then
    qryFormulas.ParamByName('EMPPRD').AsString := strEmpPrd;

  If (Not fEmptyStr(strCodAca)) And (Not fEmptyStr(strEmpAca)) And ((Not (fCfgSis('EMIOPR', varBoolean))) Or (fCfgSis('IMPTIN', varBoolean))) Then
  Begin
    qryFormulas.ParamByName('CODACA').AsString := strCodAca;
    qryFormulas.ParamByName('EMPACA').AsString := strEmpAca;
  End;

  qryFormulas.Open;
  pSetaClient(qryFormulas);
  cdsFormulas.Open;
  pSetaClient(cdsFormulas);

  pMarcaTipoTinta;

  FTemFormula := (Not cdsFormulas.IsEmpty);

  cdsFormulacao := TUniClientDataSet.Create(Nil);

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DOCUMENTO';
    DataType := ftString;
    Size := 12;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ESPECIE';
    DataType := ftString;
    Size := 2;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'EMPRESA';
    DataType := ftString;
    Size := 3;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CLIENTE';
    DataType := ftString;
    Size := 80;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'FORMULA';
    DataType := ftString;
    Size := 200;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDFORMUL';
    DataType := ftString;
    Size := 15;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'COLORANTE';
    DataType := ftString;
    Size := 70;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QUANTIDADE';
    DataType := ftString;
    Precision := 15;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'OBSCOL';
    DataType := ftString;
    Size := 100;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TIPFOR';
    DataType := ftString;
    Precision := 30;
  End;



  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VENDEDOR';
    DataType := ftString;
    Size := 30;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DIGITADOR';
    DataType := ftString;
    Size := 30;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DATA';
    DataType := ftDate;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'HORA';
    DataType := ftTime;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNITAR';
    DataType := ftFloat;
    Precision := 15;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DILCON';
    DataType := ftString;
    Size := 20
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ANOCOR';
    DataType := ftString;
    Size := 20;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TIPEMB';
    DataType := ftString;
    Size := 10
  End;


  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'EMBALAGEM';
    DataType := ftString;
    Precision := 15;
  End;

  cdsFormulacao.CreateDataSet;
end;

procedure TFatOrdProTintaMaquina.pMarcaTipoTinta;
begin
  If Not Assigned(fTipoTinta) Then
    Exit;

  Try
    With cdsFormulas Do
    Begin
      First;

      While Not Eof Do
      Begin
        Edit;

        If (fTipoTinta(FieldByName('IDEPRO').AsString) = ttAutomotiva) Then
          FieldByName('TIPTIN').AsString := 'A'
        Else
          FieldByName('TIPTIN').AsString := 'I';

        Post;

        Next;
      End;

    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TFatOrdProTintaMaquina.pMarcaTipoTinta]');
  End;
end;

function TFatOrdProTintaMaquina.fRetornaDescricaoItemBase(strIteTin,
  strIdePro: String): String;
begin
  Result := '';
  if strIdePro = 'CIM' then
  begin
    Result := fRetornaItemBaseCoralImob(strIteTin);
  end;
end;

function TFatOrdProTintaMaquina.fRetornaEmbalagemColorante(
  strIdePro, strCodCol: String): Double;
var
  qryCons: TUniQuery;
begin
  Try
    qryCons := fCriaQuery;
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT COL_EMBALA ');
      SQL.Add('   FROM ' + fRetornaTabelaColoranteTinta(strIdePro));
      SQL.Add('  WHERE COL_CODCOL = :CODCOL');
      ParamByName('CODCOL').AsString := strCodCol;
      Open;

      Result := FieldByName('COL_EMBALA').AsFloat;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TFatOrdProTintaMaquina.fRetornaItemBaseCoralImob(
  strIteTin: String): String;
var
  strSQL: String;
  qryCons: TUniQuery;
begin
  Result := '';

  strSQL := '';
  strSQL := strSQL + ' SELECT COR_CODBAS,COR_CODUNI,COR_DESPRO ';
  strSQL := strSQL + '   FROM CORIMO_CADCOR ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CONCAT(IFNULL(COR_DESCRI, ""),  ';
  strSQL := strSQL + '          IFNULL(COR_CODIGO, ""),  ';
  strSQL := strSQL + '          IFNULL(COR_UNIDAD, ""),  ';
  strSQL := strSQL + '          IFNULL(COR_COLID1, ""),  ';
  strSQL := strSQL + '          IFNULL(COR_COLID2, ""),  ';
  strSQL := strSQL + '          IFNULL(COR_DESPRO, ""),  ';
  strSQL := strSQL + '          IFNULL(COR_CODBAS, ""),  ';
  strSQL := strSQL + '          IFNULL(COR_CODEMB, ""),  ';
  strSQL := strSQL + '          IFNULL(COR_CODUNI, ""),  ';
  strSQL := strSQL + '          IFNULL(COR_UNIVER, "")) = :ITETIN; ';

  Try
    qryCons := fCriaQuery(nil);

    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ITETIN').AsString := strIteTin;
      Open;

      If Not IsEmpty Then
        Result := fRetornaProdutoBase(FieldByName('COR_CODBAS').AsString,
                                      FieldByName('COR_CODUNI').AsString,
                                      FieldByName('COR_DESPRO').AsString);
    End;

  Finally
    FreeAndNil(qryCons);
  End;
end;

function TFatOrdProTintaMaquina.fRetornaProdutoBase(strCodBas, strUnidad, strDescri: String): String;
  Var
    qryCons: TUniQuery;
begin
  Result := '';

  Try
    qryCons := fCriaQuery(nil);

    With qryCons Do
    Begin
      Close;
      SQL.Add('SELECT ');
      SQL.Add('  BAS_CODITE, ITE_DESITE ');
      SQL.Add('FROM ');
      SQL.Add('  CORIMO_CADBAS ');
      SQL.Add('INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ');
      SQL.Add('WHERE ');
      SQL.Add('  BAS_BASE__ = :CODBAS AND ');
      SQL.Add('  BAS_DESCRI = :DESCRI AND ');
      SQL.Add('  BAS_UNIDAD = :UNIDAD ');
      ParamByName('CODBAS').AsString := strCodBas;
      ParamByName('DESCRI').AsString := strDescri;
      ParamByName('UNIDAD').AsString := strUnidad;
      Open;

      If Not IsEmpty Then
        Result := ' - ' + FieldByName('BAS_CODITE').AsString + ' Ref.' + FieldByName('ITE_DESITE').AsString;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TFatOrdProTintaMaquina.fRetornarTipoFormulacao(intIdx: Integer): String;
begin
  Result := IIF(intIdx = 0, 'FÓRMULA ORIGINAL', 'FÓRMULA AJUSTADA');
end;

end.



