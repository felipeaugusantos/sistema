unit untRelFiscResumoApIcms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, RLFilters,
  RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, Mask, MaskEditFocus, StrUtils, Uni, DB, Math,
  BitBtnLockedIncrem,   Grids, DBGridCitel, DBGrids, untFuncoesGenerica, MemDS, DBAccess,
  frxExportCSVTestabilidade, Contnrs, DateUtils, Datasnap.DBClient,
  UniClientDataSet, untTypesSistema, untTDadosDifal;

Type
  TEcfLoja = class(TObject)
    public
      strNumSer: String;
      strCodEmp: String;
      strCodEcf: String;
  End;

Type
  TInformacoesECF = class(TObject)
    private
      stlEcfs: TObjectList;
      dtaDtaIni: TDateTime;
      dtaDtaFin: TDateTime;

      procedure pCarregaEcfsPorLoja;
      procedure pDefineDatasEcf;
    public
      constructor Create(dtaDtaIni, dtaDtaFin: TDateTime);
      destructor Destroy; override;
      procedure pProcessarInformacoes;

      function fEcfsPorLoja(const strCodEmp: String): TObjectList;
      procedure pTotaisPorLoja(const strCodEmp: String;
        Var fltVlrCon, fltBasIcm, fltValIcm: Double);
      procedure pVerificaReducoesPendentes(strEmpresa: String; stlResult: TStrings);
      function fReducoesOk(strEmpresa: String): Boolean;
  End;

type
  TfrmRelFiscResumoApIcms = class(TfrmPaiRelatorio)
    gbpData: TGroupBox;
    Label12: TLabel;
    Label11: TLabel;
    mskDtaFin: TMaskEditFocus;
    mskDtaIni: TMaskEditFocus;
    rdgFiltroDatas: TRadioGroup;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    btnOutros: TBitBtnLocked;
    ckbRegistrado_Ecf: TCheckBox;
    frxDbOutIcmCredito: TfrxDBDataset;
    frxDbOutIcmDebito: TfrxDBDataset;
    chkDetalhamentoDebCred: TCheckBox;
    cdsOutIcmCredito: TUniClientDataSet;
    cdsOutIcmCreditoObserv: TStringField;
    cdsOutIcmCreditoValor: TFloatField;
    cdsOutIcmDebito: TUniClientDataSet;
    cdsOutIcmDebitoObserv: TStringField;
    cdsOutIcmDebitoValor: TFloatField;
    chkInc933: TCheckBox;
    ckbEnviaValores1603_2603: TCheckBox;
    chkIncluirCreditoCat158: TCheckBox;
    chkIncluirCreDebDifal: TCheckBox;
    Label3: TLabel;
    edtNumPagina: TEditFocus;
    chkIncluirFcpIcms: TCheckBox;
    chkDeduzirFcpIcms: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    function frxReportMUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    function frxReportJUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure btnOutrosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtNumPaginaExit(Sender: TObject);
    procedure chkIncluirFcpIcmsClick(Sender: TObject);
  private
    { Private declarations }
    FStrSqlValFcpSt: string;
    FStrSqlValFcp: string;
    QryRelatorio : TUniQuery;
    FPais        : TPais;
    qryTotRel    : TUniQuery;
    fltValAnt    : Double;
    arrEmp: TConsultasArray;
    blnClaEcf: Boolean;
    strEmpresa: String;

    function fRetStringEmpresaDadosCat158: string;

    function fRetTipoAjusteIcms(intIndex: integer): string;

    Function fGetSqlFisc(intClaFis: Integer): String;
    Function fGetSqlUnion: String;
    Function fGetSqlRelatorio: String;

    Function fGetSqlTotalFisc(intClaFis: Integer): String;
    Function fGetSqlTotalUnion: String;
    Function fGetSqlTotalRelatorio: String;

    function fGetSqlConverteFiscDeCincoPraUm(intClaFis: string): string;
    function fGetSqlUnionConverteFiscDeCincoPraUm: string;

    function fRetSQLNumProximaPagina: String;

    function fRetAtuPagFisc(strNomCampo: String): String;

    Procedure pTotalRelatorio;
    Procedure pInicializaTotais(qckRel: TfrxReport);

    Procedure pIniTotal(qckRel: TfrxReport; strLocal, strNatureza, strInicial: String; blnIncrem: Boolean);

    function fReducoesOk: Boolean;
    procedure pCarregaValoresIcmsCupons(strCodEmp: String;
      var fltTotalValorIcms: Double);
    function fSQLValorIcms(const strCampo: String): String;
    function fValorIcmsCupons: String;
    function fRetornaMesRefCreFis: String;
    function fRetornaNumPagina(strNomCampo: string): string;
    function fCarregaDeducoes: Double;
    function fValorFCP(strNature: String): Double;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses untModulo, untConstantes, untCadAjustIcm, untFuncoes, untFuncoesSimples, untMemo, untConsultas, untFuncoesConsulta,
     untTApuradorAjustesIcms, untTDadosCreditoCat158, untMsgErroSQL;

{$R *.dfm}

constructor TInformacoesECF.Create(dtaDtaIni, dtaDtaFin: TDateTime);
begin
  stlEcfs := TObjectList.Create;

  Self.dtaDtaIni := dtaDtaIni;
  Self.dtaDtaFin := dtaDtaFin;

  pDefineDatasEcf;
end;

procedure TInformacoesECF.pCarregaEcfsPorLoja;
  Var
    qryEcfs: TUniQuery;
    ecf: TEcfLoja;
begin
  qryEcfs := fCriaQuery(Nil);
  qryEcfs.SQL.Add('SELECT ');
  qryEcfs.SQL.Add('  FIS_CODEMP, ECF_CODECF, REPLACE(FIS_NUMSER, "\0", "") AS FIS_NUMSER ');
  qryEcfs.SQL.Add('FROM ');
  qryEcfs.SQL.Add('  CADFIS ');
  qryEcfs.SQL.Add('JOIN CADECF ON ECF_NUMSER = REPLACE(FIS_NUMSER, "\0", "") ');
  qryEcfs.SQL.Add('WHERE ');
  qryEcfs.SQL.Add('  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ');
  qryEcfs.SQL.Add('  FIS_ESPDOC IN ("IF", "IV") AND ');
  qryEcfs.SQL.Add('  IFNULL(FIS_HISTOR, "") NOT LIKE "%CANCELADO%" ');
  qryEcfs.SQL.Add('GROUP BY ');
  qryEcfs.SQL.Add('  FIS_CODEMP, FIS_NUMSER ');

  qryEcfs.ParamByName('DTAINI').AsDateTime := dtaDtaIni;
  qryEcfs.ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
  qryEcfs.Open;

  While (Not qryEcfs.Eof) Do
  Begin
    ecf := TEcfLoja.Create;
    ecf.strNumSer := qryEcfs.FieldByName('FIS_NUMSER').AsString;
    ecf.strCodEmp := qryEcfs.FieldByName('FIS_CODEMP').AsString;
    ecf.strCodEcf := qryEcfs.FieldByName('ECF_CODECF').AsString;

    stlEcfs.Add(ecf);

    qryEcfs.Next;
  End;

  FreeAndNil(qryEcfs);
end;

procedure TInformacoesECF.pDefineDatasEcf;
  Var
    dtaSped: TDateTime;
    strDtaSped: String;
begin
  If (dtaDtaFin >= VS_Date) Then
  Begin
    dtaDtaFin := IncDay(dtaDtaFin, -1);
  End;

  strDtaSped := fCfgSis('INOBSF', varString);
  If fEmptyStr(strDtaSped) Then
  Begin
    Exit;
  End;

  dtaSped := fCfgSis('INOBSF', varDate);
  If (dtaDtaIni < dtaSped) And (dtaDtaFin < dtaSped) Then
  Begin
    dtaDtaIni := 0;
    dtaDtaFin := 0;
  End
  Else If dtaDtaIni < dtaSped Then
  Begin
    dtaDtaIni := Max(dtaSped, dtaDtaIni);
    dtaDtaFin := Max(dtaSped, dtaDtaFin);
  End;
end;

procedure TInformacoesECF.pProcessarInformacoes;
begin
  stlEcfs.Clear;
  pCarregaEcfsPorLoja;
