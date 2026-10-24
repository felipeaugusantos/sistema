{***************************}
{* qryConCli -> CADCLI     *}
{* qryConEmp -> CADEMP     *}
{************************JB*}

{***************************}
{* qryConPor -> CADPOR     *}
{************************RV*}

unit untGeraDuplicataReceber;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask, untfuncoesSimples,
  Uni, MaskEditFocus, EditFocus, ComCtrls, Buttons,
  ExtCtrls, DB, Menus, AppEvnts, strUtils, MemoFocus, UniClientDataSet, UniDataSetProvider,
  cxControls, cxContainer, cxEdit, cxProgressBar, BitBtnLockedIncrem,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, frxClass, untFuncoes,
  frxExportCSVTestabilidade, untGeraDuplicataReceberLayoutMod1, untConsultas, untTypesSistema, untFuncoesConsulta,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxCheckBox, ComboBoxFocus, untLogCtr;

type
  TfrmGeraDuplicataReceber = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    Label3: TLabel;
    pnlBotoesBaixa: TPanel;
    edtNomCli: TEditFocus;
    pgbProgresso: TcxProgressBar;
    btnConfirma: TBitBtnLocked;
    Label4: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    btnSairAgrup: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    rdbDtaCad: TRadioButton;
    rdbDtaVen: TRadioButton;
    lblPeriodo: TLabel;
    edtNomPorAgr: TEditFocus;
    edtPorAgr: TEditFocus;
    Label2: TLabel;
    btnRegraAgrup: TBitBtnLocked;
    lblCndPag: TLabel;
    edtCodCnd: TEditFocus;
    edtDesCnd: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    chkAgrupaCred: TcxCheckBox;
    cbxImpAG: TComboBoxFocus;
    Label5: TLabel;
    rdgOpcoes: TRadioGroup;
    GbpEmpresa: TGroupBox;
    rdbOrigem: TRadioButton;
    rdbFatu: TRadioButton;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairAgrupClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorAgrKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure btnRegraAgrupClick(Sender: TObject);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    arrDupAgr: Array Of TDuplicatasAgrupadas;
    arrCndPag  : TConsultasArray;

    qryGenRec: TUniQuery;
    qryConEmp: TUniQuery;
    qryConCli: TUniQuery;
    qryConPor: TUniQuery;
    cdsCtaRec: TUniClientDataSet;
    stlCliVenc: TStringList;
    dtaDtaCad: TDateTime;

    arrEmp     : TConsultasArray;
    strEmpresa : String;
    arrPortador: TConsultasArray;
    strPortador: String;

    strNumAgr: String;

    blnFecharTela: Boolean;

    objSMSMod1 : TSMSModelo1;
    FAgrVen    : String;

    strCodCliGravado: String;
    dtaDtaVencimento: TDateTime;
    blnPorFaixa: Boolean;
    strEmpDuplic: String;
    blnConfirma: Boolean;

    arrDuplicata: TarrDuplicata;

    FDuplicatasBloqueadas : TStringList;
    FDuplicatasJaAgrupadas : TStringList;

    procedure LiberaDupsMarcadas;
    procedure pLimpaDados;
    procedure pSelecionaDuplicata;
    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pMarcaTodasDuplicatas;

    procedure pAgruparDuplicatas;
    procedure GravaLogDuplicatasNaoAgrupadas;

    function fDeletaDuplicatas(arrDupSel: Array Of TDuplicataCtr): Boolean;
    function fGravaAgrupamentos(strCodCli, strDtaVen: String; dtaDtaAgr: TDateTime; strConPag: String; fltTotCli: Double): Boolean;

    procedure pCarregaCliente;
    procedure pCarregaEmpresa;
    procedure pCarregaPortador(strCodPor: String; edtDescri: TEditFocus);
    function fVerificaExiste: Boolean;
    function fExisteDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String; intSeqBai: Integer): Boolean;
    procedure pRetornaTotal(strCodCli, strDtaVen: String; Var fltTotCli: Double);
    function fCriaClientCtaRec(strFiltro: String = ''): TUniClientDataSet;
    function fCriaListaClientesVencimentos: TStringList;
    function fVerificaDuplicatasClientes: Boolean;
    procedure pExportaSMS;
    procedure pConcluirAgrupamento;
    function fGetDataDeCadastro(FDefault : TDateTime; FOlhaCfg : Boolean): TDateTime;
  protected
    function fCriaTemporaria: Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public

  published
    property strAgrVen: String read FAgrVen write FAgrVen;

  end;


implementation

uses  untPesqAux, untCtrAgrupDupRecibo, untPai,
      untCadConfRelatorios, untCadRec, untRTTIEngineProgress,
      untDuplicatas, untImpBoletoIndiv, untBoleto, untAtualizaOcorrenciasCRM, untTypesCRM, untSQLBind,
      untSQLBind_Query, untGravando, untTEnvioEmail;

{$R *.dfm}

{ TfrmGeraDuplicataReceber }

function TfrmGeraDuplicataReceber.fCriaClientCtaRec(strFiltro: String = ''): TUniClientDataSet;
var
  fld1: TAggregateField;
Begin
  Result := TUniClientDataSet.Create(Self);
  {***************************************}
  {* CARREGANDO A MENOR DATA DE CADASTRO *}
  {************************************AN*}
  fld1 := fCriaAggregateField(Result, 'FLD1', 'MIN(CTR_DTACAD)');
  With Result Do
  Begin
    Data := cdsCtaRec.Data;
    If Not fEmptyStr(strFiltro) Then
    Begin
      Filtered := False;
      Filter := strFiltro;
      Filtered := True;
      AggregatesActive := True;
      if fld1.Value <> Null then
         dtaDtaCad  := fld1.Value;
    End;
  End;
End;

function TfrmGeraDuplicataReceber.fCriaListaClientesVencimentos: TStringList;
var
  cdsGen: TUniClientDataSet;
  strCliVen: String;
  FImpNumAG : Boolean;
  strCliVenAnt : String;
Begin
  cdsGen := fCriaClientCtaRec('CTR_MARDES = ' + QuotedStr('M'));
  strCliVenAnt := '';
  With cdsGen Do
  Begin
    FImpNumAG := cbxImpAG.ItemIndex = 0;  // impresão ordenada pelo número do AG

    IndexFieldNames := IIF(FImpNumAG,'CTR_CODCLI;CTR_DTAVEN','CLI_NOMCLI;CTR_CODCLI;CTR_DTAVEN');

    Result := TStringList.Create;
    Result.Sorted := IIF(FImpNumAG, True, False);
    Result.Duplicates := dupIgnore; // só funciona se utiliza sorted = true

    Result.Clear;

    strCliVen := '';
    First;

    While Not Eof Do
    Begin
      strCliVen := FieldByName('CTR_CODCLI').AsString +
                   FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAVEN').AsDateTime);

      If Result.Sorted Or Not strCliVenAnt.Equals(strCliVen) Then
        Result.Add(strCliVen);

      strCliVenAnt := strCliVen;
      Next;
    End;
  End;
  FreeAndNil(cdsGen);
End;

{*************************************************}
{* VERIFICA O VALOR DAS DUPLICATAS SELECIONADAS. *}
{* PELO MENOS UM CLIENTE DEVE TER DUPLICATAS COM *}
{* VALOR DIFERENTE DE ZERO PARA CONTIN A AGRUPAR *}
{**********************************************AN*}
function TfrmGeraDuplicataReceber.fVerificaDuplicatasClientes: Boolean;
  Var
    cdsGen: TUniClientDataSet;
    fldVal: TAggregateField;
    strFiltro: String;
    intCont: Integer;
    stlCliVenc: TStringList;
begin
  Result := False;
  Try
    stlCliVenc := fCriaListaClientesVencimentos;
    cdsGen := TUniClientDataSet.Create(Self);
    fldVal := fCriaAggregateField(cdsGen, 'FLDVAL', 'SUM(CTR_VALCOR)', '#,##0.00');

    With cdsGen Do
    Begin
      Data := cdsCtaRec.Data;

      For intCont := 0 To stlCliVenc.Count-1 Do
      Begin
        AggregatesActive := False;

        strFiltro := 'CTR_MARDES = ' + QuotedStr('M') + ' AND ' +
                     'CTR_CODCLI = ' + QuotedStr(Copy(stlCliVenc[intCont], 1, 08)) + ' AND ' +
                     'CTR_DTAVEN = ' + QuotedStr(Copy(stlCliVenc[intCont], 9, 10));

        Filtered := False;
        Filter   := strFiltro;
        Filtered := True;

        AggregatesActive := True;
        If (fldVal.Value <> Null) And (fldVal.Value <> 0) Then
        Begin
          Result := True;
          Break;
        End;
      End;
      Application.ProcessMessages;
    End;

    If Not Result Then
      fMensagem('', 'Nenhuma Duplicata foi selecionada ou Total dos Agrupamentos é igual a zero!', ['&OK']);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmGeraDuplicataReceber.fVerificaDuplicatasClientes]');
  End;

  FreeAndNil(stlCliVenc);
  FreeAndNil(cdsGen);
end;

