{***********************}
{* qryConCli -> CADCLI *}
{* qryConBco -> CADBCO *}
{********************JB*}
unit untFinDesmRemBanc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.StrUtils,
  Dialogs, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask, MaskEditFocus, StdCtrls,
  EditFocus, Menus, ComCtrls, Buttons, ExtCtrls, QColorLabel, DB, Uni,
  AppEvnts, MemoFocus, UniClientDataSet, UniDataSetProvider, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, untTypesSistema, untTRestauraRemessa,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  System.Generics.Collections,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFinDesmRemBanc = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    pnlBotoesBaixa: TPanel;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label9: TLabel;
    edtTotalDup: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    Label5: TLabel;
    Nome: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    edtCodCliBai: TEditFocus;
    edtNomCliBai: TEditFocus;
    edtNomPorBai: TEditFocus;
    edtCodPorBai: TEditFocus;
    edtNosNum: TEditFocus;
    Label4: TLabel;
    edtCodBco: TEditFocus;
    edtDesBco: TEditFocus;
    gpbDadEnv: TGroupBox;
    Label8: TLabel;
    Label11: TLabel;
    edtDtaEnv: TEditFocus;
    edtBcoEnv: TEditFocus;
    edtHistor: TMemoFocus;
    btnConfirma: TBitBtnLocked;
    btnSairAgrup: TBitBtnLocked;
    BtnMarcarTodas2: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    dtsCtaRec: TDataSource;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnConsultar: TBitBtnLocked;
    rbtDtaVen: TRadioButton;
    rbtDtaEnv: TRadioButton;
    dbgDuplicatasDBTableView1: TcxGridDBTableView;
    dbgDuplicatasLevel1: TcxGridLevel;
    dbgDuplicatas: TcxGrid;
    colNumDup: TcxGridDBColumn;
    colEspDoc: TcxGridDBColumn;
    colCodEmp: TcxGridDBColumn;
    colDtaVen: TcxGridDBColumn;
    colValDup: TcxGridDBColumn;
    Label6: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmpresa: TEditFocus;
    FlwpnlBotoesBaixa: TFlowPanel;
    colDtaCad: TcxGridDBColumn;
    rbtDtaCad: TRadioButton;
    dbgDuplicatasCTR_MARDES: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairAgrupClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodBcoExit(Sender: TObject);
    procedure BtnMarcarTodas2Click(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mskDtaIniPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edtCodCliExit(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure dbgDuplicatasDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgDuplicatasDBTableView1CellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    objRestRemessa: TRestauraRemessa;

    arrClientes,
    arrEmpresas,
    arrBancos : TConsultasArray;

    qryConEmp: TUniQuery;
    LAutoIncremCTR: String;
    LConfirma : Boolean;

    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pLimpaDados;
    procedure pSelecionaDuplicata;
    procedure pCarregaEmpresa;
    procedure CarregaDuplicataParaRestauracao;
    function ChamadaDeOutraRotina: Boolean;
    function fPermiteRestaurarBoletoAPI : Boolean;
    function fValidaSelecaoBoleto : Boolean;
    function fAvisaBoletoEmRemessaArquivo(ACarteiraBoleto : String) : Boolean;
    function fCancelaBoletoEmRemessaAPI(ACarteiraBoleto: String): Boolean;
    procedure LimpaDadosDuplicata;
    { Private declarations }
  public
    { Public declarations }
    lstRecCbi: TStringList;

    property AutoIncrem: String   Read LAutoIncremCTR Write LAutoIncremCTR;
    property Confirma:   Boolean  Read LConfirma      Write LConfirma;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
  end;


implementation

uses untFuncoes, untFuncoesSimples, untPesqAux, untConsultas,
  untFuncoesConsulta, untConstantes, untGravando, untTFuncoesBancoOnline;

{$R *.dfm}

function TfrmFinDesmRemBanc.fPermiteRestaurarBoletoAPI: Boolean;
begin
  Result := fCfgSis('PERREB', varBoolean);
end;

function TfrmFinDesmRemBanc.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Try
    Result := True;
    {* CLIENTE *}
    If Sender = edtCodCli Then
    Begin
      objRestRemessa.strCodCli := edtCodCli.Text;
      pDesmarcaLista(edtCodCli, arrClientes);
    End

    {* BANCO *}
    Else If Sender = edtCodBco Then
    Begin
      objRestRemessa.strCodBco := edtCodBco.Text;
      pDesmarcaLista(edtCodBco, arrBancos);
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
         objRestRemessa.strEmpAce := '';
         objRestRemessa.strCodEmp := edtCodEmp.Text;
         pDesmarcaLista(edtCodEmp, arrEmpresas);

        If edtCodEmp.Text <> '000' Then
           pCarregaEmpresa;

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) And (edtDesEmpresa.Text <> '+1') Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        objRestRemessa.strCodEmp := '';
        objRestRemessa.strEmpAce := strEmpAcessoUsuarioLogado;
      End;

    End

    {* DATA INICIAL *}
    Else If Sender = mskDtaIni Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If blnBuscaPorChave Then
          mskDtaFin.Clear;

        mskDtaFin.Enabled := False;
        objRestRemessa.dtaDtaIni := 0;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
        objRestRemessa.dtaDtaIni := mskDtaIni.Date;
      End;
    End

    {* DATA FINAL *}
    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          pMensagemOk('A Data Final deve ser preenchida!');
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          pMensagemOk('A Data Final deve ser maior ou igual a Data Inicial!');
          Result := False;
        End
        Else objRestRemessa.dtaDtaFin := mskDtaFin.Date;
      End;
    End;

    If rbtDtaEnv.Checked Then
      objRestRemessa.opcDataEV := tdEnvio
    Else If rbtDtaVen.Checked Then
      objRestRemessa.opcDataEV := tdVencimento
    Else
      objRestRemessa.opcDataEV := tdCadastro;

  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagemOk(E.Message);
      Result := False;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFinDesmRemBanc.fValidaSelecaoBoleto: Boolean;
const
  LBancosAPI : array[0..5] of string = ('341', '756', '033', '001', '748', '237');
var
  LCarteiraBoleto: String;
  LAutoIncremBoleto : String;
  LBancoBoleto : String;
  LIndiceBanco : Integer;
begin
  Result := True;

  LCarteiraBoleto := objRestRemessa.qryRec.FieldByName('CTR_CARTEI').AsString;
  if fAvisaBoletoEmRemessaArquivo(LCarteiraBoleto) Then
  begin
    fMensagem('ATENÇÃO!', 'Este documento possui títulos registrados no banco. '  + #13#10 +
              'Deve-se também cancelar o registro no banco correspodente.', ['&OK']);
  end
  else
  begin
    if fCancelaBoletoEmRemessaAPI(LCarteiraBoleto) Then
    begin
      LAutoIncremBoleto := objRestRemessa.qryRec.FieldByName('AUTOINCREM').AsString;
      LBancoBoleto := objRestRemessa.qryRec.FieldByName('CTR_BCOBOL').AsString;
      LIndiceBanco := AnsiIndexStr(LBancoBoleto, LBancosAPI);

      if (LIndiceBanco >= 0) and (LIndiceBanco <= 5) Then
      begin
        If fMensagem('', 'Este documento possui títulos registrados no banco.' + #13 +
                         'Deve-se cancelar primeiro o registro! '  + #13 +
                         'Deseja cancelar agora?', ['&Sim', '&Não']) = 1 Then
        begin

          case LIndiceBanco of
            0 : Result := fCancelarBoletosRegistradosItauAPI(LCarteiraBoleto, LAutoIncremBoleto);
            1 : Result := fCancelarBoletosRegistradosSicoobAPI(LCarteiraBoleto, LAutoIncremBoleto);
            2 : Result := fCancelarBoletosRegistradosSantanderAPI(LCarteiraBoleto, LAutoIncremBoleto);
            3 : Result := CancelaBoletoRegistradoBancoDoBrasil(LCarteiraBoleto, LAutoIncremBoleto);
            4 : Result := fCancelarBoletosRegistradosSicredAPI(LCarteiraBoleto, LAutoIncremBoleto);
            5 : Result := CancelarBoletosRegistradosBradescoAPI(LCarteiraBoleto, LAutoIncremBoleto);
          end;

          btnConsultar.Click;

          Exit;
        end;
      end;

      if not fPermiteRestaurarBoletoAPI Then
      begin
        fMensagem('ATENÇÃO!', 'Rotina não permitida para boletos emitidos via API.' + #13#10 +
                  'É necessário utilizar a rotina de Cancelamento de Boletos.', ['&O k']);
        Result := False;
      end;

    end;
  end;
end;

procedure TfrmFinDesmRemBanc.LimpaDadosDuplicata;
begin
  edtCodCliBai.Clear;
  edtNomCliBai.Clear;
  edtCodPorBai.Clear;
  edtNomPorBai.Clear;
  edtNosNum.Clear;
  edtHistor.Clear;
  edtDtaEnv.Clear;
  edtBcoEnv.Clear;
end;

procedure TfrmFinDesmRemBanc.mskDtaIniPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  If Error Then pMensagemOk('Data Invalida');
end;

procedure TfrmFinDesmRemBanc.pAtualizaDados(DataSet: TDataSet);
begin
  LimpaDadosDuplicata;

  If objRestRemessa.qryRec.IsEmpty Then
    Exit;

  edtCodCliBai.Text := objRestRemessa.qryRec.FieldByName('CTR_CODCLI').AsString;
  edtNomCliBai.Text := fRetNomCliente(objRestRemessa.qryRec.FieldByName('CTR_CODCLI').AsString);

  edtCodPorBai.Text := objRestRemessa.qryRec.FieldByName('CTR_PORBAI').AsString;
  edtNomPorBai.Text := fRetNomPortador(objRestRemessa.qryRec.FieldByName('CTR_PORBAI').AsString);

  edtNosNum.Text    := objRestRemessa.qryRec.FieldByName('CTR_NOSNUM').AsString;
  edtHistor.Text    := objRestRemessa.qryRec.FieldByName('CTR_HIST01').AsString;

  If objRestRemessa.qryRec.FieldByName('CTR_DTAENV').AsDateTime > 0 Then
    edtDtaEnv.Text := FormatDateTime('dd/mm/yyyy', objRestRemessa.qryRec.FieldByName('CTR_DTAENV').AsDateTime);

  If Not objRestRemessa.qryRec.FieldByName('CTR_BCOENV').AsString.IsEmpty Then
    edtBcoEnv.Text := objRestRemessa.qryRec.FieldByName('CTR_BCOENV').AsString + ' - ' +
                      fRetNomeBco(objRestRemessa.qryRec.FieldByName('CTR_BCOENV').AsString);

  If pnlTotais.Visible Then
    edtTotalSelecionado.Text := FloatToStrF(objRestRemessa.fltTotMar, ffNumber,12,2);
end;

procedure TfrmFinDesmRemBanc.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  pLimpaDados;

  FreeAndNil(objRestRemessa);
  inherited;
end;

procedure TfrmFinDesmRemBanc.FormCreate(Sender: TObject);
begin
  inherited;

  objRestRemessa    := TRestauraRemessa.Create(Self);
  dtsCtaRec.DataSet := objRestRemessa.qryRec;
  objRestRemessa.qryRec.AfterScroll := pAtualizaDados;

  mskDtaIni.Date := VS_Date;
  mskDtaFin.Date := VS_Date;
end;

procedure TfrmFinDesmRemBanc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: If ActiveControl.ClassName = 'TcxGridSite' Then pSelecionaDuplicata;
    VK_Escape: Begin
                 pLimpaDados;
                 If ChamadaDeOutraRotina Then btnSairAgrup.Click;
               End;
    VK_F7    : BtnMarcarTodas2.Click;
    VK_F8    : btnDesmarca.Click;
    VK_F10   : Begin
                 Key := 0;
                 btnConfirma.Click;
               End;
  End;

end;

procedure TfrmFinDesmRemBanc.FormShow(Sender: TObject);
begin
  inherited;
  LConfirma := False;
  If Assigned(lstRecCbi) And (lstRecCbi.count > 0) Then
  Begin
    pnlTotais.Visible    := False;
    pnlCabecalho.Visible := False;

    objRestRemessa.ListaFiltros.Text := lstRecCbi.Text;
    objRestRemessa.pCarregaDados;
    pAtualizaDados(dtsCtaRec.DataSet);
    dtsCtaRec.DataSet := objRestRemessa.qryRec;
    objRestRemessa.qryRec.AfterScroll := pAtualizaDados;
    edtTotalDup.Text := FloatToStrF(objRestRemessa.fltTotDup, ffNumber,12,2);

    pSetFocus(dbgDuplicatas);

    TFloatField(objRestRemessa.qryRec.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
  End;

  edtCodEmp.Text     := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

  If Not fEmptyStr(LAutoIncremCTR) Then
    CarregaDuplicataParaRestauracao;
end;

procedure TfrmFinDesmRemBanc.pLimpaDados;
begin
  edtCodCliBai.Clear;
  edtNomCliBai.Clear;
  edtCodPorBai.Clear;
  edtNomPorBai.Clear;
  edtNosNum.Clear;
  edtHistor.Clear;

  edtTotalDup.Clear;
  edtTotalSelecionado.Clear;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  edtCodCli.Clear;
  edtNomCli.Clear;

  objRestRemessa.pLimparDados;

  pSetFocus(edtCodCli);
end;

procedure TfrmFinDesmRemBanc.pSelecionaDuplicata;
  Var
    LprcScroll: TprcScroll;
begin
  If (Not objRestRemessa.qryRec.Active) Then
    Exit;

  If objRestRemessa.qryRec.IsEmpty Then
    Exit;

  If not objRestRemessa.qryRec.FieldByName('CTR_MARDES').AsString.Equals('M') Then
    if not fValidaSelecaoBoleto then
      Exit;

  pDisableControls(objRestRemessa.qryRec, LprcScroll);

  Try
    If objRestRemessa.qryRec.FieldByName('CTR_MARDES').AsString.Equals('M') Then
      objRestRemessa.pDeleteSelecion
    Else
      objRestRemessa.pInsertSelecion;

    pAtualizaDados(dtsCtaRec.DataSet);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  dbgDuplicatasDBTableView1.DataController.Refresh;

  pEnableControls(objRestRemessa.qryRec, LprcScroll);
end;

procedure TfrmFinDesmRemBanc.dbgDuplicatasDBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pSelecionaDuplicata;
end;

procedure TfrmFinDesmRemBanc.dbgDuplicatasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    LMarcado: String;
begin
  inherited;

  If Not Assigned(objRestRemessa) Then
    Exit;

  If Not Assigned(objRestRemessa.qryRec) Then
    Exit;

  If objRestRemessa.qryRec.IsEmpty Then
    Exit;

  LMarcado := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTR_MARDES.Index]);

  If LMarcado.Equals('M') Then
  Begin
    ACanvas.Font.Color := clBlue;
    If AViewInfo.Selected Then
      ACanvas.Font.Color := clLime;
  End;
