unit untCtpAtribPortador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  ComCtrls, untGravando,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, QColorLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, untFrameCentroCustoEditFocus, untTypesSistema, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid,untCadPag,untFuncoesConsulta, untFramePlanoDeContasMaskEdit,
  cxCurrencyEdit, CurrencyEditFocus;


type
  TfrmCtpAtribPortador = class(TfrmPaiOrdena)
    Label1: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    prbProgresso: TProgressBar;
    btnConfirma: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    ColorLabel2: TColorLabel;
    Label11: TLabel;
    Label4: TLabel;
    ColorLabel1: TColorLabel;
    Label5: TLabel;
    ColorLabel3: TColorLabel;
    Label6: TLabel;
    ColorLabel4: TColorLabel;
    Label7: TLabel;
    ColorLabel5: TColorLabel;
    edtCheque: TEditFocus;
    edtVeioNF: TEditFocus;
    edtDeposito: TEditFocus;
    btnCarrContas: TBitBtnLocked;
    edtVeiobo: TEditFocus;
    edtPrevisao: TEditFocus;
    pnlPeriodo: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    rdgPeriodo: TRadioGroup;
    mskDtaFin: TcxDateEdit;
    mskDtaIni: TcxDateEdit;
    fraCentroCusto: TfraCentroCustoEditFocus;
    grdConsultaDBTableView1: TcxGridDBTableView;
    grdConsultaLevel1: TcxGridLevel;
    grdConsulta: TcxGrid;
    grdConsultaDBTableView1CTP_NUMDUP: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_SERIE_: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_CODEMP: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_CODFOR: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_NOMFOR: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_DTACAD: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_DTAVEN: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_CODPOR: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_CODEVE: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_CODCTA: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_VEIOBO: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_VEIONF: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_USACHQ: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_PREVIS: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_DEPOSI: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_VALORI: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_JURSUJ: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_MULSUJ: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_VENDOR: TcxGridDBColumn;
    grdConsultaDBTableView1CTP_DESSUJ: TcxGridDBColumn;
    grdConsultaDBTableView1AUTOINCREM: TcxGridDBColumn;
    grdConsultaDBTableView1TABELA: TcxGridDBColumn;
    btnHistDocumentos: TBitBtnLocked;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    rdgStatus: TRadioGroup;
    Label8: TLabel;
    edtCodPort: TEditFocus;
    edtNomPort: TEditFocus;
    Label9: TLabel;
    Label10: TLabel;
    edtHist1: TEditFocus;
    Label12: TLabel;
    edtHist2: TEditFocus;
    edtVlrOrig: TCurrencyEditFocus;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCarrContasClick(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure grdConsultaDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grdConsultaDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnHistDocumentosClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure rdgStatusClick(Sender: TObject);
    procedure edtCodPortKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    strCodPor,
    strCodEve,
    strVeiobo,
    strVeioNF,
    strUsaChq,
    strDeposi,
    strPrevis,
    APlanoDeContas,
    strDtaCad,
    strDtaVen,
    strValDup,
    strCompet,
    strHistor: String;
    strEmp   : String;
    qryCadEmp, qryCadFor, qryConCta,
    qryCadPor  //MF 20/04/2023 - 286028 - INI
    : TUniQuery;
    ACdsCtpDet: TUniClientDataSet;
    arrEmp      : TConsultasArray;
    arrCentCusto: TConsultasArray;
    strCentCusto: String;
    Function fAtribuiPortador: Boolean;
    procedure pCarregaFornecedor;
    procedure pCarregaEmpresa;
    procedure pFechaConsulta;
    procedure pConfirma;
    procedure pCarregaCentroCusto;
    function fInListaInterno(strChave: String): Boolean;
    procedure pHabilitaFiltroBaixa;
    function TravarAlteracaoDeCamposPrincipaisDaNotaDeEntrada(ADuplicatas: String):Boolean ;
    procedure pCarregaPortador;

    function RetornaListaEmpresasMarcados(AAutoIncremsCadPag: String): TStringList;
  public
    { Public declarations }
  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAbreConsulta(blnLike: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; override;
    function fSetParametros: Boolean; override;
    Function fRetChaveLista: String; override;
    function fValidaChqBolDep(Sender: TWinControl): Boolean;
    procedure AbreConsulta;
  end;


implementation

uses untPai, untConsultas, untConstantes, untFuncoesSimples, untPesqAux, StrUtils,
  untCtpAtribConf, untLogCtp, untFuncoes, untRelCtpLogAcompDuplicNovo;

{$R *.dfm}

function TfrmCtpAtribPortador.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
 Var
     LOpeSemAcesso : String;
begin
  Result := True;
  LOpeSemAcesso := '';

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR         *}
    {**************************************MV*}
    If (Sender = edtCodFor) Then
    Begin
      If (Not fEmptyStr(edtCodFor.Text)) Then
      Begin
        pCarregaFornecedor;
        If (qryCadFor.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomFor.Text := 'TODOS';
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO PORTADOR           *}
    {**************************************MF*}
    //MF 20/04/2023 - 286028 - INI
    Else If (Sender = edtCodPort) Then
    Begin
      If (Not fEmptyStr(edtCodPort.Text)) Then
      Begin
        pCarregaPortador;
        If (qryCadPor.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomPort.Text := 'TODOS';
      End;
    End
    //MF 20/04/2023 - 286028 - INI

    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************LB*}
    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);
        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        fraCentroCusto.edtDesEve.Text := 'TODOS';
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := 'TODAS';
      End
      Else
      Begin

        If Not SameText(edtCodEmp.Text, '000') Then
        Begin
          SetLength(arrEmp, 0);
          strEmp := '';

           pCarregaEmpresa;
           If (qryCadEmp.FieldByName('EMP_CODEMP').IsNull) Then
           Begin
             fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
             Result := False;
           End
           Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
           Begin
             fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
             Result := False;
           End;
        End
        Else
        If Length(arrEmp) > 0 Then
        Begin
          If Not fUsuarioTemAcessoEmpresa(strLoginUsuarioLogado,arrEmp,LOpeSemAcesso) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a(s) empresa(s) informada(s): '+ LOpeSemAcesso +'. Operação abortada!', ['&OK']);
            Result := False;
          End;
        End;

      End;

    End

    {*****************************************}
    {* VALIDA A DATA INICIAL                 *}
    {**************************************MV*}
    Else If (Sender = mskDtaIni) Then
    Begin

      If blnBuscaPorChave Then
        mskDtaFin.Clear;

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        //MF 20/04/2023 - 286028 - INI
        //If (fEmptyStr(edtHist1.Text)) and (fEmptyStr(edtHist2.Text)) Then
        //Begin
        //MF 20/04/2023 - 286028 - COMENTEI AS DUAS LINHAS ABAIXO, POIS APÓS DESABILITAR, O CAMPO NÃO É HABILITADO NOVAMENTE
          //mskDtaFin.Enabled     := False;
          //rdgPeriodo.Enabled := False;
        //End//MF 20/04/2023 - 286028
      End
      Else
      Begin
        mskDtaFin.Enabled     := True;
        rdgPeriodo.Enabled := True;
        pHabilitaFiltroBaixa();
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
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {***************************************}
    {* VALIDA CENTRO DE CUSTO              *}
    {************************************JU*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin

        If fraPlanoDeContas.MskCodCta.Text <> '0' Then
           pCarregaCentroCusto;

        if fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
           fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
           Result := False;
        End;
      End
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Text := 'TODOS';
      End;
    End
    Else If ((Sender = edtVeiobo) And edtVeiobo.Enabled) Or
            ((Sender = edtVeioNF) And edtVeioNF.Enabled) Or
            ((Sender = edtCheque) And edtCheque.Enabled) Or
            ((Sender = edtPrevisao) And edtPrevisao.Enabled) Or
            ((Sender = edtDeposito) And edtDeposito.Enabled) Then
    Begin
      Result := fValidaChqBolDep(Sender);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCtpAtribPortador.fValidaChqBolDep(Sender: TWinControl): Boolean;
begin
  Result := True;

  If Pos(TEditFocus(Sender).Text, 'SNT') <= 0 Then
  Begin
    Result := False;
    fMensagem('','O campo deve ser informado com (S)im, (N)ão ou (T)odos!', ['&Ok']);
  End;
end;


procedure TfrmCtpAtribPortador.grdConsultaDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (AViewInfo.Item.Caption = 'Vencimento') AND not AViewInfo.Selected then
  Begin
    ACanvas.Brush.Color:= clInfoBk;
    ACanvas.Font.Color:= clWindowText;
  End;

  If cdsConsulta.IsEmpty Then
    Exit;

  If (blnTemSelecao Or (Assigned(stlListSelecao) And (stlListSelecao.Count > 0))) And
    fInListaInterno(
      VarToStr(AViewInfo.GridRecord.Values[grdConsultaDBTableView1.GetColumnByFieldName('AUTOINCREM').Index]) +
      VarToStr(AViewInfo.GridRecord.Values[grdConsultaDBTableView1.GetColumnByFieldName('TABELA').Index])
    ) Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Font.Color := clHighLightText
    else
      ACanvas.Brush.Color := intCorSelecao;
  End;
end;

procedure TfrmCtpAtribPortador.grdConsultaDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
    dbgConsultaDblClick(Sender);
end;

procedure TfrmCtpAtribPortador.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryCadFor, qryCadFor, edtCodFor.Text);
  With qryCadFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