function TfrmGeraDuplicataReceber.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin

      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaEmpresa;
        If (qryConEmp.FieldByName('EMP_CODEMP').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;

    End


    Else If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        If qryConCli.FieldByName('CLI_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente está inativo!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomCli.Text := 'TODOS';
        Result := True;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA INICIAL                 *}
    {**************************************MV*}
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Enabled := False;
      End
      Else
      Begin
        If StrToDateDef(mskDtaIni.Text, 0) <= 0 Then
        Begin
          fMensagem('', 'Data inicial informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End
        Else
          mskDtaFin.Enabled := True;
      End

    End

    {*****************************************}
    {* VALIDA A DATA FINAL                   *}
    {**************************************MV*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser digitada!', ['&Ok']);
        blnMudarFoco := False;
        pSetFocus(mskDtaIni);
      End
      Else
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          If StrToDateDef(mskDtaFin.Text, 0) <= 0 Then
          Begin
            fMensagem('', 'Data final informada é inválida! Necessário correção.', ['&O k']);
            Result := False;
          End
          Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = edtCodPor) Then
    Begin
      If (fCfgSis('OBRPOR', varBoolean)) Then
      Begin

        If fEmptyStr(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Portador, deve ser preenchido!', ['&O k']);
          Result := False;
        End;

      End
      Else
      Begin
        If fEmptyStr(edtCodPor.Text) Then
        Begin
          edtNomPor.Text := 'TODOS';
        End;

      End;

      If (Result) And (edtNomPor.Text <> 'TODOS') Then
      Begin
        If Not SameText(edtCodPor.Text, '00000') Then
        Begin
          pCarregaPortador(edtCodPor.Text, edtNomPor);
          SetLength(arrPortador, 0);
          If fEmptyStr(edtNomPor.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Este portador não está cadastrado!', ['&Ok']);
            Result := False;
          End
          Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          If High(arrPortador) > 0 Then
            edtNomPor.Text := '+1'
          Else
          Begin
            fMensagem('ATENÇÃO!', 'Este portador não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtPorAgr) Then
    Begin

      If fEmptyStr(edtPorAgr.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Portador do agrupamento, deve ser preenchido!', ['&O k']);
        Result := False;
      End;

      If (Result) And (Not fEmptyStr(edtPorAgr.Text)) Then
      Begin
        pCarregaPortador(edtPorAgr.Text, edtNomPorAgr);
        If fEmptyStr(edtNomPorAgr.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmptyStr(edtCodEmp.Text) And Not fEmpresaTemAcessoPortador(edtPorAgr.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmGeraDuplicataReceber.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmGeraDuplicataReceber.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodEmp);
end;

procedure TfrmGeraDuplicataReceber.FormCreate(Sender: TObject);
begin
  inherited;
  pZeraDigDuplic(arrDuplicata);

  objSMSMod1 := TSMSModelo1.Create;
  SetLength(arrDupAgr, 0);

  qryGenRec := fCriaQuery(Self);

  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConPor := fCriaQuery(Self);

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;

  blnFecharTela := False;

  edtCodPor.Text := fCfgSis('PCTRDR');
  edtNomPor.Text := fRetNomPortador(edtCodPor.Text);

  If fEmptyStr(edtNomPor.Text) Then
  Begin
    fMensagem('','O portador para geração de Duplicatas à Receber (Filtro) deve ser ' +
                 'informado corretamente nas configurações de sistema, verificar!',['&OK']);
    blnFecharTela := True;
  End;

  edtPorAgr.Text := fCfgSis('PCTRDG');
  edtNomPorAgr.Text := fRetNomPortador(edtPorAgr.Text);
  FDuplicatasBloqueadas := TStringList.Create;
  FDuplicatasJaAgrupadas := TStringList.Create;

end;

function TfrmGeraDuplicataReceber.fCriaTemporaria: Boolean;
  Var
    strSQL, strSQLCredito: String;
    strCndPag: String;
    qryCtaRec: TUniQuery;
    strCodigosClientes: String;

  function fRetornaCodCli(strSqlOri: String): String;
  var
    qryAux : TUniQuery;
    strCodigos: String;
  begin
    qryAux := fCriaQuery;

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSqlOri);

      pSetaParam(edtCodEmp.Text, arrEmp, strEmpresa, 'CODEMP', qryAux);

      If Not (fCfgSis('DACPOR', varBoolean)) Or
        (fCfgSis('DACPOR', varBoolean)      And
         Not (fEmptyStr(edtCodPor.Text)))   Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryAux);

      If Not fEmptyStr(edtCodCli.Text) Then
        ParamByName('CODCLI').AsString := edtCodCli.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If rdbDtaCad.Checked Then
          ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text)
        Else
          ParamByName('DTAINI').AsDateTime := VS_Date;

        ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
      End;

      Open;

      strCodigos := '';
      If Not IsEmpty Then
      Begin
        First;

        while not Eof do
        Begin
          if Pos(FieldByName('CTR_CODCLI').AsString, strCodigos) <= 0 then
          begin
            if not fEmptyStr(strCodigos) then
              strCodigos := strCodigos + ',';

            strCodigos := strCodigos  + '"' + FieldByName('CTR_CODCLI').AsString + '"';
          end;

          Next;
        End;
      End;

      Result := strCodigos;

      Close;
    End;

    FreeAndNil(qryAux);
  end;

begin
  Result := False;

  Try
    if Assigned(cdsCtaRec) then
      FreeandNil(cdsCtaRec);

    qryCtaRec := fCriaQuery(Self);

    strSQL := '';
    strSQLCredito := '';

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_NUMDUP AS NRODUP, ';
    strSQL := strSQL + '  CTR_PARCEL AS PARDUP, ';
    strSQL := strSQL + '  CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS CTR_NUMDUP, ';
    strSQL := strSQL + '  R.CTR_ESPDOC AS CTR_ESPDOC, ';
    strSQL := strSQL + '  R.CTR_SEQBAI AS CTR_SEQBAI, ';
    strSQL := strSQL + '  R.CTR_DTAVEN AS CTR_DTAVEN, ';
    strSQL := strSQL + '  R.CTR_DTACAD AS CTR_DTACAD, ';
    strSQL := strSQL + '  R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IFNULL(R.CTR_DESSUJ, 0) AS CTR_VALDUP, ';
    strSQL := strSQL + '  0.00 AS CTR_JURATR,  '; //VALOR DE JUROS ATRASO
    strSQL := strSQL + '  R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0)  - IFNULL(R.CTR_DESSUJ, 0) AS CTR_VALCOR, ';
    strSQL := strSQL + '  R.CTR_CODCLI AS CTR_CODCLI, ';
    strSQL := strSQL + '  C.CLI_NOMCLI AS CLI_NOMCLI, ';
    strSQL := strSQL + '  LEFT(CONCAT(R.CTR_CODCLI, "-", C.CLI_NOMCLI), 28) AS CTR_NOMCLI, ';
    strSQL := strSQL + '  R.CTR_CODEMP AS CTR_CODEMP, ';
    strSQL := strSQL + '  C.CLI_CODREP AS CTR_CODREP, ';
    strSQL := strSQL + '  R.CTR_CODVEN AS CTR_CODVEN, ';
    strSQL := strSQL + '  R.CTR_CODDIG AS CTR_CODDIG, ';
    strSQL := strSQL + '  R.CTR_CODPOR AS CTR_CODPOR, ';
    strSQL := strSQL + '  P.POR_NOMPOR AS POR_NOMPOR, ';
    strSQL := strSQL + '  LEFT(CONCAT(R.CTR_CODPOR, "-", P.POR_NOMPOR), 25) AS CTR_NOMPOR, ';
    strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
    strSQL := strSQL + '  R.CTR_DESCON AS CTR_DESCON, ';
    strSQL := strSQL + '  R.CTR_NOSNUM AS CTR_NOSNUM, ';
    strSQL := strSQL + '  R.CTR_ADTCLI AS CTR_ADTCLI, ';
    strSQL := strSQL + '  R.CTR_CODEVE AS CTR_CODEVE, ';
    strSQL := strSQL + '  R.CTR_CODVEL AS CTR_CODVEL, ';
    strSQL := strSQL + '  R.CTR_HIST01 AS CTR_HIST01, ';
    strSQL := strSQL + '  R.CTR_HIST02 AS CTR_HIST02, ';
    strSQL := strSQL + '  R.CTR_CODCND AS CTR_CODCND, ';
    strSQL := strSQL + '  IF(R.CTR_TIPFOR IS NULL OR CTR_TIPFOR="", "NENHUM", R.CTR_TIPFOR) AS CTR_TIPFOR, ';
    strSQL := strSQL + '  R.CTR_CODCTA AS CTR_CODCTA, ';
    strSQL := strSQL + '  R.CTR_CTASER AS CTR_CTASER, ';
    strSQL := strSQL + '  R.CTR_SERVAL AS CTR_SERVAL, ';
    strSQL := strSQL + '  CTR_CONAPR, ';
    strSQL := strSQL + '  CTR_VALCOM, ';
    strSQL := strSQL + '  CTR_FATCOM, ';
    strSQL := strSQL + '  CTR_COMREP, ';
    strSQL := strSQL + '  CTR_FATREP, ';
    strSQL := strSQL + '  CTR_EMP_PD, ';
    strSQL := strSQL + '  CTR_VALIPI, ';
    strSQL := strSQL + '  CTR_VALRET, ';
    strSQL := strSQL + '  CTR_VALCBS, ';
    strSQL := strSQL + '  CTR_VALIBS, ';
    strSQL := strSQL + '  CTR_VAL_IS, ';
    strSQL := strSQL + '  CTR_VALACE, ';
    strSQL := strSQL + '  CTR_VALFRE, ';
    strSQL := strSQL + '  CTR_SEQCON, ';
    strSQL := strSQL + '  CTR_DIFORI, ';
    strSQL := strSQL + '  CTR_VALANT, ';
    strSQL := strSQL + '  CTR_GRVORI, ';
    strSQL := strSQL + '  R.CTR_DESSUJ, ';
    strSQL := strSQL + '  R.CTR_JURSUJ, ';
    strSQL := strSQL + '  R.CTR_DESCOB, ';
    strSQL := strSQL + '  R.CTR_BARCON, ';    
    strSQL := strSQL + '  " " AS CTR_MARDES,  ';
    strSQL := strSQL + '  0.00 AS CTR_VALDES, ';
    strSQL := strSQL + '  0.00 AS CTR_JURREP, ';//VALOR DE JUROS DO REPARCELAMENTO
    strSQL := strSQL + '  CTR_DOCDIV,  ';
    strSQL := strSQL + '  CTR_ESPDIV,  ';
    strSQL := strSQL + '  CTR_EMPDIV,  ';
    strSQL := strSQL + '  CTR_CLIDIV,  ';
    strSQL := strSQL + '  CTR_COMDIV,  ';
    strSQL := strSQL + '  CTR_FATDIV,  ';
    strSQL := strSQL + '  CTR_CODDIV,  ';
    strSQL := strSQL + '  CTR_INCDOC,  ';
    strSQL := strSQL + '  CTR_SEQMPX,  ';
    strSQL := strSQL + '  R.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI C ';
    strSQL := strSQL + '  JOIN CADREC R ON R.CTR_CODCLI = C.CLI_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADPOR             P ON R.CTR_CODPOR = P.POR_CODPOR ';
    strSQL := strSQL + '  LEFT JOIN FATGOR ON FATGOR.FGO_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '                  AND FATGOR.FGO_NUMDOC = CTR_NUMDUP ';
    strSQL := strSQL + '                  AND FATGOR.FGO_ESPDOC = CTR_ESPDOC ';
    strSQL := strSQL + '                  AND FATGOR.FGO_CODEMP = CTR_CODEMP ';
    strSQL := strSQL + '  LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + ' (IFNULL(FGO_BOLADT, 0.00) = 0.00) AND ';

    If Not fEmptyStr(fCfgSis('POOCRE')) Then
      strSQL := strSQL + 'IF((R.CTR_VALDUP < 0),IFNULL(R.CTR_CODPOR,"") <> ' + String(fCfgSis('POOCRE')).QuotedString + ',TRUE) AND ';

    strSQL := strSQL + '  (R.CTR_DTAENV IS NULL OR R.CTR_DTAENV = 0) AND ';
    strSQL := strSQL + '  IF(CTR_BCOBOL = "778", TRUE, (R.CTR_NOSNUM IS NULL OR R.CTR_NOSNUM = "")) AND ';
    strSQL := strSQL + '  R.CTR_DTAREC IS NULL AND ';
    strSQL := strSQL + '  R.CTR_ESPDOC IN ("NF", "EL", "NS", "IV", "IF", "NV") AND ';//SOMENTE NOTAS
    strSQL := strSQL + '  R.CTR_SEQBAI = 0 '; //AND
    //strSQL := strSQL + '  R.CTR_DTAVEN >= :DTAVEN '; {Verificar}

    {***************************************************}
    {* QUANDO OPCAO "ORIGEM (PEDIDO)", REALIZAR FILTRO *}
    {* DA EMPRESA DO PEDIDO (CTR_EMP_PD) ***************}
    {* RQ 207816 ************************************MR*}
    If rdbOrigem.Checked Then
      strSQL := strSQL + fStrLocate(edtCodEmp, arrEmp, 'R.CTR_EMP_PD', 'CODEMP')
    Else
      strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp, 'R.CTR_CODEMP', 'CODEMP');

    strSQL := strSQL + fStrLocate(edtCodCnd,arrCndPag,'CTR_CODCND'  , 'CODCND');

    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + '  AND R.CTR_CODCLI = :CODCLI ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      If rdbDtaCad.Checked Then
        strSQL := strSQL + '  AND R.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN '
      Else
        strSQL := strSQL + '  AND R.CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
    End;

    strSQL := strSQL + '  AND R.CTR_TX_PIX IS NULL ';

    // strSQL := strSQL + ' ORDER BY CTR_DTAVEN ';

    {*****************************************************}
    {* VERIFICA PERMISSÃO DE AGRUPAMENTO DE CRÉDITO "CC" *}
    {* RQ 28259 ***************************************BB*}
//    If Not fCfgSis('AGP_CC', varBoolean) Then
//      strSQL := strSQL + ' AND R.CTR_VALDUP > 0.00 ';

    {*****************************************************}
    {* VERIFICA PERMISSÃO DE AGRUPAMENTO DE CRÉDITO "CC" *}
    {* RQ 28259 ***************************************BB*}
    If fCfgSis('AGP_CC', varBoolean) Then
    begin
      strSQLCredito := strSQL;

      strSQLCredito := strSQLCredito + ' AND R.CTR_VALDUP < 0.00 ';
      strSQLCredito := StringReplace(strSQLCredito, 'R.CTR_ESPDOC IN ("NF", "EL", "NS", "IV", "IF", "NV") AND', '', [rfReplaceAll]);

      if not chkAgrupaCred.Checked then
      begin
        If Not fEmptyStr(edtCodPor.Text) Then
          strSQLCredito := strSQLCredito + fStrLocate(edtCodPor, arrPortador, 'R.CTR_CODPOR', 'CODPOR')
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          strSQLCredito := strSQLCredito + '  AND (IFNULL(R.CTR_CODPOR, "") = "" ';
          strSQLCredito := strSQLCredito + '  OR LOCATE(R.CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        End;
      end;
    end;

    strSQL := strSQL + ' AND R.CTR_VALDUP > 0.00 AND R.CTR_DTAVEN >= CURRENT_DATE';

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'R.CTR_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND (IFNULL(R.CTR_CODPOR, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(R.CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    If not fEmptyStr(strSQLCredito) then
    begin

       strCodigosClientes :=  fRetornaCodCli(strSQL);

       if not fEmptyStr(strCodigosClientes) then
          strSQLCredito := strSQLCredito + ' AND R.CTR_CODCLI IN (' + strCodigosClientes + ') ';

       strSQL := '(' +  strSQL  +  ') UNION ALL ('  + strSQLCredito + ')';

    end;

    With qryCtaRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      //ParamByName('DTAVEN').AsDateTime := VS_Date;
      pSetaParam(edtCodCnd.Text,arrCndPag,strCndPag,'CODCND',qryCtaRec);

      If (Not fEmptyStr(edtCodPor.Text)) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryCtaRec);

      If (Not fEmptyStr(edtCodEmp.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmp.Text;

      If Not fEmptyStr(edtCodCli.Text) Then
        ParamByName('CODCLI').AsString := edtCodCli.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))Then
          ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
      End;

      Open;
      cdsCtaRec := fCriaClientDatset(qryCtaRec);

      If Not IsEmpty Then
      Begin
        With cdsCtaRec Do
        Begin
          Open;
          TFloatField(FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
          TFloatField(FieldByName('CTR_JURATR')).DisplayFormat := '#,##0.00';
          TFloatField(FieldByName('CTR_JURREP')).DisplayFormat := '#,##0.00';
          TFloatField(FieldByName('CTR_VALCOR')).DisplayFormat := '#,##0.00';
          IndexFieldNames := 'CLI_NOMCLI;CTR_DTAVEN;CTR_NUMDUP';
          First;
        End;
        Result := True;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Não há duplicatas para serem agrupadas!', ['&O k']);
        pSetFocus(edtCodEmp);
        blnMudarFoco := False;
      End;

      Close;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmGeraDuplicataReceber.fCriaTemporaria]');
  End;

  cdsCtaRec.SetProvider(nil);
  FreeAndNil(qryCtaRec);
end;

procedure TfrmGeraDuplicataReceber.LiberaDupsMarcadas;
begin
  cdsCtaRec.Filtered := False;
  cdsCtaRec.Filter := 'CTR_MARDES = ''M''';
  cdsCtaRec.Filtered := True;

  If Not cdsCtaRec.IsEmpty Then
  Begin
    cdsCtaRec.First;

    While Not cdsCtaRec.Eof Do
    Begin
      fLock_Unlock('CADREC' +
                   cdsCtaRec.FieldByName('NRODUP').AsString +
                   cdsCtaRec.FieldByName('CTR_ESPDOC').AsString +
                   cdsCtaRec.FieldByName('CTR_CODEMP').AsString +
                   cdsCtaRec.FieldByName('CTR_CODCLI').AsString +
                   cdsCtaRec.FieldByName('PARDUP').AsString, False);
      cdsCtaRec.Next;
    End;
  End;
end;

procedure TfrmGeraDuplicataReceber.pLimpaDados;
begin
//  mskDtaIni.Text := DateToStr(VS_Date);
//  mskDtaFin.Text := DateToStr(VS_Date);
  edtCodCli.Clear;
  edtNomCli.Clear;

  cdsCtaRec.Close;
end;

procedure TfrmGeraDuplicataReceber.pSelecionaDuplicata;
  Var
    LChaveLCK: String;
begin
  If cdsCtaRec.IsEmpty Then
    Exit;

  If Not fExisteDuplicata(cdsCtaRec.FieldByName('NRODUP').AsString,
                          cdsCtaRec.FieldByName('PARDUP').AsString,
                          cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
                          cdsCtaRec.FieldByName('CTR_CODEMP').AsString,
                          cdsCtaRec.FieldByName('CTR_CODCLI').AsString,
                          cdsCtaRec.FieldByName('CTR_SEQBAI').AsInteger) Then
  Begin
    FDuplicatasJaAgrupadas.Add(cdsCtaRec.FieldByName('AUTOINCREM').AsString);
    fMensagem('','Essa duplicata já foi agrupada!',['&OK']);
    pMarcaDuplicata(False);
  End

  Else
  If cdsCtaRec.FieldByName('CTR_MARDES').AsString <> 'M' Then
  begin
    LChaveLCK := 'CADREC' +
                 cdsCtaRec.FieldByName('NRODUP').AsString +
                 cdsCtaRec.FieldByName('CTR_ESPDOC').AsString +
                 cdsCtaRec.FieldByName('CTR_CODEMP').AsString +
                 cdsCtaRec.FieldByName('CTR_CODCLI').AsString;

    If Not fGetHostLock(LChaveLCK).IsEmpty Then
    Begin
      FDuplicatasBloqueadas.Add(cdsCtaRec.FieldByName('AUTOINCREM').AsString);
      fMensagem('ATENÇÃO!', 'A duplicata ' + cdsCtaRec.FieldByName('NRODUP').AsString + '-' +
                                             cdsCtaRec.FieldByName('CTR_ESPDOC').AsString + '-' +
                                             cdsCtaRec.FieldByName('CTR_CODEMP').AsString + ' está sendo utilizada por outra estação: ' + fGetHostLock(LChaveLCK), ['&Ok']);
      Exit;
    End
    Else If Not fLock_Unlock(LChaveLCK + cdsCtaRec.FieldByName('PARDUP').AsString,
                             True,
                             False) Then
    Begin
      FDuplicatasBloqueadas.Add(cdsCtaRec.FieldByName('AUTOINCREM').AsString);
      fMensagem('ATENÇÃO!', 'A duplicata ' + cdsCtaRec.FieldByName('NRODUP').AsString + cdsCtaRec.FieldByName('PARDUP').AsString + '-' +
                                             cdsCtaRec.FieldByName('CTR_ESPDOC').AsString + '-' +
                                             cdsCtaRec.FieldByName('CTR_CODEMP').AsString + ' está sendo utilizada por outra estação: ' + fGetHostLock(LChaveLCK + cdsCtaRec.FieldByName('PARDUP').AsString), ['&Ok']);
      Exit;
    End
    Else
      pMarcaDuplicata(True);
  end;
end;

procedure TfrmGeraDuplicataReceber.pMarcaDuplicata(blnMarcar: Boolean);
begin

  With cdsCtaRec Do
  Begin
    Edit;
    FieldByName('CTR_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
    Post;
  End;
end;

procedure TfrmGeraDuplicataReceber.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraDuplicataReceber.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd,edtDesCnd,arrCndPag,fRetDesConPag,Nil,'da Condição de Pagamento');
end;

procedure TfrmGeraDuplicataReceber.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Not fCfgSisL('USACND', varBoolean) Then
    Exit;

  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, Nil, Key, arrCndPag, False) Then
  Begin
    If fValidaCampos(edtCodCnd, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraDuplicataReceber.pExportaSMS;
var
  sltNumAgr: TStringList;
  intCont  : Integer;
Begin
  sltNumAgr := TStringList.Create;
  For intCont := 0 To Length(arrDupAgr) - 1 Do
    sltNumAgr.Add(arrDupAgr[intCont].strNumAgr);

  objSMSMod1.pSetDocumentos(sltNumAgr);
  TfrmRTTIEngineProgress.pStart(objSMSMod1);
End;

procedure TfrmGeraDuplicataReceber.pAgruparDuplicatas;
  Var
    strCndPag : String;
    fltTotCli : Double;
    intCont   : Integer;
    strCodCli : String;
    strDtaVen : String;
    stlMsgErro: TStringList;
    strNomCli : String;
    cdsCtrBkp : TUniClientDataSet;
    blnSabDomFeriadosComoDiaUtil: Boolean;
    AMenorData: TDateTime;
    qryConsultaVendedor: TUniQuery;
    AEmpresa : String;
    strMsg   : String;
    strCodCid: String;

  {****************************************************}
  {* FAZ UMA COPIA DO CLIENTDATASET COM AS DUPLICATAS *}
  {* MARCADAS NO CASO DE UM CANCELAMENTO POR CONTA DO *}
  {* USUARIO. SE CANCELADO É RESTAURADO O CLIENTDTSET *}
  {* COM OS DADOS DO INICIO DO AGRUPAMENTO            *}
  {*************************************************AN*}
  procedure pBackupCtaRec;
  Begin
    If Not Assigned(cdsCtrBkp) Then
    Begin
      cdsCtrBkp := TUniClientDataSet.Create(Self);
      cdsCtrBkp.Data := cdsCtaRec.Data;
      cdsCtrBkp.IndexFieldNames := cdsCtaRec.IndexFieldNames;
      cdsCtrBkp.RecNo := cdsCtaRec.RecNo;
    End Else
    Begin
      cdsCtaRec.Data := cdsCtrBkp.Data;
      cdsCtaRec.IndexFieldNames := cdsCtrBkp.IndexFieldNames;
      cdsCtaRec.RecNo := cdsCtrBkp.RecNo;

      TFloatField(cdsCtaRec.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
      TFloatField(cdsCtaRec.FieldByName('CTR_JURREP')).DisplayFormat := '#,##0.00';
      TFloatField(cdsCtaRec.FieldByName('CTR_JURATR')).DisplayFormat := '#,##0.00';
      TFloatField(cdsCtaRec.FieldByName('CTR_VALCOR')).DisplayFormat := '#,##0.00';

      FreeAndNil(cdsCtrBkp);
    End;
  End;

  {*************************************************}
  {* QUANDO TEMOS MAIS DE UM CLIENTE SELECIONADO É *}
  {* NECESSÁRIO DELETAR DO CLIENTDATASET "BACKUP"  *}
  {* AS DUPLICATAS QUE JA FORAM AGRUPADAS, POIS O  *}
  {* USUARIO AINDA PODE CANCELAR O AGRUPAMENTO DAS *}
  {* DUPLICATAS DE UM SEGUNDO CLIENTE              *}
  {**********************************************AN*}
  procedure pDeletaDuplicatasBackup;
  var
    intRecNo: Integer;
  Begin
    With cdsCtrBkp Do
    Begin
      intRecNo := RecNo;

      First;
      While cdsCtrBkp.Locate('CTR_CODCLI;CTR_MARDES;CTR_DTAVEN;', VarArrayOf([strCodCli,'M', StrToDate(strDtaVen)]), []) Do
      Begin
        cdsCtrBkp.Delete;
      End;

      RecNo := IIF(intRecNo > RecordCount, 1, intRecNo);
    End;
  End;

  procedure pCancelaAgrupamento;
  begin
    pBackupCtaRec;
    FreeAndNil(stlCliVenc);

    {****************************************************************}
    {*  SE ANTES DE SER CANCELADO JA TINHA REALIZADO UM AGRUPAMENTO *}
    {* SERA CHAMADA A ROTINA DE CONCLUSAO DO AGRUPAMENTO            *}
    {*************************************************************AN*}
    If (Length(arrDupAgr) > 0) Then
      pConcluirAgrupamento;
  end;

  function fTemEmpresaDiferente: Boolean;
  var
    cdsGen: TUniClientDataSet;
    strFiltro: String;
  Begin
    strFiltro := 'CTR_MARDES = ''M'' AND ' +
                 'CTR_CODCLI = ' + QuotedStr(strCodCli);

    cdsGen := fCriaClientCtaRec(strFiltro);

    With cdsGen Do
    Begin
      AEmpresa := FieldByName('CTR_CODEMP').AsString;
      strFiltro := strFiltro + ' AND CTR_CODEMP <> ' + QuotedStr(AEmpresa);
      Filtered := False;
      Filter := strFiltro;
      Filtered := True;

      Result := Not IsEmpty;
    End;
    FreeAndNil(cdsGen);
  End;

  procedure PegaMenorDataCadastro;
  var
    cdsGen: TUniClientDataSet;
    fld1: TAggregateField;

  Begin
    cdsGen := TUniClientDataSet.Create(Self);

    {***************************************}
    {* CARREGANDO A MENOR DATA DE CADASTRO *}
    {***************************************}
    fld1 := fCriaAggregateField(cdsGen, 'FLD1', 'MIN(CTR_DTACAD)');

    With cdsGen Do
    Begin
      Data := cdsCtaRec.Data;
      Filtered := False;
      Filter := 'CTR_MARDES = ''M''' ;
      Filtered := True;
      AggregatesActive := True;
      AMenorData  := fld1.Value;
    End;

    FreeAndNil(cdsGen);
  End;

begin
  blnConfirma := false;
  blnPorFaixa := False;
  blnSabDomFeriadosComoDiaUtil := fCfgSis('FSDUDP', varBoolean);
  SetLength(arrDupAgr, 0);

  stlCliVenc := fCriaListaClientesVencimentos;

  If stlCliVenc.Count = 0 Then
  Begin
    fMensagem('Aviso', 'Nenhuma Duplicata foi selecionada!', ['&Ok']);
    FreeAndNil(stlCliVenc);
    Exit;
  End;

  stlMsgErro := TStringList.Create;

  {*******************************************************************}
  {* SALVA UMA COPIA TEMPORARIA DO CLIENTDATASET DE CONTAS A RECEBER *}
  {****************************************************************AN*}
  pBackupCtaRec;

  pgbProgresso.Properties.Max := stlCliVenc.Count;

  {**********************************************************************************}
  {* VERIFICA SE ALGUMA DUPLICATA DA LISTA TEM CONDIÇÃO DE PAGTO POR FAIXA DE VALOR *}
  {*******************************************************************************MO*}
  For intCont := 0 To stlCliVenc.Count-1 Do
  Begin
    if not blnPorFaixa then
    begin
      strCodCli := Copy(stlCliVenc[intCont], 1, 08);
      strDtaVen := Copy(stlCliVenc[intCont], 9, 10);
      pRetornaTotal(strCodCli, strDtaVen, fltTotCli);
      strCndPag := '01000';

      If fltTotCli > 0 then
        strCndPag := fRetCondicaoPagtoFaixaValor(fltTotCli);

      If Copy(strCndPag, 1, 05) <> '01000' then
        blnPorFaixa := True;
    end;
  End;

  {*************************************************}
  {* LOOP PARA PROCESSAR AS DUPLICATAS POR CLIENTE *}
  {**********************************************AN*}
  For intCont := 0 To stlCliVenc.Count-1 Do
  Begin
    strCodCli := Copy(stlCliVenc[intCont], 1, 08);
    strDtaVen := Copy(stlCliVenc[intCont], 9, 10);
    strNomCli := fRetNomCliente(strCodCli);

    pnlInfo.Caption := 'Aguarde, processando o cliente: ' + strNomCli + ' vencto: ' + strDtaVen;
    Application.ProcessMessages;

    {*******************************************}
    {* SOMA DOS DOCUMENTOS MARCADOS            *}
    {****************************************AC*}
    pRetornaTotal(strCodCli, strDtaVen, fltTotCli);

    {************************************************}
    {* CARREGANDO A EMPRESA REFERENTE AS DUPLICATAS *}
    {*********************************************FA*}
    If fCfgSis('AGRTPR', varInteger) = 1 Then
       strEmpDuplic := VS_strCodEmp
    Else
    If fCfgSis('AGRTPR', varInteger) = 4 Then
    begin
      qryConsultaVendedor := fCriaQuery(nil);

      with qryConsultaVendedor do
      begin
        SQL.Text := 'SELECT CLI_CODVEN FROM CADCLI WHERE CLI_CODCLI = ' + QuotedStr(strCodCli);
        Open;

        Close;
        SQL.Text := 'SELECT OPE_CODEMP FROM CADOPE WHERE OPE_CODOPE = ' + QuotedStr(FieldByName('CLI_CODVEN').AsString);
        Open;
        strEmpDuplic := FieldByName('OPE_CODEMP').AsString;
      end;
      FreeAndNil(qryConsultaVendedor);
    end
    else
    Begin
      If fTemEmpresaDiferente Then
        strEmpDuplic := VS_strCodEmp
      Else
        strEmpDuplic := AEmpresa;
    End;

    PegaMenorDataCadastro;

    If fltTotCli <= 0 Then
    Begin
      stlMsgErro.Add('Total de Duplicatas do Cliente : ' + strCodCli + ' - ' + strNomCli +
                     ' na data de vencimento ' + strDtaVen + ' = ' +
                     FormatFloat('#,##0.00', fltTotCli) + '. Duplicatas não agrupadas.');
    End Else
    Begin
      strNumAgr := '';

      strCndPag := fRetCondicaoPagtoFaixaValor(fltTotCli);

      blnConfirma := Not fEmptyStr(strCndPag);

      {*****************************************}
      {* PEDE VALORES DAS PARCELAS             *}
      {**************************************MA*}
      If blnConfirma Then
      Begin
        strCodCid := fRetCidCliente(strCodCli);
        fDigDuplic(arrDuplicata, strCndPag, 0, fltTotCli, False, True, False, StrToDate(strDtaVen), True, 0, 'N',
          True, False, 0, False, Nil, '', blnSabDomFeriadosComoDiaUtil,
          True, Nil, '', False, True, '', '', Nil, False, False, Nil, False, False, 0, '', strCodCid);

        blnConfirma := arrDuplicata[0].strSequen <> '';
      End;

      If Not blnConfirma Then
      Begin
        pCancelaAgrupamento;
        Exit;
      End;

      {*******************************************************************}
      {* PRIMEIRO GRAVA E DEPOIS VERIFICA SE EXISTE MAIS QUE UM CLIENTE  *}
      {* PARA DELETAR AS DUPLICATAS AGRUPADAS DO CLIENTDATASET DE BACKUP *}
      {****************************************************************AN*}
      If (strCodCliGravado <> strCodCli) or fEmptyStr(strCodCliGravado) or (blnPorFaixa) then
      begin
        If (fGravaAgrupamentos(strCodCli, strDtaVen, fGetDataDeCadastro(VS_Date, False), strCndPag, fltTotCli)) And (stlCliVenc.Count > 1) Then
          pDeletaDuplicatasBackup;
      end;

    End;

    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;

  End;

  pnlInfo.Caption := '';
  pgbProgresso.Position := 0;
  Application.ProcessMessages;

  {***********************************************}
  {* CHAMA A IMPRESSAO DO COMPROVANTE E MENSAGEM *}
  {********************************************AN*}
  If blnConfirma And (Length(arrDupAgr) > 0) Then
  Begin

    strMsg := '';
    strMsg := ifthen( (rdgOpcoes.ItemIndex in [1, 2, 3]) ,'Aguarde, Realizando Agrupamento...Gerando Arquivos...','Aguarde, Realizando Agrupamento...');

    TfrmGravando.fExecutarModalA(pConcluirAgrupamento, strMsg, '');

  End;

  LiberaDupsMarcadas;

  For intCont := 0 To stlMsgErro.Count -1 Do
    pMensagemOk(stlMsgErro[intCont]);

  pLimpaDados;
  pSetFocus(edtCodEmp);

  FreeAndNil(stlCliVenc);
  FreeAndNil(stlMsgErro);
  FreeAndNil(cdsCtrBkp);
  strCodCliGravado := '';
  dtaDtaVencimento := 0;
  blnPorFaixa      := False;
end;

procedure TfrmGeraDuplicataReceber.pConcluirAgrupamento;
  var
    strDupAgr : String;
    intCont: integer;
    //blnEnviarEmail: boolean;

    blnEnvMai       : boolean;
    blnEmailImprime : boolean;
    blnBolPdf       : boolean;

    strMSBOEM: string;
    arrDestinatarios: TStringArray;
    arrArquivos     : TStringArray;
    LDadosEnvioEmail: TDadosEnvioEmail;
Begin
  {************************************}
  {* IMPRESSÃO DO COMPROVANTE         *}
  {*********************************JB*}
  blnBolPdf       := (rdgOpcoes.ItemIndex in [1, 2, 3]);
  blnEnvMai       := (rdgOpcoes.ItemIndex in [2, 3]) ;
  blnEmailImprime := (rdgOpcoes.ItemIndex in [3]);

  // Opção 1
  if blnBolPdf then
  begin

    Try
      pCriarFormularios(TfrmCtrAgrupDupRecibo, frmCtrAgrupDupRecibo);
      frmCtrAgrupDupRecibo.blnImprimePorNomCli := IIF(cbxImpAG.ItemIndex = 0, False, True);
      If Length(arrDupAgr) > 0 Then
      Begin
        For intCont := 0 To Length(arrDupAgr) - 1 Do
          frmCtrAgrupDupRecibo.pImprimeComprovante(arrDupAgr[intCont].strNumAgr, Self.Name, 1,blnBolPdf);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[Erro ao salvar comprovante agrupamento contas a receber]');
    End;

    If blnEnvMai Then //opçoes [2,3]
    Begin
      LDadosEnvioEmail:= TDadosEnvioEmail.Create;

      // Opção 2 - enviar e-mails
      for intCont := low(frmCtrAgrupDupRecibo.arrArqAgrupamentos) to high(frmCtrAgrupDupRecibo.arrArqAgrupamentos) do
      begin
        if frmCtrAgrupDupRecibo.arrArqAgrupamentos[intCont].strEmail <> '' then
         begin
           strMSBOEM := fCfgSis('MSBOEM', varString);
           pCriarArrayAnexosEDestinatarios(frmCtrAgrupDupRecibo.arrArqAgrupamentos[intCont].strarqanexos, frmCtrAgrupDupRecibo.arrArqAgrupamentos[intCont].strEmail, arrDestinatarios, arrArquivos);

           LDadosEnvioEmail.AOwner := Self;
           LDadosEnvioEmail.ACodOperador := strLoginUsuarioLogado;
           LDadosEnvioEmail.AAssunto :=  'Agrupamentos';
           LDadosEnvioEmail.APara :=  arrDestinatarios;
           LDadosEnvioEmail.ACorpoMensagem :=  ['Segue duplicatas em anexo.', strMSBOEM];
           LDadosEnvioEmail.AAnexos := arrArquivos;
           LDadosEnvioEmail.AAbrirEditor := False;
           LDadosEnvioEmail.AExibirMensagemConfirmacaoEnvio := (intCont = High(frmCtrAgrupDupRecibo.arrArqAgrupamentos));
           LDadosEnvioEmail.blnVizualizar := False;
           TEnvioEmail.EnviarEmail(LDadosEnvioEmail);
           strArqBoletos := '';
         end;
       end;

      // opção 3
      If blnEmailImprime Then
      Begin

         If (fMensagem('Impressão', 'Deseja imprimir um comprovante?', ['&Sim', '&Não']) = 1) Then
         Begin
           Try
             pCriarFormularios(TfrmCtrAgrupDupRecibo, frmCtrAgrupDupRecibo);
             frmCtrAgrupDupRecibo.blnImprimePorNomCli := IIF(cbxImpAG.ItemIndex = 0, False, True);
             If Length(arrDupAgr) > 0 Then
             Begin
               For intCont := 0 To Length(arrDupAgr) - 1 Do
                 frmCtrAgrupDupRecibo.pImprimeComprovante(arrDupAgr[intCont].strNumAgr, Self.Name);
             End;
           Except
             On E: Exception Do
               pMensagensErro(E.Message, '[Erro ao imprimir comprovante agrupamento contas a receber]');
           End;
           pFreeAndNil(frmCtrAgrupDupRecibo);
       End;
      FreeAndNil(LDadosEnvioEmail);
    End;

      pDestroiModulo(frmCtrAgrupDupRecibo);

    End;

  end
  else
  If (fMensagem('Impressão', 'Deseja imprimir um comprovante?', ['&Sim', '&Não']) = 1) Then
  Begin
    Try
      pCriarFormularios(TfrmCtrAgrupDupRecibo, frmCtrAgrupDupRecibo);
      frmCtrAgrupDupRecibo.blnImprimePorNomCli := IIF(cbxImpAG.ItemIndex = 0, False, True);
      If Length(arrDupAgr) > 0 Then
      Begin
        For intCont := 0 To Length(arrDupAgr) - 1 Do
          frmCtrAgrupDupRecibo.pImprimeComprovante(arrDupAgr[intCont].strNumAgr, Self.Name);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[Erro ao imprimir comprovante agrupamento contas a receber]');
    End;
    pFreeAndNil(frmCtrAgrupDupRecibo);
  End;

  strDupAgr := '';
  For intCont := 0 To Length(arrDupAgr) - 1 Do
    strDupAgr := strDupAgr + arrDupAgr[intCont].strNumAgr + ', ';

  strDupAgr := Copy(strDupAgr, 1, Length(strDupAgr)-2);

  If fCfgSis('SMSCTR', varBoolean) And (fCfgSis('SMSCRM', varInteger) = 1) And (Length(arrDupAgr) > 0) Then
    If fMensagem('', 'Gerar arquivo texto para SMS ?', ['&Sim', '&Não']) = 1 Then
      pExportaSMS;

  If Length(arrDupAgr) = 1 Then
    fMensagem('','Agrupamento n° ' + arrDupAgr[0].strNumAgr + ' gerado com sucesso!', ['&O k'])

  Else If Length(arrDupAgr) > 1 Then
    fMensagem('','Agrupamentos n° ' + arrDupAgr[0].strNumAgr + ' até ' + arrDupAgr[Length(arrDupAgr)-1].strNumAgr + ' gerados com sucesso!', ['&O k']);

End;

procedure TfrmGeraDuplicataReceber.btnConfirmaClick(Sender: TObject);
  procedure pChamaImpressaoBoleto;
    var
      qryAgpDup: TUniQuery;
      intConta_: Integer;
      arrDupCtr: TArrDupCtr;
      strSqlCon,
      strSqlExe: String;

    function fGetSqlAgrup: String;
    Begin
      Result := ' SELECT R.* FROM DUPAGR D' +
                ' JOIN CADREC R ON R.CTR_NUMDUP = D.CTR_NUMAGR AND ' +
                '                  R.CTR_CODCLI = D.CTR_CODCLI AND ' +
                '                  R.CTR_ESPDOC = "AG" AND ' +
                '                  R.CTR_CODEMP = "(CODEMP)" ' +
                ' WHERE D.CTR_NUMAGR = "(NUMAGR)"  ' +
                '   AND D.CTR_CODCLI = "(CODCLI)"  ' +
                ' GROUP BY R.CTR_NUMDUP, R.CTR_PARCEL ';
    End;

  Begin
    strSqlExe := '';
    For intConta_ := 0 To Length(arrDupAgr)-1 Do
    Begin
      strSqlCon := '';
      strSqlCon := fGetSqlAgrup;
      strSqlCon := StringReplace(strSqlCon, '(NUMAGR)', arrDupAgr[intConta_].strNumAgr, []);
      strSqlCon := StringReplace(strSqlCon, '(CODEMP)', arrDupAgr[intConta_].strEmpAgr, []);
      strSqlCon := StringReplace(strSqlCon, '(CODCLI)', arrDupAgr[intConta_].strCodCli, []);

      If Not fEmptyStr(strSqlExe) Then
        StrSqlExe := StrSqlExe + ' UNION ALL ' + strSqlCon
      Else
        StrSqlExe := strSqlCon;
    End;

    qryAgpDup := fCriaQuery;

    Try
      With qryAgpDup Do
      Begin
        Sql.Clear;
        Sql.Text := StrSqlExe;
        Open;

        If Not IsEmpty Then
        Begin
          SetLength(arrDupCtr,0);
          While Not Eof Do
          Begin
            SetLength(arrDupCtr,Length(arrDupCtr)+1);
            arrDupCtr[Length(arrDupCtr)-1].strNumDup := FieldByName('CTR_NUMDUP').AsString;
            arrDupCtr[Length(arrDupCtr)-1].strEspDoc := FieldByName('CTR_ESPDOC').AsString;
            arrDupCtr[Length(arrDupCtr)-1].strCodEmp := FieldByName('CTR_CODEMP').AsString;
            arrDupCtr[Length(arrDupCtr)-1].strCodCli := FieldByName('CTR_CODCLI').AsString;
            arrDupCtr[Length(arrDupCtr)-1].strParcel := FieldByName('CTR_PARCEL').AsString;
            arrDupCtr[Length(arrDupCtr)-1].strAutoIn := FieldByName('AUTOINCREM').AsString;

            Next;
          End;

          If Length(arrDupCtr) > 0 Then
            TBoleto.fImprimirBoletos(arrDupCtr, False, True, 'Deseja imprimir boletos?', self.Name);
        End;
      End;
    Finally
      qryAgpDup.Close;
      FreeAndNil(qryAgpDup);
    End;
  End;

begin
  inherited;
  strAgrVen := '';

  FDuplicatasBloqueadas.Clear;
  FDuplicatasJaAgrupadas.Clear;

  If fVerificaCampos And fCriaTemporaria Then
  Begin
    TfrmGravando.fExecutarModalA(pMarcaTodasDuplicatas, 'Aguarde, Buscando Duplicatas...', '');

    If (cdsCtaRec.IsEmpty) Or (Not fVerificaDuplicatasClientes) Then
      Exit;

    If (fCfgSis('DTAAGR') = '3') And
        Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And
        (StrToDateTime(mskDtaFin.Text) > VS_Date) Then
    Begin
      fMensagem('ATENÇÃO!', 'Data Final informada no filtro do período é posterior a hoje. O AG será cadastrado com a data ' + FormatDateTime('dd/mm/yyyy', VS_Date),['&Ok']);
    End
    Else If (fCfgSis('DTAAGR') = '3') And fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    Begin
        fMensagem('ATENÇÃO!', 'Não foi informado a data final no filtro do periodo. O AG será cadastrado com a data ' + FormatDateTime('dd/mm/yyyy', VS_Date),['&Ok']);
    End;

    If Not fVerificaExiste Then
      fMensagem('','Existem duplicatas selecionadas que ja foram agrupadas!',['&OK'])

    Else If (fMensagem('', 'Confirma agrupamento?', ['&Sim', '&Não']) = 1) Then
    begin
      pAgruparDuplicatas;

      if blnConfirma Then
      begin
        If fVerificaAcessoSistema('frmImpBoletosIndiv') Then
          pChamaImpressaoBoleto;
      end
      else
      begin
        LiberaDupsMarcadas;
        pnlInfo.Caption := '';
      end;
    end;
    LiberaDupsMarcadas;
  end;
end;

procedure TfrmGeraDuplicataReceber.btnRegraAgrupClick(Sender: TObject);
begin
  inherited;
  fMensagem('Regras de Agrupamento', 'Duplicatas que não podem ser agrupadas:' + #13#10 +
                                     ' - Enviadas para o Banco ou com boleto impresso;        ' + #13#10 +
                                     ' - Já recebidas;                                        ' + #13#10 +
                                     ' - Com Pix gerado e ativo;                              ' + #13#10 +
                                     ' - Já vencidas, caso seja preciso fazer uma renegociação' + #13#10 +
                                     ' de duplicata vencida utilizar agrupamento tradicional. ', ['&Ok'],
                                     1, False, 2);
end;

function TfrmGeraDuplicataReceber.fGetDataDeCadastro(FDefault : TDateTime; FOlhaCfg : Boolean): TDateTime;
  Var
    FCfgDtaAgr : String;
begin
  Result := FDefault;
  FCfgDtaAgr := fCfgSis('DTAAGR'); //'Data para emissão do agrupamento - CONTAS A RECEBER'

  If Not FOlhaCfg And (FCfgDtaAgr <> '3') Then
    Exit;

  Case StrToInt(FCfgDtaAgr) Of
    1 :  Result := dtaDtaCad;
    2 :  Result := VS_Date;
    3 :  Begin
           Result := IIF(fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)),VS_Date,StrToDateTime(mskDtaFin.Text));
           If (Result > VS_Date) Then
           Begin
             Result := VS_Date;
           End;
         End;
  End;

end;

function TfrmGeraDuplicataReceber.fGravaAgrupamentos(strCodCli, strDtaVen: String; dtaDtaAgr: TDateTime; strConPag: String; fltTotCli: Double): Boolean;
Const
  	arrParcela : Array[0..25] Of Char = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
  Var
    intTamAnt: Integer;
    blnDescontoAteVencimento: Boolean;
    dagAgrup: TDadosAgrup;
    arrDupSel: Array Of TDuplicataCtr;

    strDupAgr: String;
    cdsGenCtr: TUniClientDataSet;
    fltValDes: Double;
    qryConVen:TUniQuery;
    intParcela, intContador: Integer;
    blnGravaCadRec: Boolean;
    LTotalParcelaAgr : Double;

  function fFiltroCli: String;
  begin
    Result := 'CTR_MARDES = ''M'' AND ' +
              'CTR_CODCLI = ' + QuotedStr(strCodCli);
  end;

  function fFiltroCliVenc: String;
  begin
    Result := 'CTR_MARDES = ''M'' AND ' +
              'CTR_CODCLI = ' + QuotedStr(strCodCli) + ' AND ' +
              'CTR_DTAVEN = ' + QuotedStr(strDtaVen);
  end;

  function fCliVen(codCli:String): String;
  var
    strSQL : String;
  Begin
    strSQL := 'SELECT CLI_CODVEN FROM CADCLI WHERE CLI_CODCLI = ' + QuotedStr(codCli);

    if not Assigned(qryConVen) then
      qryConVen := fCriaQuery(nil);

    with qryConVen do
    begin
      Close;
      SQL.Text := strSQL;
      Open;
      Result := FieldByName('CLI_CODVEN').AsString;
    end;
  end;

  function fCodVen: String;
  var
    intRecNo_: Integer;
    fltValDup: Double;
    strCodVen: String;
  Begin
    If (fCfgSis('OPAGCR', varInteger) = 2) Then
    Begin
      If Not fEmptyStr(strAgrVen) Then
        Result := strAgrVen
      Else
        Result := cdsGenCtr.FieldByName('CTR_CODVEN').AsString;
    End
    Else If (fCfgSis('OPAGCR', varInteger) = 1) Then
      // BUSCAR AQUI O VENDEDOR DO CADASTRO DO CLIENTE.
      Result := fCliVen(cdsGenCtr.FieldByName('CTR_CODCLI').AsString)
    Else If (fCfgSis('OPAGCR', varInteger) = 3) Then
    Begin
      intRecNo_ := cdsGenCtr.RecNo;
      fltValDup := 0;
      cdsGenCtr.First;
      With cdsGenCtr Do
      Begin
        While Not Eof Do
        Begin
          If FieldByName('CTR_MARDES').AsString = 'M' Then
          Begin
            If FieldByName('CTR_VALDUP').AsFloat >  fltValDup Then
            Begin
              fltValDup := FieldByName('CTR_VALDUP').AsFloat;
              strCodVen := FieldByName('CTR_CODVEN').AsString;
            End;
          End;

          Next;
        End;
      End;

      Result := strCodVen;
      cdsGenCtr.RecNo := intRecNo_;
    End;
  End;

begin
  blnDescontoAteVencimento := fCfgSis('UTDEFN') = '2';

  {****************************************************************************************}
  {* VERIFICAÇÃO SE IRÁ FAZER O PARCELAMENTO POR FAIXA DE VALOR OU POR CLIENTE+VENCIMENTO *}
  {*************************************************************************************MO*}
  If blnPorFaixa then
  begin
    {************************************************}
    {* RETORNA VALOR TOTAL DAS DUPLICATAS AGRUPADAS *}
    {*********************************************AC*}
    pRetornaTotal(strCodCli, strDtaVen, fltTotCli);
    Screen.Cursor := crHourGlass;
    strNumAgr     := fSeqAgrupamentoCtr;

    {***************************************************}
    {* CRIANDO UM CLIENTDATASET COM OS DADOS DO PADRAO *}
    {* DO FORM PARA CONCLUIR O AGRUPAMENTO DE DUPLIC   *}
    {************************************************AN*}
    cdsGenCtr := fCriaClientCtaRec(fFiltroCliVenc);

    With cdsGenCtr Do
    Begin
      Try
        {*****************************************}
        {* INICIA A TRANSAÇÃO                    *}
        {**************************************MV*}
        fStartTransaction;
        First;

        While Not Eof Do
        Begin
          {*****************************************}
          {* FORMATA AS OBSERVAÇÕES                *}
          {**************************************MV*}
          If fEmptyStr(dagAgrup.strObsAg1) Then
          Begin
            dagAgrup.strObsAg1 := 'REF. DOC. ' + fRetiraZerosEsquerda(FieldByName('CTR_NUMDUP').AsString);
          End
          Else If Length(dagAgrup.strObsAg1) < 98 Then
          Begin
            dagAgrup.strObsAg1 := Copy(dagAgrup.strObsAg1 + ' / ' + fRetiraZerosEsquerda(FieldByName('CTR_NUMDUP').AsString), 1, 120);
          End
          Else If Length(dagAgrup.strObsAg2) < 112 Then
          Begin
            dagAgrup.strObsAg2 := Copy(dagAgrup.strObsAg2 + ' / ' + fRetiraZerosEsquerda(FieldByName('CTR_NUMDUP').AsString), 1, 120);
          End
          Else If Length(dagAgrup.strObsAg3) < 112 Then
          Begin
            dagAgrup.strObsAg3 := Copy(dagAgrup.strObsAg3 + ' / ' + fRetiraZerosEsquerda(FieldByName('CTR_NUMDUP').AsString), 1, 120);
          End;

          {*****************************************}
          {* SALVA AS DUPLICATAS QUE SERÃO ATUALI- *}
          {* ZADAS                                 *}
          {**************************************MV*}
          intTamAnt := Length(arrDupSel);
          SetLength(arrDupSel, intTamAnt+1);

          arrDupSel[intTamAnt].strNumDup := FieldByName('NRODUP').AsString;
          arrDupSel[intTamAnt].strParcel := FieldByName('PARDUP').AsString;
          arrDupSel[intTamAnt].strEspDoc := FieldByName('CTR_ESPDOC').AsString;
          arrDupSel[intTamAnt].strCodEmp := FieldByName('CTR_CODEMP').AsString;
          arrDupSel[intTamAnt].strCodCli := FieldByName('CTR_CODCLI').AsString;

          {*****************************************}
          {* NUMERO DAS DUPLICATAS AGRUPADAS       *}
          {**************************************RV*}
          If (RecNo = 1) Then
            strDupAgr := FieldByName('CTR_NUMDUP').AsString
          Else
            strDupAgr := strDupAgr + '/' + FieldByName('CTR_NUMDUP').AsString;

          Application.ProcessMessages;
          Next;
        End;

        blnConfirma := True;
        If blnConfirma Then
        Begin
          {*****************************************}
          {* GRAVA AS DUPLICATAS AGRUPADAS         *}
          {**************************************MV*}
          For intContador := 0 To Length(arrDuplicata) -1 Do
          Begin

            {*****************************************}
            {* CHEGOU AO FIM DA MATRIZ.              *}
            {**************************************MV*}
            If fEmptyStr(arrDuplicata[intContador].strSequen) Then
              Break;

            strAgrVen := FieldByName('CTR_CODVEN').AsString;

            blnConfirma := fGravaCadRec(Self.Name,
                                        'INCLUSÃO',
                                        strNumAgr,
                                        arrDuplicata[intContador].strSequen,
                                        0,
                                        'AG',
                                        FieldByName('CTR_CODCLI').AsString,
                                        strEmpDuplic,
                                        fCodVen, // FieldByName('CTR_CODVEN').AsString,
                                        FieldByName('CTR_CODDIG').AsString,
                                        edtPorAgr.Text,
                                        dtaDtaAgr,
                                        StrToDate(arrDuplicata[intContador].dtaDtaVen),
                                        arrDuplicata[intContador].curValor,
                                        arrDuplicata[intContador].curValor,
                                        0,
                                        'N',
                                        'REF. AGRUPAMENTO Nro. ' + strNumAgr + ' - DOC(S): ' + strDupAgr,
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        0.0,
                                        0,
                                        FieldByName('CTR_ADTCLI').AsString,
                                        FieldByName('CTR_CODEVE').AsString,
                                        FieldByName('CTR_CODVEL').AsString,
                                        '',
                                        FieldByName('CTR_CODCND').AsString,
                                        False,
                                        FieldByName('CTR_CODCTA').AsString,
                                        0,
                                        0,
                                        dagAgrup.strObsAg1,
                                        dagAgrup.strObsAg2,
                                        dagAgrup.strObsAg3,
                                        FieldByName('CTR_CTASER').AsString,
                                        FieldByName('CTR_SERVAL').AsFloat,
                                        0,  //intResCai
                                        0,  //fltVlrCom
                                        0,  //fltFatCom
                                        '', //strEmpBai
                                        '', // Empresa de Origem
                                        '', //strDocDiv
                                        '', //strEspDiv
                                        '', //strEmpDiv
                                        '', //strCliDiv
                                        0,  //fltVlrRep
                                        0,  //fltFatRep
                                        FieldByName('CTR_CODREP').AsString);

            If Not blnConfirma Then
              Break;

            If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
            Begin
              TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(strNumAgr,
                                                       'AG',
                                                       strEmpDuplic,
                                                       FieldByName('CTR_CODCLI').AsString,
                                                       arrDuplicata[intContador].strSequen,
                                                       strLoginUsuarioLogado,
                                                       fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                       afcAgrupaDuplicatas);
            End;
          End;

        End;

        If blnConfirma Then
        Begin
          {*****************************************}
          {* DELETA AS DUPLICATAS ORIGINAIS        *}
          {**************************************MV*}
          blnConfirma := fDeletaDuplicatas(arrDupSel);
        End;

        {*******************************************}
        {* WHILE PARA GRAVACAO DO DUPAGR           *}
        {****************************************AF*}
        If blnConfirma Then
        Begin
          First;
          While Not Eof Do
          Begin

            If blnDescontoAteVencimento Then
            Begin
              If FieldByName('CTR_DTAVEN').AsDateTime >= VS_Date Then
                fltValDes := FieldByName('CTR_DESSUJ').AsFloat
              Else
                fltValDes := 0;
            End
            Else
              fltValDes := FieldByName('CTR_DESSUJ').AsFloat;

            {*****************************************}
            {* GRAVA A TABELA DUPAGR                 *}
            {**************************************MV*}
            strAgrVen := FieldByName('CTR_CODVEN').AsString;
            blnConfirma := fGravaDupAgr(strNumAgr,
                                        FieldByName('NRODUP').AsString,
                                        FieldbyName('PARDUP').AsString,
                                        FieldByName('CTR_SEQBAI').AsInteger,
                                        FieldByName('CTR_ESPDOC').AsString,
                                        FieldByName('CTR_CODCLI').AsString,
                                        FieldByName('CTR_CODEMP').AsString,
                                        FieldByName('CTR_CODPOR').AsString,
                                        fCodVen, // FieldByName('CTR_CODVEN').AsString,
                                        FieldByName('CTR_CODDIG').AsString,
                                        FieldByName('CTR_DTACAD').AsDateTime,
                                        FieldByName('CTR_DTAVEN').AsDateTime,
                                        FieldByName('CTR_VALDUP').AsFloat - FieldByName('CTR_JURSUJ').AsFloat - FieldByName('CTR_DESCOB').AsFloat + fltValDes,
                                        FieldByName('CTR_VALDUP').AsFloat - FieldByName('CTR_JURSUJ').AsFloat - FieldByName('CTR_DESCOB').AsFloat + fltValDes,
                                        FieldByName('CTR_DESCOB').AsFloat,
                                        FieldByName('CTR_DESCON').AsString,
                                        FieldByName('CTR_HIST01').AsString,
                                        FieldByName('CTR_HIST02').AsString,
                                        FieldByName('CTR_ADTCLI').AsString,
                                        FieldByName('CTR_CODEVE').AsString,
                                        FieldByName('CTR_CODVEL').AsString,
                                        FieldByName('CTR_TIPFOR').AsString,
                                        FieldByName('CTR_CODCND').AsString,
                                        IIF(FieldByName('CTR_CONAPR').AsInteger = 1, True, False),
                                        strEmpDuplic,
                                        FieldByName('CTR_CODCTA').AsString,
                                        FieldByName('CTR_EMP_PD').AsString,
                                        FieldByName('CTR_SEQCON').AsInteger,
                                        FieldByName('CTR_DIFORI').AsFloat,
                                        FieldByName('CTR_VALANT').AsFloat,
                                        FieldByName('CTR_GRVORI').AsFloat,
                                        FieldByName('CTR_CTASER').AsString,
                                        FieldByName('CTR_SERVAL').AsFloat,
                                        FieldByName('CTR_VALCOM').AsFloat,
                                        FieldByName('CTR_VALCOM').AsFloat/fltTotCli,
                                        FieldByName('CTR_VALCOR').AsFloat/fltTotCli,
                                        FieldByName('CTR_VALDES').AsFloat,
                                        FieldByName('CTR_JURATR').AsFloat + FieldByName('CTR_JURREP').AsFloat,
                                        strConPag,
                                        FieldByName('CTR_CODREP').AsString,
                                        FieldByName('CTR_COMREP').AsFloat,
                                        FieldByName('CTR_COMREP').AsFloat/fltTotCli,
                                        FieldByName('CTR_VALIPI').AsFloat,
                                        FieldByName('CTR_VALRET').AsFloat,
                                        FieldByName('CTR_DESSUJ').AsFloat,
                                        FieldByName('CTR_JURSUJ').AsFloat,
                                        FieldByName('CTR_BARCON').AsString,
                                        0,
                                        0,
                                        FieldByName('CTR_VALACE').AsFloat,
                                        FieldByName('CTR_VALFRE').AsFloat,
                                        0,
                                        FieldByName('CTR_DOCDIV').AsString,
                                        FieldByName('CTR_ESPDIV').AsString,
                                        FieldByName('CTR_EMPDIV').AsString,
                                        FieldByName('CTR_CLIDIV').AsString,
                                        FieldByName('CTR_COMDIV').AsFloat,
                                        FieldByName('CTR_FATDIV').AsFloat,
                                        FieldByName('CTR_CODDIV').AsString,
                                        0,
                                        '',
                                        FieldByName('CTR_INCDOC').AsString,
                                        FieldByName('CTR_SEQMPX').AsString,
                                        FieldByName('CTR_VALCBS').AsFloat,
                                        FieldByName('CTR_VALIBS').AsFloat,
                                        FieldByName('CTR_VAL_IS').AsFloat);

            If Not blnConfirma Then
              Break;

            If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
            Begin
              TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('NRODUP').AsString,
                                                       FieldByName('CTR_ESPDOC').AsString,
                                                       FieldByName('CTR_CODEMP').AsString,
                                                       FieldByName('CTR_CODCLI').AsString,
                                                       FieldbyName('PARDUP').AsString,
                                                       strLoginUsuarioLogado,
                                                       fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                       afcGeraDuplicatasReceber, True);
            End;

            Next;
            Application.ProcessMessages;

          End;

          GravaLogDuplicatasNaoAgrupadas;
        End;

      Except
        On E: Exception Do
        Begin
          blnConfirma := FALSE;
          fRollBack;
          pMensagensErro(E.Message, '[untGeraDuplicataReceber - dbgDuplicatasKeyDown]');
        End;
      End;

    End;

  end
  //PARCELAMENTO POR CLIENTE + VENCIMENTO
  else
  begin
    Screen.Cursor := crHourGlass;
    blnConfirma   := False;

    {***************************************************}
    {* CRIANDO UM CLIENTDATASET COM OS DADOS DO PADRAO *}
    {* DO FORM PARA CONCLUIR O AGRUPAMENTO DE DUPLIC   *}
    {************************************************AN*}
    intParcela := 0;
    cdsGenCtr      := fCriaClientCtaRec(fFiltroCli);
    cdsGenCtr.IndexFieldNames := 'CTR_CODCLI;CTR_DTAVEN';

    dtaDtaAgr := fGetDataDeCadastro(dtaDtaCad, True);

    If (strCodCliGravado <> cdsGenCtr.FieldByName('CTR_CODCLI').AsString) then
    begin
      strNumAgr := fSeqAgrupamentoCtr;
    end;

    with cdsGenCtr Do
    begin
      First;
      While Not Eof Do
      Begin
        {*****************************************}
        {* FORMATA AS OBSERVAÇÕES                *}
        {**************************************MV*}
        pRetornaTotal(strCodCli, DateToStr(FieldByName('CTR_DTAVEN').AsDateTime), fltTotCli);

        If fltTotCli <= 0 Then
        Begin
          cdsGenCtr.Next;
          Continue;
        End;

        If fEmptyStr(dagAgrup.strObsAg1) Then
        Begin
          dagAgrup.strObsAg1 := 'REF. DOC. ' + FieldByName('CTR_NUMDUP').AsString;
        End
        Else If Length(dagAgrup.strObsAg1) < 98 Then
        Begin
          dagAgrup.strObsAg1 := Copy(dagAgrup.strObsAg1 + '/' + FieldByName('CTR_NUMDUP').AsString, 1, 120);
        End
        Else If Length(dagAgrup.strObsAg2) < 112 Then
        Begin
          dagAgrup.strObsAg2 := Copy(dagAgrup.strObsAg2 + '/' + FieldByName('CTR_NUMDUP').AsString, 1, 120);
        End
        Else If Length(dagAgrup.strObsAg3) < 112 Then
        Begin
          dagAgrup.strObsAg3 := Copy(dagAgrup.strObsAg3 + '/' + FieldByName('CTR_NUMDUP').AsString, 1, 120);
        End;

        {*****************************************}
        {* SALVA AS DUPLICATAS QUE SERÃO ATUALI- *}
        {* ZADAS                                 *}
        {**************************************MV*}
        intTamAnt := Length(arrDupSel);
        SetLength(arrDupSel, intTamAnt+1);

        arrDupSel[intTamAnt].strNumDup := FieldByName('NRODUP').AsString;
        arrDupSel[intTamAnt].strParcel := FieldByName('PARDUP').AsString;
        arrDupSel[intTamAnt].strEspDoc := FieldByName('CTR_ESPDOC').AsString;
        arrDupSel[intTamAnt].strCodEmp := FieldByName('CTR_CODEMP').AsString;
        arrDupSel[intTamAnt].strCodCli := FieldByName('CTR_CODCLI').AsString;

        {*****************************************}
        {* NUMERO DAS DUPLICATAS AGRUPADAS       *}
        {**************************************RV*}
        If (RecNo = 1) Then
          strDupAgr := FieldByName('CTR_NUMDUP').AsString
        Else
          strDupAgr := strDupAgr + '/' + FieldByName('CTR_NUMDUP').AsString;

        Application.ProcessMessages;
        Next;
      end;
    end;

    Try
      with cdsGenCtr Do
      begin
        {*****************************************}
        {* INICIA A TRANSAÇÃO                    *}
        {**************************************MV*}
        fStartTransaction;
        First;
        LTotalParcelaAgr := 0;

        While not Eof Do
        begin

          pRetornaTotal(strCodCli, DateToStr(FieldByName('CTR_DTAVEN').AsDateTime), fltTotCli);


          If fltTotCli <= 0 Then
          Begin
            cdsGenCtr.Next;
            Continue;
          End;


          If (strCodCliGravado = FieldByName('CTR_CODCLI').AsString) and
             (dtaDtaVencimento <> FieldByName('CTR_DTAVEN').AsDateTime) then
          begin
             inc(intParcela);
          end
          else
          If (strCodCliGravado <> FieldByName('CTR_CODCLI').AsString) then
          begin
             intParcela := 0;
          end;

          If (strCodCliGravado = FieldByName('CTR_CODCLI').AsString) and
             (dtaDtaVencimento = FieldByName('CTR_DTAVEN').AsDateTime) then
          begin
            blnGravaCadRec := False;
          end
          else
            blnGravaCadRec := True;

          strAgrVen := FieldByName('CTR_CODVEN').AsString;

          if blnGravaCadRec Then
          begin
            LTotalParcelaAgr := (LTotalParcelaAgr + fltTotCli);
            blnConfirma := fGravaCadRec(Self.Name,
                                        'INCLUSÃO',
                                        strNumAgr,
                                        arrParcela[intParcela],
                                        0,
                                        'AG',
                                        FieldByName('CTR_CODCLI').AsString,
                                        strEmpDuplic,
                                        fCodVen, // FieldByName('CTR_CODVEN').AsString,
                                        FieldByName('CTR_CODDIG').AsString,
                                        edtPorAgr.Text,
                                        dtaDtaAgr,
                                        FieldByName('CTR_DTAVEN').AsDateTime,
                                        fltTotCli,
                                        fltTotCli,
                                        0,
                                        'N',
                                        'REF. AGRUPAMENTO Nro. ' + strNumAgr + ' - DOC(S): ' + strDupAgr,
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        0.0,
                                        0,
                                        FieldByName('CTR_ADTCLI').AsString,
                                        FieldByName('CTR_CODEVE').AsString,
                                        FieldByName('CTR_CODVEL').AsString,
                                        '',
                                        FieldByName('CTR_CODCND').AsString,
                                        False,
                                        FieldByName('CTR_CODCTA').AsString,
                                        0,
                                        0,
                                        dagAgrup.strObsAg1,
                                        dagAgrup.strObsAg2,
                                        dagAgrup.strObsAg3,
                                        FieldByName('CTR_CTASER').AsString,
                                        FieldByName('CTR_SERVAL').AsFloat,
                                        0,  //intResCai
                                        0,  //fltVlrCom
                                        0,  //fltFatCom
                                        '', //strEmpBai
                                        '', // Empresa de Origem
                                        '', //strDocDiv
                                        '', //strEspDiv
                                        '', //strEmpDiv
                                        '', //strCliDiv
                                        0,  //fltVlrRep
                                        0,  //fltFatRep
                                        FieldByName('CTR_CODREP').AsString);
          end
          else
            blnConfirma := True;

          If Not blnConfirma Then
            Break;

          If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
          Begin
            TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(strNumAgr,
                                                     'AG',
                                                     strEmpDuplic,
                                                     FieldByName('CTR_CODCLI').AsString,
                                                     arrParcela[intParcela],
                                                     strLoginUsuarioLogado,
                                                     fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                     afcAgrupaDuplicatas);
          End;

          strCodCliGravado    := FieldByName('CTR_CODCLI').AsString;
          dtaDtaVencimento := FieldByName('CTR_DTAVEN').AsDateTime;
          Next;
        end;


        If blnConfirma Then
        Begin
          {*****************************************}
          {* DELETA AS DUPLICATAS ORIGINAIS        *}
          {**************************************MV*}
          blnConfirma := fDeletaDuplicatas(arrDupSel);
        End;

        {*******************************************}
        {* WHILE PARA GRAVACAO DO DUPAGR           *}
        {****************************************AF*}
        If blnConfirma Then
        Begin
          {*********************************************************************************}
          {* CASO TENHA MAIS DE UMA PARCELA E A CONDIÇÃO DE PAGAMENTO NÃO VIER CORRETA, ****}
          {* A MESMA SERÁ LIMPA PARA NÃO FICAR ERRADO NOS DADOS DA DUPAGR E NO COMPROVANTE *}
          {******************************************************************************MO*}
          if (intParcela > 0) and (strConPag = '01000') then
            strConPag := '';

          First;
          While Not Eof Do
          Begin

            pRetornaTotal(strCodCli, DateToStr(FieldByName('CTR_DTAVEN').AsDateTime), fltTotCli);

            If fltTotCli <= 0 Then
            Begin
              cdsGenCtr.Next;
              Continue;
            End;

            If blnDescontoAteVencimento Then
            Begin
              If FieldByName('CTR_DTAVEN').AsDateTime >= VS_Date Then
                fltValDes := FieldByName('CTR_DESSUJ').AsFloat
              Else
                fltValDes := 0;
            End
            Else
              fltValDes := FieldByName('CTR_DESSUJ').AsFloat;

            {*****************************************}
            {* GRAVA A TABELA DUPAGR                 *}
            {**************************************MV*}
            strAgrVen := FieldByName('CTR_CODVEN').AsString;

            If LTotalParcelaAgr = 0 Then
              LTotalParcelaAgr := fltTotCli;

            blnConfirma := fGravaDupAgr(strNumAgr,
                                        FieldByName('NRODUP').AsString,
                                        FieldbyName('PARDUP').AsString,
                                        FieldByName('CTR_SEQBAI').AsInteger,
                                        FieldByName('CTR_ESPDOC').AsString,
                                        FieldByName('CTR_CODCLI').AsString,
                                        FieldByName('CTR_CODEMP').AsString,
                                        FieldByName('CTR_CODPOR').AsString,
                                        fCodVen, // FieldByName('CTR_CODVEN').AsString,
                                        FieldByName('CTR_CODDIG').AsString,
                                        FieldByName('CTR_DTACAD').AsDateTime,
                                        FieldByName('CTR_DTAVEN').AsDateTime,
                                        FieldByName('CTR_VALDUP').AsFloat - FieldByName('CTR_JURSUJ').AsFloat - FieldByName('CTR_DESCOB').AsFloat + fltValDes,
                                        FieldByName('CTR_VALDUP').AsFloat - FieldByName('CTR_JURSUJ').AsFloat - FieldByName('CTR_DESCOB').AsFloat + fltValDes,
                                        FieldByName('CTR_DESCOB').AsFloat,
                                        FieldByName('CTR_DESCON').AsString,
                                        FieldByName('CTR_HIST01').AsString,
                                        FieldByName('CTR_HIST02').AsString,
                                        FieldByName('CTR_ADTCLI').AsString,
                                        FieldByName('CTR_CODEVE').AsString,
                                        FieldByName('CTR_CODVEL').AsString,
                                        FieldByName('CTR_TIPFOR').AsString,
                                        FieldByName('CTR_CODCND').AsString,
                                        IIF(FieldByName('CTR_CONAPR').AsInteger = 1, True, False),
                                        strEmpDuplic,
                                        FieldByName('CTR_CODCTA').AsString,
                                        FieldByName('CTR_EMP_PD').AsString,
                                        FieldByName('CTR_SEQCON').AsInteger,
                                        FieldByName('CTR_DIFORI').AsFloat,
                                        FieldByName('CTR_VALANT').AsFloat,
                                        FieldByName('CTR_GRVORI').AsFloat,
                                        FieldByName('CTR_CTASER').AsString,
                                        FieldByName('CTR_SERVAL').AsFloat,
                                        FieldByName('CTR_VALCOM').AsFloat,
                                        FieldByName('CTR_VALCOM').AsFloat/LTotalParcelaAgr,
                                        FieldByName('CTR_VALCOR').AsFloat/LTotalParcelaAgr,
                                        FieldByName('CTR_VALDES').AsFloat,
                                        FieldByName('CTR_JURATR').AsFloat + FieldByName('CTR_JURREP').AsFloat,
                                        strConPag,
                                        FieldByName('CTR_CODREP').AsString,
                                        FieldByName('CTR_COMREP').AsFloat,
                                        FieldByName('CTR_COMREP').AsFloat/LTotalParcelaAgr,
                                        FieldByName('CTR_VALIPI').AsFloat,
                                        FieldByName('CTR_VALRET').AsFloat,
                                        FieldByName('CTR_DESSUJ').AsFloat,
                                        FieldByName('CTR_JURSUJ').AsFloat,
                                        FieldByName('CTR_BARCON').AsString,
                                        0,
                                        0,
                                        FieldByName('CTR_VALACE').AsFloat,
                                        FieldByName('CTR_VALFRE').AsFloat,
                                        0,
                                        FieldByName('CTR_DOCDIV').AsString,
                                        FieldByName('CTR_ESPDIV').AsString,
                                        FieldByName('CTR_EMPDIV').AsString,
                                        FieldByName('CTR_CLIDIV').AsString,
                                        FieldByName('CTR_COMDIV').AsFloat,
                                        FieldByName('CTR_FATDIV').AsFloat,
                                        FieldByName('CTR_CODDIV').AsString,
                                        0,
                                        '',
                                        FieldByName('CTR_INCDOC').AsString,
                                        FieldByName('CTR_SEQMPX').AsString,
                                        FieldByName('CTR_VALCBS').AsFloat,
                                        FieldByName('CTR_VALIBS').AsFloat,
                                        FieldByName('CTR_VAL_IS').AsFloat);

            If Not blnConfirma Then
              Break;

            If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
            Begin
              TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('NRODUP').AsString,
                                                       FieldByName('CTR_ESPDOC').AsString,
                                                       FieldByName('CTR_CODEMP').AsString,
                                                       FieldByName('CTR_CODCLI').AsString,
                                                       FieldbyName('PARDUP').AsString,
                                                       strLoginUsuarioLogado,
                                                       fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                       afcGeraDuplicatasReceber, True);
            End;

            Next;
            Application.ProcessMessages;

          End;

          GravaLogDuplicatasNaoAgrupadas;
        End;
      end;
      Except
      On E: Exception Do
      Begin
        blnConfirma := FALSE;
        fRollBack;
        pMensagensErro(E.Message, '[untGeraDuplicataReceber - dbgDuplicatasKeyDown]');
      End;
    End;
  end;

  If blnConfirma Then
  Begin
    SetLength(arrDupAgr, Length(arrDupAgr) + 1);
    arrDupAgr[Length(arrDupAgr)-1].strNumAgr := strNumAgr;
    arrDupAgr[Length(arrDupAgr)-1].strEmpAgr := strEmpDuplic;
    arrDupAgr[Length(arrDupAgr)-1].strCodCli := strCodCli;

    fCommit;
  End else
    fRollBack;

  Result := blnConfirma;
  Screen.Cursor := crDefault;
  FreeAndNil(cdsGenCtr);
