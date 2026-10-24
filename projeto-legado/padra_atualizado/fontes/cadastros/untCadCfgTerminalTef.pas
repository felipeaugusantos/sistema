unit untCadCfgTerminalTef;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Vcl.StdCtrls, EditFocus, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, Uni, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, untCfgRel, Vcl.Printers, System.StrUtils, UniClientDataSet,
  ComboBoxFocus;

type
  TfrmCadCfgTerminalTef = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    btnConfirmar: TBitBtnLocked;
    dsTerminaisTef: TDataSource;
    cxGridTerminaisDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridTerminaisLevel1: TcxGridLevel;
    cxGridTerminais: TcxGridCitel;
    cxGridTerminaisTFC_NUMTER: TcxGridDBColumn;
    cxGridTerminaisTFC_NUMLOJ: TcxGridDBColumn;
    cxGridTerminaisTFC_MACADD: TcxGridDBColumn;
    cxGridTerminaisTFC_NOMUSU: TcxGridDBColumn;
    cxGridTerminaisTFC_NOMMAQ: TcxGridDBColumn;
    cxGridTerminaisTFC_CODEMP: TcxGridDBColumn;
    cxGridTerminaisTFC_NUM_IP: TcxGridDBColumn;
    cxGridTerminaisTFC_PATIMP: TcxGridDBColumn;
    btnConsultaInfo: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    btnNovo: TBitBtnLocked;
    cxGridTerminaisTFC_LOC_IP: TcxGridDBColumn;
    CdsTerminaisTef: TUniClientDataSet;
    CdsTerminaisTefAUTOINCREM: TStringField;
    CdsTerminaisTefNUMTER: TStringField;
    CdsTerminaisTefNUMLOJ: TStringField;
    CdsTerminaisTefMACADD: TStringField;
    CdsTerminaisTefNOMUSU: TStringField;
    CdsTerminaisTefNOMMAQ: TStringField;
    CdsTerminaisTefCODEMP: TStringField;
    CdsTerminaisTefNUM_IP: TStringField;
    CdsTerminaisTefPATIMP: TStringField;
    CdsTerminaisTefLOC_IP: TStringField;
    CdsTerminaisTefEMPTIP: TStringField;
    cxGridTerminaisTFC_EMPTIP: TcxGridDBColumn;
    btnFechar: TBitBtnLocked;
    btnVersaoDll: TBitBtnLocked;
    CdsTerminaisTefPINPOR: TStringField;
    CdsTerminaisTefPINFAB: TStringField;
    pcConfiguracoes: TPageControl;
    tsTef: TTabSheet;
    tsPinPad: TTabSheet;
    lblNumLoja: TLabel;
    edtNumLoja: TEditFocus;
    lblNumTer: TLabel;
    edtNumTer: TEditFocus;
    lblServidorTef: TLabel;
    edtIpServ: TEditFocus;
    lblImpressora: TLabel;
    btnLocImp: TBitBtnLocked;
    edtImpressora: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtNomUsu: TEditFocus;
    edtNomMaq: TEditFocus;
    lblNomMaq: TLabel;
    edtIpMaquina: TEditFocus;
    lblIpMaquina: TLabel;
    edtMacAdd: TEditFocus;
    lblMacAdd: TLabel;
    Label4: TLabel;
    cbPortaPinPad: TComboBoxFocus;
    Label5: TLabel;
    cbFabricantePinPad: TComboBoxFocus;
    cxGridTerminaisTFC_PINPOR: TcxGridDBColumn;
    cxGridTerminaisTFC_PINFAB: TcxGridDBColumn;
    lbAvisoPinPad: TLabel;
    lbAvisoPinPad2: TLabel;
    cmbPortaComTef: TComboBoxFocus;
    CdsTerminaisTefCOMTEF: TStringField;
    lblTerminalSales: TLabel;
    edtTerminalSales: TEditFocus;
    CdsTerminaisTefTSALES: TStringField;
    cxGridTerminaisTFC_TSALES: TcxGridDBColumn;
    CdsTerminaisTefTKSALE: TStringField;
    rgOpcaoSales: TRadioGroup;
    lblNomUsu: TLabel;
    lblTokenMsitef: TLabel;
    edtTokenMsitef: TEditFocus;
    cxGridTerminaisTFC_TKSALE: TcxGridDBColumn;
    CdsTerminaisTefTIPTEF: TStringField;
    CdsTerminaisTefADQUIR: TStringField;
    btnCopiarNomMaq: TBitBtnLocked;
    cmbAdquirente: TComboBoxFocus;
    lblAdquirente: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cxGridTerminaisDBTableViewCitel1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnConsultaInfoClick(Sender: TObject);
    procedure pDeletaTerminal;
    procedure pLimpaCampos;
    function fValidacaoCampos : Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnLocImpClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnVersaoDllClick(Sender: TObject);
    procedure rgOpcaoSalesClick(Sender: TObject);
    procedure btnCopiarNomMaqClick(Sender: TObject);
    procedure cbPortaPinPadClick(Sender: TObject);
    procedure cmbPortaComTefClick(Sender: TObject);
  private
    { Private declarations }
    strTipTer : String;
    FqryConEmp: TUniQuery;
    FblnTerminalSales: Boolean ;
    FintTopLblNumTer   : Integer ;
    FintTopEdtNumTer   : Integer ;
    FintTopRgOpcaoSales: Integer ;
    FTelaExibindo: String;

    procedure pCarregaConfiguracao(var AqryConsulta: TUniQuery) ;
    procedure pHabilitaDesabilitaCampos;
    function fVerificaTerminalExiste(blnLocate : Boolean; strMacAdd : String): Boolean;
    procedure pCarregaEmpresa;
    function fTrataCodEmp(const AstrCodEmp: string): Variant ;
    function fConfirmaRecuperacaoDados(const AstrTerminal, AstrEmpresa: String): Boolean ;
    function fConfirmaFechar: Boolean ;
    function fRetornaVersaoTefDLL: String ;
    procedure pAjustaFormulario;
    procedure pAjustaFormularioNCR;
    procedure pAjustaFormularioClisitefOuPOS;
    function fValidaIpServOuComTef: Boolean ;
    procedure pCarregaDllsAcessoPinPad ;
    procedure pShowTerminalSales(AblnMostrar: Boolean) ;
    procedure pShowTerminalSalesMSitef(AblnMostrar: Boolean) ;
    procedure pPosicionaEdtTerminalSales ;
    procedure pShowEdtsTerminalAutcom ;
    function fPerguntaSobreTerminalSales: Boolean ;
    function fEdtTerminalSalesVisivel: Boolean ;
    procedure pMostraColunaTerminalSales ;
    function fVerLiberacaoCadastroTerminalSales: Boolean;
    procedure pAtualizaNomeAbaTEF(const AblnTEF: Boolean) ;
    function fTrataTefCitTerminalFiltro: String ;
    function fOpcaoTerminalTipoTef: String ;
    function fOpcaoTerminalTipoTefIndex(const AstrTipoTef: String): Integer ;
    procedure pAlterarSelecaoPortaCOM(Sender: TObject);
    function fObterNomeEmpresa(const ACodEmpresa: string): string;
    procedure pCarregarAdquirentes;
    procedure pVisibleComboAdquirente(const AValue: Boolean);
    function fPodeInserirAdquirenteTerminalSales: Boolean;
    function fIsTerminalSales: Boolean;
    procedure pLimparComboBoxAdquirente;
    function fIndexOfNomeAdquirente(const ACodAdquir: string): Integer;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnEdicao : Boolean;
    autoincrem: string;
    blnGravou, blnDeletou: Boolean;
    procedure pBuscaTerminais;
  end;

