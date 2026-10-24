{***************************}
{* qryConCli -> CADCLI     *}
{* qryConEmp -> CADEMP     *}
{************************JB*}

{***************************}
{* qryConPor -> CADPOR     *}
{************************RV*}

unit untGeraNotaDebito;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask,
  untFuncoesSimples, Uni, MaskEditFocus, EditFocus,
  ComCtrls, Buttons, ExtCtrls, DB, Menus, AppEvnts, strUtils, MemoFocus,
  UniClientDataSet, UniDataSetProvider, cxControls, cxContainer, cxEdit, cxProgressBar,
  BitBtnLockedIncrem, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, frxClass, frxExportCSVTestabilidade,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxCheckBox,untTLock, ComboBoxFocus, untTypesSistema;
type
  TfrmGeraNotaDebito = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    pnlBotoesBaixa: TPanel;
    edtNomCli: TEditFocus;
    Label20: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    pgbProgresso: TcxProgressBar;
    btnConfirma: TBitBtnLocked;
    edtNomPor: TEditFocus;
    edtCodPor: TEditFocus;
    Label4: TLabel;
    btnSairAgrup: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    Label5: TLabel;
    edtPorAgr: TEditFocus;
    edtNomPorAgr: TEditFocus;
    btnRegraAgrup: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    Label6: TLabel;
    cbxImpAG: TComboBoxFocus;
    rdgOpcoes: TRadioGroup;
    edtEspDoc: TEditFocus;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairAgrupClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure edtPorAgrKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnRegraAgrupClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    sltNumAgr: TStringList;

    qryGenRec: TUniQuery;
    qryConEmp: TUniQuery;
    qryConCli: TUniQuery;
    qryConPor: TUniQuery;
    cdsCtaRec: TUniClientDataSet;

    strNumAgr: String;

    blnFecharTela: Boolean;

    FAgrVen    : String;
    strEmpDuplic: String;
    blnConfirma: Boolean;
    objLock: TLock;

    strEmpCod: String;

    arrDuplicata: TarrDuplicata;

    procedure pLimpaDados;
    procedure pSelecionaDuplicata;
    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pMarcaTodasDuplicatas;

    procedure pAgruparDuplicatas;

    function fDeletaDuplicatas(arrDupSel: Array Of TDuplicataCtr): Boolean;
    function fGravaAgrupamentos(strCodCli, strDtaVen: String; dtaDtaAgr: TDateTime; strConPag: String): Boolean;

    procedure pCarregaCliente;
    procedure pCarregaEmpresa;
    procedure pCarregaPortador(strCodPor: String; edtDescri: TEditFocus);
    function fVerificaExiste: Boolean;
    function fExisteDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String; intSeqBai: Integer): Boolean;
    procedure pRetornaTotal(strCodCli, strDtaVen: String; Var fltTotCli: Double);
    function fCriaClientCtaRec(strFiltro: String = ''): TUniClientDataSet;
    function fVerificaDuplicatasClientes: Boolean;
    function fCriaListaClientesVencimentos: TStringList;
    procedure pConcluirAgrupamento;
    function fLockedByCurrentConnection(strChaLck: String): Boolean;
    function fUtilizaCredEmpresa(): Boolean;
    function fGetDataDeCadastro: TDateTime;
  protected
    function fCriaTemporaria: Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public

  published
    property strAgrVen: String read FAgrVen write FAgrVen;

  end;


implementation

uses untPesqAux, untConsultas, untFuncoes, untPai,
     untCadConfRelatorios, untCtrAgrupDupRecibo, untCadRec, untDuplicatas,
     untAtualizaOcorrenciasCRM, untTypesCRM, untTEnvioEmail, untGravando;

{$R *.dfm}

{ TfrmGeraNotaDebito }

function TfrmGeraNotaDebito.fCriaClientCtaRec(strFiltro: String = ''): TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Self);
  With Result Do
  Begin
    Data := cdsCtaRec.Data;
    If Not fEmptyStr(strFiltro) Then
    Begin
      Filtered := False;
      Filter := strFiltro;
      Filtered := True;
    End;
  End;
End;

{**************************************}
{* CRIA UM STRING LIST COM OS CODIGOS *}
{* DOS CLIENTES SELEC. NAS DUPLICATAS *}
{***********************************AN*}
function TfrmGeraNotaDebito.fCriaListaClientesVencimentos: TStringList;
var
  cdsGen: TUniClientDataSet;
  strCliVen: String;