end;

function TfrmGeraDuplicataReceber.fDeletaDuplicatas(
  arrDupSel: Array Of TDuplicataCtr): Boolean;
  Var
    strSQL     : String;
    intContador: Integer;
    qryGenRec  : TUniQuery;

begin
  Try
    Result := True;

    qryGenRec := fCriaQuery(Self);
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE * FROM CADREC ';
      strSQL := strSQL + 'WHERE ';

      For intContador := 0 To Length(arrDupSel) -1 Do
      Begin

        strSQL := strSQL + '( CTR_NUMDUP = ' + QuotedStr(arrDupSel[intContador].strNumDup);
        strSQL := strSQL + ' AND CTR_PARCEL = ' + QuotedStr(arrDupSel[intContador].strParcel);
        strSQL := strSQL + ' AND CTR_SEQBAI = 0 ';
        strSQL := strSQL + ' AND CTR_ESPDOC = ' + QuotedStr(arrDupSel[intContador].strEspDoc);
        strSQL := strSQL + ' AND CTR_CODEMP = ' + QuotedStr(arrDupSel[intContador].strCodEmp);
        strSQL := strSQL + ' AND CTR_CODCLI = ' + QuotedStr(arrDupSel[intContador].strCodCli) + ')';

        If intContador < Length(arrDupSel) -1 Then
          strSQL := strSQL + ' OR ';

      End;

      With qryGenRec Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        While Not Eof Do
        Begin
          Result := Result And fApagaDuplicataContasReceber(qryGenRec, Self.Name, '', False);
          Next;
        End;

        Close;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fDeletaDuplicatas]');
      End;

    End;

  Finally
    FreeAndNil(qryGenRec);
  End;