implementation

uses
  untFuncoesSimples, untWorkStationInfo, untTypesSistema, untConsultas,
  untPesqAux, untTefCitelUtil, untInterfaceTefCitel, PinPad.Funcoes, untLiberacao,
  PinPad.Interfaces, untTipoOperadores;

const
  OPC_MSITEF   = 0 ;
  OPC_REDEFLEX = 1 ;

{$R *.dfm}

procedure TfrmCadCfgTerminalTef.btnCancelarClick(Sender: TObject);
begin
  inherited;
  cxGridTerminais.Enabled := True;
  pHabilitaDesabilitaCampos;
  pLimpaCampos;
  pBuscaTerminais;
  pShowTerminalSales(False);
  btnNovo.Enabled := True;
end;

procedure TfrmCadCfgTerminalTef.btnConfirmarClick(Sender: TObject);
var
  qryTefTra : TUniQuery;
  blnLocate : Boolean;
  LKey: string;
begin
  inherited;
  if fValidacaoCampos then
  begin   
    
    qryTefTra := fCriaQuery(Self);

    try
      fStartTransaction;

      if blnEdicao then
      begin
        pDeletaTerminal;
        blnEdicao := False;

        if not blnDeletou then
        begin
          fRollBack;
          Exit;
        end;
      end;

      pCarregaConfiguracao(qryTefTra) ;

      if fEdtTerminalSalesVisivel then
        blnLocate := qryTefTra.Locate('TFC_TSALES', edtTerminalSales.Text , [])
      else
        if strTipTer = '1' then
          blnLocate := qryTefTra.Locate('TFC_NUMLOJ;TFC_NUMTER', VarArrayOf([edtNumLoja.Text, edtNumTer.Text]), [])
        else if strTipTer = '2' then
          blnLocate := qryTefTra.Locate('TFC_NOMMAQ;TFC_LOC_IP;TFC_EMPTIP', VarArrayOf([edtNomMaq.Text, edtIpMaquina.Text, fTrataCodEmp(edtCodEmp.Text)]), [])
        else // 3
          blnLocate := qryTefTra.Locate('TFC_NOMMAQ;TFC_EMPTIP', VarArrayOf([edtNomMaq.Text, edtCodEmp.Text]), []);

      if not (fVerificaTerminalExiste(blnLocate, qryTefTra.FieldByName('TFC_MACADD').AsString)) then
      begin
        try
          qryTefTra.Append;
          qryTefTra.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('TEFCFG', VS_strCodEmp);
          qryTefTra.FieldByName('TFC_NUMTER').AsString := edtNumTer.Text;
          qryTefTra.FieldByName('TFC_NUMLOJ').AsString := edtNumLoja.Text;
          qryTefTra.FieldByName('TFC_MACADD').AsString := edtMacAdd.Text;
          qryTefTra.FieldByName('TFC_NOMUSU').AsString := edtNomUsu.Text;
          qryTefTra.FieldByName('TFC_NOMMAQ').AsString := edtNomMaq.Text;
          qryTefTra.FieldByName('TFC_CODEMP').AsString := VS_strCodEmp;
          qryTefTra.FieldByName('TFC_NUM_IP').AsString := edtIpServ.Text;
          qryTefTra.FieldByName('TFC_PATIMP').AsString := edtImpressora.Text;
          qryTefTra.FieldByName('TFC_LOC_IP').AsString := edtIpMaquina.Text;
          qryTefTra.FieldByName('TFC_EMPTIP').AsVariant := fTrataCodEmp(edtCodEmp.Text) ;
          qryTefTra.FieldByName('TFC_PINPOR').AsString := cbPortaPinPad.Text;
          qryTefTra.FieldByName('TFC_PINFAB').AsString := cbFabricantePinPad.Text;
          qryTefTra.FieldByName('TFC_COMTEF').AsString := cmbPortaComTef.Text;
          qryTefTra.FieldByName('TFC_TIPTEF').AsString := fOpcaoTerminalTipoTef;
          qryTefTra.FieldByName('TFC_TSALES').Value := Null ;
          qryTefTra.FieldByName('TFC_TKSALE').Value := Null ;
          if not fEmptyStr(edtTerminalSales.Text) then
            qryTefTra.FieldByName('TFC_TSALES').AsString := edtTerminalSales.Text ;
          if not fEmptyStr(edtTokenMsitef.Text) then
            qryTefTra.FieldByName('TFC_TKSALE').AsString := edtTokenMsitef.Text ;

          qryTefTra.FieldByName('TFC_ADQUIR').Value := Null;
          if fPodeInserirAdquirenteTerminalSales and (cmbAdquirente.ItemIndex > 0) then
          begin
            LKey := TItemCombo(cmbAdquirente.Items.Objects[cmbAdquirente.ItemIndex]).Codigo;
            qryTefTra.FieldByName('TFC_ADQUIR').AsString := LKey;
          end;

          qryTefTra.Post;
        finally
          blnGravou := True;
        end;

        if not blnGravou then
        begin
          fRollBack;
          Exit;
        end;

        fCommit;

        pLimpaCampos;
        pShowTerminalSales(False);
      end;

      pBuscaTerminais;

      cxGridTerminais.Enabled := True;

      pHabilitaDesabilitaCampos;
      btnNovo.Enabled := True;
      pBuscaTerminais;
    finally
      FreeAndNil(qryTefTra);
    end;
  end;
end;

procedure TfrmCadCfgTerminalTef.pHabilitaDesabilitaCampos;
begin
  edtNumTer.Enabled := not cxGridTerminais.Enabled;
  edtNumLoja.Enabled := not cxGridTerminais.Enabled;
  edtMacAdd.Enabled := not cxGridTerminais.Enabled;
  edtNomUsu.Enabled := not cxGridTerminais.Enabled;
  edtNomMaq.Enabled := not cxGridTerminais.Enabled;
  edtIpServ.Enabled := not cxGridTerminais.Enabled;
  cmbPortaComTef.Enabled := not cxGridTerminais.Enabled;
  edtIpMaquina.Enabled := not cxGridTerminais.Enabled;
  edtImpressora.Enabled := not cxGridTerminais.Enabled;
  btnCancelar.Enabled := not cxGridTerminais.Enabled;
  edtTerminalSales.Enabled := not cxGridTerminais.Enabled;
  btnConsultaInfo.Enabled := not cxGridTerminais.Enabled;
  btnLocImp.Enabled := not cxGridTerminais.Enabled;
  btnConfirmar.Enabled := not cxGridTerminais.Enabled;
  btnConsultaInfo.Enabled := not cxGridTerminais.Enabled;
  edtCodEmp.Enabled := not cxGridTerminais.Enabled;
  edtNomEmp.Enabled := not cxGridTerminais.Enabled;
  cbPortaPinPad.Enabled := not cxGridTerminais.Enabled;
  cbFabricantePinPad.Enabled := not cxGridTerminais.Enabled;
  btnCopiarNomMaq.Enabled := not cxGridTerminais.Enabled;
  cmbAdquirente.Enabled := not cxGridTerminais.Enabled;
end;

procedure TfrmCadCfgTerminalTef.btnConsultaInfoClick(Sender: TObject);
begin
  inherited;
  edtMacAdd.Text := VS_MacAddress;
  edtNomUsu.Text := VS_UserFromWindows;
  edtNomMaq.Text := IfThen(fCfgSis('TIPTER', varString) = '1',VS_ComputerNetName,TWorkStationInfo.fGetWorkstationID);
  edtIpMaquina.Text := VS_WorkstationIP;