Begin
  cdsGen := fCriaClientCtaRec('CTR_MARDES = ' + QuotedStr('M'));
  With cdsGen Do
  Begin
    IndexFieldNames := 'CTR_CODCLI;CTR_DTAVEN';

    Result := TStringList.Create;
    Result.Sorted := True;
    Result.Duplicates := dupIgnore;

    Result.Clear;

    strCliVen := '';
    First;

    While Not Eof Do
    Begin
      strCliVen := FieldByName('CTR_CODCLI').AsString +
                   FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAVEN').AsDateTime);

      Result.Add(strCliVen);

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
function TfrmGeraNotaDebito.fVerificaDuplicatasClientes: Boolean;
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
      pMensagensErro(E.Message, '[TfrmGeraNotaDebito.fVerificaDuplicatasClientes]');
  End;

  FreeAndNil(stlCliVenc);
  FreeAndNil(cdsGen);
end;

function TfrmGeraNotaDebito.fUtilizaCredEmpresa: Boolean;
  Var
    cdsDupSel: TUniClientDataSet;
    strAuxEmp: String;
begin
  Result := False;

  If Not fCfgSis('EMPORI', VarBoolean) Then
    Exit;

  cdsDupSel          := TUniClientDataSet.Create(nil);
  pCloneDataSet(cdsDupSel, cdsCtaRec);

  Try
    cdsDupSel.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
    cdsDupSel.Filtered := True;
    cdsDupSel.IndexFieldNames := 'CTR_CODEMP';

    strEmpCod := '';
    strAuxEmp := '';
    While Not cdsDupSel.Eof Do
    Begin
      If ((cdsDupSel.FieldByName('CTR_ESPDOC').AsString = 'CC') Or (cdsDupSel.FieldByName('CTR_VALDUP').AsFloat < 0)) And
         (VS_strCodEmp <> cdsDupSel.FieldByName('CTR_CODEMP').AsString) Then
      Begin
        Result := True;

        If strAuxEmp <> cdsDupSel.FieldByName('CTR_CODEMP').AsString Then
        Begin
          strEmpCod := strEmpCod + cdsDupSel.FieldByName('CTR_CODEMP').AsString + ', ';
          strAuxEmp := cdsDupSel.FieldByName('CTR_CODEMP').AsString;
        End;
      End;

      cdsDupSel.Next;
    End;

    strEmpCod := Copy(strEmpCod, 1, Length(strEmpCod) - 2); // Para remover a vírgula adicional do final

  Finally
    FreeAndNil(cdsDupSel);
  End;
end;

