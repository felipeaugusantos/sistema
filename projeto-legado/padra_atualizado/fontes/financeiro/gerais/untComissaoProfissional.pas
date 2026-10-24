{*********************************************************}
{* CLASSE PARA COMISSÃO DE PROFISSIONAIS                 *}
{* (MANUTENÇÃO / RELATORIO)                              *}
{*                                                       *}
{* DATA......: 12/05/2008                                *}
{* AUTOR.....: LUCIENE                                   *}
{*                                                       *}
{******************************************************LU*}
unit untComissaoProfissional;

interface

uses Classes, StrUtils, SysUtils, Uni, UniClientDataSet, UniDataSetProvider, DB, untfuncoesSimples,
     EditFocus, Forms, untGeraExcel, untExcel, Variants, StdCtrls, untTypesSistema, untFuncoesGenerica,
     untFuncFatTypes, untLogCom, untAtiGru;

Type

  TComPro = Class(TComponent)
  Private
    fltTotPerComi,
    fltTotGerComi,
    fltTotGer: Double;
    FForRel: Pointer;
    FAnalit: Boolean;
    FCodSeq: String;
    FDtaCad: TDateTime;
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FCodCli: String;
    FCodPro: String;
    FCodVen: String;
    FCodAti: String;
    FCreDeb: String;
    FVrVend: Double;
    FVrComi: Double;
    FObserv: String;
    FTipFil: String;
    FStatus: Integer;
    fMulSel: Boolean;
    FOrdem : Integer;
    FCodFor: String;
    FcmsCodPro : TConsultaMultSelecao;
    FcmsCodVen : TConsultaMultSelecao;
    FcmsCodVe2 : TConsultaMultSelecao;
    FcmsCodAti : TConsultaMultSelecao;
    FcmsCodCli : TConsultaMultSelecao;
    FcmsCodRed : TConsultaMultSelecao;
    FcmsCodEmp : TConsultaMultSelecao;
    FcmsCodFor : TConsultaMultSelecao;

    {*************************************}
    {* INCLUIDO FILTRO POR REDE DE LOJAS *}
    {**********************************DP*}
    arrRede    : TConsultasArray;
    edtCodRede : TEditFocus;
    arrTitulos : Array Of String;

    FDtaIni: TDateTime;
    FDtaFin: TDateTime;

    FDtaBai: TDateTime;
    FDtaBaf: TDateTime;

    function getDtaCad: String;
    function getVrVend: String;
    function getVrComi: String;
    function getDtaFin: String;
    function getDtaIni: String;
    function getDtaBaf: String;
    function getDtaBai: String;
    function getTipFil: String;

    procedure setDtaCad(const Value: String);
    procedure setVrVend(const Value: String);
    procedure setVrComi(const Value: String);
    procedure setDtaFin(const Value: String);
    procedure setDtaIni(const Value: String);
    procedure setDtaBaf(const Value: String);
    procedure setDtaBai(const Value: String);
    procedure setTipFil(const Value: String);

    {**************************************}
    {* PROCEDURES E FUNÇÕES GERAIS        *}
    {***********************************LU*}
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pAfterOpenSal(DataSet: TDataSet);
    function fAjustaSQLParaDataFaturamento(strSQL: String): String;

    function fCalculaPerComExcelAnalitico(dtsDados: TDataSet): Double;

    Procedure pMontaExcelAnalitico(frmForRel: Pointer);
    Procedure pMontaExcelSintetico(frmForRel: Pointer; blnExpSimples: Boolean = False);

    procedure pMontaTitGru(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    Procedure pMontaTitulos;
    Procedure pMontaTitulosAnalitico(objExcel : TGeraExcel);

    function fSQLFiltroVendedor2(): String;
  Public


    qryComSal: TUniQuery;
    qryComPro: TUniQuery;
    cpvComPro: TUniDataSetProvider;
    cdsComPro: TUniClientDataSet;

    VS_strTCoProInterna: String;

    property strCodSeq: String Read FCodSeq   Write FCodSeq;
    property strDtaCad: String Read getDtaCad Write setDtaCad;
    property strNumDoc: String Read FNumDoc   Write FNumDoc;
    property strEspDoc: String Read FEspDoc   Write FEspDoc;
    property strCodEmp: String Read FCodEmp   Write FCodEmp;
    property strCodCli: String Read FCodCli   Write FCodCli;
    property strCodPro: String Read FCodPro   Write FCodPro;
    property strCodVen: String Read FCodVen   Write FCodVen;
    property strCodAti: String Read FCodAti   Write FCodAti;
    property strCreDeb: String Read FCreDeb   Write FCreDeb;
    property strVrVend: String Read getVrVend Write setVrVend;
    property strVrComi: String Read getVrComi Write setVrComi;
    property strObserv: String Read FObserv   Write FObserv;
    property strDtaIni: String Read getDtaIni Write setDtaIni;
    property strDtaFin: String Read getDtaFin Write setDtaFin;
    property strDtaBai: String Read getDtaBai Write setDtaBai;
    property strDtaBaf: String Read getDtaBaf Write setDtaBaf;
    property arrRedeLo: TConsultasArray Read arrRede Write arrRede;
    property edtCodRed: TEditFocus Read edtCodRede Write edtCodRede;
    property strTipFil: String Read getTipFil Write setTipFil;
    property blnMulSel: Boolean Read fMulSel Write fMulSel;
    property intOrdem : Integer Read FOrdem  Write FOrdem;
    property intStatus: Integer Read FStatus Write FStatus;
    property strCodFor: String Read FCodFor   Write FCodFor;
    property cmsCodPro: TConsultaMultSelecao Read FcmsCodPro Write FcmsCodPro;
    property cmsCodVen: TConsultaMultSelecao Read FcmsCodVen Write FcmsCodVen;
    property cmsCodVe2: TConsultaMultSelecao Read FcmsCodVe2 Write FcmsCodVe2;
    property cmsCodAti: TConsultaMultSelecao Read FcmsCodAti Write FcmsCodAti;
    property cmsCodCli: TConsultaMultSelecao Read FcmsCodCli Write FcmsCodCli;
    property cmsCodRed: TConsultaMultSelecao Read FcmsCodRed Write FcmsCodRed;
    property cmsCodEmp: TConsultaMultSelecao Read FcmsCodEmp Write FcmsCodEmp;
    property cmsCodFor: TConsultaMultSelecao Read FcmsCodFor Write FcmsCodFor;

    function fRetComissaoProfissionalItem(strCodIte: String): Double;

    Procedure pMontaExcel(frmForRel: Pointer; blnExpSimples: Boolean = False);

    procedure pGeraRelatorioComissao(strAnaSin: String; intCalc: Integer);

    procedure pRetornaSaldoInicial(strCodPro: String;  intCalc: Integer;
      dtaDtaIni: TDateTime; Var fltSalVen, fltSalCom: Double);

    procedure pAjustaComissaoDigitadaManualmente(arrMatItens: TMatrizFechamento; fltPerComPro, fltValorComissao: Double);

    function fGravaComPro(Var strCodCom: String;
                          strNumDoc,
                          strEspDoc,
                          strCodCli,
                          strCodPro,
                          strCreDeb,
                          strObserv: String;
                          fltVrVend,
                          fltVrComi: Double;
                          strNomeForm : String = '';
                          fltVlrComOri: Double = 0 ): Boolean;

    function fGravaMovCpr(arrMatItens: TMatrizFechamento;
                          strNumDocDev,
                          strEspDocDev,
                          strCodCliDev,
                          strCodComPro: String;
                          strCodDiv: String;
                          strCodIteDev: String = '';
                          strAutIncDev: String = '';
                          fltBasComDev: Double = 0.00;
                          fltPerComDev: Double = 0.00;
                          fltVlrComDev: Double = 0.00;
                          strSomenteOsAutIncDet: String = ''): Boolean;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor  Destroy; Override;
  End;

Const
  ORD_PROFISSIONAL      = 0;
  ORD_DATA_FATURAMENTO  = 1;
  ORD_VENDEDOR          = 2;
  ORD_PROFISSIONAL_EMP  = 3;
  ORD_PROFISSIONAL_NOME = 4;

implementation

uses untFuncoes, untFuncoesConsulta, untRelComissaoProfissionais;

{ TComPro }

constructor TComPro.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  VS_strTCoProInterna := fCfgSis('TCOPRO');

  qryComSal := fCriaQuery(Self);
  qryComSal.AfterOpen := pAfterOpenSal;

  qryComPro := fCriaQuery(Self);
  qryComPro.AfterOpen := pAfterOpen;

  cpvComPro := TUniDataSetProvider.Create(Self);
  cpvComPro.DataSet := qryComPro;

  cdsComPro := TUniClientDataSet.Create(Self);
  cdsComPro.SetProvider(cpvComPro);

  With qryComPro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM COMPRO LIMIT 0');
  End;

  fMulSel := False;

end;

destructor TComPro.Destroy;
Begin
  FreeAndNil(qryComSal);
  FreeAndNil(qryComPro);
  FreeAndNil(cdsComPro);
  FreeAndNil(cpvComPro);
  inherited Destroy;
End;

function TComPro.getDtaCad: String;
begin
  Result := IfThen(FDtaCad = 0, '', FormatDateTime('dd/mm/yyyy',FDtaCad));
end;

function TComPro.getVrVend: String;
begin
  Result := FloatToStrF(FVrVend,ffFixed,12,2);
end;

function TComPro.getVrComi: String;
begin
  Result := FloatToStrF(FVrComi,ffFixed,12,2);
end;

procedure TComPro.pAfterOpen(DataSet: TDataSet);
begin

  With qryComPro Do
  Begin
    (FieldByName('COM_DTACAD') As TDateField).EditMask       := '99/99/9999';

    (FieldByName('COM_DTABAI') As TDateField).EditMask       := '99/99/9999';

    (FieldByName('COM_VRVEND') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('COM_VRVEND') As TFloatField).EditFormat    := '#,##0.00';

    (FieldByName('COM_VRCOMI') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('COM_VRCOMI') As TFloatField).EditFormat    := '#,##0.00';

  End;

end;

procedure TComPro.pAfterOpenSal(DataSet: TDataSet);
begin

  With qryComSal Do
  Begin
    (FieldByName('SALVEN') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('SALVEN') As TFloatField).EditFormat    := '#,##0.00';

    (FieldByName('SALCOM') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('SALCOM') As TFloatField).EditFormat    := '#,##0.00';

  End;

end;


procedure TComPro.pAjustaComissaoDigitadaManualmente(
  arrMatItens: TMatrizFechamento; fltPerComPro, fltValorComissao: Double);
var
  intContador: integer;
  fltTotComissao: Double;
  fltDiferenca: Double;
begin
  fltTotComissao := 0;
  for intContador := Low(ArrMatItens) to High(ArrMatItens) do
  begin
    ArrMatItens[intContador].fltPerComPro := fltPerComPro;
    ArrMatItens[intContador].fltVlrComPro := ((ArrMatItens[intContador].fltBasComPro * ArrMatItens[intContador].fltPerComPro) / 100);
    fltTotComissao := fltTotComissao + ArrMatItens[intContador].fltVlrComPro;
  end;

  fltDiferenca := fltTotComissao - fltValorComissao;

  if fltDiferenca <> 0 then
    ArrMatItens[Length(ArrMatItens) - 1].fltVlrComPro := ArrMatItens[Length(ArrMatItens) - 1].fltVlrComPro - fltDiferenca;
end;

procedure TComPro.setDtaCad(const Value: String);
begin
  FDtaCad := StrToDateDef(Value,0);
end;

procedure TComPro.setVrVend(const Value: String);
begin
  FvrVend := fStrToFloat(Value);
end;

procedure TComPro.setVrComi(const Value: String);
begin
  FVrComi := fStrToFloat(Value);
end;

function TComPro.fGravaComPro(Var strCodCom: String;
                              strNumDoc,
                              strEspDoc,
                              strCodCli,
                              strCodPro,
                              strCreDeb,
                              strObserv: String;
                              fltVrVend,
                              fltVrComi: Double;
                              strNomeForm : String = '';
                              fltVlrComOri: Double = 0 ): Boolean;

Var
   strAutoInc : String;
Begin

  Try

    If (Not qryComPro.Active) Then
      qryComPro.Open;

    qryComPro.Insert;

    strCodCom := fAtualizaProCod('COMPRO', 'COM_CODCOM');

    strAutoInc := fRetAutoIncrem('COMPRO',VS_strCodEmp);

    qryComPro.FieldByName('AUTOINCREM').AsString   := strAutoInc;
    qryComPro.FieldByName('COM_CODCOM').AsString   := strCodCom;
    qryComPro.FieldByName('COM_DTACAD').AsDateTime := VS_Date;
    qryComPro.FieldByName('COM_NUMDOC').AsString   := strNumDoc;
    qryComPro.FieldByName('COM_ESPDOC').AsString   := strEspDoc;
    qryComPro.FieldByName('COM_CODEMP').AsString   := VS_strCodEmp;
    qryComPro.FieldByName('COM_CODCLI').AsString   := strCodCli;
    qryComPro.FieldByName('COM_CODPRO').AsString   := strCodPro;
    qryComPro.FieldByName('COM_CREDEB').AsString   := strCreDeb;
    qryComPro.FieldByName('COM_OBSERV').AsString   := strObserv;
    qryComPro.FieldByName('COM_VRVEND').AsFloat    := fFormataFloat(fltVrVend, 2);
    qryComPro.FieldByName('COM_VRCOMI').AsFloat    := fFormataFloat(fltVrComi, 2);
    qryComPro.FieldByName('COM_VRCORI').AsFloat    := fFormataFloat(fltVlrComOri, 2);

    qryComPro.Post;


    Result := fGravaLogCom( strAutoInc, strObserv, strNomeForm, '');

  Except
    On E: Exception Do
    Begin
      Result := False;
      pRaise(e.Message);
    End;
  End;

End;

function TComPro.fGravaMovCpr(arrMatItens: TMatrizFechamento;
                              strNumDocDev,
                              strEspDocDev,
                              strCodCliDev,
                              strCodComPro: String;
                              strCodDiv: String;
                              strCodIteDev: String = '';
                              strAutIncDev: String = '';
                              fltBasComDev: Double = 0.00;
                              fltPerComDev: Double = 0.00;
                              fltVlrComDev: Double = 0.00;
                              strSomenteOsAutIncDet: String = ''): Boolean;
  Var
    qryAux : TUniQuery;
    intCont: Integer;
    strSQL : String;
    objAtiGru: TAtiGru;

  function fGetSeqComPro: String;
  begin
    Result := fCampoTabela('AUTOINCREM','COMPRO',['COM_CODCOM','COM_CODEMP'],[strCodComPro,VS_strCodEmp]);
  end;

Begin
  Try
    objAtiGru := TAtiGru.Create(Self);
    objAtiGru.fCarregaAtiGru(fRetAtividadeProfissional(strCodDiv));

    Result := True;

    qryAux := fCriaQuery(Self);

    With qryAux Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO MOVCPR ( ';
      strSQL := strSQL + '  AUTOINCREM,          ';
      strSQL := strSQL + '  CPR_SEQDET,          ';
      strSQL := strSQL + '  CPR_SEQCOM,          ';
      strSQL := strSQL + '  CPR_CODCOM,          ';
      strSQL := strSQL + '  CPR_BASCOM,          ';
      strSQL := strSQL + '  CPR_VLRCOM,          ';
      strSQL := strSQL + '  CPR_PERCOM) VALUES ( ';
      strSQL := strSQL + '  :AUTINC,             ';
      strSQL := strSQL + '  :SEQDET,             ';
      strSQL := strSQL + '  :SEQCOM,             ';
      strSQL := strSQL + '  :CODCOM,             ';
      strSQL := strSQL + '  :BASCOM,             ';
      strSQL := strSQL + '  :VLRCOM,             ';
      strSQL := strSQL + '  :PERCOM  )           ';

      SQL.Clear;
      SQL.Add(strSQL);

      If (fltVlrComDev > 0) Then
      Begin
        ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVCPR',VS_strCodEmp);
        ParamByName('SEQCOM').AsString := fGetSeqComPro;
        ParamByName('CODCOM').AsString := strCodComPro;
        ParamByName('BASCOM').AsFloat  := fltBasComDev;
        ParamByName('VLRCOM').AsFloat  := fltVlrComDev;
        ParamByName('PERCOM').AsFloat  := fltPerComDev;
        ParamByName('SEQDET').AsString := strAutIncDev;
        ExecSQL;
      End
      Else
      Begin
        For intCont := Low(ArrMatItens) To High(ArrMatItens) Do
        Begin
           If ((Not strSomenteOsAutIncDet.IsEmpty) And (Pos(ArrMatItens[intCont].strAutIncDet, strSomenteOsAutIncDet) = 0)) Then
              Continue;

          If objAtiGru.IsEmpty Or //Caso nao tenha linhas/grupos informados para a atividade
             objAtiGru.fLinhaGrupoJaInformado(ArrMatItens[intCont].strCodGru) Or //Caso o grupo permita comissao
             objAtiGru.fLinhaGrupoJaInformado(LeftStr(ArrMatItens[intCont].strCodGru, 3) + '000') Then //Caso a Linha permita comissao
          Begin
            If Not fEmptyStr(ArrMatItens[intCont].strAutIncDet) Then
            Begin
              ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVCPR',VS_strCodEmp);
              ParamByName('SEQCOM').AsString := fGetSeqComPro;
              ParamByName('CODCOM').AsString := strCodComPro;
              ParamByName('BASCOM').AsFloat  := ArrMatItens[intCont].fltBasComPro;
              ParamByName('VLRCOM').AsFloat  := ArrMatItens[intCont].fltVlrComPro;
              ParamByName('PERCOM').AsFloat  := ArrMatItens[intCont].fltPerComPro;
              ParamByName('SEQDET').AsString := ArrMatItens[intCont].strAutIncDet;
              ExecSQL;
            End;
          End;
        End;
      End;
    End;

    FreeAndNil(qryAux);
    FreeAndNil(objAtiGru);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pRaise(e.Message);
    End;
  End;
End;

function TComPro.getDtaFin: String;
begin
  Result := IfThen(FDtaFin = 0, '', FormatDateTime('dd/mm/yyyy', FDtaFin));
end;

function TComPro.getDtaIni: String;
begin
  Result := IfThen(FDtaIni = 0, '', FormatDateTime('dd/mm/yyyy', FDtaIni));
end;

function TComPro.getDtaBaF: String;
begin
  Result := IfThen(FDtaBaf = 0, '', FormatDateTime('dd/mm/yyyy', FDtaBaf));
end;

function TComPro.getDtaBai: String;
begin
  Result := IfThen(FDtaBai = 0, '', FormatDateTime('dd/mm/yyyy', FDtaBai));
end;

function TComPro.getTipFil: String;
begin
  Result := FTipFil;
end;

procedure TComPro.setDtaFin(const Value: String);
begin
  FDtaFin := StrToDateDef(Value, 0);
end;

procedure TComPro.setDtaIni(const Value: String);
begin
  FDtaIni := StrToDateDef(Value, 0);
end;

procedure TComPro.setDtaBaf(const Value: String);
begin
  FDtaBaf := StrToDateDef(Value, 0);
end;

procedure TComPro.setDtaBai(const Value: String);
begin
  FDtaBai := StrToDateDef(Value, 0);
end;

procedure TComPro.setTipFil(const Value: String);
begin
  FTipFil := Value;
end;

{*********************************}
{* GERA O RELATÓRIO DE COMISSÃO  *}
{******************************LU*}
procedure TComPro.pGeraRelatorioComissao(strAnaSin: String; intCalc: Integer);
  Var
    strSQL   : String;
    strSQLFF : String;
    strSQLTRDV: String;

    blnComProFF: Boolean;
    blnComProTRDV: Boolean;
    blnFiltraVendedor: Boolean;
    blnFiltraFornecedor: Boolean;
begin
  FAnalit := strAnaSin = 'A';

  blnComProFF   := False;
  blnComProTRDV := False;

  blnFiltraVendedor := (FAnalit) Or (Not fEmptyStr(FCodVen)) Or (Length(cmsCodVen.arrSelecao) > 0);
  blnFiltraFornecedor := (Not fEmptyStr(FCodFor)) Or (Length(cmsCodFor.arrSelecao) > 0);

  {***********************************}
  {* SELECT  DO RELATÓRIO            *}
  {********************************JB*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COM_DTACAD, ';
  strSQL := strSQL + '  COM_NUMDOC, ';
  strSQL := strSQL + '  COM_ESPDOC, ';
  strSQL := strSQL + '  COM_CODEMP, ';
  strSQL := strSQL + '  CONCAT(COM_CODEMP,"-",EMP_NOMEMP) AS NOMEMP, ';
  strSQL := strSQL + '  COM_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CONCAT(COM_CODCLI,"-", CLI_NOMCLI) AS NOMCLI, ';
  strSQL := strSQL + '  COM_CODPRO, ';
  strSQL := strSQL + '  DIV_NOMDIV, ';
  strSQL := strSQL + '  DIV_PERCOM, ';
  strSQL := strSQL + '  DIV_EMAIL_, ';
  strSQL := strSQL + '  DIV_C_G_C_, ';
  strSQL := strSQL + '  DIV_CELULA, ';
  strSQL := strSQL + '  (SELECT ATI_DESATI FROM CADATI WHERE ATI_CODATI = DIV_CODATI LIMIT 1) AS ATI_DESATI, ';

  If blnFiltraFornecedor Then
  Begin
    strSQL := strSQL + '  (IF(LEFT(D.DET_CLAFIS, 1) < 5 OR D.DET_ESPDOC = "BR" OR (D.DET_CLAFIS IN ("5910", "6910")), -1, 1) * ';
    strSQL := strSQL + '     (D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF)) AS COM_VRVEND, ';
  End
  Else
    strSQL := strSQL + '  ABS(COM_VRVEND) * IF(COM_CREDEB = "C", 1, -1) AS COM_VRVEND, ';

  If blnFiltraVendedor Then
  Begin
    strSQL := strSQL + '  CONCAT(OPE_CODOPE,"-",OPE_NOMOPE) AS VENDED,';
    strSQL := strSQL + '  OPE_NOMOPE AS NOMOPE,';
  End;

  If intCalc = 1 Then
  Begin
    If blnFiltraFornecedor Then
    Begin
      If VS_strTCoProInterna = '3' Then
        strSQL := strSQL + '  (IF(LEFT(D.DET_CLAFIS, 1) < 5 OR COM_ESPDOC = "BR" OR (D.DET_CLAFIS IN ("5910", "6910")), -1, 1) * ABS(IFNULL(D.DET_QTDPON, 0) * D.DET_QTDITE)) AS COM_VRCOMI, '
      Else
      Begin
        strSQL := strSQL + '  IF(LEFT(D.DET_CLAFIS, 1) < 5 OR COM_ESPDOC = "BR" OR (D.DET_CLAFIS IN ("5910", "6910")), -(ROUND((D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF) / 100)), ';
        strSQL := strSQL + '  ROUND((((D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF) / ';
        strSQL := strSQL + '  (G.GER_TOTPRO - G.GER_DESESP - G.GER_DESCFF)) * COM_VRCOMI), 2)) AS COM_VRCOMI, ';
      End
    End
    Else
      strSQL := strSQL + '  ABS(COM_VRCOMI) * IF(COM_CREDEB = "C", 1, -1) AS COM_VRCOMI, '
  End
  Else
  Begin
    {************************************************************************}
    {* QUANDO "BRINDE, NF BRINDE" E DÉBITO, O VALOR ENTRA NA SUA TOTALIDADE *}
    {*********************************************************************RN*}
    If blnFiltraFornecedor Then
    Begin
      If VS_strTCoProInterna = '3' Then
        strSQL := strSQL + '  (IF(LEFT(D.DET_CLAFIS, 1) < 5 OR COM_ESPDOC = "BR" OR (D.DET_CLAFIS IN ("5910", "6910")), -1, 1) * ABS(IFNULL(D.DET_QTDPON, 0) * D.DET_QTDITE)) AS COM_VRCOMI, '
      Else
      Begin
        strSQL := strSQL + '  IF(LEFT(D.DET_CLAFIS, 1) < 5 OR COM_ESPDOC = "BR" OR (D.DET_CLAFIS IN ("5910", "6910")), -(ROUND((D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF) / 100)), ';
        strSQL := strSQL + '  (((D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF) / 100) * DIV_PERCOM)) AS COM_VRCOMI, ';
      End
    End
    Else
    Begin
      strSQL := strSQL + ' IF(((IFNULL(COM_ESPDOC, "") = "BR") OR (G.GER_CLAFIS IN ("5910", "6910")) OR (RIGHT(G.GER_CLAFIS, 3) = :CLABRI)), ';
      strSQL := strSQL + '   IF(COM_CREDEB = "C", (IF(COM_VRVEND > 0, (COM_VRVEND/100)*DIV_PERCOM, COM_VRCOMI)), -COM_VRCOMI),  ';
      strSQL := strSQL + '     IF(COM_CREDEB = "C", (IF(COM_VRVEND > 0, (COM_VRVEND/100)*DIV_PERCOM, COM_VRCOMI)), -(IF(COM_VRVEND > 0, (COM_VRVEND/100)*DIV_PERCOM, COM_VRCOMI)))) AS COM_VRCOMI, ';
    End;
  End;

  strSQL := strSQL + '  COM_DTABAI, ';
  strSQL := strSQL + '  COM_CREDEB, ';
  strSQL := strSQL + '  COM_OBSERV  ';
  strSQL := strSQL + 'FROM          ';
  strSQL := strSQL + '  COMPRO      ';
  strSQL := strSQL + '  LEFT JOIN CADEMP ON COM_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = COM_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADDIV ON DIV_CODDIV = COM_CODPRO ';

  If (intCalc = 2) Or (blnFiltraVendedor) Or blnFiltraFornecedor Then
  Begin
    strSQL := strSQL + '  LEFT JOIN MOVGER G ON G.GER_NUMDOC = COM_NUMDOC ';
    strSQL := strSQL + '                    AND G.GER_ESPDOC = COM_ESPDOC ';
    strSQL := strSQL + '                    AND G.GER_CODEMP = COM_CODEMP ';
    strSQL := strSQL + '                    AND G.GER_CODCLI = COM_CODCLI ';

    If blnFiltraVendedor Then
      strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = G.GER_CODVEN ';
  End;

  If blnFiltraFornecedor Then
    strSQL := strSQL + '  LEFT JOIN MOVDET  D  ON  G.AUTOINCREM = D.DET_SEQGER  ';

  {*****************************************}
  {* ESSA LINHA SERÁ SUBSTITUIDA MAIS A    *}
  {* FRENTE DA SEGUINTE FORMA:             *}
  {* 1) NA PARTE NORMAL DO RELATORIO, FICA-*}
  {*    RÁ EM BRANCO                       *}
  {* 2) NA PARTE DE FF/TR/DV POR DATA DE   *}
  {*    FATURAMENTO, TERÁ UM JOIN COM O    *}
  {*    MOVGER                             *}
  {**************************************MV*}
  strSQL := strSQL + '  JOINMOVGER ';

  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL  + ' IF(IFNULL(COM_TCOPRO, "") = "", ' + QuotedStr(VS_strTCoProInterna) +
                                       ', COM_TCOPRO) = ' + QuotedStr(VS_strTCoProInterna) + ' AND ';

  If (FTipFil = 'P') Then
    strSQL    := strSQL    + '  COM_DTABAI IS NULL AND '
  Else If (FTipFil = 'B') Then
    strSQL    := strSQL    + '  COM_DTABAI IS NOT NULL AND ';

  strSQL := strSQL + '  TRUE ';

  If FDtaIni > 0 Then
    strSQL := strSQL + '  AND COM_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  If FDtaBai > 0 Then
    strSQL := strSQL + '  AND COM_DTABAI BETWEEN :DTABAI AND :DTABAF ';

  If blnMulSel Then
    strSQL := strSQL + fStrLocate(cmsCodCli.edtCodigo, cmsCodCli.arrSelecao, 'COM_CODCLI', 'CODCLI')
  Else
    If Not fEmptyStr(FCodCli) Then
      strSQL    := strSQL    + '  AND COM_CODCLI = :CODCLI ';

  if blnMulSel Then
    strSQL := strSQL + fStrLocate(cmsCodPro.edtCodigo, cmsCodPro.arrSelecao, 'COM_CODPRO', 'CODPRO')
  Else
    If Not fEmptyStr(FCodPro) Then
      strSQL    := strSQL    + '  AND COM_CODPRO = :CODPRO ';

  If blnFiltraVendedor Then
  Begin
    If blnMulSel Then
      strSQL := strSQL + fStrLocate(cmsCodVen.edtCodigo, cmsCodVen.arrSelecao, 'OPE_CODOPE', 'CODVEN')
    Else
      If Not fEmptyStr(FCodVen) Then
        strSQL := strSQL + '  AND OPE_CODOPE = :CODVEN ';
  End;

  If Length(cmsCodVe2.arrSelecao) > 0 Then
    strSQL := strSQL + ' AND ' + fSQLFiltroVendedor2();

  If blnMulSel Then
    strSQL := strSQL + fStrLocate(cmsCodAti.edtCodigo, cmsCodAti.arrSelecao, 'DIV_CODATI', 'CODATI')
  Else
    If Not fEmptyStr(FCodAti) Then
      strSQL    := strSQL    + '  AND DIV_CODATI = :CODATI ';

  if blnMulSel Then
    strSQL := strSQL + fStrLocate(cmsCodEmp.edtCodigo, cmsCodEmp.arrSelecao, 'COM_CODEMP', 'CODEMP')
  Else
    If Not fEmptyStr(FCodEmp) Then
      strSQL    := strSQL    + '  AND COM_CODEMP = :CODEMP '
    Else
      strSQL    := strSQL    + '  AND LOCATE(COM_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If blnMulSel Then
    strSQL := strSQL + fStrLocate(cmsCodFor.edtCodigo, cmsCodFor.arrSelecao, 'D.DET_FORITE', 'CODFOR')
  Else
    If Not fEmptyStr(FCodFor) Then
      strSQL    := strSQL    + '  AND D.DET_FORITE = :CODFOR ';

  Case intStatus Of
    0: strSQL := strSQL + '  AND DIV_STATUS = "A" ';
    1: strSQL := strSQL + '  AND DIV_STATUS = "I" ';
  End;

  {****************************}
  {* FILTRO POR REDE DE LOJAS *}
  {*************************DP*}
  if not blnMulSel Then
    strSQL := strSQL + fStrLocate(cmsCodRed.edtCodigo, cmsCodRed.arrSelecao, 'CLI_CODRED', 'CODRED')
  Else
    If Not fEmptyStr(edtCodRede.Text) Then
    Begin
      strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');
    End;

  {*****************************************}
  {* COLOCA O JOIN COM O MOVGER           *}
  {**************************************MV*}
  strSQLFF := fAjustaSQLParaDataFaturamento(strSQL);

  strSQLTRDV := strSQLFF;


  strSQLFF   := strSQLFF + ' AND COM_ESPDOC = "FF" ';
  strSQLTRDV := strSQLTRDV + ' AND COM_ESPDOC IN ("TR", "DV") ';

  strSQL := AnsiReplaceStr(strSQL, 'JOINMOVGER', '');

  If (fCfgSis('CPROFF') = '2') Then
  Begin
    blnComProFF := True;
    strSQL      := strSQL + ' AND IFNULL(COM_ESPDOC, "") <> "FF" ';
  End;

  If (fCfgSis('CPROTR') = '2') Then
  Begin
    blnComProTRDV := True;
    strSQL := strSQL + ' AND IFNULL(COM_ESPDOC, "") NOT IN ("TR", "DV") ';
  End;

  {*****************************************}
  {* EFETUA O SELECT FINAL, USANDO TODOS OS*}
  {* UNIONs.                               *}
  {**************************************MV*}
  If (blnComProFF) Then
    strSQL := strSQL + ' UNION ALL ' + strSQLFF;

  If (blnComProTRDV) Then
    strSQL := strSQL + ' UNION ALL ' + strSQLTRDV;

  strSQL := 'SELECT '        +
            '  COM_DTACAD, ' +
            '  COM_NUMDOC, ' +
            '  COM_ESPDOC, ' +
            '  COM_CODEMP, ' +
            '  NOMEMP,     ' +
            '  COM_CODCLI, ' +
            '  CLI_NOMCLI, ' +
            '  NOMCLI, '     +
            '  COM_CODPRO, ' +
            '  DIV_NOMDIV, ' +
            '  DIV_PERCOM, ' +
            '  ATI_DESATI, ' +
            '  DIV_EMAIL_, ' +
            '  DIV_C_G_C_, ' +
            '  DIV_CELULA, ' +
            IIF(strAnaSin = 'A', '  COM_VRVEND, ', '  SUM(COM_VRVEND) COM_VRVEND, ') +
            IIF(strAnaSin = 'A', '  COM_VRCOMI, ', '  SUM(COM_VRCOMI) COM_VRCOMI, ') +
            '  COM_DTABAI, ' +
            '  COM_CREDEB, ' +
            '  COM_OBSERV, ' +

            ' CONCAT(COM_CODPRO, " ", DIV_NOMDIV, " - ", ATI_DESATI) AS NOMPRO ' +

            IIF(blnFiltraVendedor, ' , VENDED ', '')+
            IIF(blnFiltraVendedor, ' , NOMOPE ', '')+

            '  FROM (' + strSQL + ') AS TBL ';

  If strAnaSin = 'A' Then
  Begin
    strSQL := strSQL + 'ORDER BY     ';
    Case FOrdem Of
      ORD_PROFISSIONAL:
        Begin
          strSQL := strSQL + '  COM_CODPRO, ';
          strSQL := strSQL + '  COM_DTACAD, ';
          strSQL := strSQL + '  COM_CODEMP ';
        End;
      ORD_DATA_FATURAMENTO:
        Begin
          strSQL := strSQL + '  COM_DTACAD, ';
          strSQL := strSQL + '  COM_CODPRO, ';
          strSQL := strSQL + '  COM_CODEMP, ';
          strSQL := strSQL + '  COM_ESPDOC, ';
          strSQL := strSQL + '  COM_NUMDOC ';
        End;
      ORD_VENDEDOR:
        Begin
          strSQL := strSQL + '  NOMOPE, ';
          strSQL := strSQL + '  COM_DTACAD, ';
          strSQL := strSQL + '  DIV_NOMDIV, ';
          strSQL := strSQL + '  COM_CODPRO, ';
          strSQL := strSQL + '  COM_CODEMP, ';
          strSQL := strSQL + '  COM_ESPDOC, ';
          strSQL := strSQL + '  COM_NUMDOC ';
        End;
      ORD_PROFISSIONAL_EMP:
        Begin
          strSQL := strSQL + '  NOMEMP, ';
          strSQL := strSQL + '  COM_CODPRO, ';
          strSQL := strSQL + '  COM_DTACAD ';
        End;
      ORD_PROFISSIONAL_NOME:
        Begin
          strSQL := strSQL + '  DIV_NOMDIV, ';
          strSQL := strSQL + '  COM_CODPRO  ';
        End;
    End;

  End
  Else
  Begin
    strSQL := strSQL + 'GROUP BY     ';
    strSQL := strSQL + '  COM_CODPRO ';
    strSQL := strSQL + 'ORDER BY     ';
    strSQL := strSQL + '  COM_CODPRO, ';
    strSQL := strSQL + '  COM_DTACAD ';
  End;

  {***********************************}
  {* EXECUTA A QRY P\ GERAL DO REL   *}
  {********************************JB*}
  With qryComPro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If FDtaIni > 0 Then
    Begin
      ParamByName('DTAINI').AsDate := FDtaIni;
      ParamByName('DTAFIN').AsDate := FDtaFin;
    End;

    If FDtaBai > 0 Then
    Begin
      ParamByName('DTABAI').AsDate := FDtaBai;
      ParamByName('DTABAF').AsDate := FDtaBaf;
    End;

    If blnMulSel Then
      pSetaParam(TEdit(cmsCodCli.edtCodigo).Text, cmsCodCli.arrSelecao, cmsCodCli.strSelecao^, 'CODCLI', qryComPro)
    Else
      If Not fEmptyStr(FCodCli) Then
        ParamByName('CODCLI').AsString := FCodCli;

    If blnMulSel Then
      pSetaParam(TEdit(cmsCodPro.edtCodigo).Text, cmsCodPro.arrSelecao, cmsCodPro.strSelecao^, 'CODPRO', qryComPro)
    Else
      If Not fEmptyStr(FCodPro) Then
        ParamByName('CODPRO').AsString := FCodPro;

    If blnFiltraVendedor Then
    Begin
      If blnMulSel Then
        pSetaParam(TEdit(cmsCodVen.edtCodigo).Text, cmsCodVen.arrSelecao, cmsCodVen.strSelecao^, 'CODVEN', qryComPro)
      Else
        If Not fEmptyStr(FCodVen) Then
          ParamByName('CODVEN').AsString := FCodVen;
    End;

    If Length(cmsCodVe2.arrSelecao) > 0 Then
      pSetaParam(TEdit(cmsCodVe2.edtCodigo).Text, cmsCodVe2.arrSelecao, cmsCodVe2.strSelecao^, 'CODVE2', qryComPro);

    If blnMulSel Then
      pSetaParam(TEdit(cmsCodAti.edtCodigo).Text, cmsCodAti.arrSelecao, cmsCodAti.strSelecao^, 'CODATI', qryComPro)
    Else
      If Not fEmptyStr(FCodAti) Then
        ParamByName('CODATI').AsString := FCodAti;

    If blnMulSel Then
      pSetaParam(TEdit(cmsCodEmp.edtCodigo).Text, cmsCodEmp.arrSelecao, cmsCodEmp.strSelecao^, 'CODEMP', qryComPro)
    Else
      If Not fEmptyStr(FCodEmp) Then
        ParamByName('CODEMP').AsString := FCodEmp;

    If blnMulSel Then
      pSetaParam(TEdit(cmsCodFor.edtCodigo).Text, cmsCodFor.arrSelecao, cmsCodFor.strSelecao^, 'CODFOR', qryComPro)
    Else
      If Not fEmptyStr(FCodFor) Then
        ParamByName('CODFOR').AsString := FCodFor;

    If intCalc = 2 Then
    Begin
      If FindParam('CLABRI') <> Nil Then
      Begin
        If fEmptyStr(fCfgSis('CLABRI')) Then
          ParamByName('CLABRI').Value := Null
        Else
          ParamByName('CLABRI').AsString := fCfgSis('CLABRI');
      End;
    End;

    {***************************}
    {* FILTRO POR REDE DE LOJA *}
    {************************DP*}
    if blnMulSel Then
      pSetaParam(TEdit(cmsCodRed.edtCodigo).Text, cmsCodRed.arrSelecao, cmsCodRed.strSelecao^, 'CODRED', qryComPro)
    Else
      pSetaParamOR(edtCodRede,arrRede,'CODRED',qryComPro);

    Open;

    If IsEmpty Then
      Raise Exception.Create('Não há dados para gerar relatório!');

  End;

end;

procedure TComPro.pRetornaSaldoInicial(strCodPro: String; intCalc: Integer;
  dtaDtaIni: TDateTime; var fltSalVen, fltSalCom: Double);
  Var
    strSQL: String;
    strSQLFF: String;
    strSQLTRDV: String;

    blnComProFF: Boolean;
    blnComProTRDV: Boolean;

    qryAux: TUniQuery;
begin

  blnComProFF   := False;
  blnComProTRDV := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If intCalc = 1 Then
    strSQL := strSQL + '  SUM(IF(COM_CREDEB = "C", COM_VRCOMI, -COM_VRCOMI)) AS SALCOM, '
  Else
    strSQL := strSQL + '  SUM(IF(COM_CREDEB = "C", (IF(COM_VRVEND > 0, (COM_VRVEND/100)*DIV_PERCOM, COM_VRCOMI)), -(IF(COM_VRVEND > 0, (COM_VRVEND/100)*DIV_PERCOM, COM_VRCOMI)))) AS SALCOM, ';

  strSQL := strSQL + '  SUM(IF(CS.COM_CREDEB = "C", CS.COM_VRVEND, -CS.COM_VRVEND)) SALVEN ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  COMPRO AS CS ';

  If intCalc = 1 Then
    strSQL := strSQL + '  LEFT JOIN CADDIV ON DIV_CODDIV = COM_CODPRO '
  Else
    strSQL := strSQL + '  INNER JOIN CADDIV ON DIV_CODDIV = COM_CODPRO '; //PARA PEGAR O DIV_PERCOM

  strSQL := strSQL + '  JOINMOVGER ';
  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL  + ' IF(IFNULL(COM_TCOPRO, "") = "", ' + QuotedStr(VS_strTCoProInterna) +
                                       ', COM_TCOPRO) = ' + QuotedStr(VS_strTCoProInterna) + ' AND ';

  If Not fEmptyStr(strCodPro) Then
    strSQL    := strSQL    + '  CS.COM_CODPRO =:CODPRO AND ';

  If (FTipFil = 'P') Then
    strSQL    := strSQL    + '  CS.COM_DTABAI IS NULL AND '
  Else If (FTipFil = 'B') Then
    strSQL    := strSQL    + '  CS.COM_DTABAI IS NOT NULL AND ';

  strSQL := strSQL + '  TRUE ';

  strSQL := strSQL + ' AND CS.COM_DTACAD < :DTAINI ';

  If blnMulSel Then
    strSQL := strSQL + fStrLocate(cmsCodEmp.edtCodigo, cmsCodEmp.arrSelecao, 'COM_CODEMP', 'CODEMP')
  Else
    If Not fEmptyStr(FCodEmp) Then
      strSQL   := strSQL    + '  AND COM_CODEMP = :CODEMP '
    Else
      strSQL   := strSQL    + '  AND LOCATE(COM_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  {*****************************************}
  {* COLOCA O JOIN COM O MOVGER           *}
  {**************************************MV*}
  strSQLFF := fAjustaSQLParaDataFaturamento(strSQL);

  strSQLTRDV := strSQLFF;

  strSQLFF   := strSQLFF + ' AND COM_ESPDOC = "FF" ';
  strSQLTRDV := strSQLTRDV + ' AND COM_ESPDOC IN ("TR", "DV") ';

  strSQL := AnsiReplaceStr(strSQL, 'JOINMOVGER', '');

  If (fCfgSis('CPROFF') = '2') Then
  Begin
    blnComProFF := True;
    strSQL      := strSQL + ' AND IFNULL(COM_ESPDOC, "") <> "FF" ';
  End;

  If (fCfgSis('CPROTR') = '2') Then
  Begin
    blnComProTRDV := True;
    strSQL := strSQL + ' AND IFNULL(COM_ESPDOC, "") NOT IN ("TR", "DV") ';
  End;

  If (blnComProFF) Then
    strSQL := strSQL + ' UNION ALL ' + strSQLFF + ' GROUP BY COM_NUMDOC, COM_ESPDOC, COM_CODEMP, COM_CODCLI ';

  If (blnComProTRDV) Then
    strSQL := strSQL + ' UNION ALL ' + strSQLTRDV + ' GROUP BY COM_NUMDOC, COM_ESPDOC, COM_CODEMP, COM_CODCLI ';

  {*****************************************}
  {* MONTA O SELECT FINAL.                 *}
  {**************************************MV*}
  strSQL := 'SELECT ' +
            '  SUM(IFNULL(SALCOM, 0)) AS SALCOM, ' +
            '  SUM(IFNULL(SALVEN, 0)) AS SALVEN ' +
            'FROM (' + strSQL + ') AS TBL ';

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add(strSQL);
  qryAux.ParamByName('DTAINI').AsDateTime := dtaDtaIni;

  If Not fEmptyStr(strCodPro) Then
    qryAux.ParamByName('CODPRO').AsString := strCodPro;

  If blnMulSel Then
    pSetaParam(TEdit(cmsCodEmp.edtCodigo).Text, cmsCodEmp.arrSelecao, cmsCodEmp.strSelecao^, 'CODEMP', qryAux)
  Else
    If Not fEmptyStr(FCodEmp) Then
      qryAux.ParamByName('CODEMP').AsString := FCodEmp;

  qryAux.Open;

  fltSalCom := qryAux.FIeldByName('SALCOM').AsFloat;
  fltSalVen := qryAux.FIeldByName('SALVEN').AsFloat;

  qryAux.Close;
  FreeAndNil(qryAux);

end;

function TComPro.fAjustaSQLParaDataFaturamento(strSQL: String): String;
begin
  Result := AnsiReplaceStr(strSQL, 'JOINMOVGER', 'JOIN MOVGER X ON X.GER_NUMDOC = COM_NUMDOC AND ' +
                                                 '                  X.GER_ESPDOC = COM_ESPDOC AND ' +
                                                 '                  X.GER_CODEMP = COM_CODEMP AND ' +
                                                 '                  X.GER_CODCLI = COM_CODCLI ');
  Result := AnsiReplaceStr(Result, 'CS.COM_DTACAD < :DTAINI', 'X.GER_DTAFAT < :DTAINI');
  Result := AnsiReplaceStr(Result, 'COM_DTACAD BETWEEN', 'X.GER_DTAFAT BETWEEN');
end;

function TComPro.fRetComissaoProfissionalItem(strCodIte: String): Double;
  Var
    qryIteger: TUniQuery;
Begin
  Result := 0;
  qryIteger := fCriaQuery;

  With qryIteger, SQL Do
  Begin
    Clear;
    Add('SELECT IFNULL(ITE_COMPRO, 0) AS COMPRO FROM ITEGER');
    Add('WHERE');
    Add('  ITE_CODITE = :CODITE AND');
    Add('  ITE_CODEMP = :CODEMP    ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If Not IsEmpty Then
      Result := FieldByName('COMPRO').AsFloat;

    Close;  
  End;

  FreeAndNil(qryIteger);
End;

function TComPro.fSQLFiltroVendedor2: String;
begin
  Result := '';
  Result := Result + '(                               ';
  Result := Result + '  EXISTS                        ';
  Result := Result + '  (SELECT                       ';
  Result := Result + '    1                           ';
  Result := Result + '  FROM                          ';
  Result := Result + '    MOVDET                      ';
  Result := Result + '  WHERE DET_NUMDOC = COM_NUMDOC ';
  Result := Result + '    AND DET_ESPDOC = COM_ESPDOC ';
  Result := Result + '    AND DET_CODEMP = COM_CODEMP ';
  Result := Result + '    AND DET_CODCLI = COM_CODCLI ';
  Result := Result + fStrLocate(cmsCodVe2.edtCodigo, cmsCodVe2.arrSelecao, 'DET_CODVE2', 'CODVE2') + ' ) ';
  Result := Result + ')                               ';
end;

Procedure TComPro.pMontaExcel(frmForRel: Pointer; blnExpSimples: Boolean = False);
Begin
  FForRel := frmForRel;

  fltTotGerComi := 0;
  fltTotGer     := 0;

  pMontaTitulos;

  If FAnalit Then
    pMontaExcelAnalitico(frmForRel)
  Else
    pMontaExcelSintetico(frmForRel, blnExpSimples);
End;

procedure TComPro.pMontaTitGru(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
  Var
    fltSalVen: Double;
    fltSalCom: Double;
    strCreDebSI: String;
begin
  With Excel, Dados, TfrmRelComissaoProfissionais(FForRel) Do
  Begin
    If Quebra.NomeCampo = 'NOMPRO' Then
    Begin
      pCarregaSaldoInicial(FieldByName('COM_CODPRO').AsString);

      Escrever(ProximaLinha, 01, 'PROFISSIONAL: ' + FieldByName('NOMPRO').AsString);

      Escrever(ProximaLinha, 6, 'SALDO INICIAL:');
      Alinhamento(LinhaAtual, 6, Direita);

      fltSalVen := fRetSalVen;
      fltSalCom := fRetSalCom;

      If fltSalCom < 0 Then
        strCreDebSI := 'D'
      Else
        strCreDebSI := 'C';

      Escrever(LinhaAtual,   7, fltSalVen);
      Escrever(LinhaAtual,   8, fltSalCom);
      FormatoNumerico(LinhaAtual,   7);
      FormatoNumerico(LinhaAtual,   8);

      Escrever(LinhaAtual,   9, strCreDebSI);

      Negrito (LinhaAtual   , 01, True);
      Negrito (LinhaAtual -1, 01, True);

      Mesclar ('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual -1));

      CorFundo('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde_Mar);
      CorFonte('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
      Bordas  ('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True, True, False, False);

    End
    Else If Quebra.NomeCampo = 'NOMEMP' Then
    Begin
      Escrever(ProximaLinha, 01, 'EMPRESA: ' + FieldByName('NOMEMP').AsString);
      Negrito (LinhaAtual   , 01, True);
      Mesclar ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde_Mar);
      CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
      Bordas  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True, True, False, False);
    End
    Else If Quebra.NomeCampo = 'VENDED' Then
    Begin
      Escrever(ProximaLinha, 01, 'VENDEDOR: ' + FieldByName('VENDED').AsString);
      Negrito (LinhaAtual   , 01, True);
      Mesclar ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde_Mar);
      CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
      Bordas  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True, True, False, False);
    End
    Else If Quebra.NomeCampo = 'COM_DTACAD' Then
    Begin
      Escrever(ProximaLinha, 01, 'DATA FATURAMENTO: ' + FormatDateTime('dd/mm/yyyy', FieldByName('COM_DTACAD').AsDateTime));
      Negrito (LinhaAtual   , 01, True);
      Mesclar ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde_Mar);
      CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
      Bordas  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True, True, False, False);
    End;
  End;
end;

procedure TComPro.pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
  Var
    strCreDeb: String;
begin

  With Excel, TfrmRelComissaoProfissionais(FForRel) Do
  Begin
    If (Quebra.NomeCampo = 'NOMPRO') Or (Quebra.NomeCampo = 'COM_DTACAD') Or
       (Quebra.NomeCampo = 'VENDED') Or (Quebra.NomeCampo = 'NOMEMP') Then
    Begin
      If Quebra.NomeCampo = 'NOMPRO' Then
        Escrever(ProximaLinha, Campos.ColunaPorNome['COM_VRVEND'].Coluna -1, 'TOTAL DO PROFISSIONAL')
      Else If Quebra.NomeCampo = 'COM_DTACAD' Then
        Escrever(ProximaLinha, Campos.ColunaPorNome['COM_VRVEND'].Coluna -1, 'TOTAL DA DATA DE FATURAMENTO')
      Else If Quebra.NomeCampo = 'NOMEMP' Then
        Escrever(ProximaLinha, Campos.ColunaPorNome['COM_VRVEND'].Coluna -1, 'TOTAL DA EMPRESA')
      Else
        Escrever(ProximaLinha, Campos.ColunaPorNome['COM_VRVEND'].Coluna -1, 'TOTAL DO VENDEDOR');

      Alinhamento(LinhaAtual, Campos.ColunaPorNome['COM_VRVEND'].Coluna -1, Direita);

      Quebra.Totais['fltTotPro']     := Quebra.Totais['fltTotPro']     + fRetSalVen;
      Quebra.Totais['fltTotProComi'] := Quebra.Totais['fltTotProComi'] + fRetSalCom;

      If Quebra.Totais['fltTotPro'] <> 0 Then
        Quebra.Totais['fltTotPerComi'] := Quebra.Totais['fltTotProComi'] / Quebra.Totais['fltTotPro'] * 100
      Else
        Quebra.Totais['fltTotPerComi'] := 0;

      If (Quebra.NomeCampo <> 'NOMEMP') Then
      Begin      
        fltTotGer     := fltTotGer     + Quebra.Totais['fltTotPro'];
        fltTotGerComi := fltTotGerComi + Quebra.Totais['fltTotProComi'];
      End;

      If fltTotGer <> 0 Then
        fltTotPerComi := fltTotGerComi / fltTotGer * 100
      Else
        fltTotPerComi := 0;

      If Quebra.Totais['fltTotProComi'] < 0 Then
        strCreDeb := 'D'
      Else
        strCreDeb := 'C';

      Escrever(LinhaAtual, Campos.ColunaPorNome['COM_VRVEND'].Coluna, Quebra.Totais['fltTotPro']);
      Escrever(LinhaAtual, Campos.ColunaPorNome['COM_VRCOMI'].Coluna, Quebra.Totais['fltTotProComi']);
      FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['COM_VRVEND'].Coluna);
      FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['COM_VRCOMI'].Coluna);

      Escrever(LinhaAtual, Campos.ColunaPorNome['COM_CREDEB'].Coluna, strCreDeb);

      If VS_strTCoProInterna <> '3' Then
      Begin
        Escrever(LinhaAtual, Campos.ColunaPorNome['COM_PERCOM'].Coluna, Quebra.Totais['fltTotPerComi']);
        FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['COM_PERCOM'].Coluna);
      End;

      Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
      CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    End
    Else
    Begin

      Escrever(ProximaLinha, Campos.ColunaPorNome['COM_VRVEND'].Coluna -1, 'TOTAL GERAL');
      Alinhamento(LinhaAtual, Campos.ColunaPorNome['COM_VRVEND'].Coluna -1, Direita);

      If fltTotGerComi < 0 Then
        strCreDeb := 'D'
      Else
        strCreDeb := 'C';

      Escrever(LinhaAtual, Campos.ColunaPorNome['COM_VRVEND'].Coluna, fltTotGer);
      Escrever(LinhaAtual, Campos.ColunaPorNome['COM_VRCOMI'].Coluna, fltTotGerComi);
      FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['COM_VRVEND'].Coluna);
      FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['COM_VRCOMI'].Coluna);

      Escrever(LinhaAtual, Campos.ColunaPorNome['COM_CREDEB'].Coluna, strCreDeb);

      If VS_strTCoProInterna <> '3' Then
      Begin
        Escrever(LinhaAtual, Campos.ColunaPorNome['COM_PERCOM'].Coluna, fltTotPerComi);
        FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['COM_PERCOM'].Coluna);
      End;

      Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
      CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

      If (IIF(blnMulSel, (Length(cmsCodFor.arrSelecao) > 0), (Not fEmptyStr(FCodFor)))) Then
      Begin
        Escrever(ProximaLinha, 1, '* Os valores exibidos no relatório são referentes aos itens do(s) fornecedor(es) filtrado(s).');
        Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
        Negrito('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      End;
    End;
  End;
end;

procedure TComPro.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
begin
  With Dados Do
  Begin
    Totais['fltTotPro']     := Totais['fltTotPro']     + FieldByName('COM_VRVEND').AsFloat;
    Totais['fltTotProComi'] := Totais['fltTotProComi'] + FieldByName('COM_VRCOMI').AsFloat;
  End;
end;

Procedure TComPro.pMontaTitulos;
var
  blnVend2: Boolean;
  intQtdTitulos: Integer;
Begin
  blnVend2 := fCfgSis('REPVEN', varBoolean);

  With TfrmRelComissaoProfissionais(FForRel) Do
  Begin
    If blnVend2 Then
      intQtdTitulos := 11
    else
      intQtdTitulos := 10;
    SetLength(arrTitulos, intQtdTitulos);

    arrTitulos[0] := fStrTitulo(edtCodProfissional.Text, edtNomProfissional, cmsCodPro.arrSelecao, cmsCodPro.strSelecao^, 'PROFISSIONAL');
    arrTitulos[1] := fStrTitulo(edtCodVen.Text, edtDesVen, cmsCodVen.arrSelecao, cmsCodVen.strSelecao^, 'VENDEDOR');
    arrTitulos[2] := fStrTitulo(edtCodAtividade.Text, edtDesAtividade, cmsCodAti.arrSelecao, cmsCodAti.strSelecao^, 'ATIVIDADE', True);
    arrTitulos[3] := fStrTitulo(edtCodCliente.Text, edtDesCliente, cmsCodCli.arrSelecao, cmsCodCli.strSelecao^, 'CLIENTE');
    arrTitulos[4] := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, cmsCodEmp.arrSelecao, cmsCodEmp.strSelecao^, 'EMPRESA', True);
    arrTitulos[5] := fStrTitulo(edtCodRede.Text, edtDesRede, cmsCodRed.arrSelecao, cmsCodRed.strSelecao^, 'REDE DE LOJAS', True);
    arrTitulos[6] := fStrTitulo(edtFornecedor.Text, edtDesFornecedor, cmsCodFor.arrSelecao, cmsCodFor.strSelecao^, 'FORNECEDOR');
    arrTitulos[7] := 'FILTRO: ' + IIF((edtFiltro.Text = 'T'), 'TODOS', IIF((edtFiltro.Text = 'P'), 'PENDENTES', 'BAIXADOS'));
    arrTitulos[8] := 'SITUAÇÃO DO PROFISSIONAL: ' + IIF(rdgSitPro.ItemIndex = 0,'ATIVO',IIF(rdgSitPro.ItemIndex = 1, 'INATIVO', 'TODOS'));

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaBai.Text))) Then
      arrTitulos[9] := 'PERÍODO DE ENTRADA: ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text + ' PERÍODO DA BAIXA: ' + mskDtaBai.Text + ' A ' + mskDtaBai.Text
    Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      arrTitulos[9] := 'PERÍODO DE ENTRADA: ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text
    Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaBai.Text))) Then
      arrTitulos[9] := 'PERÍODO DA BAIXA: ' + mskDtaBai.Text + ' A ' + mskDtaBai.Text
    Else
      arrTitulos[9] := '';

    if blnVend2 Then
      arrTitulos[10] := fStrTitulo(edtCodVe2.Text, edtDesVe2, cmsCodVe2.arrSelecao, cmsCodVe2.strSelecao^, 'VENDEDOR 2');
  End;