end;

procedure TfrmFinDesmRemBanc.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmFinDesmRemBanc.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFinDesmRemBanc.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmpresa, arrEmpresas, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmFinDesmRemBanc.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmpresa, Nil, Key, arrEmpresas, True, True) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFinDesmRemBanc.fAvisaBoletoEmRemessaArquivo(
  ACarteiraBoleto: String): Boolean;
begin
  Result := False;
  if fEmptyStr(ACarteiraBoleto) then
    Exit;

  if ACarteiraBoleto.Contains('API-') then
    Exit;

  Result := True;
end;

function TfrmFinDesmRemBanc.fCancelaBoletoEmRemessaAPI(
  ACarteiraBoleto: String): Boolean;
begin
  Result := False;
  if fEmptyStr(ACarteiraBoleto) then
    Exit;

  if not ACarteiraBoleto.Contains('API-') then
    Exit;

  Result := True;
end;

procedure TfrmFinDesmRemBanc.edtCodBcoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqBanco(Self, edtCodBco, edtDesBco, qryTabela, Key, arrBancos) Then
  Begin
    If fValidaCampos(edtCodBco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFinDesmRemBanc.btnConsultarClick(Sender: TObject);
  Var
    LprcScroll: TprcScroll;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  Try
    pDisableControls(objRestRemessa.qryRec, LprcScroll);

    TfrmGravando.fExecutarModal(objRestRemessa.pCarregaDados, 'Aguarde... Carregando Títulos.', '');
    pAtualizaDados(dtsCtaRec.DataSet);
    dtsCtaRec.DataSet := objRestRemessa.qryRec;
    objRestRemessa.qryRec.AfterScroll := pAtualizaDados;
    edtTotalDup.Text := FloatToStrF(objRestRemessa.fltTotDup, ffNumber,12,2);
  Finally
    pEnableControls(objRestRemessa.qryRec, LprcScroll);
  End;

  If dtsCtaRec.DataSet.IsEmpty Then
  Begin
    pMensagemOK('Não há dados para serem restaurados!');
    pSetFocus(edtCodCli);
  End
  Else
    pSetFocus(dbgDuplicatas);
end;

procedure TfrmFinDesmRemBanc.btnDesmarcaClick(Sender: TObject);
  Var
    LprcScroll: TprcScroll;
begin
  If (Not objRestRemessa.qryRec.Active) Or (objRestRemessa.qryRec.IsEmpty) Then
  begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata!');
    Exit;
  end;

  if (StrToCurrDef(StringReplace(Trim(edtTotalSelecionado.Text),'.','',[rfReplaceAll,rfIgnoreCase]), 0) <= 0) then
  begin
    pMensagemOk('Não existe duplicata marcada para ser desmarcada!');
    Exit;
  end;

  Try
    pDisableControls(objRestRemessa.qryRec, LprcScroll);

    Try
      TfrmGravando.fExecutarModal(objRestRemessa.pDesmarcaTodos, 'Aguarde... Desmarcando duplicatas.', '');
      pAtualizaDados(dtsCtaRec.DataSet);
    Except
      On E: Exception Do pMensagensErro(E.Message, '');
    End;

    dbgDuplicatasDBTableView1.DataController.Refresh;
  Finally
    pEnableControls(objRestRemessa.qryRec, LprcScroll);
  End;
end;

procedure TfrmFinDesmRemBanc.BtnMarcarTodas2Click(Sender: TObject);
  Var
    LprcScroll: TprcScroll;
begin
  If (Not objRestRemessa.qryRec.Active) Or (objRestRemessa.qryRec.IsEmpty) Then
  begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata!');
    Exit;
  end;

  Try
    pDisableControls(objRestRemessa.qryRec, LprcScroll);

    Try
      TfrmGravando.fExecutarModal(objRestRemessa.pMarcaTodos, 'Aguarde... Marcando duplicatas.', '');
      pAtualizaDados(dtsCtaRec.DataSet);
    Except
      On E: Exception Do pMensagensErro(E.Message, '');
    End;

    dbgDuplicatasDBTableView1.DataController.Refresh;
  Finally
    pEnableControls(objRestRemessa.qryRec, LprcScroll);
  End;
end;

procedure TfrmFinDesmRemBanc.btnSairAgrupClick(Sender: TObject);
begin
  inherited;
  LConfirma := False;
  Self.Close;
end;

procedure TfrmFinDesmRemBanc.CarregaDuplicataParaRestauracao;
begin
  objRestRemessa.strAutInc := LAutoIncremCTR;
  If fVerificaCampos Then TfrmGravando.fExecutarModal(objRestRemessa.pCarregaDuplicata, 'Aguarde... Carregando Título.', '');
    pAtualizaDados(dtsCtaRec.DataSet);

  pnlCabecalho.Visible := False;
  btnConsultar.Visible := False;
end;

function TfrmFinDesmRemBanc.ChamadaDeOutraRotina: Boolean;
begin
  Result := (Assigned(objRestRemessa.ListaFiltros) And (objRestRemessa.ListaFiltros.count > 0));
  If Not Result Then
    Result := Not LAutoIncremCTR.IsEmpty;
end;

procedure TfrmFinDesmRemBanc.btnConfirmaClick(Sender: TObject);
  Var
    LprcScroll: TprcScroll;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  Try
    If (Not Assigned(objRestRemessa.qryRec)) Or (objRestRemessa.qryRec.IsEmpty) Then
    Begin
      pMensagemOk('Não há duplicatas a serem restauradas!');

      pSetFocus(edtCodCli);
      pLimpaDados;
      Exit;
    End;

    {**********************************}
    {* NÃO HÁ DUPLICATAS SELECIONADAS *}
    {*******************************AF*}
    If objRestRemessa.fltTotMar <= 0 Then
    Begin
      pMensagemOk('Não há duplicatas selecionadas! Selecionar ao menos um registro para efetuar a restauração!');

      pSetFocus(dbgDuplicatas);
      Exit;
    End;

    {***************}
    {* CONFIRMAÇÃO *}
    {************AF*}
    If fMensagem('', 'Confirma restaurar duplicata(s)?', ['', '']) <> 1 Then
    Begin
      pSetFocus(dbgDuplicatas);
      Exit;
    End;

    Try
      TfrmGravando.fExecutarModal(objRestRemessa.pRestauraDuplicatas, 'Aguarde... Restaurando remessa.', '');

      pDisableControls(objRestRemessa.qryRec, LprcScroll);

      If Assigned(lstRecCbi) And (lstRecCbi.count > 0) Then
      Begin
        lstRecCbi.Clear;
        TfrmGravando.fExecutarModal(objRestRemessa.pCarregaDados, 'Aguarde... Carregando Títulos.', '');

        objRestRemessa.qryRec.First;

        While Not objRestRemessa.qryRec.Eof Do
        Begin
          lstRecCbi.Add(Concat(objRestRemessa.qryRec.FieldByName('CTR_NUMDUP').AsString, '-',
                               objRestRemessa.qryRec.FieldByName('CTR_PARCEL').AsString, '-',
                               objRestRemessa.qryRec.FieldByName('CTR_ESPDOC').AsString, '-',
                               objRestRemessa.qryRec.FieldByName('CTR_CODEMP').AsString, '-',
                               objRestRemessa.qryRec.FieldByName('CTR_CODCLI').AsString));

          objRestRemessa.qryRec.Next;
        End;
      End;
    Finally
      pEnableControls(objRestRemessa.qryRec, LprcScroll);
    End;

    If ChamadaDeOutraRotina Then
    Begin
      btnSairAgrup.Click;
      LConfirma := True;
      Exit;
    End;

    pLimpaDados;
    LimpaDadosDuplicata;
    pSetFocus(edtCodCli);
  Except
    On E: Exception Do
    Begin
      LConfirma := False;
      pMensagensErro(E.Message,'');
    End;
  End;

end;

procedure TfrmFinDesmRemBanc.edtCodBcoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodBco, edtDesBco, arrBancos, Nil, fRetNomBanco, 'do Banco');
end;

procedure TfrmFinDesmRemBanc.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtDesEmpresa.Clear;
end;

end.