end;

procedure TfrmGeraDuplicataReceber.btnSairAgrupClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmGeraDuplicataReceber.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm   := Self.Name;
    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmCadConfRelatorios);
end;

procedure TfrmGeraDuplicataReceber.pMarcaTodasDuplicatas;
  Var
    intRecNo   : Integer;
begin
  If cdsCtaRec.IsEmpty Then
    Exit;

  With cdsCtaRec Do
  Begin
    DisableControls;
    intRecNo := RecNo;

    First;
    While Not Eof Do
    Begin
      pSelecionaDuplicata;
      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;

end;

procedure TfrmGeraDuplicataReceber.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraDuplicataReceber.edtCodPorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     edtNomPor,
                     qryConPor,
                     Key,
                     arrPortador,
                     False,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     edtCodEmp.Text) Then
    Begin
      If fValidaCampos(edtCodPor, False) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmGeraDuplicataReceber.edtPorAgrKeyPress(Sender: TObject; var Key: Char);
 Var
    arrPortador: TConsultasArray;

begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtPorAgr, edtNomPorAgr, qryConPor, Key, arrPortador) Then
    Begin
      If fValidaCampos(edtPorAgr, False) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmGeraDuplicataReceber.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmGeraDuplicataReceber.pCarregaPortador(strCodPor: String; edtDescri: TEditFocus);