//MF 20/04/2023 - 286028 - INI
procedure TfrmCtpAtribPortador.pCarregaPortador;
begin
  pPesquisaCadPor(qryCadPor, qryCadPor, edtCodPort.Text);
  With qryCadPor Do
  Begin
    edtNomPort.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;
//MF 20/04/2023 - 286028 - FIM

procedure TfrmCtpAtribPortador.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryCadEmp, qryCadEmp, edtCodEmp.Text);
  With qryCadEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmCtpAtribPortador.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

//MF 20/04/2023 - 286028 - INI
procedure TfrmCtpAtribPortador.edtCodPortKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPort: TConsultasArray;
begin
  inherited;

  If fPesqPortador(conSimples,
                     Self,
                     edtCodPort,
                     edtNomPort,
                     nil,
                     Key,
                     arrPort,
                     True,
                     'Consulta de Portadores') Then
  Begin
    If fValidaCampos(edtCodPort, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;
//MF 20/04/2023 - 286028 - FIM

procedure TfrmCtpAtribPortador.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, false) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

Function TfrmCtpAtribPortador.fAbreConsulta(blnLike: Boolean = True): Boolean;
Begin
  Result := False;
  If fVerificaCampos Then
  Begin
    stlListSelecao.Clear;
    Result := inherited fAbreConsulta;
  End;
End;