end;

procedure TInformacoesECF.pTotaisPorLoja(const strCodEmp: String; var fltVlrCon, fltBasIcm,
  fltValIcm: Double);
  Var
    qryTotais: TUniQuery;
    stlEcfsTmp: TObjectList;
    strNumSerEmp: String;
    intContador: Integer;
begin
  strNumSerEmp := '';
  stlEcfsTmp := fEcfsPorLoja(strCodEmp);
  For intContador := 0 To stlEcfsTmp.Count-1 Do
  Begin
    strNumSerEmp := strNumSerEmp + TEcfLoja(stlEcfsTmp[intContador]).strNumSer + ',';
  End;

  fltBasIcm := 0;
  fltValIcm := 0;

  If Not fEmptyStr(strNumSerEmp) Then
  Begin
    qryTotais := fCriaQuery(Nil);

    qryTotais.SQL.Add('SELECT ');
    qryTotais.SQL.Add('  SUM(IFNULL(TOT_BASIMP, 0)) AS VLRCON, ');
    qryTotais.SQL.Add('  SUM(IF(TOT_ALQIMP > 0, IFNULL(TOT_BASIMP, 0), 0)) AS BASIMP, ');
    qryTotais.SQL.Add('  SUM(IFNULL(TOT_VALIMP, 0)) AS VALIMP ');
    qryTotais.SQL.Add('FROM ');
    qryTotais.SQL.Add('  RDZTOT ');
    qryTotais.SQL.Add('JOIN CADRDZ ON RDZ_QTDRDZ = TOT_NUMCRZ AND ');
    qryTotais.SQL.Add('               RDZ_CODECF = TOT_CODECF ');
    qryTotais.SQL.Add('JOIN CADECF ON ECF_CODECF = RDZ_CODECF ');
    qryTotais.SQL.Add('WHERE ');
    qryTotais.SQL.Add('  LOCATE(ECF_NUMSER, :NUMSER) > 0 AND ');
    qryTotais.SQL.Add('  RDZ_DTAMOV BETWEEN :DTAINI AND :DTAFIN ');

    qryTotais.ParamByName('NUMSER').AsString := strNumSerEmp;
    qryTotais.ParamByName('DTAINI').AsDateTime := dtaDtaIni;
    qryTotais.ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
    qryTotais.Open;

    fltVlrCon := qryTotais.FieldByName('VLRCON').AsFloat;
    fltBasIcm := qryTotais.FieldByName('BASIMP').AsFloat;
    fltValIcm := qryTotais.FieldByName('VALIMP').AsFloat;

    FreeAndNil(qryTotais);
  End;

  FreeAndNil(stlEcfs);
end;

destructor TInformacoesECF.Destroy;
begin
  FreeAndNil(stlEcfs);
  inherited;
end;

{*************************************}
{* QUEM CHAMA A FUNÇÃO É RESPONSÁVEL *}
{* POR LIBERAR A MEMÓRIA.            *}
{**********************************MV*}
function TInformacoesECF.fEcfsPorLoja(const strCodEmp: String): TObjectList;
  Var
    intContador: Integer;
begin
  Result := TObjectList.Create;
  Result.OwnsObjects := False;

  For intContador := 0 To stlEcfs.Count-1 Do
  Begin
    If (fEmptyStr(strCodEmp)) Or (TEcfLoja(stlEcfs[intContador]).strCodEmp = strCodEmp) Then
      Result.Add(stlEcfs[intContador]);
  End;
end;

{*************************************}
{* QUEM CHAMA A FUNÇÃO É RESPONSÁVEL *}
{* POR LIBERAR A MEMÓRIA.            *}
{**********************************MV*}
procedure TInformacoesECF.pVerificaReducoesPendentes(strEmpresa: String; stlResult: TStrings);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT DISTINCT' +
                       '  F.FIS_DTAENT, F.FIS_NUMSER, E.ECF_CODECF, IFNULL(F.FIS_ACESSO, "") AS ACESSO ' +
                       'FROM ' +
                       '  CADFIS F ' +
                       'LEFT JOIN CADECF E ' +
                       '  ON REPLACE(E.ECF_NUMSER, "\0", "") = REPLACE(F.FIS_NUMSER, "\0", "") ' +
                       'LEFT JOIN CADRDZ R ' +
                       '  ON R.RDZ_CODECF = E.ECF_CODECF AND ' +
                       '  R.RDZ_DTAMOV = F.FIS_DTAENT ' +
                       'WHERE (F.FIS_DTAENT BETWEEN :DTAINI AND :DTAFIM) ' +
                       'AND (F.FIS_ESPDOC IN ("IF", "IV")) ' +
                       'AND (F.FIS_NUMSER IS NOT NULL) ' +
                       'AND (R.RDZ_DTAMOV IS NULL) ';

    If Not fEmptyStr(strEmpresa) Then
      qryAux.SQL.Text := qryAux.SQL.Text + 'AND (F.FIS_CODEMP = :CODEMP) ';

    qryAux.ParamByName('DTAINI').AsDate    := dtaDtaIni;
    qryAux.ParamByName('DTAFIM').AsDate    := dtaDtaFin;
    If Not fEmptyStr(strEmpresa) Then
      qryAux.ParamByName('CODEMP').AsString := strEmpresa;
    qryAux.Open;

    While Not qryAux.Eof Do
    Begin
      If fEmptyStr(qryAux.FieldByName('ACESSO').AsString) Then
      Begin
        If fEmptyStr(qryAux.FieldByName('ECF_CODECF').AsString) Then
        Begin
          stlResult.Add('Não existe ECF cadastrado para o dia ' +
            FormatDateTime('dd/mm/yyyy',qryAux.FieldByName('FIS_DTAENT').AsDateTime) + ' ECF ' +
            qryAux.FieldByName('FIS_NUMSER').AsString);
        End
        Else
        Begin
          stlResult.Add('Não existe Redução Z gravada para o dia ' +
            FormatDateTime('dd/mm/yyyy',qryAux.FieldByName('FIS_DTAENT').AsDateTime) + ' ECF ' +
            qryAux.FieldByName('FIS_NUMSER').AsString);
        End;
      End;
      qryAux.Next;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TInformacoesECF.fReducoesOk(strEmpresa: String): Boolean;
  Var
    stlErros: TStringList;
begin
  stlErros := TStringList.Create;
  pVerificaReducoesPendentes(strEmpresa, stlErros);

  Result := (stlErros.Count <= 0);

  If Not Result Then
  Begin
    pCriarFormularios(TfrmMemo, frmMemo);

    Try
      stlErros.Insert(0, 'Verifique as pendências abaixo antes de de prosseguir.');
      frmMemo.cxMemo.Lines.Assign(stlErros);
      frmMemo.ShowModal;
    Finally
      FreeAndNil(frmMemo);
    End;
  End;

  FreeAndNil(stlErros);
end;

function TfrmRelFiscResumoApIcms.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        pSetFocus(mskDtaIni);
        Result := False;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            pSetFocus(mskDtaFin);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) And (edtCodEmpresa.Text <> '000') Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    else if (Sender = edtNumPagina) then
    begin
      edtNumPagina.Text := fStrZero(IntToStr(StrToIntDef(edtNumPagina.Text, 2)), 6);
      edtNumPagina.Text := IIF(AnsiMatchStr(edtNumPagina.Text, ['000000', '000001']), '000002', edtNumPagina.Text);
    end;
  End;

end;

procedure TfrmRelFiscResumoApIcms.FormShow(Sender: TObject);
begin
  pnlBotoes.Align := alBottom;
  pnlDados.Align  := alLeft;

  inherited;

  mskDtaIni.Text     := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text     := FormatDateTime('dd/mm/yyyy',VS_Date);
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

  QryRelatorio := fCriaQuery;
  frxRelatorio.DataSet := QryRelatorio;
end;

procedure TfrmRelFiscResumoApIcms.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
    VK_RETURN: If ActiveControl Is TRadioButton Then
                 self.SelectNext(ActiveControl, True, True);
  End;

end;