begin
  pPesquisaCadPor(Nil, qryConPor, strCodPor);
  With qryConPor Do
  Begin
    edtDescri.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmGeraDuplicataReceber.pRetornaTotal(strCodCli, strDtaVen: String; Var fltTotCli: Double);
  Var
    cdsGen: TUniClientDataSet;
    fldTotCli: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldTotCli := fCriaAggregateField(cdsGen, 'FLDTOTCLI', 'SUM(CTR_VALCOR)', '#,##0.00');

  With cdsGen Do
  Begin
    Data := cdsCtaRec.Data;
    Filtered := False;
    Filter := '';
    Filter := Filter + 'CTR_MARDES = ''M'' AND ';
    Filter := Filter + 'CTR_CODCLI = ' + QuotedStr(strCodCli) + ' AND ';
    Filter := Filter + 'CTR_DTAVEN = ' + QuotedStr(strDtaVen);
    Filtered := True;

    AggregatesActive := True;
    fltTotCli := IIF(fldTotCli.Value = Null, 0, fldTotCli.Value);
  End;

  FreeAndNil(cdsGen);
end;

procedure TfrmGeraDuplicataReceber.FormDestroy(Sender: TObject);
begin
  inherited;         
  setLength(arrDupAgr, 0);
  FreeAndNil(objSMSMod1);

  If Assigned(cdsCtaRec) THen
    FreeAndNil(cdsCtaRec);