function TfrmCtpAtribPortador.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
    strCmpPort: String;//MF 20/04/2023 - 286028
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  P.AUTOINCREM, ';
  strSQL := strSQL + '  CONCAT(CTP_NUMDUP, CTP_PARCEL) AS CTP_NUMDUP, ';
  strSQL := strSQL + '  CTP_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '  CTP_PARCEL, ';
  strSQL := strSQL + '  CTP_SERIE_, ';
  strSQL := strSQL + '  CTP_CODEMP, ';
  strSQL := strSQL + '  CTP_CODFOR, ';
  strSQL := strSQL + '  FOR_NOMFOR AS CTP_NOMFOR, ';
  strSQL := strSQL + '  CTP_DTACAD, ';
  strSQL := strSQL + '  CTP_DTAVEN, ';
  strSQL := strSQL + '  CTP_CODPOR, ';
  strSQL := strSQL + '  CTP_VALORI, ';
  strSQL := strSQL + '  CTP_JURSUJ, ';
  strSQL := strSQL + '  CTP_MULSUJ, ';
  strSQL := strSQL + '  CTP_VENDOR, ';
  strSQL := strSQL + '  CTP_DESSUJ, ';
  strSQL := strSQL + '  CTP_CODEVE, ';
  strSQL := strSQL + '  CTP_VEIOBO, ';
  strSQL := strSQL + '  CTP_VEIONF, ';
  strSQL := strSQL + '  CTP_USACHQ, ';
  strSQL := strSQL + '  CTP_DEPOSI, ';
  strSQL := strSQL + '  CTP_PREVIS, ';
  strSQL := strSQL + '  CTP_CODCTA, ';
  //MF 20/04/2023 - 286028 - INI
  strSQL := strSQL + '  CTP_PORBAI, ';
  strSQL := strSQL + '  CTP_HIST01, ';
  strSQL := strSQL + '  CTP_HIST02, ';
  //MF 20/04/2023 - 286028 - INI
  strSQL := strSQL + QuotedStr('CADPAG') + ' AS TABELA ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + 'CADPAG AS P ';
  strSQL := strSQL + 'INNER JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR  ';

  strSQL := strSQL + 'WHERE ';

  // Baixadas
  If rdgStatus.ItemIndex = 1 Then
  Begin
     strSQL := strSQL + ' CTP_DTAPAG IS NOT NULL AND IFNULL(CTP_VALPAG,0) <> 0 ';
     strCmpPort := 'CTP_PORBAI';//MF 20/04/2023 - 286028
  End
  Else
  Begin
    strSQL := strSQL + '  CTP_DTAPAG IS NULL AND ';
    strSQL := strSQL + '  CTP_SEQBAI = 0         '; /// ?????
    strCmpPort := 'CTP_CODPOR';//MF 20/04/2023 - 286028
  End;

  If Not fEmptyStr(edtCodFor.Text) Then
    strSQL := strSQL + '  AND CTP_CODFOR = :CODFOR ';

  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    strSQL := strSQL + '  AND CTP_CODEVE = :CODEVE ';

  If (Not fEmptyStr(edtCodEmp.Text)) Then
    strSQL := strSQL + fStrLocate(edtCodEmp, arrEmp, 'CTP_CODEMP', 'CODEMP')
  Else
    strSQL := strSQL + ' AND LOCATE(CTP_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin

     If rdgPeriodo.ItemIndex = 0 Then
        strSQL := strSQL + '  AND CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN '
     Else
     If rdgPeriodo.ItemIndex = 1 Then
        strSQL := strSQL + '  AND CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN '
     Else
     If rdgPeriodo.ItemIndex = 2 Then
        strSQL := strSQL + '  AND CTP_DTABAI BETWEEN :DTAINI AND :DTAFIN ';

  End;

  If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + '  AND (IFNULL(CTP_CODPOR, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If (edtVeiobo.Text <> 'T') Then
    strSQL := strSQL + '  AND CTP_VEIOBO = :VEIOBO ';

  If (edtVeioNF.Text <> 'T') Then
    strSQL := strSQL + '  AND CTP_VEIONF = :VEIONF ';

  If (edtPrevisao.Text <> 'T') Then
    strSQL := strSQL + '  AND CTP_PREVIS = :PREVIS ';

  If (edtCheque.Text <> 'T') Then
    strSQL := strSQL + '  AND CTP_USACHQ = :USACHQ ';

  If (edtDeposito.Text <> 'T') Then
    strSQL := strSQL + '  AND CTP_DEPOSI = :DEPOSI ';

  //MF 20/04/2023 - 286028 - INI
  If Not fEmptyStr(edtCodPort.Text) Then
    strSQL := strSQL + '  AND ' + strCmpPort + ' = :CODPOR ';

  If (Not fEmptyStr(edtVlrOrig.Text)) and (edtVlrOrig.Value > 0) Then
    strSQL := strSQL + '  AND CTP_VALORI = :VALORI ';

  If Not fEmptyStr(edtHist1.Text) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) or fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para realizar a busca por Histórico é necessário informar um Período de Datas!', ['&O k']);
      Abort;
    End
    else
      strSQL := strSQL + '  AND CTP_HIST01 LIKE :HIST01';

  End;

  If Not fEmptyStr(edtHist2.Text) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) or fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para realizar a busca por Histórico é necessário informar um Período de Datas!', ['&O k']);
      Abort;
    End
    else
      strSQL := strSQL + '  AND CTP_HIST02 LIKE :HIST02';
  End;
  //MF 20/04/2023 - 286028 - FIM

  strSQL := strSQL + fStrLocateLinGru(fraPlanoDeContas.MskCodCta, arrCentCusto, 'CTP_CODCTA', 'CODCTA');


  Result := strSQL;