function TfrmGeraNotaDebito.fValidaCampos(Sender: TWinControl;
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
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&O k']);
        Result := False;
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
      End;
    End

    {*****************************************}
    {* VALIDA A DATA FINAL                   *}
    {**************************************MV*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If StrToDateDef(mskDtaFin.Text, 0) <= 0 Then
        Begin
          fMensagem('', 'Data final informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A Data inicial deve ser digitada!', ['&Ok']);
        blnMudarFoco := False;
        pSetFocus(mskDtaIni);
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

      If (Result) And (Not fEmptyStr(edtCodPor.Text)) Then
      Begin
        pCarregaPortador(edtCodPor.Text, edtNomPor);
        If fEmptyStr(edtNomPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
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
        Else If Not fEmpresaTemAcessoPortador(edtPorAgr.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtEspDoc) Then
    begin
      If (not fEmptyStr(edtEspDoc.Text)) and (Length(edtEspDoc.Text) <> 2) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espécie deve ter exatamente 2 caracteres!', ['&O k']);
        Result := False;
      End
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmGeraNotaDebito.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmGeraNotaDebito.FormCreate(Sender: TObject);
begin
  inherited;
  pZeraDigDuplic(arrDuplicata);
  sltNumAgr := TStringList.Create;

  qryGenRec := fCriaQuery(Self);

  pZeraDigDuplic(arrDuplicata);

  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConPor := fCriaQuery(Self);

  cdsCtaRec := TUniClientDataSet.Create(Self);

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;

  edtCodPor.Text := fCfgSis('PCTNDR');
  edtNomPor.Text := fRetNomPortador(edtCodPor.Text);

  blnFecharTela := False;

  edtPorAgr.Text := fCfgSis('PCTRAG');
  edtNomPorAgr.Text := fRetNomPortador(edtPorAgr.Text);
  objLock := TLock.Create;

end;

function TfrmGeraNotaDebito.fCriaTemporaria: Boolean;
  Var
    strSQL: String;
    qryCtaRec: TUniQuery;
    dspCtaRec: TUniDataSetProvider;
begin
  Result := False;
  Try
    cdsCtaRec.Close;
    qryCtaRec := fCriaQuery(Self);
    dspCtaRec := TUniDataSetProvider.Create(Self);
    dspCtaRec.DataSet := qryCtaRec;
    cdsCtaRec.SetProvider(dspCtaRec);

    strSQL := '';
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
    strSQL := strSQL + '  R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IFNULL(R.CTR_DESSUJ, 0) AS CTR_VALCOR, ';
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
    strSQL := strSQL + '  CTR_SEQMPX   ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI C ';
    strSQL := strSQL + '  JOIN CADREC R ON R.CTR_CODCLI = C.CLI_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADPOR P ON R.CTR_CODPOR = P.POR_CODPOR ';
    strSQL := strSQL + '  LEFT JOIN FATGOR ON FATGOR.FGO_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '                  AND FATGOR.FGO_NUMDOC = CTR_NUMDUP ';
    strSQL := strSQL + '                  AND FATGOR.FGO_ESPDOC = CTR_ESPDOC ';
    strSQL := strSQL + '                  AND FATGOR.FGO_CODEMP = CTR_CODEMP ';
    strSQL := strSQL + '  LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (R.CTR_DTAENV IS NULL OR R.CTR_DTAENV = 0) AND ';

    strSQL := strSQL + ' (IFNULL(FGO_BOLADT, 0.00) = 0.00) AND ';

    If Not fEmptyStr(fCfgSis('POOCRE')) Then
      strSQL := strSQL + 'IF((R.CTR_VALDUP < 0),IFNULL(R.CTR_CODPOR,"") <> ' + String(fCfgSis('POOCRE')).QuotedString + ',TRUE) AND ';

    strSQL := strSQL + '  IF(CTR_BCOBOL = "778", TRUE, (R.CTR_NOSNUM IS NULL OR R.CTR_NOSNUM = "")) AND ';
    strSQL := strSQL + '  R.CTR_DTAREC IS NULL AND ';

    strSQL := strSQL + '  R.CTR_ESPDOC <> "AG" AND ';

    If (not fEmptyStr(edtEspDoc.Text)) Then
      strSQL := strSQL + '  R.CTR_ESPDOC = :ESPDOC AND ';

    strSQL := strSQL + '  R.CTR_SEQBAI = 0 AND ';
    strSQL := strSQL + '  R.CTR_DTAVEN >= :DTAVEN ';

    {*****************************************************}
    {* VERIFICA PERMISSÃO DE AGRUPAMENTO DE CRÉDITO "CC" *}
    {* RQ 28259 ***************************************BB*}
    If Not fCfgSis('AGP_CC', varBoolean) Then
      strSQL := strSQL + ' AND R.CTR_VALDUP > 0.00 ';

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      strSQL := strSQL + '  AND R.CTR_CODEMP = :CODEMP ';

    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + '  AND R.CTR_CODCLI = :CODCLI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND R.CTR_CODPOR = :CODPOR ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + '  AND R.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

    strSQL := strSQL + '  AND R.CTR_TX_PIX IS NULL ';

    With qryCtaRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (not fEmptyStr(edtEspDoc.Text)) Then
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;

      ParamByName('DTAVEN').AsDateTime := VS_Date;

      If (Not fEmptyStr(edtCodEmp.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmp.Text;

      If Not fEmptyStr(edtCodCli.Text) Then
        ParamByName('CODCLI').AsString := edtCodCli.Text;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
      End;
      Open;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCtaRec);
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
      pMensagensErro(E.Message, '[TfrmGeraNotaDebito.fCriaTemporaria]');
  End;

  cdsCtaRec.SetProvider(nil);
  FreeAndNil(dspCtaRec);
  FreeAndNil(qryCtaRec);
end;

procedure TfrmGeraNotaDebito.pLimpaDados;
begin
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  edtCodCli.Clear;
  edtNomCli.Clear;

  cdsCtaRec.Close;
end;

procedure TfrmGeraNotaDebito.pSelecionaDuplicata;
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
    fMensagem('','Essa duplicata ja foi agrupada!',['&OK']);
    pMarcaDuplicata(False);
  End

  Else If cdsCtaRec.FieldByName('CTR_MARDES').AsString <> 'M' Then
    pMarcaDuplicata(True);
end;

procedure TfrmGeraNotaDebito.pMarcaDuplicata(blnMarcar: Boolean);
  Var
    strChaLck: String;
    strInfDup : String;
begin
  strChaLck := '';
  strInfDup := '';

  strChaLck := 'CADREC' +
             cdsCtaRec.FieldByName('NRODUP').AsString +
             cdsCtaRec.FieldByName('CTR_ESPDOC').AsString +
             cdsCtaRec.FieldByName('CTR_CODEMP').AsString +
             cdsCtaRec.FieldByName('CTR_CODCLI').AsString;

  If blnMarcar Then
  Begin
    strInfDup := cdsCtaRec.FieldByName('NRODUP').AsString + '-' +
                 cdsCtaRec.FieldByName('PARDUP').AsString + '-' +
                 cdsCtaRec.FieldByName('CTR_ESPDOC').AsString +  '-' +
                 cdsCtaRec.FieldByName('CTR_CODEMP').AsString +  '-' +
                 cdsCtaRec.FieldByName('CTR_CODCLI').AsString;

    If (Not fLockedByCurrentConnection(strChaLck)) Then
    Begin
      If Not objLock.fLock_Unlock(strChaLck, True, False, False, '',True,'') Then
      Begin
        fMensagem('ATENÇÃO!', 'Este documento ('+strInfDup+') está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck), ['&OK']);
        Exit;
      End;
    End;

    strChaLck := strChaLck + cdsCtaRec.FieldByName('PARDUP').AsString;
    If Not objLock.fLock_Unlock(strChaLck, True, False, False, '',True,'') Then
    Begin
      fMensagem('ATENÇÃO!', 'Este documento ('+strInfDup+') está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck), ['&OK']);
      Exit;
    End;
  End
  Else
  Begin
    objLock.fLock_Unlock(strChaLck, False);
    objLock.fLock_Unlock(strChaLck + cdsCtaRec.FieldByName('PARDUP').AsString, False);
  End;

  With cdsCtaRec Do
  Begin
    Edit;
    FieldByName('CTR_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
    Post;
  End;
end;

procedure TfrmGeraNotaDebito.edtCodCliKeyPress(Sender: TObject;
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

procedure TfrmGeraNotaDebito.pConcluirAgrupamento;
 var
    intCont: integer;
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
      If sltNumAgr.Count > 1 Then
      Begin
        For intCont := 0 To sltNumAgr.Count - 1 Do
          frmCtrAgrupDupRecibo.pImprimeComprovante(sltNumAgr[intCont], Self.Name, 1,blnBolPdf);
      End
      Else
        frmCtrAgrupDupRecibo.pImprimeComprovante(sltNumAgr.CommaText, Self.Name, 1,blnBolPdf);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[Erro ao salvar comprovante agrupamento contas a receber]');
    End;

    If blnEnvMai Then //opçoes [2,3]
    Begin
      LDadosEnvioEmail:= TDadosEnvioEmail.Create;

       //Opção 2
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
              frmCtrAgrupDupRecibo.pImprimeComprovante(sltNumAgr.CommaText, Self.Name);
            Except
            On E: Exception Do
               pMensagensErro(E.Message, '[Erro ao imprimir comprovante agrupamento contas a receber]');
            End;
            pFreeAndNil(frmCtrAgrupDupRecibo);
         End;
       End;

      FreeAndNil(LDadosEnvioEmail);
    End;

    pDestroiModulo(frmCtrAgrupDupRecibo);
  end
  else
  If (fMensagem('Impressão', 'Deseja imprimir um comprovante?', ['&Sim', '&Não']) = 1) Then
  Begin
    Try
      pCriarFormularios(TfrmCtrAgrupDupRecibo, frmCtrAgrupDupRecibo);
      frmCtrAgrupDupRecibo.blnImprimePorNomCli := IIF(cbxImpAG.ItemIndex = 0, False, True);
      frmCtrAgrupDupRecibo.pImprimeComprovante(sltNumAgr.CommaText, Self.Name);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[Erro ao imprimir comprovante agrupamento contas a receber]');
    End;
    pFreeAndNil(frmCtrAgrupDupRecibo);
  End;

    fMensagem('','Agrupamento(s) n° ' + AnsiReplaceStr(sltNumAgr.CommaText,',',', ') + ' gerado(s) com sucesso!', ['&O k']);
    objLock.pDestravarTodos;
End;

procedure TfrmGeraNotaDebito.pAgruparDuplicatas;
  Var
    strCndPag : String;
    fltTotCli : Double;
    intCont   : Integer;
    stlCliVenc: TStringList;
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
    If (Not fEmptyStr(sltNumAgr.CommaText)) Then
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
  blnConfirma := False;

  blnSabDomFeriadosComoDiaUtil := fCfgSis('FSDUDP', varBoolean);
  sltNumAgr.Clear;

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

      strCndPag := fRetCondicaoPagtoFaixaValor(fltTotCli,False,IIF((fCfgSis('FAICND', varString) = '1'),'FAICND','CNDGND'));

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
      If (fGravaAgrupamentos(strCodCli, strDtaVen, fGetDataDeCadastro, strCndPag)) And (stlCliVenc.Count > 1) Then
        pDeletaDuplicatasBackup;
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
  If blnConfirma And (Not fEmptyStr(sltNumAgr.CommaText)) Then
  Begin
     strMsg := '';
     strMsg := ifthen( (rdgOpcoes.ItemIndex in [1, 2, 3]) ,'Aguarde, Realizando Agrupamento...Gerando Arquivos...','Aguarde, Realizando Agrupamento...');

     TfrmGravando.fExecutarModalA(pConcluirAgrupamento, strMsg, '');
  End;

  For intCont := 0 To stlMsgErro.Count -1 Do
    pMensagemOk(stlMsgErro[intCont]);

  pLimpaDados;
  pSetFocus(edtCodEmp);

  FreeAndNil(stlCliVenc);
  FreeAndNil(stlMsgErro);
  FreeAndNil(cdsCtrBkp);

end;

procedure TfrmGeraNotaDebito.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos And fCriaTemporaria Then
  Begin
    pMarcaTodasDuplicatas;

    If (cdsCtaRec.IsEmpty) Or (Not fVerificaDuplicatasClientes) Then
      Exit;

    If fUtilizaCredEmpresa Then
    Begin
      fMensagem('ATENÇÃO!', 'O(s) crédito(s) selecionado(s) pertence(m) a(s) empresa(s) '+ strEmpCod + #13 +
                            'e o mesmo só poderá ser utilizado na empresa de origem.', ['&OK']);
      objLock.pDestravarTodos;
      Exit;
    End;

    If (fCfgSis('DTAAGN') = '2') And
        Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And
        (StrToDateTime(mskDtaFin.Text) > VS_Date) Then
    Begin
      fMensagem('ATENÇÃO!', 'Data Final informada no filtro do período é posterior a hoje. O AG será cadastrado com a data ' + FormatDateTime('dd/mm/yyyy', VS_Date),['&Ok']);
    End;

    If Not fVerificaExiste Then
      fMensagem('','Existem duplicatas selecionadas que ja foram agrupadas!',['&OK'])
    Else
    Begin
      If (fMensagem('', 'Confirma agrupamento?', ['&Sim', '&Não']) = 1) Then
        pAgruparDuplicatas
      Else
        objLock.pDestravarTodos;
    End;

    if not blnConfirma Then
      pnlInfo.Caption := '';
  End;

end;

procedure TfrmGeraNotaDebito.btnRegraAgrupClick(Sender: TObject);
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

function TfrmGeraNotaDebito.fGetDataDeCadastro: TDateTime;
  Var
    FCfgDtaAgr : String;
begin
  Result := VS_Date;
  FCfgDtaAgr := fCfgSis('DTAAGN'); //'Data para Geração de Nota de Débito (AG) - CONTAS A RECEBER'


  Case StrToInt(FCfgDtaAgr) Of
    1 :  Result := VS_Date;
    2 :  Begin
           Result := IIF(fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)),VS_Date,StrToDateTime(mskDtaFin.Text));
           If (Result > VS_Date) Then
           Begin
             Result := VS_Date;
           End;
         End;
  End;

end;

function TfrmGeraNotaDebito.fGravaAgrupamentos(strCodCli, strDtaVen: String; dtaDtaAgr: TDateTime; strConPag: String): Boolean;
  Var
    intContador: Integer;
    intTamAnt: Integer;
    blnDescontoAteVencimento: Boolean;
    dagAgrup: TDadosAgrup;
    arrDupSel: Array Of TDuplicataCtr;
    fltTotAgr: Double;
    strDupAgr: String;
    cdsGenCtr: TUniClientDataSet;
    fltValDes: Double;
    qryConVen:TUniquery;

  function fFiltro: String;
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
  {************************************************}
  {* RETORNA VALOR TOTAL DAS DUPLICATAS AGRUPADAS *}
  {*********************************************AC*}
  pRetornaTotal(strCodCli, strDtaVen, fltTotAgr);

  Screen.Cursor := crHourGlass;

  strNumAgr   := fSeqAgrupamentoCtr;

  {***************************************************}
  {* CRIANDO UM CLIENTDATASET COM OS DADOS DO PADRAO *}
  {* DO FORM PARA CONCLUIR O AGRUPAMENTO DE DUPLIC   *}
  {************************************************AN*}
  cdsGenCtr := fCriaClientCtaRec(fFiltro);

  blnDescontoAteVencimento := fCfgSis('UTDEFN') = '2';

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
                                                     afcGeraNotaDebito);
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
                                      FieldByName('CTR_VALCOM').AsFloat/fltTotAgr,
                                      FieldByName('CTR_VALCOR').AsFloat/fltTotAgr,
                                      FieldByName('CTR_VALDES').AsFloat,
                                      FieldByName('CTR_JURATR').AsFloat + FieldByName('CTR_JURREP').AsFloat,
                                      strConPag,
                                      FieldByName('CTR_CODREP').AsString,
                                      FieldByName('CTR_COMREP').AsFloat,
                                      FieldByName('CTR_COMREP').AsFloat/fltTotAgr,
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
                                                     afcAgrupaDuplicatas, True);
          End;

          Next;
          Application.ProcessMessages;

        End;
      End;

    Except
      On E: Exception Do
      Begin
        blnConfirma := FALSE;
        fRollBack;
        pMensagensErro(E.Message, '[untGeraNotaDebito - dbgDuplicatasKeyDown]');
      End;
    End;

  End;

  If blnConfirma Then
  Begin
    sltNumAgr.Add(strNumAgr);
    fCommit;
  End else
    fRollBack;

  Result := blnConfirma;
  Screen.Cursor := crDefault;
  FreeAndNil(cdsGenCtr);
end;

function TfrmGeraNotaDebito.fDeletaDuplicatas(
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

procedure TfrmGeraNotaDebito.btnSairAgrupClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmGeraNotaDebito.btnConfigurarClick(Sender: TObject);
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

procedure TfrmGeraNotaDebito.pMarcaTodasDuplicatas;
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

procedure TfrmGeraNotaDebito.edtCodEmpKeyPress(Sender: TObject;
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

procedure TfrmGeraNotaDebito.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPortador: TConsultasArray;
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
                     True,
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

procedure TfrmGeraNotaDebito.edtPorAgrKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmGeraNotaDebito.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmGeraNotaDebito.pCarregaPortador(strCodPor: String; edtDescri: TEditFocus);
begin
  pPesquisaCadPor(Nil, qryConPor, strCodPor);
  With qryConPor Do
  Begin
    edtDescri.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmGeraNotaDebito.pRetornaTotal(strCodCli, strDtaVen: String; Var fltTotCli: Double);
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

procedure TfrmGeraNotaDebito.FormDestroy(Sender: TObject);
begin
  inherited;         
  sltNumAgr.Clear;
  sltNumAgr.Free;
  objLock.pDestravarTodos;
  FreeAndNil(objLock);
end;

procedure TfrmGeraNotaDebito.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_F10 Then
    btnConfirma.Click;
end;

procedure TfrmGeraNotaDebito.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharTela Then
    Close;
end;

function TfrmGeraNotaDebito.fVerificaExiste: Boolean;
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

function TfrmGeraNotaDebito.fExisteDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String; intSeqBai: Integer): Boolean;
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

function TfrmGeraNotaDebito.fLockedByCurrentConnection(
  strChaLck: String): Boolean;
begin
  Result := (fGetIdConnectionLock(strChaLck) = fGetConnectionID) And
            (fGetIPConnectionLock(strChaLck) = GetIPAddressAsString);
end;

end.