end;

procedure TfrmCadCfgTerminalTef.btnCopiarNomMaqClick(Sender: TObject);
var
  qryTefCfg: TUniQuery;
  Larr: Array of String;
  LselRec : Integer;
  LComTEF : string;
  LCodEmpresa: string;
  LSQL: string;
  LDllNome: string;
begin
  inherited;

  qryTefCfg := fCriaQuery(Self);
  try
    LSQL := 'SELECT DISTINCT ' + sLineBreak +
      'TFC_CODEMP, ' + sLineBreak +
      'TFC_NUMTER, ' + sLineBreak +
      'TFC_NOMMAQ, ' + sLineBreak +
      'TFC_PINPOR, ' + sLineBreak +
      'TFC_COMTEF, ' + sLineBreak +
      'TFC_PATIMP  ' + sLineBreak +
      'FROM TEFCFG ' + sLineBreak +
      'WHERE       ' + sLineBreak +
      'IFNULL(TFC_NOMMAQ, "") <> "" AND ' + sLineBreak +
      'TFC_TIPTEF = "S"';

    qryTefCfg.Sql.Text := LSQL;
    qryTefCfg.Open;

    if qryTefCfg.IsEmpty then
      Exit;

    if qryTefCfg.RecordCount > 1 then
    begin
      SetLength(Larr, 0);
      while not qryTefCfg.Eof do
      begin
        SetLength(Larr, Succ(Length(Larr)));
        Larr[High(Larr)] := qryTefCfg.FieldByName('TFC_CODEMP').AsString + ' | ' +
                            qryTefCfg.FieldByName('TFC_NUMTER').AsString + ' | ' +
                            qryTefCfg.FieldByName('TFC_NOMMAQ').AsString;
        qryTefCfg.Next;
      end;

      LselRec := fGetMenu('Emp | N.Ter | Maq', Larr, 0, True);

      if LselRec <= 0 then
        Exit;

      qryTefCfg.RecNo := LselRec;
    end;

    if edtNomMaq.Text = qryTefCfg.FieldByName('TFC_NOMMAQ').AsString then
      Exit;

    if fEmptyStr(edtNomMaq.Text) then
    begin
      if fMensagem('ATENÇÃO!', 'Confirma utilização do nome da máquina "' + qryTefCfg.FieldByName('TFC_NOMMAQ').AsString + '" ?', ['&Sim', '&Não'], 2) <> 1 then
        Exit;
    end
    else
    begin
      if fMensagem('ATENÇÃO!', 'Confirma alteração do nome da máquina  de "' + edtNomMaq.Text + '" para "' + qryTefCfg.FieldByName('TFC_NOMMAQ').AsString + '" ?', ['&Sim', '&Não'], 2) <> 1 then
        Exit;
    end;

    edtNomMaq.Text := qryTefCfg.FieldByName('TFC_NOMMAQ').AsString;
    LComTEF := qryTefCfg.FieldByName('TFC_PINPOR').AsString;
    LCodEmpresa := qryTefCfg.FieldByName('TFC_CODEMP').AsString;
    LDllNome := ArrayDllAcessoPinPad[ppcfGertec];

    edtImpressora.Text := qryTefCfg.FieldByName('TFC_PATIMP').AsString;
    cmbPortaComTef.ItemIndex := cmbPortaComTef.Items.IndexOf(LComTEF);
    cbPortaPinPad.ItemIndex := cbPortaPinPad.Items.IndexOf(LComTEF);
    edtCodEmp.Text := LCodEmpresa;
    edtNomEmp.Text := fObterNomeEmpresa(LCodEmpresa);
    cbFabricantePinPad.ItemIndex := cbFabricantePinPad.Items.IndexOf(LDllNome);
  finally
    FreeAndNil(qryTefCfg);
  end;

end;

procedure TfrmCadCfgTerminalTef.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close ;
end;

procedure TfrmCadCfgTerminalTef.btnLocImpClick(Sender: TObject);
Var
  strNomImp, strTipImp: String;
begin
  inherited;
  If fCfgSis('CADIMP', VarBoolean) Or TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    If TCfgRel.fSelecionaFila('','','','',strNomImp,strTipImp,True) Then
    Begin
      edtImpressora.Text := strNomImp;
      SelectNext(ActiveControl, True, True);
    End;
  End
  Else If (TCfgRel.fExecutePrintDialog(strNomImp)) Then
  Begin
    If fEmptyStr(strNomImp) Then
      strNomImp := TCfgRel.fGetImpressoraSelecionada;
    edtImpressora.Text := strNomImp;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCfgTerminalTef.btnNovoClick(Sender: TObject);
var
  LstrCodigoLoja: String ;
begin
  inherited;

  if fPerguntaSobreTerminalSales then
    pShowTerminalSales(True);

  LstrCodigoLoja := CdsTerminaisTefNUMLOJ.AsString ;
  pLimpaCampos;
  edtIpServ.Text := '127.0.0.1' ;
  edtNumLoja.Text := LstrCodigoLoja ;
  cxGridTerminais.Enabled := False;
  pHabilitaDesabilitaCampos;
  btnNovo.Enabled := False;
  pSetFocus(edtNumLoja);
end;

procedure TfrmCadCfgTerminalTef.btnVersaoDllClick(Sender: TObject);
var
  LstrVersaoDLL: String ;
begin
  inherited;

  if CdsTerminaisTef.IsEmpty then
  begin
    fMensagem('Atenção!', 'Nenhum terminal cadastrado!' , ['&Ok']) ;
    exit ;
  end ;

  LstrVersaoDLL := fRetornaVersaoTefDLL ;

  if fEmptyStr(LstrVersaoDLL) then
  begin
    fMensagem('Atenção!', 'Não foi possível retornar a versão da DLL!' , ['&Ok']) ;
    pSetFocus(cxGridTerminais);
    exit ;
  end ;

  fMensagem('', LstrVersaoDLL, ['&Ok']) ;
  pSetFocus(cxGridTerminais);
end;

procedure TfrmCadCfgTerminalTef.cbPortaPinPadClick(Sender: TObject);
begin
  inherited;
  pAlterarSelecaoPortaCOM(Sender);
end;

procedure TfrmCadCfgTerminalTef.cmbPortaComTefClick(Sender: TObject);
begin
  inherited;
  pAlterarSelecaoPortaCOM(Sender);
end;

procedure TfrmCadCfgTerminalTef.cxGridTerminaisDBTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
  LIsTefSales: Boolean;