End;

function TfrmCtpAtribPortador.fInListaInterno(strChave: String): Boolean;
begin
  If Assigned(stlListselecao) Then
    Result := (stlListselecao.IndexOf(strChave) > -1)
  Else
    Result := False;
end;

function TfrmCtpAtribPortador.fSetParametros: Boolean;
Begin

  With qryConsulta Do
  Begin

    If Not fEmptyStr(edtCodFor.Text) Then
      ParamByName('CODFOR').AsString := edtCodFor.Text;

    //MF 20/04/2023 - 286028 - INI
    If (Not fEmptyStr(edtCodPort.Text)) Then
      ParamByName('CODPOR').AsString := edtCodPort.Text;

    If (Not fEmptyStr(edtVlrOrig.Text)) and (edtVlrOrig.Value > 0) Then
      ParamByName('VALORI').AsFloat := fStrToFloat(edtVlrOrig.Text);

    If Not fEmptyStr(edtHist1.Text) Then
       ParamByName('HIST01').AsString := '%' + edtHist1.Text + '%';

    If Not fEmptyStr(edtHist2.Text) Then
       ParamByName('HIST02').AsString := '%' + edtHist2.Text + '%';
    //MF 20/04/2023 - 286028 - FIM

    If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      ParamByName('CODEVE').AsString := fraCentroCusto.edtCodEve.Text;

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryConsulta);

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    If (edtVeiobo.Text <> 'T') Then
       ParamByName('VEIOBO').AsString := edtVeiobo.Text;

    If (edtVeioNF.Text <> 'T') Then
      ParamByName('VEIONF').AsString := edtVeioNF.Text;

    If (edtPrevisao.Text <> 'T') Then
      ParamByName('PREVIS').AsString := edtPrevisao.Text;

    If (edtCheque.Text <> 'T') Then
      ParamByName('USACHQ').AsString := edtCheque.Text;

    If (edtDeposito.Text <> 'T') Then
      ParamByName('DEPOSI').AsString := edtDeposito.Text;

    pSetaParam(fraPlanoDeContas.MskCodCta.Text, arrCentCusto ,strCentCusto ,'CODCTA',qryConsulta);

  End;

  Result := True;
End;

procedure TfrmCtpAtribPortador.btnDesmarcaTodosClick(Sender: TObject);
  Var
    LFiltroAnterior: String;
begin
  inherited;

  Try
    LFiltroAnterior := cdsConsulta.Filter;

    cdsConsulta.Filter := grdConsultaDBTableView1.DataController.Filter.FilterText;
    cdsConsulta.Filtered := Not cdsConsulta.Filter.IsEmpty;

    If cdsConsulta.IsEmpty Then
    Begin
      fMensagem('', 'É necessário filtrar ao menos uma duplicata!', ['&Ok']);
      Exit;
    End;

    pDesmarcaTodos;
  Finally
    cdsConsulta.Filter := LFiltroAnterior;
    cdsConsulta.Filtered := Not LFiltroAnterior.IsEmpty;
    grdConsultaDBTableView1.DataController.Refresh;
  End;

end;

procedure TfrmCtpAtribPortador.btnHistDocumentosClick(Sender: TObject);
Var
  frmRelCtpLogAcompDuplicNovo : TfrmRelCtpLogAcompDuplicNovo;
begin
  inherited;
  Try
    pCriarFormularios(TfrmRelCtpLogAcompDuplicNovo, frmRelCtpLogAcompDuplicNovo);

    frmRelCtpLogAcompDuplicNovo.edtCodFornecedor.Text := edtCodFor.Text;
    frmRelCtpLogAcompDuplicNovo.edtCodEmpresa.Text := edtCodEmp.Text;

    If(Not fEmptyStr(mskDtaIni.Text)) And(Not fEmptyStr(mskDtaFin.Text)) Then
    Begin
      frmRelCtpLogAcompDuplicNovo.mskDtaIni.Text := mskDtaIni.Text;
      frmRelCtpLogAcompDuplicNovo.mskDtaFin.Text := mskDtaFin.Text;
      frmRelCtpLogAcompDuplicNovo.rdgData.ItemIndex := 0;
    End
    Else
    Begin
      frmRelCtpLogAcompDuplicNovo.mskDtaIni.Text := DateToStr(VS_DATE);
      frmRelCtpLogAcompDuplicNovo.mskDtaFin.Text := DateToStr(VS_DATE);
      frmRelCtpLogAcompDuplicNovo.rdgData.ItemIndex := 1;
    End;
    frmRelCtpLogAcompDuplicNovo.pnlOperador.Visible := True;
    frmRelCtpLogAcompDuplicNovo.edtCodOpe.Text := strLoginUsuarioLogado;
    frmRelCtpLogAcompDuplicNovo.blnVeioAtribPortador := True;
    frmRelCtpLogAcompDuplicNovo.pCarregaCampos;
    frmRelCtpLogAcompDuplicNovo.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCtpAtribPortador.btnHistDocumentos]');
  End;
  pFreeAndNil(frmRelCtpLogAcompDuplicNovo);
end;

procedure TfrmCtpAtribPortador.btnMarcaTodosClick(Sender: TObject);
  Var
    LFiltroAnterior: String;