Function TfrmRelFiscResumoApIcms.fGetSqlTotalFisc(intClaFis: Integer): String;
  Var
    strSQL   : String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  /*IF(IFNULL(AUXMOV.AUX_VENPRE, IFNULL(AUXNOT.AUX_VENPRE, "")) = "S",*/ IF(FIS_ENTSAI = "E", ';
  strSQL := strSQL + '  IF(FIS_CLFSC' + intToStr(intClaFis) + ' < 2000, "DENTRO", "FORA"), ';
  strSQL := strSQL + '  IF(FIS_CLFSC' + intToStr(intClaFis) + ' < 6000, "DENTRO", "FORA"))/*, ';
  strSQL := strSQL + '  IF(FIS_ESTADO = :ESTEMP, "DENTRO", "FORA"))*/ AS LOCALI, ';
  strSQL := strSQL + '  IF(FIS_CLFSC'  + IntToStr(intClaFis) + ' < 5000, "DEBITO" , "CREDITO")   AS NATURE, ';
  If intClaFis = 1 Then
    strSQL := strSQL + ' ' + fValorIcmsCupons + ' AS ICM_IF, '
  Else
    strSQL := strSQL + '  0.00 AS ICM_IF, ';

  //If (fCfgSis('ZERCIF', varBoolean)) Then
  If (ckbRegistrado_Ecf.Checked) And
     (ckbEnviaValores1603_2603.Checked) Then
  Begin

    strSQL := strSQL + '  SUM(IFNULL(MD.DET_VLRCON, IFNULL(ND.DET_VLRCON, IFNULL(FIS_VLCON' + IntToStr(intClaFis) + ', 0)))) AS VLRCON, ';
    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAFIS) > 0,                   ';
    strSQL := strSQL + '         IFNULL(MD.DET_VLRCON, IFNULL(ND.DET_VLRCON, IFNULL(FIS_VLCON' + IntToStr(intClaFis) + ', 0))), 0)) AS VLRCOV, ';
    strSQL := strSQL + '  SUM(IFNULL(MD.DET_BASICM, IFNULL(ND.DET_BASICM, IFNULL(FIS_BASIC' + IntToStr(intClaFis) + ', 0)))) AS BASICM, ';
    strSQL := strSQL + '  SUM(' + FStrSqlValFcp + ' + ' + fSQLValorIcms('IFNULL(MD.DET_VALICM, IFNULL(ND.DET_VALICM, IFNULL(FIS_VLRIC' + IntToStr(intClaFis) + ', 0)))')+') AS VLRICM, ';
    strSQL := strSQL + '  SUM(' + FStrSqlValFcpSt + ' + IFNULL(MD.DET_VALRET, IFNULL(ND.DET_VALRET, IFNULL(FIS_RETID' + IntToStr(intClaFis) + ', 0)))) AS RETIDO, ';
    strSQL := strSQL + '  SUM('+IIF(chkDeduzirFcpIcms.Checked, FStrSqlValFcp, '0')+') AS VLRFCP, ';
    strSQL := strSQL + '  SUM(IFNULL(MT.DET_OUTICM, IFNULL(NT.DET_OUTICM, IFNULL(FIS_OUTRA' + IntToStr(intClaFis) + ', 0)))) AS OUTRAS, ';
    strSQL := strSQL + '  SUM(IFNULL(MT.DET_ISEICM, IFNULL(NT.DET_ISEICM, IFNULL(FIS_ISENT' + IntToStr(intClaFis) + ', 0)))) AS ISENTA, ';
    strSQL := strSQL + '  SUM(IFNULL(MD.DET_VALIPI, IFNULL(ND.DET_VALIPI, IFNULL(FIS_VLRIP' + IntToStr(intClaFis) + ', 0)))) AS VLRIPI, ';
    strSQL := strSQL + '  SUM(IFNULL(MT.DET_ICMANT, IFNULL(NT.DET_ICMANT, IFNULL(FIS_ANTIC' + IntToStr(intClaFis) + ', 0)))) AS VALANT  ';

    blnClaEcf := False;
  End
  Else
  Begin
      strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0,                   ';
      strSQL := strSQL + '                0, IFNULL(MD.DET_VLRCON, IFNULL(ND.DET_VLRCON, IFNULL(FIS_VLCON' + IntToStr(intClaFis) + ',0)))))   AS VLRCON, ';

      strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAFIS) > 0,                   ';
      strSQL := strSQL + '          IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, 0, IFNULL(MD.DET_VLRCON, IFNULL(ND.DET_VLRCON, IFNULL(FIS_VLCON' + IntToStr(intClaFis)+ ',0)))), 0)) AS VLRCOV, ';

      strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0,                   ';
      strSQL := strSQL + '                0, IFNULL(MD.DET_BASICM, IFNULL(ND.DET_BASICM, IFNULL(FIS_BASIC' + IntToStr(intClaFis) + ',0)))))    AS BASICM, ';

      strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0,                   ';
      strSQL := strSQL + '                0, ' + FStrSqlValFcp + ' + ' + fSQLValorIcms('IFNULL(MD.DET_VALICM, IFNULL(ND.DET_VALICM, IFNULL(FIS_VLRIC' + IntToStr(intClaFis) + ',0)))') + ')) AS VLRICM, ';

      strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0,                   ';
      strSQL := strSQL + '                0, ' + FStrSqlValFcpSt + ' + IFNULL(MD.DET_VALRET, IFNULL(ND.DET_VALRET, IFNULL(FIS_RETID' + IntToStr(intClaFis) + ',0))))) AS RETIDO, ';

      strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0,                   ';
      strSQL := strSQL + '                0, ' + IIF(chkDeduzirFcpIcms.Checked, FStrSqlValFcp, '0') + ')) AS VLRFCP, ';

      strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0,                   ';
      strSQL := strSQL + '                0, IFNULL(MT.DET_OUTICM, IFNULL(NT.DET_OUTICM, IFNULL(FIS_OUTRA' + IntToStr(intClaFis) + ', 0))))) AS OUTRAS, ';

      strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0,                   ';
      strSQL := strSQL + '                0, IFNULL(MT.DET_ISEICM, IFNULL(NT.DET_ISEICM, IFNULL(FIS_ISENT' + IntToStr(intClaFis) + ',0)))))  AS ISENTA, ';

      strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0,                   ';
      strSQL := strSQL + '                0, IFNULL(MD.DET_VALIPI, IFNULL(ND.DET_VALIPI, IFNULL(FIS_VLRIP' + IntToStr(intClaFis) + ',0)))))  AS VLRIPI, ';

      strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0,                   ';
      strSQL := strSQL + '                0, IFNULL(MT.DET_ICMANT, IFNULL(NT.DET_ICMANT, IFNULL(FIS_ANTIC' + IntToStr(intClaFis) + ', 0)))))  AS VALANT  ';

      blnClaEcf := True;
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fGetSqlUnionConverteFiscDeCincoPraUm;

  strSQL := strSQL + '  LEFT JOIN MOVGER ';
  strSQL := strSQL + '    ON MOVGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND MOVGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND MOVGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND IFNULL(MOVGER.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN AUXMOV ';
  strSQL := strSQL + '    ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN NOTGER ';
  strSQL := strSQL + '    ON NOTGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND NOTGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND NOTGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND IFNULL(NOTGER.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", NOTGER.GER_CODCLI, NOTGER.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN AUXNOT ';
  strSQL := strSQL + '    ON AUXNOT.AUX_SEQGER = NOTGER.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN MOVDET MD ';
  strSQL := strSQL + '    ON MD.DET_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND MD.DET_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND MD.DET_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND IFNULL(MD.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", MD.DET_CODCLI, MD.DET_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + '    AND MD.DET_CLAFIS = FIS_CLFSC' + IntToStr(intClaFis);
  strSQL := strSQL + '    AND MD.DET_ALQICM = FIS_ALQIC' + IntToStr(intClaFis);

  strSQL := strSQL + '  LEFT JOIN MOVTRI MT ON MT.DET_SEQGER = MD.AUTOINCREM ';

  strSql := strSql + '  LEFT JOIN MOVICD MI ON MI.ICD_SEQGER = MD.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN NOTDET ND ';
  strSQL := strSQL + '    ON ND.DET_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND ND.DET_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND ND.DET_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND IFNULL(ND.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", ND.DET_CODCLI, ND.DET_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + '    AND ND.DET_CLAFIS = FIS_CLFSC' + IntToStr(intClaFis);
  strSQL := strSQL + '    AND ND.DET_ALQICM = FIS_ALQIC' + IntToStr(intClaFis);

  strSQL := strSQL + '  LEFT JOIN NOTTRI NT ON NT.DET_SEQGER = ND.AUTOINCREM ';

  strSql := strSql + '  LEFT JOIN NOTICD NI ON NI.ICD_SEQGER = ND.AUTOINCREM ';

  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

  Case rdgFiltroDatas.ItemIndex Of
    0: strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
    1: strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';
  End;

  If Not chkInc933.Checked Then
    strSQL := strSQL + ' AND LOCATE(RIGHT(FIS_CLFSC' + IntToStr(intClaFis) + ' ,3), "933") <= 0 ';

  strSQL := strSQL + fStrLocateEmpresa(edtCodEmpresa, arrEmp, 'FIS_CODEMP', 'CODEMP');

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  /* IF(IFNULL(AUXMOV.AUX_VENPRE, IFNULL(AUXNOT.AUX_VENPRE, "")) = "S", */ IF(FIS_ENTSAI = "E", ';
  strSQL := strSQL + '  IF(FIS_CLFSC' + intToStr(intClaFis) + ' < 2000, "DENTRO", "FORA"), ';
  strSQL := strSQL + '  IF(FIS_CLFSC' + intToStr(intClaFis) + ' < 6000, "DENTRO", "FORA"))/*, ';
  strSQL := strSQL + '  IF(FIS_ESTADO = :ESTEMP, "DENTRO", "FORA"))*/, ';
  strSQL := strSQL + '  IF(FIS_CLFSC'  + IntToStr(intClaFis) + ' < 5000, "DEBITO" , "CREDITO") ';

  Result := strSQL;
End;

Function TfrmRelFiscResumoApIcms.fGetSqlTotalUnion: String;
  Var
    strSQL: String;
    intClaFis: Integer;
Begin
  strSQL := '';
  For intClaFis := 1 To 1 Do
  Begin
    strSQL := strSQL + fGetSqlTotalFisc(intClaFis);
    If intClaFis <> 1 Then
      strSQL := strSQL + ' UNION ALL ';
  End;

  Result := strSQL;
End;

Function TfrmRelFiscResumoApIcms.fGetSqlTotalRelatorio: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                   ';
  strSQL := strSQL + '   LOCALI,                ';
  strSQL := strSQL + '   NATURE,                ';
  strSQL := strSQL + '   SUM(VLRCON) AS VLRCON, ';
  strSQL := strSQL + '   SUM(VLRCOV) AS VLRCOV, ';
  strSQL := strSQL + '   SUM(BASICM) AS BASICM, ';
  strSQL := strSQL + '   SUM(VLRICM) AS VLRICM, ';
  strSQL := strSQL + '   SUM(VLRFCP) AS VLRFCP, ';
  strSQL := strSQL + '   SUM(VALANT) AS VALANT, ';
  strSQL := strSQL + '   SUM(RETIDO) AS RETIDO, ';
  strSQL := strSQL + '   SUM(OUTRAS) AS OUTRAS, ';
  strSQL := strSQL + '   SUM(ISENTA) AS ISENTA, ';
  strSQL := strSQL + '   SUM(VLRIPI) AS VLRIPI, ';
  strSQL := strSQL + '   ICM_IF';

  strSQL := strSQL + '  FROM (';

  strSQL := strSQL + fGetSqlTotalUnion;

  strSQL := strSQL + ' ) AS TAB ';

  strSQL := strSQL + '  GROUP BY ';
  strSQL := strSQL + '    LOCALI,                ';
  strSQL := strSQL + '    NATURE                 ';

  strSQL := strSQL + '  ORDER BY ';
  strSQL := strSQL + '    LOCALI,                ';
  strSQL := strSQL + '    NATURE                 ';

  Result := strSQL;
End;

Procedure TfrmRelFiscResumoApIcms.pTotalRelatorio;
  Var
    strClaEcf: String;
Begin
  With qryTotRel Do
  Begin
    SQL.Text := fGetSqlTotalRelatorio;

    If Active Then
      Close;

    ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      pSetaParam(edtCodEmpresa.Text, arrEmp, strEmpresa, 'CODEMP', qryTotRel);

    // ParamByName('ESTEMP').AsString := QryRelatorio.FieldByName('ESTADO').AsString;
    ParamByName('CLAFIS').AsString := VS_strClaVen + IIF(ckbRegistrado_Ecf.Checked, '5929_6929_', '') + IIF(ckbEnviaValores1603_2603.Checked, '1603_2603_', '');

    If blnClaEcf Then
    Begin
      If Not ckbRegistrado_Ecf.Checked Then
        strClaEcf := strClaEcf + CLAFIS_REGISTRADO_ECF;

      If (Not ckbEnviaValores1603_2603.Checked) Then
        strClaEcf := strClaEcf + '1603_2603_';

      ParamByName('CLAECF').AsString := strClaEcf;
    End;

    Open;

    fltValAnt := 0;
    While Not Eof Do
    Begin
      fltValAnt := fltValAnt + FieldByName('VALANT').AsFloat;
      Next;
    End;

    First;

  End;
End;

Procedure TfrmRelFiscResumoApIcms.pIniTotal(qckRel: TfrxReport; strLocal, strNatureza, strInicial: String; blnIncrem: Boolean);
Begin

  With qryTotRel, qckRel.Script Do
  Begin
    If Locate('LOCALI;NATURE',VarArrayOf([strLocal,strNatureza]),[]) Then
    Begin
      Variables[strInicial + 'VLRCON'] := FieldByName('VLRCON').AsFloat;
      Variables[strInicial + 'VLRCOV'] := FieldByName('VLRCOV').AsFloat;
      Variables[strInicial + 'BASICM'] := FieldByName('BASICM').AsFloat;
      Variables[strInicial + 'VLRICM'] := FieldByName('VLRICM').AsFloat + IfThen(blnIncrem = True, FieldByName('ICM_IF').AsFloat, 0);
      Variables[strInicial + 'RETIDO'] := FieldByName('RETIDO').AsFloat;
      Variables[strInicial + 'OUTRAS'] := FieldByName('OUTRAS').AsFloat;
      Variables[strInicial + 'ISENTA'] := FieldByName('ISENTA').AsFloat;
      Variables[strInicial + 'VLRIPI'] := FieldByName('VLRIPI').AsFloat;
    End Else
    Begin
      Variables[strInicial + 'VLRCON'] := 0;
      Variables[strInicial + 'VLRCOV'] := 0;
      Variables[strInicial + 'BASICM'] := 0;
      Variables[strInicial + 'VLRICM'] := 0;
      Variables[strInicial + 'RETIDO'] := 0;
      Variables[strInicial + 'OUTRAS'] := 0;
      Variables[strInicial + 'ISENTA'] := 0;
      Variables[strInicial + 'VLRIPI'] := 0;
    End;
  End;

End;

Procedure TfrmRelFiscResumoApIcms.pInicializaTotais(qckRel: TfrxReport);
Begin
  pIniTotal(qckRel,'DENTRO','DEBITO',  'D_D_', False);
  pIniTotal(qckRel,'FORA',  'DEBITO',  'F_D_', False);

  pIniTotal(qckRel,'DENTRO','CREDITO', 'D_C_', True);
  pIniTotal(qckRel,'FORA',  'CREDITO', 'F_C_', False);
End;

function TfrmRelFiscResumoApIcms.fCarregaDeducoes: Double;
var
  qryDeducoes: TUniQuery;
  intMesIni,
  intMesFin,
  intAnoIni,
  intAnoFin: integer;
begin
  Result := 0;
  intMesIni := MonthOf(StrToDateDef(mskDtaIni.Text, 0));
  intMesFin := MonthOf(StrToDateDef(mskDtaFin.Text, 0));
  intAnoIni := YearOf(StrToDateDef(mskDtaIni.Text, 0));
  intAnoFin := YearOf(StrToDateDef(mskDtaFin.Text, 0));
  qryDeducoes := fCriaQuery;

  With qryDeducoes, Sql Do
  Begin
    Clear;
    Close;
    Add('SELECT SUM(A.AJU_VALAJU) VALOR FROM AJUICM A ');
    Add('INNER JOIN AJUSTE B ON B.AJU_CODAJU = A.AJU_CODAJU ');
    Add('WHERE   B.AJU_TIPAJU = "4" AND ');
    Add('IFNULL(B.AJU_ENVAPU, "N") = "S" AND ');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      Add('A.AJU_CODEMP = :CODEMP AND ');

    Add('(');
    Add('  (CAST(SUBSTRING(AJU_MESANO, 4, 4)  AS SIGNED)) >= :ANOINI');
    Add('  AND');
    Add('  (CAST(SUBSTRING(AJU_MESANO, 1, 2) AS SIGNED)) >= :MESINI');
    Add(') ');

    Add('AND ');

    Add('(');
    Add('  (CAST(SUBSTRING(AJU_MESANO, 4, 4)  AS SIGNED)) <= :ANOFIN');
    Add('  AND');
    Add('  (CAST(SUBSTRING(AJU_MESANO, 1, 2) AS SIGNED)) <= :MESFIN');
    Add(') ');

    ParamByName('ANOINI').AsInteger := intAnoIni;
    ParamByName('ANOFIN').AsInteger := intAnoFin;
    ParamByName('MESINI').AsInteger := intMesIni;
    ParamByName('MESFIN').AsInteger := intMesFin;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    Open;

    If Not isEmpty Then
      Result := FieldByName('VALOR').AsFloat;

  End;
end;

function TfrmRelFiscResumoApIcms.fGetSqlConverteFiscDeCincoPraUm(intClaFis: string): string;
  var
    strSQL: string;
begin
  strSQL := '            SELECT ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_ENTSAI AS FIS_ENTSAI, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_CODEMP AS FIS_CODEMP, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_ACESSO AS FIS_ACESSO, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_HISTOR AS FIS_HISTOR, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_DTAENT AS FIS_DTAENT, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_DTADOC AS FIS_DTADOC, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_NUMDOC AS FIS_NUMDOC, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_SERIE_ AS FIS_SERIE_, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_FORCLI AS FIS_FORCLI, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_ESPDOC AS FIS_ESPDOC, ';
  strSQL := strSQL + '     CLFSC' + intClaFis + '.FIS_TIP_FC AS FIS_TIP_FC, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_CLFSC' + intClaFis + ', "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_VLCON' + intClaFis + ', 0) AS FIS_VLCON1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_OUTRA' + intClaFis + ', 0) AS FIS_OUTRA1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_BCRET' + intClaFis + ', 0) AS FIS_BCRET1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_RETID' + intClaFis + ', 0) AS FIS_RETID1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_ISENT' + intClaFis + ', 0) AS FIS_ISENT1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_BASIC' + intClaFis + ', 0) AS FIS_BASIC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_ALQIC' + intClaFis + ', 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_VLRIC' + intClaFis + ', 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_BASIP' + intClaFis + ', 0) AS FIS_BASIP1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_VLRIP' + intClaFis + ', 0) AS FIS_VLRIP1, ';
  strSQL := strSQL + '     IFNULL(CLFSC' + intClaFis + '.FIS_ANTIC' + intClaFis + ', 0) AS FIS_ANTIC1 ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + '     CADFIS CLFSC' + intClaFis;
  strSQL := strSQL + '   WHERE (IFNULL(CLFSC' + intClaFis + '.FIS_HISTOR, "") <> "CANCELADO") ';

  case rdgFiltroDatas.ItemIndex Of
    0: strSQL := strSQL + 'AND CLFSC' + intClaFis + '.FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
    1: strSQL := strSQL + 'AND CLFSC' + intClaFis + '.FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';
  end;
  strSQL := strSQL + fStrLocateEmpresa(edtCodEmpresa, arrEmp, 'CLFSC' + intClaFis + '.FIS_CODEMP', 'CODEMP');

  if not chkInc933.Checked then
    strSQL := strSQL + '   AND LOCATE(RIGHT(CLFSC' + intClaFis + '.FIS_CLFSC' + intClaFis + ', 3), "933") <= 0 ';

  strSQL := strSQL + '     AND LENGTH(CLFSC' + intClaFis + '.FIS_CLFSC' + intClaFis + ') > 0 ';

  result := strSQL;
end;

Function TfrmRelFiscResumoApIcms.fGetSqlFisc(intClaFis: Integer): String;
  Var
    strSQL   : String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT           ';
  strSQL := strSQL + '  CRE_ICMANT      AS ICMANT, ';
  strSQL := strSQL + '  EMP_I_E_S_      AS I_E_S_, ';
  strSQL := strSQL + '  EMP_C_G_C_      AS C_G_C_, ';
  strSQL := strSQL + '  CID_ESTADO      AS ESTADO, ';
  strSQL := strSQL + '  FIS_CLFSC'     + IntToStr(intClaFis) + '  AS CLAFSC, ';

  ///If (fCfgSis('ZERCIF', varBoolean)) Then
  If (ckbRegistrado_Ecf.Checked) And
     (ckbEnviaValores1603_2603.Checked) Then
  Begin
    strSQL := strSQL + '  SUM(IFNULL(MD.DET_VLRCON, IFNULL(ND.DET_VLRCON, IFNULL(FIS_VLCON' + IntToStr(intClaFis) + ',0)))) AS VLRCON, ';
    strSQL := strSQL + '  SUM(IFNULL(MD.DET_BASICM, IFNULL(ND.DET_BASICM, IFNULL(FIS_BASIC' + IntToStr(intClaFis) + ',0)))) AS BASICM, ';
    strSQL := strSQL + '  SUM(' + FStrSqlValFcp + ' + ' + fSQLValorIcms('IFNULL(MD.DET_VALICM, IFNULL(ND.DET_VALICM, IFNULL(FIS_VLRIC' + IntToStr(intClaFis) + ', 0)))')+') AS VLRICM, ';
    strSQL := strSQL + '  SUM(' + FstrSqlValFcpSt + ' + IFNULL(MD.DET_VALRET, IFNULL(ND.DET_VALRET, IFNULL(FIS_RETID' + IntToStr(intClaFis) + ',0)))) AS RETIDO, ';
    strSQL := strSQL + '  SUM(' + IIF(chkDeduzirFcpIcms.Checked, FStrSqlValFcp, '0') +') AS VLRFCP, ';
    strSQL := strSQL + '  SUM(IFNULL(MT.DET_OUTICM, IFNULL(NT.DET_OUTICM, IFNULL(FIS_OUTRA' + IntToStr(intClaFis) + ',0)))) AS OUTRAS, ';
    strSQL := strSQL + '  SUM(IFNULL(MT.DET_ISEICM, IFNULL(NT.DET_ISEICM, IFNULL(FIS_ISENT' + IntToStr(intClaFis) + ',0)))) AS ISENTA, ';
    strSQL := strSQL + '  SUM(IFNULL(MD.DET_VALIPI, IFNULL(ND.DET_VALIPI, IFNULL(FIS_VLRIP' + IntToStr(intClaFis) + ',0)))) AS VLRIPI  ';

    blnClaEcf := False;
  End
  Else
  Begin
    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", IFNULL(MD.DET_VLRCON, IFNULL(ND.DET_VLRCON, IFNULL(FIS_VLCON' + IntToStr(intClaFis) + ',0))))) AS VLRCON, ';
    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", IFNULL(MD.DET_BASICM, IFNULL(ND.DET_BASICM, IFNULL(FIS_BASIC' + IntToStr(intClaFis) + ',0))))) AS BASICM, ';
    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", ' + FStrSqlValFcp + ' + ' + fSQLValorIcms('IFNULL(MD.DET_VALICM, IFNULL(ND.DET_VALICM, IFNULL(FIS_VLRIC' + IntToStr(intClaFis) + ',0)))') + ')) AS VLRICM, ';
    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", ' + IIF(chkDeduzirFcpIcms.Checked, FStrSqlValFcp, '0') + ')) AS VLRFCP, ';
    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", ' + FStrSqlValFcpSt + ' + IFNULL(MD.DET_VALRET, IFNULL(ND.DET_VALRET, IFNULL(FIS_RETID' + IntToStr(intClaFis) + ',0))))) AS RETIDO, ';
    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", IFNULL(MT.DET_OUTICM, IFNULL(NT.DET_OUTICM, IFNULL(FIS_OUTRA' + IntToStr(intClaFis) + ',0))))) AS OUTRAS, ';
    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", IFNULL(MT.DET_ISEICM, IFNULL(NT.DET_ISEICM, IFNULL(FIS_ISENT' + IntToStr(intClaFis) + ',0))))) AS ISENTA, ';
    strSQL := strSQL + '  SUM(IF(LOCATE(FIS_CLFSC' + IntToStr(intClaFis) + ', :CLAECF) > 0, "0.0", IFNULL(MD.DET_VALIPI, IFNULL(ND.DET_VALIPI, IFNULL(FIS_VLRIP' + IntToStr(intClaFis) + ',0))))) AS VLRIPI  ';

    blnClaEcf := True;
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fGetSqlUnionConverteFiscDeCincoPraUm;

  strSQL := strSQL + '  LEFT JOIN MOVGER ';
  strSQL := strSQL + '    ON MOVGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND MOVGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND MOVGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND IFNULL(MOVGER.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN NOTGER ';
  strSQL := strSQL + '    ON NOTGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND NOTGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND NOTGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND IFNULL(NOTGER.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", NOTGER.GER_CODCLI, NOTGER.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN MOVDET MD ';
  strSQL := strSQL + '    ON MD.DET_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND MD.DET_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND MD.DET_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND IFNULL(MD.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", MD.DET_CODCLI, MD.DET_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + '    AND MD.DET_CLAFIS = FIS_CLFSC' + IntToStr(intClaFis);
  strSQL := strSQL + '    AND MD.DET_ALQICM = FIS_ALQIC' + IntToStr(intClaFis);

  strSQL := strSQL + '  LEFT JOIN MOVTRI MT ON MT.DET_SEQGER = MD.AUTOINCREM ';

  strSql := strSql + '  LEFT JOIN MOVICD MI ON MI.ICD_SEQGER = MD.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN NOTDET ND ';
  strSQL := strSQL + '    ON ND.DET_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '    AND ND.DET_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '    AND ND.DET_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '    AND IFNULL(ND.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '    AND IF(FIS_TIP_FC = "C", ND.DET_CODCLI, ND.DET_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + '    AND ND.DET_CLAFIS = FIS_CLFSC' + IntToStr(intClaFis);
  strSQL := strSQL + '    AND ND.DET_ALQICM = FIS_ALQIC' + IntToStr(intClaFis);

  strSQL := strSQL + '  LEFT JOIN NOTTRI NT ON NT.DET_SEQGER = ND.AUTOINCREM ';

  strSql := strSql + '  LEFT JOIN NOTICD NI ON NI.ICD_SEQGER = ND.AUTOINCREM ';

  strSQL := strSQL + '  INNER JOIN CADEMP ON EMP_CODEMP = FIS_CODEMP ';

  strSQL := strSQL + '  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CREFIS ON CRE_CODEMP = EMP_CODEMP AND ';
  strSQL := strSQL + '                      CRE_MESREF = :MESREF ';

  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + '  (IFNULL(FIS_HISTOR, "") <> "CANCELADO") AND ';

  Case rdgFiltroDatas.ItemIndex Of
    0: strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
    1: strSQL := strSQL + '  FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN ';
  End;

  strSQL := strSQL + fStrLocateEmpresa(edtCodEmpresa, arrEmp, 'FIS_CODEMP', 'CODEMP');

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  FIS_CLFSC' + IntToStr(intClaFis) + ' ';

  Result := strSQL;
End;

Function TfrmRelFiscResumoApIcms.fGetSqlUnion: String;
  Var
    strSQL: String;
    intClaFis: Integer;
Begin
  strSQL := '';
  For intClaFis := 1 To 1 Do
  Begin
    strSQL := strSQL + fGetSqlFisc(intClaFis);
    If intClaFis <> 1 Then
      strSQL := strSQL + ' UNION ALL ';
  End;

  Result := strSQL;
End;

function TfrmRelFiscResumoApIcms.fGetSqlUnionConverteFiscDeCincoPraUm: string;
  Var
    strSQL: String;
    intClaFis: Integer;
Begin
  strSQL := '';
  strSQL := '( SELECT ';
  strSQL := strSQL + '   FIS_ENTSAI, ';
  strSQL := strSQL + '   FIS_ESPDOC, ';
  strSQL := strSQL + '   FIS_ACESSO, ';
  strSQL := strSQL + '   FIS_HISTOR, ';
  strSQL := strSQL + '   FIS_DTAENT, ';
  strSQL := strSQL + '   FIS_DTADOC, ';
  strSQL := strSQL + '   FIS_CODEMP, ';
  strSQL := strSQL + '   FIS_NUMDOC, ';
  strSQL := strSQL + '   FIS_SERIE_, ';
  strSQL := strSQL + '   FIS_TIP_FC, ';
  strSQL := strSQL + '   FIS_FORCLI, ';
  strSQL := strSQL + '   FIS_CLFSC1, ';
  strSQL := strSQL + '   FIS_ALQIC1, ';
  strSQL := strSQL + '   SUM(FIS_VLCON1) AS FIS_VLCON1, ';
  strSQL := strSQL + '   SUM(FIS_OUTRA1) AS FIS_OUTRA1, ';
  strSQL := strSQL + '   SUM(FIS_BCRET1) AS FIS_BCRET1, ';
  strSQL := strSQL + '   SUM(FIS_RETID1) AS FIS_RETID1, ';
  strSQL := strSQL + '   SUM(FIS_ISENT1) AS FIS_ISENT1, ';
  strSQL := strSQL + '   SUM(FIS_BASIC1) AS FIS_BASIC1, ';
  strSQL := strSQL + '   SUM(FIS_VLRIC1) AS FIS_VLRIC1, ';
  strSQL := strSQL + '   SUM(FIS_BASIP1) AS FIS_BASIP1, ';
  strSQL := strSQL + '   SUM(FIS_VLRIP1) AS FIS_VLRIP1, ';
  strSQL := strSQL + '   SUM(FIS_ANTIC1) AS FIS_ANTIC1 ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ( ';

  for intClaFis := 1 to 5 do
  begin
    strSQL := strSQL + fGetSqlConverteFiscDeCincoPraUm(IntToStr(intClaFis));
    if intClaFis <> 5 then
      strSQL := strSQL + ' UNION ALL ';
  end;

  strSQL := strSQL + ' ) AS TCADFIS ';
  strSQL := strSQL + ' GROUP BY FIS_CODEMP, ';
  strSQL := strSQL + '   FIS_NUMDOC, ';
  strSQL := strSQL + '   FIS_SERIE_, ';
  strSQL := strSQL + '   FIS_TIP_FC, ';
  strSQL := strSQL + '   FIS_FORCLI, ';
  strSQL := strSQL + '   FIS_DTAENT, ';
  strSQL := strSQL + '   FIS_DTADOC, ';
  strSQL := strSQL + '   FIS_HISTOR, ';
  strSQL := strSQL + '   FIS_ACESSO, ';
  strSQL := strSQL + '   FIS_ESPDOC, ';
  strSQL := strSQL + '   FIS_ENTSAI, ';
  strSQL := strSQL + '   FIS_CLFSC1, ';
  strSQL := strSQL + '   FIS_ALQIC1 ) AS TB_CADFIS ';

  Result := strSQL;
end;

Function TfrmRelFiscResumoApIcms.fGetSqlRelatorio: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT       ';
  strSQL := strSQL + '   ICMANT, ';
  strSQL := strSQL + '   I_E_S_, ';
  strSQL := strSQL + '   C_G_C_, ';
  strSQL := strSQL + '   ESTADO, ';
  strSQL := strSQL + '   CLAFSC, ';
  strSQL := strSQL + '   SUM(VLRCON) AS VLRCON, ';
  strSQL := strSQL + '   SUM(BASICM) AS BASICM, ';

  strSQL := strSQL + '  IFNULL(SUM(VLRICM),0) + IF(CLAFSC="5102", ' + fValorIcmsCupons + ',0) AS VLRICM, ';
  strSQL := strSQL + '  SUM(VLRFCP) AS VLRFCP, ';

  strSQL := strSQL + '   SUM(RETIDO) AS RETIDO, ';
  strSQL := strSQL + '   SUM(OUTRAS) AS OUTRAS, ';
  strSQL := strSQL + '   SUM(ISENTA) AS ISENTA, ';
  strSQL := strSQL + '   SUM(VLRIPI) AS VLRIPI  ';

  strSQL := strSQL + '  FROM (';

  strSQL := strSQL + fGetSqlUnion;

  strSQL := strSQL + ' ) AS TAB ';

  If Not chkInc933.Checked Then
    strSQL := strSQL + ' WHERE LOCATE(RIGHT(CLAFSC, 3), "933") <= 0 ';

  strSQL := strSQL + '  GROUP BY ';

  strSQL := strSQL + '    CLAFSC ';

  strSQL := strSQL + '  ORDER BY ';

  strSQL := strSQL + '    CLAFSC ';

  Result := strSQL;
End;


procedure TfrmRelFiscResumoApIcms.btnImprimirClick(Sender: TObject);
  var
    EstDeb, EstCre, OutDeb, OutCre: double;
    strClaEcf: string;
    apuradorIcms: TApuradorAjustesIcms;
    dadosCat158: TDadosCreditoCat158;
    dadosDifal: TDadosDifal;
    qckRel: TfrxReport;
    qryAux: TUniQuery;
    intIndex: integer;
    strDocumentosParados:String;
begin

  strDocumentosParados := fVerificaDocumentoComErroNoPainelNFE;

  If Not fEmptyStr(strDocumentosParados) Then
  Begin
   pExibeMensagemDeValidacao(strDocumentosParados);
   exit;
  end;

  If fVerificaCampos Then
  Begin
    if chkIncluirFcpIcms.Checked then
    begin
      FStrSqlValFcpSt := 'IFNULL(MT.DET_VFCPST, IFNULL(NT.DET_VFCPST, 0)) ';
      FStrSqlValFcp := 'IFNULL(MI.ICD_VALFCP, IFNULL(NI.ICD_VALFCP, 0)) ';

    end
    else
    begin
      FStrSqlValFcpSt := '0';
      FStrSqlValFcp := '0';
    end;

    If Length(arrEmp) = 0 Then
      edtCodEmpresaExit(Sender);

    EstDeb := 0;
    EstCre := 0;
    OutDeb := 0;
    OutCre := 0;

    If (Not fCfgSis('USNFCE', varBoolean)) And
       ((Not fCfgSis('USASAT', varBoolean)) Or (fCfgSis('SATECF', varBoolean )) ) Then
    Begin
      If (StrToDate(mskDtaIni.Text) <> StrToDate(mskDtaFin.Text)) Then
      Begin
       If Not fReducoesOk Then
         Exit;
      End;
    End;

    pnlInfo.Caption := 'Gerando Relatório...';
    pnlInfo.Repaint;

    inherited;

    If blnImprime Then
    Begin
      With QryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fGetSqlRelatorio);

        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
        ParamByName('MESREF').AsString := fRetornaMesRefCreFis;

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          pSetaParam(edtCodEmpresa.Text, arrEmp, strEmpresa, 'CODEMP', QryRelatorio);

        If blnClaEcf Then
        Begin
          If Not ckbRegistrado_Ecf.Checked Then
            strClaEcf := strClaEcf + CLAFIS_REGISTRADO_ECF;

          If (Not ckbEnviaValores1603_2603.Checked) Then
            strClaEcf := strClaEcf + '1603_2603_';

          ParamByName('CLAECF').AsString := strClaEcf;
        End;

        Open;

        pTotalRelatorio;
      End;

      If Not QryRelatorio.IsEmpty Then
      Begin

        If strTipImp = 'M' Then
          qckRel := frxReportM
        Else
        Begin
          qckRel := frxReportJ;
          qckRel.PrintOptions.PrintOnSheet := 9;
        End;

        qckRel.AddFunction('function fStrToFloat(strValor: String): Double;');

        pInicializaTotais(qckRel);

        qckRel.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

        qckRel.Script.Variables['EMPRESA'] := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmpresa, 'EMPRESA', TRUE);

        qckRel.Script.Variables['CGC']     := IfThen(strTipImp = 'M','CNPJ.......: ', '') +  fFormataCpfCgc(QryRelatorio.FieldByName('C_G_C_').AsString, FPais,
                                                 QryRelatorio.FieldByName('ESTADO').AsString) +
                                                 '     INSC.ESTADUAL.....: ' + QryRelatorio.FieldByName('I_E_S_').AsString;
        If strTipImp = 'M' Then
          qckRel.Script.Variables['PERIODO'] := 'RELATORIO DO RESUMO DE APURACAO DE I.C.M.S. REFERENTE AO PERIODO DE ' +
                                                FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' +
                                                FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFin.Text))
        Else
          qckRel.Script.Variables['PERIODO'] := 'RELATÓRIO DO RESUMO DE APURAÇÃO DE I.C.M.S. REFERENTE AO PERÍODO DE ' +
                                                FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' +
                                                FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFin.Text));

        qckRel.Script.Variables['ICMANT'] := fFormataFloat(QryRelatorio.FieldByName('ICMANT').AsfLOAT, 02);

        qckRel.Script.Variables['DEBITO_FCP']  := fFormataFloat(fValorFCP('CREDITO'),  02);
        qckRel.Script.Variables['CREDITO_FCP'] := fFormataFloat(fValorFCP('DEBITO'), 02);

        cdsOutIcmDebito.EmptyDataSet;
        cdsOutIcmCredito.EmptyDataSet;

        apuradorIcms := TApuradorAjustesIcms.Create(frmModulo.GetCurrentConnection);
        dadosCat158 := TDadosCreditoCat158.Create(frmModulo.GetCurrentConnection);
        dadosDifal := TDadosDifal.Create(frmModulo.GetCurrentConnection);
        try
          for intIndex := 0 to 2 do
          begin
            apuradorIcms.pCarregarAjustes(fRetTipoAjusteIcms(intIndex),
                                          StrToDate(mskDtaIni.Text),
                                          StrToDate(mskDtaFin.Text),
                                          fRetStringEmpresaDadosCat158);

            if chkDetalhamentoDebCred.Checked then
            begin
              apuradorIcms.pCarregaObservacoesCredito(cdsOutIcmDebito);
              apuradorIcms.pCarregaObservacoesDebito(cdsOutIcmCredito);
            end;

            EstDeb := EstDeb + apuradorIcms.fRetValorEstornoDebito;
            EstCre := EstCre + apuradorIcms.fRetValorEstornoCredito;
            OutDeb := OutDeb + apuradorIcms.fRetValorOutrosDebitos;
            OutCre := OutCre + apuradorIcms.fRetValorOutrosCreditos;
          end;

          qckRel.Script.Variables['fltDeducoes'] := fCarregaDeducoes;
          qckRel.Script.Variables['fltAntIcm'] := fltValAnt;
          qckRel.Script.Variables['DEBITO'] := fFormataFloat(OutDeb, 02);
          qckRel.Script.Variables['CREDITO'] := fFormataFloat(OutCre, 02);
          qckRel.Script.Variables['EST_DEB'] := fFormataFloat(EstDeb, 02);
          qckRel.Script.Variables['EST_CRE'] := fFormataFloat(EstCre, 02);
          qckRel.Script.Variables['CREDITO_CAT158'] := IIF(not chkIncluirCreditoCat158.Checked, 0, dadosCat158.fRetCreditoPeriodo(StrToDate(mskDtaIni.Text), fRetStringEmpresaDadosCat158));
          qckRel.Script.Variables['DEBITO_DIFAL'] := IIF(not chkIncluirCreDebDifal.Checked, 0, dadosDifal.fRetDebitoPeriodo(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), arrEmp));
          qckRel.Script.Variables['CREDITO_DIFAL'] := IIF(not chkIncluirCreDebDifal.Checked, 0, dadosDifal.fRetCreditoPeriodo(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), arrEmp));
        finally
          apuradorIcms.Free;
          dadosCat158.Free;
          dadosDifal.Free;
        end;

        fAtuCfgSis('FOLAPU', edtNumPagina.Text);

        If (chkDetalhamentoDebCred.Checked) Then
          qckRel.Pages[2].Visible := True
        Else
          qckRel.Pages[2].Visible := False;

        {$IFDEF TESTABILIDADE_AUTCOM}
          // O botão salvar será utilizado nos testes automatizados
          qckRel.PreviewOptions.Buttons := [pbPrint, pbZoom, pbSave, pbFind, pbOutline, pbPageSetup, pbNavigator, pbExport];
        {$ELSE}
          qckRel.PreviewOptions.Buttons := [pbPrint, pbZoom, pbFind, pbOutline, pbPageSetup, pbNavigator];
        {$ENDIF}

        If edtDestino.Text = 'V' Then
          pPreviewReport(Self.Name, Self.Caption, qckRel)
        Else
          If qckRel.PrepareReport Then
            pPrintReport(Self.Name, Self.Caption, strNomImp, qckRel);

        edtNumPagina.Text := fRetornaNumPagina('FOLAPU');
      End
      Else
        pTabelaVazia;
    End;

    pSetFocus(mskDtaIni);
    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';

    FreeAndNil(qryAux);
  End;