begin
  inherited;

  Case Key Of
    VK_DELETE:
      Begin
        If fMensagem('', 'Deseja remover o terminal selecionado?', ['&Sim', '&Não']) = 1 Then
        Begin
          pDeletaTerminal;
          pLimpaCampos;
          pBuscaTerminais;
        End;
      End;
    VK_RETURN:
      Begin
        if not fConfirmaRecuperacaoDados(CdsTerminaisTefNUMTER.AsString, IfThen(strTipTer = '1', CdsTerminaisTefCODEMP.AsString, CdsTerminaisTefEMPTIP.AsString)) then
          exit ;

        cxGridTerminais.Enabled := False;

        pHabilitaDesabilitaCampos;

        edtNumTer.Text := CdsTerminaisTefNUMTER.AsString;
        edtNumLoja.Text := CdsTerminaisTefNUMLOJ.AsString;
        edtMacAdd.Text := CdsTerminaisTefMACADD.AsString;
        edtNomUsu.Text := CdsTerminaisTefNOMUSU.AsString;
        edtNomMaq.Text := CdsTerminaisTefNOMMAQ.AsString;
        edtIpServ.Text     := CdsTerminaisTefNUM_IP.AsString;
        edtIpMaquina.Text := cdsTerminaisTefLOC_IP.AsString;
        edtImpressora.Text := CdsTerminaisTefPATIMP.AsString;
        edtCodEmp.Text     := CdsTerminaisTefEMPTIP.AsString;
        cbPortaPinPad.ItemIndex := cbPortaPinPad.Items.IndexOf(CdsTerminaisTefPINPOR.AsString);
        cbFabricantePinPad.ItemIndex := cbFabricantePinPad.Items.IndexOf(CdsTerminaisTefPINFAB.AsString);
        cmbPortaComTef.ItemIndex := cmbPortaComTef.Items.IndexOf(CdsTerminaisTefCOMTEF.AsString);
        edtTerminalSales.Text := CdsTerminaisTefTSALES.AsString;
        edtTokenMsitef.Text := CdsTerminaisTefTKSALE.AsString;
        rgOpcaoSales.ItemIndex := fOpcaoTerminalTipoTefIndex(CdsTerminaisTefTIPTEF.AsString) ;

        pCarregaEmpresa ;
        LIsTefSales := not fEmptyStr(CdsTerminaisTefTSALES.AsString);
        pShowTerminalSales(LIsTefSales);

        cmbAdquirente.ItemIndex := -1;
        if LIsTefSales then
          cmbAdquirente.ItemIndex := fIndexOfNomeAdquirente(CdsTerminaisTefADQUIR.AsString);

        cxGridTerminais.Enabled := False;
        pSetFocus(edtNumLoja);

        blnEdicao := True;
        btnNovo.Enabled := False;
      End;
    VK_ESCAPE:
      btnSair.Click();
  end;
end;