end;

procedure TfrmGeraDuplicataReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_F10 Then
    btnConfirma.Click;

end;

procedure TfrmGeraDuplicataReceber.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharTela Then
    Close;
end;

procedure TfrmGeraDuplicataReceber.FormShow(Sender: TObject);
begin
  inherited;
  chkAgrupaCred.Visible := fCfgSis('AGP_CC', varBoolean);
end;

function TfrmGeraDuplicataReceber.fVerificaExiste: Boolean;
  Var
    cdsGen: TUniClientDataSet;
Begin
  Result := True;
  cdsGen := fCriaClientCtaRec('CTR_MARDES = ' + QuotedStr('M'));
  With cdsGen Do
  Begin
    First;
    While Not Eof Do
    Begin
      If Not fExisteDuplicata(FieldByName('NRODUP').AsString,
                              FieldByName('PARDUP').AsString,
                              FieldByName('CTR_ESPDOC').AsString,
                              FieldByName('CTR_CODEMP').AsString,
                              FieldByName('CTR_CODCLI').AsString,
                              FieldByName('CTR_SEQBAI').AsInteger) Then
      Begin
        Result := False;
        Break;
      End;

      Next;
    End;
  End;

  FreeAndNil(cdsGen);
End;

procedure TfrmGeraDuplicataReceber.GravaLogDuplicatasNaoAgrupadas;
var
  I: Integer;