end;

procedure TfrmRelFiscResumoApIcms.btnOutrosClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmCadAjustIcm);
end;

procedure TfrmRelFiscResumoApIcms.chkIncluirFcpIcmsClick(Sender: TObject);
begin
  inherited;
  chkDeduzirFcpIcms.Enabled := chkIncluirFcpIcms.Checked;
  chkDeduzirFcpIcms.Checked := IIF(chkDeduzirFcpIcms.Enabled = False, False, chkDeduzirFcpIcms.Checked);

end;

procedure TfrmRelFiscResumoApIcms.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelFiscResumoApIcms.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFiscResumoApIcms.edtNumPaginaExit(Sender: TObject);
begin
  inherited;

  fValidaCampos(edtNumPagina, True);
end;

procedure TfrmRelFiscResumoApIcms.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFiscResumoApIcms.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(QryRelatorio);
end;

procedure TfrmRelFiscResumoApIcms.FormCreate(Sender: TObject);
begin
  inherited;
  FPais := fSetaPais;
  qryTotRel := fCriaQuery(Self);

  cdsOutIcmCredito.CreateDataSet;
  cdsOutIcmDebito.CreateDataSet;

  edtNumPagina.Text := fRetornaNumPagina('FOLAPU');
  chkDeduzirFcpIcms.Enabled := False;

  {**************************************}
  {* PASSA A FUNCTION PARA O FASTREPORT *}
  {***********************************LU*}
  frxReportJ.AddFunction('function fRetAtuPagFisc(strNomCampo: String): String');
  frxReportM.AddFunction('function fRetAtuPagFisc(strNomCampo: String): String');