procedure TfrmCadCfgTerminalTef.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadCfgTerminalTef.fConfirmaFechar: Boolean;
begin
  Result := True ;
  if btnConfirmar.Enabled then
  begin
    result := fMensagem('Aviso', 'Terminal em modo de edição!'+#13+#10+'Deseja realmente cancelar?', ['&Sim', '&Não'], 2) = 1 ;
  end ;
end;

function TfrmCadCfgTerminalTef.fConfirmaRecuperacaoDados(const AstrTerminal,
  AstrEmpresa: String): Boolean;
var
  LstrMsgEmpresa: String ;
begin
  LstrMsgEmpresa := '' ;
  if not fEmptyStr(AstrEmpresa) then
    LstrMsgEmpresa := Format(' da Empresa [%s]', [AstrEmpresa]) ;

  result := fMensagem('Aviso', Format('Deseja carregar informações do terminal [%s]', [AstrTerminal]) + LstrMsgEmpresa + '?', ['C&arregar', '&Cancelar'], 2) = 1 ;
end;

function TfrmCadCfgTerminalTef.fEdtTerminalSalesVisivel: Boolean;
begin
  Result := edtTerminalSales.Visible ;
end;

function TfrmCadCfgTerminalTef.fObterNomeEmpresa(const ACodEmpresa: string): string;
begin
  if fEmptyStr(ACodEmpresa) then
  begin
    Result := ifthen(strTipTer = '2', 'TODOS', '');
    Exit;
  end;
  pPesquisaCadEmp(FqryConEmp, FqryConEmp, ACodEmpresa);
  Result := FqryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

function TfrmCadCfgTerminalTef.fOpcaoTerminalTipoTef: String;
var
  LstrTefCit: String ;
begin
  Result := 'S' ;
  LstrTefCit := fCfgSis('TEFCIT', varString) ;
  if LstrTefCit = OPCAO_NCR then
    Result := LstrTefCit
  else if LstrTefCit = OPCAO_CLISITEF then
    Result := LstrTefCit ;
  if (rgOpcaoSales.Visible) and (FblnTerminalSales) and (rgOpcaoSales.ItemIndex = OPC_REDEFLEX) then
    Result := OPCAO_REDE_FLEX_POS ;
end;

function TfrmCadCfgTerminalTef.fOpcaoTerminalTipoTefIndex(
  const AstrTipoTef: String): Integer;
begin
  Result := OPC_MSITEF ;
  if AstrTipoTef = OPCAO_REDE_FLEX_POS then
    Result := OPC_REDEFLEX ;
end;

procedure TfrmCadCfgTerminalTef.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if blnGravou then
    fMensagem('', 'Feche o Autcom (todos deste computador) para aplicar as configurações gravadas!', ['&OK']);
end;

procedure TfrmCadCfgTerminalTef.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := fConfirmaFechar ;
end;

procedure TfrmCadCfgTerminalTef.FormCreate(Sender: TObject);
begin
  inherited;
  btnCopiarNomMaq.Visible := False;
  cmbAdquirente.Visible := False;
  lblAdquirente.Visible := False;
  FintTopLblNumTer    := lblNumTer.Top ;
  FintTopEdtNumTer    := edtNumTer.Top ;
  FintTopRgOpcaoSales := rgOpcaoSales.Top ;

  strTipTer := fCfgSis('TIPTER', varString);
  FblnTerminalSales := fCfgSis('TERSAL', varString) = 'S' ;
  FqryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

  pShowEdtsTerminalAutcom ;

  pPosicionaEdtTerminalSales ;
  pMostraColunaTerminalSales ;
end;

procedure TfrmCadCfgTerminalTef.FormDestroy(Sender: TObject);
begin
  pLimparComboBoxAdquirente;
  inherited;
end;

procedure TfrmCadCfgTerminalTef.FormShow(Sender: TObject);
begin
  inherited;
  pAjustaFormulario ;
  pBuscaTerminais;
  blnEdicao := False;
  blnGravou := False;
  pCarregaDllsAcessoPinPad;
  pHabilitaDesabilitaCampos;
  pShowTerminalSales(False);
  pcConfiguracoes.ActivePageIndex := 0 ;
end;

procedure TfrmCadCfgTerminalTef.pAjustaFormulario;
begin
  if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
  begin
    pAjustaFormularioNCR;
    Exit;
  end;

  pAjustaFormularioClisitefOuPOS;
end;

procedure TfrmCadCfgTerminalTef.pAjustaFormularioClisitefOuPOS;
begin
  lblNumLoja.Caption := 'Código Loja';
  edtNumLoja.TipoTexto := ttAlfanumerico;
  lblNumTer.Caption := 'Nº Terminal:';
  edtNumTer.MaxLength := 8;
  edtNumTer.TamCampo := 8;
  edtNumTer.CompZeros := False;
  edtNumTer.TipoTexto := ttAlfanumerico;
  btnVersaoDll.Visible := True;
  btnCopiarNomMaq.Visible := False;
  edtIpServ.Visible := True;
  cmbPortaComTef.Visible := False;
  lblServidorTef.Caption := 'IP Servidor TEF:';

  cxGridTerminaisTFC_NUM_IP.Caption := 'IP Servidor TEF';
  cxGridTerminaisTFC_NUM_IP.DataBinding.FieldName := 'NUM_IP' ;

  lbAvisoPinPad.Visible := True;
  lbAvisoPinPad2.Visible := True;
  FTelaExibindo:= TELA_CLISITEF;
end;

procedure TfrmCadCfgTerminalTef.pAjustaFormularioNCR;
begin
  lblNumLoja.Caption := 'Empresa/Filial' ;
  edtNumLoja.TipoTexto := ttInteiro ;

  lblNumTer.Caption := 'Nº PDV' ;
  edtNumTer.MaxLength := 3 ;
  edtNumTer.TamCampo := 3 ;
  edtNumTer.CompZeros := True ;
  edtNumTer.TipoTexto := ttInteiro ;

  btnVersaoDll.Visible := False ;

  btnCopiarNomMaq.Visible := (strTipTer = '3') and MatchStr(strLoginUsuarioLogado, ['997', '998', '999'] );

  edtIpServ.Visible := False ;
  cmbPortaComTef.Top := edtIpServ.Top ;
  cmbPortaComTef.Left := edtIpServ.Left ;
  cmbPortaComTef.Visible := True ;

  lblServidorTef.Caption := 'Porta COM TEF' ;

  cxGridTerminaisTFC_NUM_IP.Caption := 'Porta COM TEF' ;
  cxGridTerminaisTFC_NUM_IP.DataBinding.FieldName := 'COMTEF' ;

  lbAvisoPinPad.Visible := False ;
  lbAvisoPinPad2.Visible := False ;
  FTelaExibindo:= TELA_NCR;
end;

procedure TfrmCadCfgTerminalTef.pAlterarSelecaoPortaCOM(Sender: TObject);
var
  LPortaCom: string;
begin
  if not(Sender is TComboBoxFocus) then
    Exit;

  LPortaCom := TComboBox(Sender).Text;
  if Trim(LPortaCom).IsEmpty then
  begin
    cmbPortaComTef.ItemIndex := -1;
    cbPortaPinPad.ItemIndex := -1;
    Exit;
  end;

  if cmbPortaComTef.Text <> LPortaCom then
    cmbPortaComTef.ItemIndex := cmbPortaComTef.Items.IndexOf(LPortaCom);

  if cbPortaPinPad.Text <> LPortaCom then
    cbPortaPinPad.ItemIndex := cbPortaPinPad.Items.IndexOf(LPortaCom);

end;

procedure TfrmCadCfgTerminalTef.pAtualizaNomeAbaTEF(const AblnTEF: Boolean);
begin
  if AblnTEF then
    tsTef.Caption := 'TEF'
  else
    tsTef.Caption := 'Smart POS' ;
end;

procedure TfrmCadCfgTerminalTef.pBuscaTerminais;
var
  qryTefTra : TUniQuery;
begin
  inherited;
  if not CdsTerminaisTef.Active then
    CdsTerminaisTef.CreateDataSet;
  CdsTerminaisTef.EmptyDataSet;

  qryTefTra := fCriaQuery(Self);
  try

    pCarregaConfiguracao(qryTefTra) ;

    qryTefTra.First;
    while not qryTefTra.Eof do
    begin
      CdsTerminaisTef.Append;
      CdsTerminaisTefAUTOINCREM.AsString := qryTefTra.FieldByName('AUTOINCREM').AsString;
      CdsTerminaisTefNUMTER.AsString     := qryTefTra.FieldByName('TFC_NUMTER').AsString;
      CdsTerminaisTefNUMLOJ.AsString     := qryTefTra.FieldByName('TFC_NUMLOJ').AsString;
      CdsTerminaisTefMACADD.AsString     := qryTefTra.FieldByName('TFC_MACADD').AsString;
      CdsTerminaisTefNOMUSU.AsString     := qryTefTra.FieldByName('TFC_NOMUSU').AsString;
      CdsTerminaisTefNOMMAQ.AsString     := qryTefTra.FieldByName('TFC_NOMMAQ').AsString;
      CdsTerminaisTefCODEMP.AsString     := qryTefTra.FieldByName('TFC_CODEMP').AsString;
      CdsTerminaisTefNUM_IP.AsString     := qryTefTra.FieldByName('TFC_NUM_IP').AsString;
      CdsTerminaisTefPATIMP.AsString     := qryTefTra.FieldByName('TFC_PATIMP').AsString;
      CdsTerminaisTefLOC_IP.AsString     := qryTefTra.FieldByName('TFC_LOC_IP').AsString;
      CdsTerminaisTefEMPTIP.AsVariant    := qryTefTra.FieldByName('TFC_EMPTIP').AsVariant;
      CdsTerminaisTefPINPOR.AsString     := qryTefTra.FieldByName('TFC_PINPOR').AsString;
      CdsTerminaisTefPINFAB.AsString     := qryTefTra.FieldByName('TFC_PINFAB').AsString;
      CdsTerminaisTefCOMTEF.AsString     := qryTefTra.FieldByName('TFC_COMTEF').AsString;
      CdsTerminaisTefTSALES.AsString     := qryTefTra.FieldByName('TFC_TSALES').AsString;
      CdsTerminaisTefTKSALE.AsString     := qryTefTra.FieldByName('TFC_TKSALE').AsString;
      CdsTerminaisTefTIPTEF.AsString     := qryTefTra.FieldByName('TFC_TIPTEF').AsString;
      cdsTerminaisTefADQUIR.AsString     := qryTefTra.FieldByName('TFC_ADQUIR').AsString;
      CdsTerminaisTef.Post;

      qryTefTra.Next;
    end;
  finally
    FreeAndNil(qryTefTra);
  end;

end;

procedure TfrmCadCfgTerminalTef.pCarregaConfiguracao(
  var AqryConsulta: TUniQuery);
begin
  AqryConsulta.Close;
  AqryConsulta.SQL.Clear;
  AqryConsulta.SQL.Add(' SELECT');
  AqryConsulta.SQL.Add('   AUTOINCREM,');
  AqryConsulta.SQL.Add('   TFC_NUMTER,');
  AqryConsulta.SQL.Add('   TFC_NUMLOJ,');
  AqryConsulta.SQL.Add('   TFC_MACADD,');
  AqryConsulta.SQL.Add('   TFC_NOMUSU,');
  AqryConsulta.SQL.Add('   TFC_NOMMAQ,');
  AqryConsulta.SQL.Add('   TFC_CODEMP,');
  AqryConsulta.SQL.Add('   TFC_NUM_IP,');
  AqryConsulta.SQL.Add('   TFC_PATIMP,');
  AqryConsulta.SQL.Add('   TFC_LOC_IP,');
  AqryConsulta.SQL.Add('   TFC_EMPTIP,');
  AqryConsulta.SQL.Add('   TFC_PINPOR,');
  AqryConsulta.SQL.Add('   TFC_PINFAB,');
  AqryConsulta.SQL.Add('   TFC_COMTEF,');
  AqryConsulta.SQL.Add('   TFC_TIPTEF,');
  AqryConsulta.SQL.Add('   TFC_TSALES,');
  AqryConsulta.SQL.Add('   TFC_TKSALE,');
  AqryConsulta.SQL.Add('   TFC_ADQUIR ');
  AqryConsulta.SQL.Add(' FROM');
  AqryConsulta.SQL.Add('   TEFCFG');
  AqryConsulta.SQL.Add(' WHERE TFC_TIPTEF IN ('+ fTrataTefCitTerminalFiltro +')');
  if fCfgSis('TIPTER', varString) = '1' then
  begin
    AqryConsulta.SQL.Add('   AND TFC_CODEMP = :CODEMP');
    AqryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
  end ;
  AqryConsulta.Open;
end;

procedure TfrmCadCfgTerminalTef.pCarregaDllsAcessoPinPad;
var
  LlstDlls: TStrings ;
begin
  LlstDlls := TStringList.Create ;
  try
    cbFabricantePinPad.Items.Clear ;
    TListaDllAcessoPinPad.pCarrega(LlstDlls) ;
    cbFabricantePinPad.Items.Assign(LlstDlls);
  finally
    FreeAndNil(LlstDlls) ;
  end ;
end;

procedure TfrmCadCfgTerminalTef.pCarregaEmpresa;
begin
  pPesquisaCadEmp(FqryConEmp, FqryConEmp, edtCodEmp.Text);
  edtNomEmp.Text := FqryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmCadCfgTerminalTef.pDeletaTerminal;
var
  qryTefTra : TUniQuery;
begin
  blnDeletou := False;
  try
    qryTefTra := fCriaQuery(Self);

    qryTefTra.SQL.Clear;
    qryTefTra.SQL.Add(' SELECT                    ');
    qryTefTra.SQL.Add('   TFC_NUMTER,             ');
    qryTefTra.SQL.Add('   TFC_NUMLOJ,             ');
    qryTefTra.SQL.Add('   TFC_MACADD,             ');
    qryTefTra.SQL.Add('   TFC_NOMUSU,             ');
    qryTefTra.SQL.Add('   TFC_NOMMAQ,             ');
    qryTefTra.SQL.Add('   TFC_CODEMP,             ');
    qryTefTra.SQL.Add('   TFC_NUM_IP,             ');
    qryTefTra.SQL.Add('   TFC_PATIMP,             ');
    qryTefTra.SQL.Add('   TFC_EMPTIP,             ');
    qryTefTra.SQL.Add('   AUTOINCREM,             ');
    qryTefTra.SQL.Add('   TFC_PINPOR,             ');
    qryTefTra.SQL.Add('   TFC_PINFAB,             ');
    qryTefTra.SQL.Add('   TFC_COMTEF,             ');
    qryTefTra.SQL.Add('   TFC_TSALES,             ');
    qryTefTra.SQL.Add('   TFC_TIPTEF,             ');
    qryTefTra.SQL.Add('   TFC_TKSALE              ');
    qryTefTra.SQL.Add(' FROM                      ');
    qryTefTra.SQL.Add('   TEFCFG                  ');
    qryTefTra.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM ');

    qryTefTra.ParamByName('AUTOINCREM').AsString := CdsTerminaisTefAUTOINCREM.AsString;
    qryTefTra.Open;
    qryTefTra.delete;
  finally
    blnDeletou := True;
    FreeAndNil(qryTefTra);
  end;
end;

procedure TfrmCadCfgTerminalTef.pMostraColunaTerminalSales;
begin
  if not FblnTerminalSales then
    Exit ;

  cxGridTerminaisTFC_TSALES.Visible := True ;
  cxGridTerminaisTFC_TSALES.VisibleForCustomization := True ;

  cxGridTerminaisTFC_TKSALE.Visible := True ;
  cxGridTerminaisTFC_TKSALE.VisibleForCustomization := True ;

end;

procedure TfrmCadCfgTerminalTef.pLimpaCampos;
begin
  edtNumTer.Clear();
  edtNumLoja.Clear();
  edtMacAdd.Clear();
  edtNomUsu.Clear();
  edtNomMaq.Clear();
  edtIpServ.Clear();
  edtIpMaquina.Clear();
  edtImpressora.Clear();
  edtCodEmp.Clear();
  edtNomEmp.Text := ifthen(strTipTer = '2', 'TODOS', '');
  cbPortaPinPad.ItemIndex := 0;
  cmbPortaComTef.ItemIndex := 0;
  cbFabricantePinPad.ItemIndex := 0;
  pcConfiguracoes.ActivePageIndex := 0 ;
  rgOpcaoSales.ItemIndex := 0 ;
  edtTerminalSales.Clear();
  edtTokenMsitef.Clear();
end;

procedure TfrmCadCfgTerminalTef.pPosicionaEdtTerminalSales;
begin
  lblTerminalSales.Left := lblMacAdd.Left ;
  lblTerminalSales.Top := lblMacAdd.Top ;

  edtTerminalSales.Left := edtMacAdd.Left ;
  edtTerminalSales.Top := edtMacAdd.Top ;

  rgOpcaoSales.Left := lblNomUsu.Left ;
  rgOpcaoSales.Top  := lblNomUsu.Top ;

  lblTokenMsitef.Left := lblNomMaq.Left ;
  edtTokenMsitef.Left := edtNomMaq.Left ;

end;

procedure TfrmCadCfgTerminalTef.pShowEdtsTerminalAutcom;
begin
  if strTipTer = '1' then
  begin
    lblIpMaquina.Visible := False;
    edtIpMaquina.Visible := False;
    cxGridTerminaisTFC_LOC_IP.Visible := False;
    cxGridTerminaisTFC_EMPTIP.Visible := False ;

    edtNomMaq.Width := 365;
    edtCodEmp.Visible := False ;
    edtNomEmp.Visible := False ;
    lblEmpresa.Visible := False ;
  end;

  if strTipTer = '2' then
  begin
    lblIpMaquina.Visible := True;
    edtIpMaquina.Visible := True;

    lblMacAdd.Visible := False;
    edtMacAdd.Visible := False;
    cxGridTerminaisTFC_MACADD.Visible := False;

    lblNomUsu.Visible := False;
    edtNomUsu.Visible := False;
    cxGridTerminaisTFC_NOMUSU.Visible := False;
    cxGridTerminaisTFC_CODEMP.Visible := False ;

    edtCodEmp.Visible := True ;
    edtNomEmp.Visible := True ;
    lblEmpresa.Visible := True ;
    //ajusta posição
    lblEmpresa.Top := lblNomUsu.Top ;
    edtCodEmp.Top := edtNomUsu.Top ;
    edtNomEmp.Top := edtNomUsu.Top ;
  end;

  if strTipTer = '3' then
  begin
    lblMacAdd.Visible := False;
    edtMacAdd.Visible := False;
    cxGridTerminaisTFC_MACADD.Visible := False;

    lblNomUsu.Visible := False;
    edtNomUsu.Visible := False;
    cxGridTerminaisTFC_NOMUSU.Visible := False;
    cxGridTerminaisTFC_CODEMP.Visible := False ;

    edtCodEmp.Visible := True ;
    edtNomEmp.Visible := True ;
    lblEmpresa.Visible := True ;
    //ajusta posição
    lblEmpresa.Top := lblNomUsu.Top ;
    edtCodEmp.Top := edtNomUsu.Top ;
    edtNomEmp.Top := edtNomUsu.Top ;

    lblIpMaquina.Visible := False ;
    edtIpMaquina.Visible := False ;
    cxGridTerminaisTFC_LOC_IP.Visible := False ;
  end ;
end;

procedure TfrmCadCfgTerminalTef.pShowTerminalSales(AblnMostrar: Boolean);
begin
  if Not FblnTerminalSales then
    AblnMostrar := False ;

  case AblnMostrar of
    True: pAjustaFormularioClisitefOuPOS;
    False: pAjustaFormulario;
  end;

  lblMacAdd.Visible := not AblnMostrar ;
  edtMacAdd.Visible := not AblnMostrar ;
  lblNomMaq.Visible := not AblnMostrar ;
  edtNomMaq.Visible := not AblnMostrar ;
  lblIpMaquina.Visible := not AblnMostrar ;
  edtIpMaquina.Visible := not AblnMostrar ;
  lblNomUsu.Visible := not AblnMostrar ;
  edtNomUsu.Visible := not AblnMostrar ;

  lblEmpresa.Visible := not AblnMostrar ;
  edtCodEmp.Visible := not AblnMostrar ;
  edtNomEmp.Visible := not AblnMostrar ;

  lblImpressora.Visible := not AblnMostrar ;
  edtImpressora.Visible := not AblnMostrar ;
  btnLocImp.Visible := not AblnMostrar ;
  tsPinPad.TabVisible := not AblnMostrar ;

  btnConsultaInfo.Visible := not AblnMostrar ;

  lblTerminalSales.Visible := AblnMostrar ;
  edtTerminalSales.Visible := AblnMostrar ;
  rgOpcaoSales.Visible := AblnMostrar ;
  lblTokenMsitef.Visible := AblnMostrar ;
  edtTokenMsitef.Visible := AblnMostrar ;

  lblTokenMsitef.Visible := False ;
  edtTokenMsitef.Visible := False ;

  if not AblnMostrar then
    pShowEdtsTerminalAutcom
  else
  begin
    pShowTerminalSalesMSitef(rgOpcaoSales.ItemIndex = OPC_MSITEF) ;
    pCarregarAdquirentes;
  end;

  pAtualizaNomeAbaTEF(not AblnMostrar) ;
  pVisibleComboAdquirente(AblnMostrar);
end;

procedure TfrmCadCfgTerminalTef.pVisibleComboAdquirente(const AValue: Boolean);
begin
  cmbAdquirente.Visible := False;
  lblAdquirente.Visible := False;

  if not AValue then Exit;

  cmbAdquirente.Visible := fPodeInserirAdquirenteTerminalSales;
  lblAdquirente.Visible := cmbAdquirente.Visible;
end;

function TfrmCadCfgTerminalTef.fIsTerminalSales: Boolean;
begin
  Result := (fCfgSis('TERSAL', varString) = 'S');
end;

function TfrmCadCfgTerminalTef.fPodeInserirAdquirenteTerminalSales: Boolean;
begin
  Result := (rgOpcaoSales.Visible and (rgOpcaoSales.ItemIndex = OPC_REDEFLEX)) and fIsTerminalSales;
end;

procedure TfrmCadCfgTerminalTef.pCarregarAdquirentes;
var
  LSQL: string;
  LqryAdquir: TUniQuery;
  LobjItemCombo: TItemCombo;
begin
  cmbAdquirente.Items.Clear;
  cmbAdquirente.Items.Add('');

  LSQL := 'SELECT AUTOINCREM, ADQ_DESCRI FROM ADQUIR ORDER BY ADQ_DESCRI';
  LqryAdquir := fCriaQuery();
  try
    LqryAdquir.SQL.Text := LSQL;
    LqryAdquir.Open;

    LqryAdquir.First;
    while not LqryAdquir.Eof do
    begin
      LobjItemCombo := TItemCombo.Create;
      LobjItemCombo.Codigo := LqryAdquir.FieldByName('AUTOINCREM').AsString;
      LobjItemCombo.Descricao := LqryAdquir.FieldByName('ADQ_DESCRI').AsString;
      cmbAdquirente.Items.AddObject(LobjItemCombo.Descricao, LobjItemCombo);
      LqryAdquir.Next;
    end;
    cmbAdquirente.ItemIndex := 0;
  finally
    FreeAndNil(LqryAdquir);
  end;
end;

function TfrmCadCfgTerminalTef.fIndexOfNomeAdquirente(const ACodAdquir: string): Integer;
var
  LObj: TItemCombo;
  I: Integer;
begin
  Result := -1;
  for I := 0 to Pred(cmbAdquirente.Items.Count) do
  begin
    LObj := TItemCombo(cmbAdquirente.Items.Objects[I]);
    if Assigned(LObj) and (LObj.Codigo = ACodAdquir) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

procedure TfrmCadCfgTerminalTef.pLimparComboBoxAdquirente;
var
  LObj: TObject;
  I: Integer;
begin
  for I := 0 to Pred(cmbAdquirente.Items.Count) do
  begin
    LObj := cmbAdquirente.Items.Objects[I];
    if Assigned(LObj) then
      FreeAndNil(LObj);
  end;
  cmbAdquirente.Items.Clear;
end;

procedure TfrmCadCfgTerminalTef.pShowTerminalSalesMSitef(AblnMostrar: Boolean);
begin
  lblNumLoja.Visible := AblnMostrar ;
  edtNumLoja.Visible := AblnMostrar ;
  lblServidorTef.Visible := AblnMostrar ;
  edtIpServ.Visible := AblnMostrar ;
  lblTokenMsitef.Visible := AblnMostrar ;
  edtTokenMsitef.Visible := AblnMostrar ;

  /// reposicionar os componentes na tela.
  if AblnMostrar then
  begin
    lblNumTer.Top := FintTopLblNumTer ;
    edtNumTer.Top := FintTopEdtNumTer ;
    rgOpcaoSales.Top := FintTopRgOpcaoSales ;
    lblAdquirente.Top := FintTopRgOpcaoSales;
    cmbAdquirente.Top := lblAdquirente.Top + lblAdquirente.Height + 1;
  end
  else
  begin
    lblNumTer.Top := lblNumLoja.Top ;
    edtNumTer.Top := edtNumLoja.Top ;
    rgOpcaoSales.Top := lblNomMaq.Top ;
    lblAdquirente.Top := lblNomMaq.Top;
    cmbAdquirente.Top := lblAdquirente.Top + lblAdquirente.Height + 1;
  end;
end;

procedure TfrmCadCfgTerminalTef.rgOpcaoSalesClick(Sender: TObject);
var
  LIndex: Integer;
begin
  inherited;
  LIndex := TRadioGroup(Sender).ItemIndex;
  pShowTerminalSalesMSitef(LIndex = OPC_MSITEF) ;
  pVisibleComboAdquirente(LIndex = OPC_REDEFLEX);
end;

function TfrmCadCfgTerminalTef.fPerguntaSobreTerminalSales: Boolean;
begin
  Result := False ;

  if not FblnTerminalSales then
    Exit ;

  if not fEhAdministrador(strLoginUsuarioLogado) then
    if not fVerLiberacaoCadastroTerminalSales then
      Exit ;

  Result := fMensagem('Aviso', 'Deseja cadastrar um terminal Smart POS (Citel Sales)?', ['&Sim', '&Não'], 2) = 1  ;
end;

function TfrmCadCfgTerminalTef.fRetornaVersaoTefDLL: String;
const
  TEFDLL = 'CliSiTef32I.dll' ;
var
  LstrPathTerminal: String ;
  LstrPathDLL: String ;
  LstrMsgRetorno: String ;
  LstrVersao: String ;
  LstrTerminal: String ;
begin
  Result := '' ;
  LstrTerminal := CdsTerminaisTefNUMTER.AsString ;
  LstrPathTerminal := fDiretorioPorTerminal(LstrTerminal) ;

  //busca o path do autcom.exe
  if fEmptyStr(LstrPathTerminal) then
    LstrPathDLL := ExtractFileDir(Application.ExeName) + '\'
  else
    LstrPathDLL := LstrPathTerminal ;

  if not DirectoryExists(LstrPathDLL) then
  begin
    fMensagem('ATENÇÃO!', 'Diretório não encontrado:' + #13+#10 + LstrPathDLL , ['&Ok']);
    exit ;
  end ;

  if not FileExists(LstrPathDLL+TEFDLL) then
  begin
    fMensagem('ATENÇÃO!', 'DLL não encontrada:' + #13+#10 + LstrPathDLL+TEFDLL , ['&Ok']);
    exit ;
  end ;

  LstrVersao := fRetornaVersao(LstrPathDLL+TEFDLL) ;

  if fEmptyStr(LstrPathTerminal) then
  begin
    LstrMsgRetorno := 'Versão da %s é %s ' ;
    result := Format(LstrMsgRetorno, [TEFDLL, LstrVersao]) ;
  end
  else
  begin
    LstrMsgRetorno := 'Versão da %s no terminal %s é %s ' ;
    result := Format(LstrMsgRetorno, [TEFDLL, LstrTerminal, LstrVersao]) ;
  end ;

end;

function TfrmCadCfgTerminalTef.fTrataCodEmp(const AstrCodEmp: string): Variant;
begin
  Result := Null ;
  if not fEmptyStr(AstrCodEmp) then
    Result := AstrCodEmp ;
end;

function TfrmCadCfgTerminalTef.fTrataTefCitTerminalFiltro: String;
var
  LstrTefCit: String ;
begin
  Result :=  fQuotedStr('S') ;
  LstrTefCit := fCfgSis('TEFCIT', varString) ;
  if LstrTefCit = OPCAO_NCR then
    Result := fQuotedStr(LstrTefCit)
  else if LstrTefCit = OPCAO_CLISITEF then
    Result := fQuotedStr(LstrTefCit) + ',' + fQuotedStr(OPCAO_REDE_FLEX_POS) ;
end;

function TfrmCadCfgTerminalTef.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodEmp) and ((strTipTer = '2') or (strTipTer = '3')) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := ifthen(strTipTer = '2', 'TODOS', '');
        edtCodEmp.Clear();
      End
      Else
      Begin
        pCarregaEmpresa;
        If (FqryConEmp.FieldByName('EMP_CODEMP').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          edtCodEmp.Clear();
          Result := False;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadCfgTerminalTef.fValidacaoCampos : Boolean;
begin
  Result := True;

  if fEmptyStr(edtNumTer.Text) then
  begin
    fMensagem('', 'Informe o número do terminal!', ['&OK']);
    pSetFocus(edtNumTer);
    Result := False;
    Exit;
  end;

  if fEmptyStr(edtNumLoja.Text) then
  begin
    fMensagem('', 'Informe o código da loja!', ['&OK']);
    pSetFocus(edtNumLoja);
    Result := False;
    Exit;
  end;

  if not fEdtTerminalSalesVisivel then
  begin

    if ((fEmptyStr(edtMacAdd.Text)) and (strTipTer = '1')) then
    begin
      fMensagem('', 'Informe o endereço MAC!', ['&OK']);
      pSetFocus(edtMacAdd);
      Result := False;
      Exit;
    end;

    if fEmptyStr(edtNomMaq.Text) then
    begin
      fMensagem('', 'Informe o nome da Máquina!', ['&OK']);
      pSetFocus(edtNomMaq);
      Result := False;
      Exit;
    end;

    if fEmptyStr(edtCodEmp.Text) and (strTipTer = '3') then
    begin
      fMensagem('', 'Informe Empresa!', ['&OK']);
      pSetFocus(edtCodEmp);
      Result := False;
      Exit;
    end ;

    if not fEmptyStr(edtCodEmp.Text) then
      edtCodEmp.Text := fStrZero(edtCodEmp.Text, 3) ;

    if not fValidaCampos(edtCodEmp) then
    begin
      Result := False;
      Exit;
    end ;

    if fEmptyStr(edtImpressora.Text) then
    begin
      fMensagem('', 'Informe o caminho da impressora do TEF!', ['&OK']);
      pSetFocus(edtImpressora);
      Result := False;
      Exit;
    end;

  end
  else
  begin
    if fEmptyStr(edtTerminalSales.Text) then
    begin
      fMensagem('', 'Informe o Número Série Smart POS (Citel Sales)!', ['&OK']);
      pSetFocus(edtTerminalSales);
      Result := False;
      Exit;
    end;
  end ;

  if not fValidaIpServOuComTef then
  begin
    Result := False;
    Exit;
  end ;

end;

function TfrmCadCfgTerminalTef.fValidaIpServOuComTef: Boolean;
begin
  Result := True ;
  if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
  begin
    if FTelaExibindo = TELA_CLISITEF then
      Exit;

    if fEmptyStr(cmbPortaComTef.Text) then
    begin
      fMensagem('', 'Informe e Porta de Comunicação [COM] da Leitora de Cartão com Fio [Pinpad]!', ['&OK']);
      pSetFocus(cmbPortaComTef);
      Result := False;
      Exit;
    end;
  end
  else
  begin
    if fEmptyStr(edtIpServ.Text) then
    begin
      fMensagem('', 'Informe o ip do servidor TEF!', ['&OK']);
      pSetFocus(edtIpServ);
      Result := False;
      Exit;
    end;
  end ;
end;

function TfrmCadCfgTerminalTef.fVerificaTerminalExiste(blnLocate : Boolean; strMacAdd : String): Boolean;
begin
  Result := False;

  if blnLocate then
  begin
    fRollBack;

    if fEdtTerminalSalesVisivel then
      fMensagem('', 'Já existe um terminal cadastrado para este Número Série Smart POS (Citel Sales)!', ['&OK'])
    else
      if strTipTer = '1' then
      begin
        if strMacAdd = edtMacAdd.Text then
          fMensagem('', 'Já existe um terminal cadastrado para este endereço MAC!', ['&OK'])
        else
          fMensagem('', 'Terminal já adicionado!', ['&OK']);
      end
      else if strTipTer = '2' then
      begin
        fMensagem('', 'Já existe um terminal cadastrado para as seguintes informações: '+sLineBreak+
                      'MAQUINA: '+edtNomMaq.Text+sLineBreak+
                      'IP: '+edtIpMaquina.Text,['&OK']);
      end
      else /// 3
      begin
        fMensagem('', 'Já existe um terminal cadastrado para as seguintes informações: '+sLineBreak+
                      'MAQUINA: '+edtNomMaq.Text+sLineBreak+
                      'Empresa: '+edtCodEmp.Text,['&OK']);
      end ;

    Result := True;
  end;
end;

function TfrmCadCfgTerminalTef.fVerLiberacaoCadastroTerminalSales: Boolean;
var
  LobjLiberacao:  TLiberacao;
begin
  LobjLiberacao := TLiberacao.Create;
  try
    Result := True;
    If Not fVerificaAcessoSistema('TEFCADTERSAL', strLoginUsuarioLogado) Then
    Begin
      LobjLiberacao.Clear;
      LobjLiberacao.objMsgLibera.pAddSeparador(106);
      LobjLiberacao.objMsgLibera.pAddTexto('Permitir cadastrar terminal TEF (Citel Sales) quando operador não for do grupo ADM');
      LobjLiberacao.objMsgLibera.pAddTextoCaption('', 'Terminal TEF', 23);

      LobjLiberacao.strDirAce := 'TEFCADTERSAL';
      LobjLiberacao.strMsgSen := 'Cadastro Terminal TEF (Citel Sales)';
      LobjLiberacao.blnMosMen := True;
      LobjLiberacao.strCodOpe := strLoginUsuarioLogado;
      LobjLiberacao.strCodDig := strLoginUsuarioLogado;
      LobjLiberacao.objMsgLibera.pAddSeparador(106);

      If (Not LobjLiberacao.fLibera) Then
        Result := False;
    End;
  finally
    FreeAndNil(LobjLiberacao);
  End;
end;

end.