End;

Procedure TComPro.pMontaTitulosAnalitico(objExcel : TGeraExcel);
  Var
    intIndice: Integer;
Begin
  For intIndice := Low(arrTitulos) To High(arrTitulos) Do
    objExcel.AddFiltro(arrTitulos[intIndice]);
End;

function TComPro.fCalculaPerComExcelAnalitico(dtsDados: TDataSet): Double;
begin
  If dtsDados.FieldByName('COM_VRVEND').AsFloat <> 0 Then
    Result := dtsDados.FieldByName('COM_VRCOMI').AsFloat / dtsDados.FieldByName('COM_VRVEND').AsFloat * 100
  Else
    Result := 0;
end;

Procedure TComPro.pMontaExcelAnalitico(frmForRel: Pointer);
  Var
    objExcel : TGeraExcel;
Begin
  With TfrmRelComissaoProfissionais(frmForRel) Do
  Try

    objExcel := TGeraExcel.Create(qryComPro, pgbGerArq);
    If FOrdem <> ORD_DATA_FATURAMENTO Then
      objExcel.AddCampo('COM_DTACAD', 'DATA DE CADASTRO');

    objExcel.AddCampo('COM_NUMDOC', 'DOCUMENTO');
    objExcel.AddCampo('COM_ESPDOC', 'ESPÉCIE');
    objExcel.AddCampo('COM_CODEMP', 'EMPRESA');
    objExcel.AddCampo('NOMCLI', 'CLIENTE');
    If FOrdem <> ORD_VENDEDOR Then
      objExcel.AddCampo('VENDED', 'VENDEDOR');
    If (FOrdem <> ORD_PROFISSIONAL) AND (FOrdem <> ORD_PROFISSIONAL_EMP) Then
      objExcel.AddCampo('NOMPRO', 'PROFISSIONAL');
    objExcel.AddCampo('COM_VRVEND', 'VALOR DA VENDA');

    If VS_strTCoProInterna = '3' Then
      objExcel.AddCampo('COM_VRCOMI', 'QTD.PONTOS')
    Else
      objExcel.AddCampo('COM_VRCOMI', 'VALOR DA COMISSÃO');

    objExcel.AddCampo('COM_CREDEB', 'D/C');

    If VS_strTCoProInterna <> '3' Then
      objExcel.AddCampo(fCalculaPerComExcelAnalitico,'COM_PERCOM', '(%)COM');

    objExcel.AddCampo('COM_OBSERV', 'OBSERVAÇÕES');

    pMontaTitulosAnalitico(objExcel);

    objExcel.strNomRel := 'RELATORIO DE COMISSAO DE PROFISSIONAIS - ANALÍTICO';

    Case FOrdem Of
      ORD_PROFISSIONAL    : objExcel.AddQuebra('NOMPRO', 'PROFISSIONAL:', False);
      ORD_DATA_FATURAMENTO: objExcel.AddQuebra('COM_DTACAD', 'DATA FATURAMENTO:', False);
      ORD_VENDEDOR        : objExcel.AddQuebra('VENDED', 'VENDEDOR:', False);
      ORD_PROFISSIONAL_EMP: 
      Begin
        objExcel.AddQuebra('NOMEMP', 'EMPRESA:', False);
        objExcel.AddQuebra('NOMPRO', 'PROFISSIONAL:', False);
      End;
    End;
    
    objExcel.OnImpTitGrupo := pMontaTitGru;
    objExcel.OnMontaResumo := pMontaResumo;
    objExcel.OnSomaResumo  := pSomaTotais;

    If Not objExcel.fGerarRelatorio Then
    begin
      FreeAndNil(objExcel);
      Exit;
    End;

    fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);

  Finally
    FreeAndNil(objExcel);
    pnlInfo.Caption   := '';
    pgbGerArq.Visible := False;
  End;