end;

function TfrmRelFiscResumoApIcms.frxReportMUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  inherited;

  If SameText(MethodName,'fStrToFloat') Then
    Result := fStrToFloat(Trim(Params[0]))

  Else If MethodName = 'FRETATUPAGFISC' Then
  Begin
    Result := UpperCase(fRetAtuPagFisc(Params[0]));
  End;

end;

function TfrmRelFiscResumoApIcms.frxReportJUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  inherited;

  If SameText(MethodName,'fStrToFloat') Then
    Result := fStrToFloat(Trim(Params[0]))

  Else If MethodName = 'FRETATUPAGFISC' Then
    Result := UpperCase(fRetAtuPagFisc(Params[0]));

end;

function TfrmRelFiscResumoApIcms.fRetornaNumPagina(strNomCampo: string): string;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := fRetSQLNumProximaPagina;
    qryAux.ParamByName('NOMCAMPO').AsString := 'CFG_' + strNomCampo;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;

    Result := fStrZero(IntToStr(StrToIntDef(qryAux.FieldByName('SIS_VALCFG').AsString, 2)), 6);
    Result := IIF(AnsiMatchStr(Result, ['000000', '000001']), '000002', Result);
  finally
    qryAux.Free;
  end;
end;

function TfrmRelFiscResumoApIcms.fRetAtuPagFisc(strNomCampo: String): String;
var
  strNum: String;