begin
  inherited;

  Try
    LFiltroAnterior := cdsConsulta.Filter;

    cdsConsulta.Filter := grdConsultaDBTableView1.DataController.Filter.FilterText;
    cdsConsulta.Filtered := Not cdsConsulta.Filter.IsEmpty;

    If cdsConsulta.IsEmpty Then
    Begin
      fMensagem('', 'É necessário filtrar ao menos uma duplicata!', ['&Ok']);
      Exit;
    End;

    pMarcaTodos;
  Finally
    cdsConsulta.Filter := LFiltroAnterior;
    cdsConsulta.Filtered := Not LFiltroAnterior.IsEmpty;
  End;

end;

procedure TfrmCtpAtribPortador.btnMudaOrdemClick(Sender: TObject);
begin
  If cdsConsulta.IsEmpty Then
  Begin
    fMensagem('', 'É necessário filtrar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  inherited;

end;

procedure TfrmCtpAtribPortador.btnPesquisarClick(Sender: TObject);
begin
  If cdsConsulta.IsEmpty Then
  Begin
    fMensagem('', 'É necessário filtrar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  inherited;

end;

procedure TfrmCtpAtribPortador.FormShow(Sender: TObject);
Var
  intCont: Integer;
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;

  lflLastField.intIndCol := 6;
  lflLastField.strNomCam := dbgConsulta.Columns[6].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[6].Title.Caption;
  lflLastField.ftyTipCam := ftDateTime;

  blnSempreRelerBanco   := False;
  blnSelecionaComEspaco := True;
  blnSelecionaComEnter  := True;
  blnQuoteLista         := False;

  {*****************************************}
  {* VERIFICA SE UTILIZA O CAMPO VENDOR    *}
  {**************************************RV*}

  for intCont := 0 to Pred(grdConsultaDBTableView1.ColumnCount) do
  begin
    if grdConsultaDBTableView1.Columns[intCont].DataBinding.FieldName = 'CTP_VENDOR' then
      grdConsultaDBTableView1.Columns[intCont].Visible := fCfgSis('CTPVND', varBoolean)
    else
    if (grdConsultaDBTableView1.Columns[intCont].DataBinding.FieldName = 'CTP_NOMFOR') then
      if Not fCfgSis('CTPVND', varBoolean) then
        grdConsultaDBTableView1.Columns[intCont].Width := 210;
  end;

  pHabilitaFiltroBaixa();

  pSetFocus(edtCodFor);
end;

procedure TfrmCtpAtribPortador.pFechaConsulta;
Begin
  cdsConsulta.Close;

  edtCodFor.Clear;
  edtNomFor.Clear;
  //MF 20/04/2023 - 286028 - INI
  edtCodPort.Clear;
  edtNomPort.Clear;
  edtHist1.Clear;
  edtHist2.Clear;
  edtVlrOrig.Value := 0;
  //MF 20/04/2023 - 286028 - FIM
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  
  mskDtaIni.Clear;
  mskDtaFin.Clear;

  rdgPeriodo.Enabled := True;

  pHabilitaFiltroBaixa();

  pSetFocus(edtCodFor);
End;

procedure TfrmCtpAtribPortador.pHabilitaFiltroBaixa();
Begin
  with rdgPeriodo do
  begin
    If rdgPeriodo.enabled Then
       Controls[2].Enabled := rdgStatus.ItemIndex = 1;

    If (ItemIndex = 2) And (Controls[2].Enabled = False) Then
       rdgPeriodo.itemindex := 0;
  end;
End;

procedure TfrmCtpAtribPortador.rdgStatusClick(Sender: TObject);
begin
  inherited;
  pHabilitaFiltroBaixa();
end;

function TfrmCtpAtribPortador.RetornaListaEmpresasMarcados(
  AAutoIncremsCadPag: String): TStringList;
  Var
    LConsulta: TUniQuery;
begin
  Result := TStringList.Create;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT CTP_CODEMP ' +
                          'FROM CADPAG ' +
                          'WHERE AUTOINCREM IN (' +  AAutoIncremsCadPag + ') ' +
                          'GROUP BY CTP_CODEMP';

    LConsulta.Open;
    While Not LConsulta.Eof Do
    Begin
      Result.Add(LConsulta.FieldByName('CTP_CODEMP').AsString);

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmCtpAtribPortador.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryCadFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryCadPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);//MF 20/04/2023 - 286028
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  ACdsCtpDet := TUniClientDataSet.Create(Self);
end;

procedure TfrmCtpAtribPortador.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of
    VK_F3    : btnMudaOrdem.Click;
    VK_F5    : btnPesquisar.Click;
    VK_F6    : btnMarcaTodos.Click;
    VK_F7    : btnDesmarcaTodos.Click;
    VK_F10   : btnConfirma.Click;

    VK_ESCAPE: If pnlPesquisa.Visible Or
                 (edtCodFor.Focused And (Not cdsConsulta.Active)) Then
                 inherited
               Else
                 pFechaConsulta;

    Else       inherited;
  End;

end;

procedure TfrmCtpAtribPortador.pConfirma;
Var
  AContador: Integer;
  AAutoIncremMarcado: String;
  strEmpSemAcesso: String;
Begin
  Try
    For AContador := 0 To stlListSelecao.Count - 1 Do
      AAutoIncremMarcado := AAutoIncremMarcado + QuotedStr(LeftStr(stlListSelecao[AContador], 20)) + ',';

    AAutoIncremMarcado := LeftStr(AAutoIncremMarcado, Length(AAutoIncremMarcado) - 1);

    pCriarFormularios(TfrmCtpAtribConf, frmCtpAtribConf);
    frmCtpAtribConf.ADuplicataMarcada := AAutoIncremMarcado;
    frmCtpAtribConf.blnBaixadas       := (rdgStatus.itemIndex = 1);

    If TravarAlteracaoDeCamposPrincipaisDaNotaDeEntrada(AAutoIncremMarcado) Then
    Begin
      fMensagem('AVISO!', 'Não será permitido alterar a data de cadastro, valor e plano de contas'+
                          ' pois há duplicata(s) de nota de entrada selecionada(s) para alteração.', ['&Ok']);

      frmCtpAtribConf.TravaCamposNota := True;
    End;


    frmCtpAtribConf.ShowModal;

    If frmCtpAtribConf.blnConfirma Then
    Begin
      strCodPor := frmCtpAtribConf.strCodPor;
      strCodEve := frmCtpAtribConf.strCodEve;
      strVeiobo := frmCtpAtribConf.strVeiobo;
      strVeioNF := frmCtpAtribConf.strVeioNF;
      strUsaChq := frmCtpAtribConf.strUsaChq;
      strPrevis := frmCtpAtribConf.strPrevis;
      strDeposi := frmCtpAtribConf.strDeposi;
      APlanoDeContas := frmCtpAtribConf.strPlanoContas;
      ACdsCtpDet.Data := frmCtpAtribConf.FCdsCtpDet.Data;
      strDtaCad := frmCtpAtribConf.strDtaCad;
      strDtaVen := frmCtpAtribConf.strDtaVen;
      strValDup := frmCtpAtribConf.strValDup;
      strCompet := frmCtpAtribConf.strCompet;
      strHistor := frmCtpAtribConf.strHistor;
    End
    Else
    Begin
      FreeAndNil(frmCtpAtribConf);
      Exit;
    End;
  Except
    strCodPor := '';
    strCodEve := '';
    strVeiobo := '';
    strVeioNF := '';
    strUsaChq := '';
    strPrevis := '';
    strDeposi := '';
    APlanoDeContas := '';
    strDtaCad := '';
    strDtaVen := '';
    strValDup := '';
    strCompet := '';
    strHistor := '';
  End;

  FreeAndNil(frmCtpAtribConf);

  {*REQ*145940**********RP*}
  If Not fEmptyStr(strCodPor) Then
  Begin
    If Not fEmpresasTemAcessoPortador(strCodPor, RetornaListaEmpresasMarcados(AAutoIncremMarcado), strEmpSemAcesso) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do Portador informado: '+ strEmpSemAcesso +'. Operação abortada!', ['&OK']);
      Exit;
    End;
  End;

  If (fEmptyStr(strCodPor)) And (fEmptyStr(strCodEve)) And
     (fEmptyStr(strVeiobo)) And (fEmptyStr(strVeioNF)) And
     (fEmptyStr(strUsaChq)) And (fEmptyStr(strDeposi)) And
     (fEmptyStr(strPrevis)) And (fEmptyStr(APlanoDeContas)) And
     (fEmptyStr(strDtaCad)) And (fEmptyStr(strDtaVen)) And
     (fEmptyStr(strValDup)) And (fEmptyStr(strCompet)) And
     (fEmptyStr(strHistor)) Then
  Begin
    pMensagemOk('Nenhum registro foi alterado!');
   End
  Else If fAtribuiPortador Then
  Begin
    pMensagemOk('Operação concluída com sucesso!');
    pFechaConsulta;
  End;

End;

Function TfrmCtpAtribPortador.fAtribuiPortador: Boolean;
  Var
    intContador: Integer;
    qryCadPag: TUniQuery;
    qryPagar: TUniQuery;
    strTabela,
    strSQL,
    strAutInc,
    strMsgCtp: String;
    blnAnd : Boolean;
    LClientDataSetTemp: TClientDataSet;
Begin

  If (fEmptyStr(strCodPor)) And (fEmptyStr(strCodEve)) And
     (fEmptyStr(strVeiobo)) And (fEmptyStr(strVeioNF)) And
     (fEmptyStr(strUsaChq)) And (fEmptyStr(strDeposi)) And
     (fEmptyStr(strPrevis)) And (fEmptyStr(APlanoDeContas)) And
     (fEmptyStr(strDtaCad)) And (fEmptyStr(strDtaVen)) And
     (fEmptyStr(strValDup)) And (fEmptyStr(strCompet)) And
     (fEmptyStr(strHistor)) Then
  Begin
    Result:=False;
    Exit;
  end;

  Try
    prbProgresso.Position := 0;
    prbProgresso.Visible  := True;
    prbProgresso.Max      := stlListSelecao.Count;

    fStartTransaction;

    qryCadPag := fCriaQuery;

    With qryCadPag, SQL Do
    Begin

      For intContador := 0 To stlListSelecao.Count - 1 Do
      Begin
        strAutInc := LeftStr(stlListSelecao[intContador], 20);
        strTabela := Copy(stlListSelecao[intContador], 21, Length(stlListSelecao[intContador]) - 20);

        strMsgCtp := '';

        qryPagar := fCriaQuery;

        strSQL := '';
        strSQL := strSQL + 'SELECT AUTOINCREM, CTP_NUMDUP, CTP_PARCEL, CTP_SEQBAI, ';
        strSQL := strSQL + '       CTP_CODEMP, CTP_CODFOR, CTP_SERIE_, ';
        strSQL := strSQL + '       CTP_DTACAD, CTP_DTAVEN, CTP_VALDUP, CTP_COMPET, CTP_VALORI ';
        strSQL := strSQL + 'FROM CADPAG ';
        strSQL := strSQL + 'WHERE AUTOINCREM = '+ QuotedStr(strAutInc);

        with qryPagar Do
        begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          Open;
        end;

        Clear;
        Add('UPDATE');
        Add(strTabela);
        Add('SET ');

        blnAnd := False;
                                               //para tirar um hint essa segunda condição
        If (not fEmptyStr(strCodPor)) And (not blnAnd) Then
        Begin
          Add(' CTP_CODPOR = :CODPOR ');
          blnAnd := True;
          strMsgCtp := strMsgCtp + 'PORTADOR/';
        End;

        If not fEmptyStr(strCodEve) Then
        begin
          If blnAnd Then Add(' , ');
          Add(' CTP_CODEVE = :CODEVE ');
          blnAnd := True;
          strMsgCtp := strMsgCtp + 'CENTRO DE CUSTOS/';
        End;

        If not fEmptyStr(strVeiobo) Then
        begin
          If blnAnd Then Add(' , ');
          Add(' CTP_VEIOBO = :VEIOBO ');
          blnAnd := True;
          strMsgCtp := strMsgCtp + 'VEIO BOLETO/';
        End;

        If not fEmptyStr(strVeioNF) Then
        begin
          If blnAnd Then Add(' , ');
          Add(' CTP_VEIONF = :VEIONF ');
          blnAnd := True;
          strMsgCtp := strMsgCtp + 'VEIO NF./';
        End;

        If not fEmptyStr(strUsaChq) Then
        begin
          If blnAnd Then Add(' , ');
          Add(' CTP_USACHQ = :USACHQ ');
          blnAnd := True;
          strMsgCtp := strMsgCtp + 'VEIO CHEQUE/';
        End;

        If not fEmptyStr(strPrevis) Then
        begin
          If blnAnd Then Add(' , ');
          Add(' CTP_PREVIS = :PREVIS ');
          blnAnd := True;
          strMsgCtp := strMsgCtp + 'PREVISÃO/';
        End;

        If not fEmptyStr(strDeposi) Then
        begin
          If blnAnd Then Add(' , ');
          Add(' CTP_DEPOSI = :DEPOSI ');
          blnAnd := True;
          strMsgCtp := strMsgCtp + 'DEPÓSITO/';
        End;

        If not fEmptyStr(APlanoDeContas) Then
        begin
          If blnAnd then
            Add(' , ');
          Add(' CTP_CODCTA = :PLANOCONTAS ');
          blnAnd := True;
          strMsgCtp := strMsgCtp + 'PL. CONTAS/';
        end;

        If not fEmptyStr(strDtaCad) Then
        begin
          If blnAnd then
            Add(' , ');
          Add(' CTP_DTACAD = :DTACAD ');
          blnAnd := True;
          strMsgCtp := strMsgCtp + 'DT. CADASTRO/';
        end;

        If not fEmptyStr(strDtaVen) Then
        begin
          If blnAnd then
            Add(' , ');
          Add(' CTP_DTAVEN = :DTAVEN ');
          blnAnd := True;
          strMsgCtp := strMsgCtp + 'DT. VENCTO./';
        end;

        If not fEmptyStr(strValDup) Then
        begin
          If blnAnd then
            Add(' , ');

          Add(' CTP_VALDUP = :VALDUP ');
          Add(' , ');
          Add(' CTP_VALORI = :VALORI ');

          blnAnd := True;
          strMsgCtp := strMsgCtp + 'VLR. DUPLICATA/';
        end;

        If not fEmptyStr(strCompet) Then
        begin
          If blnAnd then
            Add(' , ');
          Add(' CTP_COMPET = :COMPET ');
          strMsgCtp := strMsgCtp + 'COMPET./';
          blnAnd := True;
        end;

        If not fEmptyStr(strHistor) Then
        begin
          If blnAnd then
            Add(' , ');
          Add(' CTP_HIST01 = :HIST01 ');
          strMsgCtp := strMsgCtp + 'HISTÓRICO/';
        end;

        Add('WHERE ');
        Add('  AUTOINCREM = :AUTINC ');

        If not fEmptyStr(strCodPor) Then
          ParamByName('CODPOR').AsString := strCodPor;
        If not fEmptyStr(strCodEve) Then
          ParamByName('CODEVE').AsString := strCodEve;
        If not fEmptyStr(strVeiobo) Then
          ParamByName('VEIOBO').AsString := strVeiobo;
        If not fEmptyStr(strVeionf) Then
          ParamByName('VEIONF').AsString := strVeioNF;
        If not fEmptyStr(strUsaChq) Then
          ParamByName('USACHQ').AsString := strUsaChq;
        If not fEmptyStr(strDeposi) Then
          ParamByName('DEPOSI').AsString := strDeposi;
        If not fEmptyStr(strPrevis) Then
          ParamByName('PREVIS').AsString := strPrevis;
        If not fEmptyStr(APlanoDeContas) Then
          ParamByName('PLANOCONTAS').AsString := APlanoDeContas;
        If not fEmptyStr(strDtaCad) Then
          ParamByName('DTACAD').AsDateTime := StrToDateTime(strDtaCad);
        If not fEmptyStr(strDtaVen) Then
          ParamByName('DTAVEN').AsDateTime := StrToDateTime(strDtaVen);
        If not fEmptyStr(strValDup) Then
        Begin
          ParamByName('VALDUP').AsFloat := fFormataFloat(fStrToFloat(strValDup), 2);
          ParamByName('VALORI').AsFloat := fFormataFloat(fStrToFloat(strValDup), 2);
        End;
        If not fEmptyStr(strCompet) Then
          ParamByName('COMPET').AsString := strCompet;
        If not fEmptyStr(strHistor) Then
          ParamByName('HIST01').AsString := strHistor;

        ParamByName('AUTINC').AsString := strAutInc;

        ExecSQL;

        prbProgresso.StepBy(1);
        Application.ProcessMessages;

        strMsgCtp := LeftStr( strMsgCtp, Length(strMsgCtp)-1 );

        untLogCtp.GravaLogCtp(strAutInc, 'ALTERACAO DE ' + IIF(fEmptyStr(strMsgCtp),'PORTADOR/CENTRO DE CUSTOS/PLANO DE CONTAS',strMsgCtp), 'frmCtpAtribPortador');

        If Assigned(ACdsCtpDet) Then
        Begin
          If (AcdsCtpDet.RecordCount > 0) Then
          Begin
            AcdsCtpDet.Filter   := 'AUTOINCREM = ' + QuotedStr(qryPagar.FieldByName('AUTOINCREM').AsString);
            AcdsCtpDet.Filtered := True;

            LClientDataSetTemp := TClientDataSet.Create(nil);
            Try
              LClientDataSetTemp.CloneCursor(AcdsCtpDet, False); // Apenas os filtrados
              If Not fGravaFatorCalculado(qryPagar.FieldByName('CTP_NUMDUP').AsString,
                                          qryPagar.FieldByName('CTP_PARCEL').AsString,
                                          qryPagar.FieldByName('CTP_CODEMP').AsString,
                                          qryPagar.FieldByName('CTP_CODFOR').AsString,
                                          qryPagar.FieldByName('CTP_SERIE_').AsString,
                                          LClientDataSetTemp,
                                          Self.Name,
                                          True) Then
              Begin
                fRollBack;
              End;
              AcdsCtpDet.Filtered := False;
            Finally
              FreeAndNil(LClientDataSetTemp);
            End;
          End;
        End;
      End;

    End;

    FreeAndNil(qryCadPag);

    fCommit;

    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(e.Message, '[fAtribuiPortador]');
    End;
  End;

  prbProgresso.Visible := False;

End; 

procedure TfrmCtpAtribPortador.fraPlanoDeContasMskCodCtaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, arrCentCusto, fRetNomeConta, Nil, 'da Conta');

  fraPlanoDeContas.MskCodCtaExit(Sender);