begin
  for I := 0 to Pred(FDuplicatasBloqueadas.Count) do
  begin
    untLogCtr.GravaLogCtr(FDuplicatasBloqueadas[I],
                          'TENTATIVA DE AGRUPAMENTO - DUPLICATA EM USO',
                          'TfrmGeraDuplicataReceber',
                          strLoginUsuarioLogado);
  end;

  for I := 0 to Pred(FDuplicatasJaAgrupadas.Count) do
  begin
    untLogCtr.GravaLogCtr(FDuplicatasJaAgrupadas[I],
                          'TENTATIVA DE AGRUPAMENTO - DUPLICATA JA AGRUPADA',
                          'TfrmGeraDuplicataReceber',
                          strLoginUsuarioLogado);
  end;
end;

function TfrmGeraDuplicataReceber.fExisteDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String; intSeqBai: Integer): Boolean;
  Var
    strSQL: String;
    qryGenRec: TUniQuery;

begin
  Try
    qryGenRec := fCriaQuery;

    Result := False;
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS VALOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_SEQBAI = :SEQBAI ';

    With qryGenRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SUM(VALOR) AS VALOR FROM (' + strSQL + ') AS TMP');
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('ESPDOC').AsString  := strEspDoc;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODCLI').AsString  := strCodCli;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;

      If FieldByName('VALOR').AsInteger <> 0 Then
        Result := True;

      Close;
    End;
  Finally
    FreeAndNil(qryGenRec);
  End;
End;

end.