begin
  strNum := fRetornaNumPagina(strNomCampo);

  fAtuCfgSis(strNomCampo, fStrZero(StrToInt(strNum) + 1, 6));

  Result := strNum;
end;

function TfrmRelFiscResumoApIcms.fReducoesOk: Boolean;
  Var
    infoEcf: TInformacoesECF;
begin
  infoEcf := TInformacoesECF.Create(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));
  Result := infoEcf.fReducoesOk(edtCodEmpresa.Text);
  FreeAndNil(infoEcf);
end;

procedure TfrmRelFiscResumoApIcms.pCarregaValoresIcmsCupons(strCodEmp: String;
  Var fltTotalValorIcms: Double);
  Var
    informacoesEcf: TInformacoesECF;
    fltTotalBaseIcms: Double;
    fltValorContabil: Double;
begin
  fltTotalBaseIcms := 0;
  fltTotalValorIcms := 0;

  informacoesEcf := TInformacoesECF.Create(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));
  informacoesEcf.pProcessarInformacoes;
  informacoesEcf.pTotaisPorLoja(strCodEmp, fltValorContabil, fltTotalBaseIcms, fltTotalValorIcms);
  FreeAndNil(informacoesEcf);
end;

function TfrmRelFiscResumoApIcms.fSQLValorIcms(const strCampo: String): String;
begin
  Result := ' IF(((FIS_ESPDOC IN ("IF","IV")) AND (IFNULL(FIS_ACESSO, "") = "")), 0, ' + strCampo + ')';