end;

procedure TfrmCtpAtribPortador.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentCusto) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, False) Then
      SelectNext(ActiveControl, True, True);
  end;

end;

Function TfrmCtpAtribPortador.fRetChaveLista: String;
Begin
  With cdsConsulta Do
  Begin
    Result := FieldByName('AUTOINCREM').AsString + FieldByName('TABELA').AsString;
  End;
End;

procedure TfrmCtpAtribPortador.AbreConsulta;
begin
  fAbreConsulta;
end;

procedure TfrmCtpAtribPortador.btnCarrContasClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
    TfrmGravando.fExecutarModal(AbreConsulta, 'Aguarde... Carregando Títulos.', '');

  If cdsConsulta.IsEmpty Then
    fMensagem('ATENÇÃO!', 'Não há duplicatas para serem alteradas!', ['&O k']);

  If grdConsultaDBTableView1.DataController.Dataset.Active Then
  Begin
    grdConsultaDBTableView1.DataController.DataSet.Refresh;
    grdConsultaDBTableView1.DataController.Refresh;
  End;
end;

procedure TfrmCtpAtribPortador.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Or (stlListSelecao.Count = 0) Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If fVerificaCampos Then
    TfrmGravando.fExecutarModal(pConfirma, 'Aguarde... Confirmando registros.', '');