End;


Procedure TComPro.pMontaExcelSintetico(frmForRel: Pointer; blnExpSimples: Boolean = False);
  Var
    objExcel : TExcel;
    intQtdCol: Integer;
    intCont  : Integer;
    strUltCol: String;
    arrSintetico: Array [1..12] Of Array [1..3] Of String;
    fltValRet,
    fltValCom,
    fltPerCom,
    fltTotGerSint,
    fltTotGerComiSint: Double;
Begin
  With TfrmRelComissaoProfissionais(frmForRel) Do
  Try

    objExcel := TExcel.fCriarExcel(Self);

    arrSintetico[01][01] := 'CÓDIGO';
    arrSintetico[02][01] := 'NOME DO PROFISSIONAL';
    arrSintetico[03][01] := 'ATIVIDADE';

    If VS_strTCoProInterna = '3' Then
      arrSintetico[04][01] := 'SALDO INICIAL PONTOS'
    Else
      arrSintetico[04][01] := 'SALDO INICIAL VENDA';

    arrSintetico[05][01] := 'C/D';

    arrSintetico[06][01] := 'SALDO INICIAL COMISSÃO';
    arrSintetico[07][01] := 'C/D';

    arrSintetico[08][01] := 'VALOR DA VENDA';
    arrSintetico[09][01] := 'C/D';

    If VS_strTCoProInterna = '3' Then
      arrSintetico[10][01] := 'QTD.PONTOS'
    Else
      arrSintetico[10][01] := 'VALOR DA COMISSÃO';

    arrSintetico[11][01] := 'C/D';

    If VS_strTCoProInterna = '3' Then
      arrSintetico[12][01] := ''
    Else
      arrSintetico[12][01] := '(%)COM';

    if not blnExpSimples then
    begin
      arrSintetico[01][02] := 'CPF/CNPJ';
      arrSintetico[02][02] := 'CELULAR';
      arrSintetico[03][02] := 'E-MAIL';
      arrSintetico[04][02] := '';
      arrSintetico[05][02] := '';
      arrSintetico[06][02] := '';
      arrSintetico[07][02] := '';
      arrSintetico[08][02] := '';
      arrSintetico[09][02] := '';
      arrSintetico[10][02] := '';
      arrSintetico[11][02] := '';
      arrSintetico[12][02] := '';

      arrSintetico[01][03] := 'COM_CODPRO';
      arrSintetico[02][03] := 'DIV_NOMDIV';
      arrSintetico[03][03] := 'ATI_DESATI';
      arrSintetico[04][03] := '';
      arrSintetico[05][03] := '';
      arrSintetico[06][03] := '';
      arrSintetico[07][03] := '';
      arrSintetico[08][03] := '';
      arrSintetico[09][03] := '';
      arrSintetico[10][03] := '';
      arrSintetico[11][03] := '';
      arrSintetico[12][03] := '';
    end;

    If Not objExcel.CriarArquivo Then
    begin
      FreeAndNil(objExcel);
      Exit;
    End;

    With objExcel Do
    Begin

      pnlInfo.Caption       := 'Aguarde... Gerando Arquivo!';
      pnlInfo.Repaint;
      Application.ProcessMessages;

      PintarTudo(Branco);
      DefinirFonte(CourierNew, 10);

      LinhaAtual := 1;
      intQtdCol  := Length(arrSintetico);

      //Percentual de comissao
      If VS_strTCoProInterna = '3' Then
        intQtdCol := intQtdCol - 1;

      strUltCol  := fGetLetraAlfa(intQtdCol);

      if not blnExpSimples then
      begin
        Escrever(ProximaLinha, 01, fRetNomeEmpresa);
        Escrever(ProximaLinha, 01, 'RELATORIO DE COMISSAO DE PROFISSIONAIS - SINTÉTICO');

        For intCont := Low(arrTitulos) To High(arrTitulos) Do
          Escrever(ProximaLinha, 01, arrTitulos[intCont]);

        For intCont := 1 To LinhaAtual Do
        Begin
          Mesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
          Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
          Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
        End;

        CorFundo('A2', strUltCol + '3', Cinza);
        Bordas('A2', strUltCol + '3',True,True,True,True);

        ProximaLinha;
      end;

      For intCont := 1 To intQtdCol Do
      Begin
        Escrever(LinhaAtual, intCont, arrSintetico[intCont, 01]);
        Negrito(LinhaAtual, intCont, True);
      End;

      CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);
      CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
      Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

      if not blnExpSimples then
      begin
        ProximaLinha;

        For intCont := 1 To intQtdCol Do
        Begin
          Escrever(LinhaAtual, intCont, arrSintetico[intCont, 02]);
          Negrito(LinhaAtual, intCont, True);
        End;

        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
        Mesclar('C' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
        Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
      end;

      With qryComPro Do
      Begin
        First;
        pgbGerArq.Visible  := True;
        pgbGerArq.Max      := RecordCount;

        fltTotGerSint     := 0;
        fltTotGerComiSint := 0;

        While Not Eof Do
        Begin
          pgbGerArq.Position := RecNo;
          Application.ProcessMessages;

          pCarregaSaldoInicial(FieldByName('COM_CODPRO').AsString);

          ProximaLinha;
          Escrever(LinhaAtual, 1, FieldByName('COM_CODPRO').AsString);
          Escrever(LinhaAtual, 2, FieldByName('DIV_NOMDIV').AsString);
          Escrever(LinhaAtual, 3, FieldByName('ATI_DESATI').AsString);

          fltValRet := fRetSalVen;
          Escrever(LinhaAtual, 4 , fltValRet);
          FormatoNumerico(LinhaAtual, 4);

          If fltValRet < 0 Then
            Escrever(LinhaAtual, 5 , 'D')
          Else
            Escrever(LinhaAtual, 5 , 'C');

          fltValCom := fRetSalCom;
          Escrever(LinhaAtual, 6, fltValCom);
          FormatoNumerico(LinhaAtual, 6);

          If fltValCom < 0 Then
            Escrever(LinhaAtual, 7 , 'D')
          Else
            Escrever(LinhaAtual, 7 , 'C');

          Escrever(LinhaAtual, 8, FieldByName('COM_VRVEND').AsFloat + fltValRet );
          FormatoNumerico(LinhaAtual, 8);

          If FieldByName('COM_VRVEND').AsFloat < 0 Then
            Escrever(LinhaAtual, 9 , 'D')
          Else
            Escrever(LinhaAtual, 9 , 'C');

          Escrever(LinhaAtual, 10, FieldByName('COM_VRCOMI').AsFloat + fltValCom );
          FormatoNumerico(LinhaAtual, 10);

          If FieldByName('COM_VRCOMI').AsFloat < 0 Then
            Escrever(LinhaAtual, 11 , 'D')
          Else
            Escrever(LinhaAtual, 11 , 'C');

          //Percentual de comissao
          If VS_strTCoProInterna <> '3' Then
          Begin
            If (FieldByName('COM_VRVEND').AsFloat + fltValRet) <> 0 Then
              fltPerCom := (FieldByName('COM_VRCOMI').AsFloat + fltValCom) / (FieldByName('COM_VRVEND').AsFloat + fltValRet) * 100
            Else
              fltPerCom := 0.00;

            Escrever(LinhaAtual, 12, fltPerCom);
            FormatoNumerico(LinhaAtual, 12);
          End;

          If RecNo Mod 2 = 0 Then
            CorFundo('A' + IntToStr(LinhaAtual), IfThen(VS_strTCoProInterna <> '3', fGetLetraAlfa(12), fGetLetraAlfa(11)) + IntToStr(LinhaAtual), Cinza);

          fltTotGerSint     := fltTotGerSint     + FieldByName('COM_VRVEND').AsFloat + fltValRet;
          fltTotGerComiSint := fltTotGerComiSint + FieldByName('COM_VRCOMI').AsFloat + fRetSalCom;

          if not blnExpSimples then
          begin
            ProximaLinha;
            Escrever(LinhaAtual, 1, FieldByName('DIV_C_G_C_').AsString);
            Escrever(LinhaAtual, 2, fFormataFone(FieldByName('DIV_CELULA').AsString));
            Escrever(LinhaAtual, 3, FieldByName('DIV_EMAIL_').AsString);
          end;

          If RecNo Mod 2 = 0 Then
            CorFundo('A' + IntToStr(LinhaAtual), IfThen(VS_strTCoProInterna <> '3', fGetLetraAlfa(12), fGetLetraAlfa(11)) + IntToStr(LinhaAtual), Cinza);

          Bordas('A' + IntToStr(LinhaAtual-1), IfThen(VS_strTCoProInterna <> '3', fGetLetraAlfa(12), fGetLetraAlfa(11)) + IntToStr(LinhaAtual));

          Next;
        End;

        Escrever(ProximaLinha, 06, 'TOTAL GERAL');
        Alinhamento(LinhaAtual, 06, Direita);

        Escrever(LinhaAtual, 08, fltTotGerSint);
        FormatoNumerico(LinhaAtual, 08);

        If fltTotGerSint < 0 Then
          Escrever(LinhaAtual, 09, 'D')
        Else
          Escrever(LinhaAtual, 09, 'C');

        Escrever(LinhaAtual, 10, fltTotGerComiSint);
        FormatoNumerico(LinhaAtual, 10);

        If fltTotGerComiSint < 0 Then
          Escrever(LinhaAtual, 11, 'D')
        Else
          Escrever(LinhaAtual, 11, 'C');

        //Percentual de comissao
        If VS_strTCoProInterna <> '3' Then
        Begin
          If fltTotGerSint <> 0 Then
            fltPerCom := fltTotGerComiSint / fltTotGerSint * 100
          Else
            fltPerCom := 0.00;

          Escrever(LinhaAtual, 12, fltPerCom);
          FormatoNumerico(LinhaAtual, 12);
        End;

        Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(intQtdCol) + IntToStr(LinhaAtual), True);
        CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(intQtdCol) + IntToStr(LinhaAtual), Amarelo);
        CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(intQtdCol) + IntToStr(LinhaAtual), Azul);
        Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(intQtdCol) + IntToStr(LinhaAtual));
      End;

      If (IIF(blnMulSel, (Length(cmsCodFor.arrSelecao) > 0), (Not fEmptyStr(FCodFor)))) Then
      Begin
        Escrever(ProximaLinha, 1, '* Os valores exibidos no relatório são referentes aos itens do(s) fornecedor(es) filtrado(s).');
        Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(intQtdCol) + IntToStr(LinhaAtual));
        Negrito('A' + IntToStr(LinhaAtual), fGetLetraAlfa(intQtdCol) + IntToStr(LinhaAtual), True);
      End;

      if not blnExpSimples then
        CongelarPaines('A13');

      AutoAjuste;
      SalvarArquivo;
      FecharArquivo;

      fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);
    End;

  Finally
    FreeAndNil(objExcel);
    pnlInfo.Caption   := '';
    pgbGerArq.Visible := False;
  End;

End;

end.