end;

function TfrmRelFiscResumoApIcms.fValorFCP(strNature: String): Double;
var strNatureza: String;
begin
  Result := 0;
  QryRelatorio.First;
  While Not QryRelatorio.Eof Do
  Begin
    strNatureza := IIF(QryRelatorio.FieldByName('CLAFSC').AsString < '5000', 'DEBITO', 'CREDITO');
    If strNature = strNatureza Then
    Begin
      Result := Result + QryRelatorio.FieldByName('VLRFCP').AsFloat;
    End;
    QryRelatorio.Next;
  End;
  qryTotRel.First;
end;

function TfrmRelFiscResumoApIcms.fValorIcmsCupons: String;
  Var
    fltValorIcms: Double;
begin
  pCarregaValoresIcmsCupons(edtCodEmpresa.Text, fltValorIcms);
  Result := AnsiReplaceStr(FormatFloat('0#.##', fltValorIcms), ',', '.');
end;

function TfrmRelFiscResumoApIcms.fRetornaMesRefCreFis: String;
  Var
    dtaIni: TDateTime;
begin
  dtaIni := StrToDateDef(mskDtaIni.Text, 0);
  Result := FormatDateTime('mmyyyy', IncMonth(dtaIni, -1));
end;

function TfrmRelFiscResumoApIcms.fRetSQLNumProximaPagina: String;
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT SIS_VALCFG ';
  strSQL := strSQL + '  FROM CFGSIS ';
  strSQL := strSQL + ' WHERE SIS_CODCFG = :NOMCAMPO ';
  strSQL := strSQL + '   AND SIS_CODEMP = :CODEMP ';

  Result := strSQL;
end;

function TfrmRelFiscResumoApIcms.fRetStringEmpresaDadosCat158: string;
  var
    intIndex: integer;
begin
  Result := edtCodEmpresa.Text;

  if Length(arrEmp) > 0 then
  begin
    Result := '';

    for intIndex := Low(arrEmp) to High(arrEmp) do
    begin
      Result :=  Result + arrEmp[intIndex].strCodigo + '_';
    end;
  end;
end;

function TfrmRelFiscResumoApIcms.fRetTipoAjusteIcms(intIndex: integer): string;
begin
  case intIndex of
    0: Result := 'GERAL';
    1: Result := 'DOCUMENTO';
    2: Result := 'PRODUTO';
  end;
end;

end.