end;

procedure TfrmCtpAtribPortador.pCarregaCentroCusto;
begin
  fraPlanoDeContas.edtDesCta.Text := '';
  If not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
  begin
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
    With qryConCta Do
    Begin
      fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
    End;
  end;
end;


function TfrmCtpAtribPortador.TravarAlteracaoDeCamposPrincipaisDaNotaDeEntrada(
  ADuplicatas: String): Boolean;
  Var
    LCadRec : TUniQuery;
begin
  Result := False;

  If Not fCfgSis('ALTNEP', varBoolean) Then
    Exit;

  Try

    Try
      LCadRec := fCriaQuery(Nil);

      LCadRec.Close;
      LCadRec.SQL.Clear;
      LCadRec.SQL.Text := '  SELECT                                            '+
                          '    COUNT(CTP_NUMDUP) AS QTD_NOTAS                  '+
                          '  FROM                                              '+
                          '    CADPAG                                          '+
                          '  JOIN CADFIS                                       '+
                          '       ON FIS_NUMDOC = CTP_NUMDUP                   '+
                          '       AND FIS_CODEMP = CTP_CODEMP                  '+
                          '       AND FIS_FORCLI = CTP_CODFOR                  '+
                          '       AND FIS_TIP_FC = "F"                         '+
                          '       AND FIS_SERIE_ = CTP_SERIE_                  '+
                          '   WHERE CADPAG.AUTOINCREM IN ('+ADuplicatas+')     ';

      LCadRec.Open;
      Result := (LCadRec.FieldByName('QTD_NOTAS').AsInteger > 0);

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LCadRec);
  End;

end;

end.
