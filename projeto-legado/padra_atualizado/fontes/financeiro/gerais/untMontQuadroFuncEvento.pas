unit untMontQuadroFuncEvento;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Windows, untPai, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxButtonEdit, cxMaskEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.Mask,
  MaskEditFocus, Vcl.StdCtrls, EditFocus, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, BitBtnLockedIncrem, Uni, untZClient,
  untControlePagtoFunc, cxCalendar, cxCheckBox, cxLookupEdit,
  System.Variants, untWord, cxContainer, cxTextEdit, cxDropDownEdit,
  cxDBLookupEdit, cxDBLookupComboBox,cxProgressBar,Vcl.Forms;
type
  TfrmMontQuadroFuncEvento = class(TfrmPai)
    pnl1: TPanel;
    lbl1: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    mskDtaEve: TMaskEditFocus;
    lbl2: TLabel;
    pnl2: TPanel;
    cxGrdQuadro: TcxGridCitel;
    cxGrdQuadroTableView: TcxGridDBTableViewCitel;
    cxGrdQuadroTableViewNROGER: TcxGridDBColumn;
    cxGrdQuadroTableViewNROFNC: TcxGridDBColumn;
    cxGrdQuadroTableViewNOMFUN: TcxGridDBColumn;
    cxGrdQuadroTableViewFUNCAO: TcxGridDBColumn;
    cxGrdQuadroTableViewONIBUS: TcxGridDBColumn;
    cxGrdQuadroTableViewVLRFUN: TcxGridDBColumn;
    cxGrdQuadroTableViewDTAINI: TcxGridDBColumn;
    cxGrdQuadroTableViewDTAFIM: TcxGridDBColumn;
    cxGrdQuadroTableViewGERCTR: TcxGridDBColumn;
    cxGrdQuadroLevel: TcxGridLevel;
    lbl3: TLabel;
    lblVlrTot: TLabel;
    btnIncluir: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    dtsModContrato: TDataSource;
    cxCboModContrato: TcxLookupComboBox;
    btnGerarContrato: TBitBtnLocked;
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxGrdQuadroTableViewNOMFUNPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGrdQuadroTableViewFUNCAOPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGrdQuadroTableViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxGrdQuadroTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGrdQuadroExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGerarContratoClick(Sender: TObject);
  private
    { Private declarations }
    fltVlrTot: Double;
    cdsQuadro: TZClient;
    objMonQdr: TMonQdr;
    qryCadEve: TUniQuery;
    qryCadFun: TUniQuery;
    qryCadFnc: TUniQuery;
    qryModContrato: TUniQuery;
    strEndEve: String;
    strCodEveCarregado: String;
    intQtdContratosSelecionados: Integer;
    strArqOriContrato: String;
    lstArqsGerados: TStringList;
    lstProblemas: TStringList;
    function fGerarContratosComProgresso(pgbStatus: TcxProgressBar): Boolean;
    function fAplicarSaidaContratos(AListaArquivos: TStringList): Boolean;
    procedure pCarregaModContrato;
    function fGravarQuadro: Boolean;
    procedure pCarregaGrid;
    procedure pOrdenar;
    function fVerificaCampos: Boolean;
    procedure pTotalizar;
    procedure pLimpaCampos;
    procedure cdsQuadroBeforePost(DataSet: TDataSet);
    procedure cdsQuadroAfterPost(DataSet: TDataSet);
    function fContarFuncionariosMarcados: Integer;
    function fValidaLinhasSelecionadas: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema, untPesqAux, untGravando,untCfgRel;

{$R *.dfm}

procedure TfrmMontQuadroFuncEvento.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodEve.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Código do Evento deve ser preenchido!', ['&O k']);
    pSetFocus(edtCodEve);
    Exit;
  End;

  If cdsQuadro.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum funcionário foi informado!', ['&O k']);
    pSetFocus(cxGrdQuadro);
    Exit;
  End;

  If Not fVerificaCampos Then
    Exit;

  pOrdenar;

  If fMensagem('', 'Confirma a gravação?', ['&Sim', '&Não']) = 1 Then
  Begin
    If fGravarQuadro Then
    Begin
      fMensagem('', 'Planilha salva com sucesso!', ['&O k']);
      pLimpaCampos;
      pSetFocus(edtCodEve);
    End;
  End;
end;

procedure TfrmMontQuadroFuncEvento.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  pSetFocus(edtCodEve);
end;

procedure TfrmMontQuadroFuncEvento.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodEve.Text) Then
    Exit;

  cdsQuadro.Append;
  cdsQuadro.FieldByName('CODEMP').AsString := VS_strCodEmp;
  pSetFocus(cxGrdQuadro);
  cxGrdQuadroTableViewNOMFUN.FocusWithSelection;
end;

procedure TfrmMontQuadroFuncEvento.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If cdsQuadro.IsEmpty Then
    Exit;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
    cdsQuadro.Delete;
    pSetFocus(btnIncluir);
  End;
end;

procedure TfrmMontQuadroFuncEvento.cdsQuadroAfterPost(DataSet: TDataSet);
begin
  pTotalizar;
end;

procedure TfrmMontQuadroFuncEvento.cdsQuadroBeforePost(DataSet: TDataSet);
begin
  If StrToIntDef(Trim(cdsQuadro.FieldByName('ONIBUS').AsString), 0) > 0 Then
    cdsQuadro.FieldByName('ONIBUS').AsString := fStrZero(Trim(cdsQuadro.FieldByName('ONIBUS').AsString), 3)
  Else
    cdsQuadro.FieldByName('ONIBUS').Clear;
end;

procedure TfrmMontQuadroFuncEvento.cxGrdQuadroExit(Sender: TObject);
begin
  inherited;
  If cdsQuadro.State In [dsInsert, dsEdit] Then
    cdsQuadro.Post;
end;

procedure TfrmMontQuadroFuncEvento.cxGrdQuadroTableViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  If cxGrdQuadroTableView.Controller.FocusedColumn = cxGrdQuadroTableViewNOMFUN Then
  Begin
    If Key = '/' Then
      cxGrdQuadroTableViewNOMFUNPropertiesButtonClick(Sender, 0);
  End
  Else If cxGrdQuadroTableView.Controller.FocusedColumn = cxGrdQuadroTableViewFUNCAO Then
  Begin
    If Key = '/' Then
      cxGrdQuadroTableViewFUNCAOPropertiesButtonClick(Sender, 0);
  End;
  cxGrdQuadroTableView.Controller.EditingController.ShowEdit;
end;

procedure TfrmMontQuadroFuncEvento.cxGrdQuadroTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
  Begin
    If cdsQuadro.State in [dsInsert, dsEdit] Then
      cdsQuadro.Cancel
    Else
      btnCancelar.Click;
  End;
end;

procedure TfrmMontQuadroFuncEvento.cxGrdQuadroTableViewFUNCAOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    Key: Char;
    arrFnc: TConsultasArray;
begin
  inherited;
  Key := '/';
  If fPesqFuncoes(Self, Nil, Nil, qryCadFnc, Key, arrFnc, False, cdsQuadro.FieldByName('CODEMP').AsString) Then
  Begin
    If cdsQuadro.State = dsBrowse Then
      cdsQuadro.Edit;
    cdsQuadro.FieldByName('CODFNC').AsString := qryCadFnc.FieldByName('FNC_CODFNC').AsString;
    cdsQuadro.FieldByName('FUNCAO').AsString := qryCadFnc.FieldByName('FNC_NOMFNC').AsString;
    cdsQuadro.FieldByName('AUTFNC').AsString := qryCadFnc.FieldByName('AUTOINCREM').AsString;
    cdsQuadro.Post;
  End;
end;

procedure TfrmMontQuadroFuncEvento.cxGrdQuadroTableViewNOMFUNPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    Key: Char;
    arrFun: TConsultasArray;
begin
  inherited;
  Key := '/';
  If fPesqFuncionarios(Self, Nil, Nil, qryCadFun, Key, arrFun) Then
  Begin
    If cdsQuadro.State = dsBrowse Then
      cdsQuadro.Edit;
    cdsQuadro.FieldByName('CODFUN').AsString := qryCadFun.FieldByName('FUN_CODFUN').AsString;
    cdsQuadro.FieldByName('NOMFUN').AsString := qryCadFun.FieldByName('FUN_NOMFUN').AsString;
    cdsQuadro.FieldByName('CODFNC').AsString := qryCadFun.FieldByName('FUN_FUNATU').AsString;
    cdsQuadro.FieldByName('FUNCAO').AsString := fRetNomFnc(qryCadFun.FieldByName('FUN_AUTFNC').AsString);
    cdsQuadro.FieldByName('AUTFUN').AsString := qryCadFun.FieldByName('AUTOINCREM').AsString;
    cdsQuadro.FieldByName('AUTFNC').AsString := qryCadFun.FieldByName('FUN_AUTFNC').AsString;
    cdsQuadro.Post;
  End;
end;

procedure TfrmMontQuadroFuncEvento.edtCodEveKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEvento) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmMontQuadroFuncEvento.FormCreate(Sender: TObject);
begin
  inherited;
  objMonQdr := TMonQdr.Create(Self);
  cdsQuadro := TZClient.Create(Self, objMonQdr.fSQLSelect);

  cdsQuadro.BeforePost  := cdsQuadroBeforePost;
  cdsQuadro.AfterPost   := cdsQuadroAfterPost;
  cdsQuadro.AfterDelete := cdsQuadroAfterPost;

  qryCadEve := fCriaQuery(Self);
  qryCadFun := fCriaQuery(Self);
  qryCadFnc := fCriaQuery(Self);

  qryModContrato := fCriaQuery(Self);
  dtsModContrato.DataSet := qryModContrato;
  pCarregaModContrato;

  lstProblemas := TStringList.Create;

  cxGrdQuadroTableView.DataController.DataSource := cdsQuadro.dtsSource;
  cxGrdQuadro.ShowHint := True;
end;

procedure TfrmMontQuadroFuncEvento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(lstProblemas);
  inherited;
end;

procedure TfrmMontQuadroFuncEvento.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    pSetFocus(btnConfirmar);
    btnConfirmar.Click;
  End;
end;

procedure TfrmMontQuadroFuncEvento.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(TCadFun.CriaNovosRegistrosDeFuncoes, 'Aguarde... Atualizando registros de versões  anteriores.', '');
  If TCadFun.ExistemFuncoesCadastradasNaFormaAntiga Then
    TfrmGravando.fExecutarModal(TCadFun.CorrigeCadastroDeFuncoes, 'Aguarde... Atualizando registros de versões anteriores.', '');
end;

function TfrmMontQuadroFuncEvento.fGravarQuadro: Boolean;
  Var
    blnGravar: Boolean;
    intNroGer: Integer;
begin
  cdsQuadro.DisableControls;
  Try
    cdsQuadro.IndexFieldNames := 'FUNCAO;NOMFUN';
    blnGravar := True;
    fStartTransaction;

    If (objMonQdr.fExcluiQuadro(edtCodEve.Text)) Then
    Begin
      intNroGer := 1;

      cdsQuadro.First;
      While Not cdsQuadro.Eof Do
      Begin
        If Not objMonQdr.fGravarQuadro(edtCodEve.Text,
                                       fltVlrTot,
                                       cdsQuadro.FieldByName('CODEMP').AsString,
                                       cdsQuadro.FieldByName('CODFUN').AsString,
                                       cdsQuadro.FieldByName('CODFNC').AsString,
                                       cdsQuadro.FieldByName('NROGER').AsInteger,
                                       cdsQuadro.FieldByName('NROFNC').AsInteger,
                                       cdsQuadro.FieldByName('VLRFUN').AsFloat,
                                       cdsQuadro.FieldByName('ONIBUS').AsString,
                                       intNroGer,
                                       cdsQuadro.FieldByName('AUTFUN').AsString,
                                       cdsQuadro.FieldByName('AUTFNC').AsString,
                                       cdsQuadro.FieldByName('DTAINI').AsDateTime,
                                       cdsQuadro.FieldByName('DTAFIM').AsDateTime,
                                       cdsQuadro.FieldByName('GERCTR').AsString) Then
          blnGravar := False
        Else
          Inc(intNroGer);

        cdsQuadro.Next;
      End;

      If blnGravar Then
      Begin
        fCommit;
        Result := True;
      End
      Else
      Begin
        fRollBack;
        Result := False;
      End;
    End
    Else
    Begin
      fRollBack;
      Result := False;
    End;
  Finally
    cdsQuadro.EnableControls;
  End;
end;

function TfrmMontQuadroFuncEvento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If inherited fValidaCampos(Sender) Then
  Begin
    If Sender = edtCodEve Then
    Begin
      If fEmptyStr(edtCodEve.Text) Then
      Begin
        edtDesEve.Clear;
        fMensagem('ATENÇÃO!', 'O Código do Evento deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pPesquisaCadEve(Nil, qryCadEve, edtCodEve.Text);

        edtDesEve.Text := qryCadEve.FieldByName('EVE_DESEVE').AsString;
        mskDtaEve.Text := IIF(Not qryCadEve.FieldByName('EVE_DTAEVE').IsNull,
                              FormatDateTime('dd/mm/yyyy', qryCadEve.FieldByName('EVE_DTAEVE').AsDateTime), '');
        strEndEve := qryCadEve.FieldByName('EVE_ENDEVE').AsString;

        If fEmptyStr(edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Evento não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
          pCarregaGrid;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmMontQuadroFuncEvento.pCarregaGrid;
begin
  strCodEveCarregado := edtCodEve.Text;

  objMonQdr.AtualizaDadosDeVersoesAnteriores(edtCodEve.Text, VS_strCodEmp);

  cdsQuadro.qryQuery.Close;
  cdsQuadro.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
  cdsQuadro.qryQuery.ParamByName('CODEVE').AsString := edtCodEve.Text;
  cdsQuadro.qryQuery.Open;

  cdsQuadro.fAbreClient(True);
  cdsQuadro.IndexFieldNames := '';

  pTotalizar;

  TFloatField(cdsQuadro.FieldByName('VLRFUN')).DisplayFormat := ',#0.00';
end;

procedure TfrmMontQuadroFuncEvento.pLimpaCampos;
begin
  edtCodEve.Clear;
  edtDesEve.Clear;
  mskDtaEve.Clear;
  cdsQuadro.Close;
  lblVlrTot.Caption := '0,00';
  strCodEveCarregado := '';
end;

procedure TfrmMontQuadroFuncEvento.pOrdenar;
  Var
    intNroGer,
    intNroFnc: Integer;
    strFncAnt: String;
begin
  cdsQuadro.DisableControls;
  Try
    cdsQuadro.IndexFieldNames := 'FUNCAO;NOMFUN';

    intNroGer := 1;
    intNroFnc := 1;
    strFncAnt := '';

    cdsQuadro.First;
    While Not cdsQuadro.Eof Do
    Begin
      cdsQuadro.Edit;
      cdsQuadro.FieldByName('NROGER').AsInteger := intNroGer;
      cdsQuadro.FieldByName('NROFNC').AsInteger := intNroFnc;
      cdsQuadro.Post;

      strFncAnt := cdsQuadro.FieldByName('FUNCAO').AsString;
      cdsQuadro.Next;

      Inc(intNroGer);

      If strFncAnt = cdsQuadro.FieldByName('FUNCAO').AsString Then
        Inc(intNroFnc)
      Else
        intNroFnc := 1;
    End;
  Finally
    cdsQuadro.EnableControls;
  End;
end;

procedure TfrmMontQuadroFuncEvento.pTotalizar;
  Var
    intPos: Integer;
begin
  intPos := cdsQuadro.RecNo;
  cdsQuadro.DisableControls;
  Try
    fltVlrTot := 0;
    cdsQuadro.First;
    While Not cdsQuadro.Eof Do
    Begin
      fltVlrTot := fltVlrTot + cdsQuadro.FieldByName('VLRFUN').AsFloat;
      cdsQuadro.Next;
    End;

    lblVlrTot.Caption := FormatFloat(',0.00', fltVlrTot);
  Finally
    cdsQuadro.EnableControls;
    cdsQuadro.RecNo := intPos;
  End;
end;

function TfrmMontQuadroFuncEvento.fVerificaCampos: Boolean;
begin
  Result := True;
  cdsQuadro.DisableControls;
  Try
    cdsQuadro.First;
    While Not cdsQuadro.Eof Do
    Begin
      If fEmptyStr(cdsQuadro.FieldByName('NOMFUN').AsString) Then
      Begin
        fMensagem('ATENÇÃO', 'É Obrigatório informar o funcionário.', ['&OK']);
        pSetFocus(cxGrdQuadro);
        cxGrdQuadroTableViewNOMFUN.FocusWithSelection;
        Exit(False);
      End
      Else If cdsQuadro.FieldByName('VLRFUN').IsNull Then
      Begin
        fMensagem('ATENÇÃO', 'É Obrigatório informar o valor.', ['&OK']);
        pSetFocus(cxGrdQuadro);
        cxGrdQuadroTableViewVLRFUN.FocusWithSelection;
        Exit(False);
      End
      Else If cdsQuadro.FieldByName('VLRFUN').AsFloat <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O valor deve ser maior que zero.', ['&OK']);
        pSetFocus(cxGrdQuadro);
        cxGrdQuadroTableViewVLRFUN.FocusWithSelection;
        Exit(False);
      End;

      cdsQuadro.Next;
    End;
  Finally
    cdsQuadro.EnableControls;
  End;
end;

procedure TfrmMontQuadroFuncEvento.pCarregaModContrato;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                  ';
  strSQL := strSQL + '  SER_CODSER AS CODSER, ';
  strSQL := strSQL + '  SER_NOMSER AS NOMSER, ';
  strSQL := strSQL + '  SER_PATSER AS PATSER  ';
  strSQL := strSQL + 'FROM                     ';
  strSQL := strSQL + '  CTRSER                 ';
  strSQL := strSQL + 'WHERE                    ';
  strSQL := strSQL + '  SER_CODEMP = :CODEMP   ';

  qryModContrato.Close;
  qryModContrato.SQL.Clear;
  qryModContrato.SQL.Add(strSQL);
  qryModContrato.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryModContrato.Open;
end;

function TfrmMontQuadroFuncEvento.fContarFuncionariosMarcados: Integer;
begin
  Result := 0;
  cdsQuadro.DisableControls;
  Try
    cdsQuadro.First;
    While Not cdsQuadro.Eof Do
    Begin
      If cdsQuadro.FieldByName('GERCTR').AsString = 'S' Then
        Inc(Result);
      cdsQuadro.Next;
    End;
  Finally
    cdsQuadro.EnableControls;
  End;
end;

function TfrmMontQuadroFuncEvento.fValidaLinhasSelecionadas: Boolean;
begin
  Result := True;
  lstProblemas.Clear;

  cdsQuadro.DisableControls;
  Try
    cdsQuadro.First;
    While Not cdsQuadro.Eof Do
    Begin
      If cdsQuadro.FieldByName('GERCTR').AsString = 'S' Then
      Begin
        If fEmptyStr(cdsQuadro.FieldByName('AUTFUN').AsString) Then
          lstProblemas.Add('Linha sem funcionário selecionado.')
        Else If cdsQuadro.FieldByName('DTAINI').IsNull Or cdsQuadro.FieldByName('DTAFIM').IsNull Then
          lstProblemas.Add(cdsQuadro.FieldByName('NOMFUN').AsString + ': sem Data/Hora de Início ou Término.');
      End;
      cdsQuadro.Next;
    End;
  Finally
    cdsQuadro.EnableControls;
  End;

  If lstProblemas.Count > 0 Then
  Begin
    Result := fMensagem('ATENÇÃO!',
      'Foram encontrados ' + IntToStr(lstProblemas.Count) + ' problema(s):' + sLineBreak +
      lstProblemas.Text + sLineBreak +
      'Deseja continuar, pulando essas linhas?',
      ['&Sim', '&Não']) = 1;
  End;
end;

procedure TfrmMontQuadroFuncEvento.btnGerarContratoClick(Sender: TObject);
Var
  frmGravandoLocal: TfrmGravando;
  varLookup: Variant;
begin
  inherited;

  If cdsQuadro.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum funcionário foi informado!', ['&Ok']);
    Exit;
  End;

  If edtCodEve.Text <> strCodEveCarregado Then
  Begin
    fMensagem('ATENÇÃO!', 'O código do evento foi alterado, mas o quadro ainda não foi recarregado. Confirme o evento antes de gerar os contratos.', ['&Ok']);
    pSetFocus(edtCodEve);
    Exit;
  End;


  pPesquisaCadEve(Nil, qryCadEve, edtCodEve.Text);
  strEndEve := qryCadEve.FieldByName('EVE_ENDEVE').AsString;

  If cxCboModContrato.EditValue = Null Then
  Begin
    fMensagem('ATENÇÃO!', 'Selecione um Modelo de Contrato antes de gerar!', ['&Ok']);
    Exit;
  End;

  varLookup := qryModContrato.Lookup('CODSER', cxCboModContrato.EditValue, 'PATSER');

  If VarIsNull(varLookup) Then
    strArqOriContrato := ''
  Else
    strArqOriContrato := varLookup;

  If fEmptyStr(strArqOriContrato) Or (Not FileExists(strArqOriContrato)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Modelo de contrato não encontrado! Verifique o caminho cadastrado.', ['&Ok']);
    Exit;
  End;

  intQtdContratosSelecionados := fContarFuncionariosMarcados;

  If intQtdContratosSelecionados = 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum funcionário foi selecionado para geração de contrato!', ['&Ok']);
    Exit;
  End;

  If Not fValidaLinhasSelecionadas Then
    Exit;

  If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'CONTRATOS EVENTOS') Then
    CreateDir(ExtractFilePath(Application.ExeName) + 'CONTRATOS EVENTOS');

  Try
    lstArqsGerados := TStringList.Create;

    pCriarFormularios(TfrmGravando, frmGravandoLocal);
    Try
      frmGravandoLocal.pgbStatus.Visible := True;
      frmGravandoLocal.fExecutarAcao := fGerarContratosComProgresso;
      frmGravandoLocal.lblGravando.Caption := 'Aguarde... Gerando Contratos...';
      frmGravandoLocal.ShowModal;
    Finally
      pFreeAndNil(frmGravandoLocal);
    End;

    If lstArqsGerados.Count = 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Nenhum contrato foi gerado!', ['&Ok']);
      Exit;
    End;

    If Not fAplicarSaidaContratos(lstArqsGerados) Then
      Exit;

    If lstProblemas.Count > 0 Then
      fMensagem('', 'Processamento concluído. ' + IntToStr(lstProblemas.Count) +
                ' linha(s) não geraram contrato:' + sLineBreak + lstProblemas.Text, ['&Ok'])
    Else
      fMensagem('', 'Contratos gerados com sucesso!', ['&Ok']);
  Finally
    FreeAndNil(lstArqsGerados);
  End;
end;

function TfrmMontQuadroFuncEvento.fGerarContratosComProgresso(pgbStatus: TcxProgressBar): Boolean;
  Var
    Word: TWord;
    strArqDes: String;
    qryFun: TUniQuery;
    intAtual: Integer;
begin
  Result := True;

  pgbStatus.Properties.Max := intQtdContratosSelecionados;
  intAtual := 0;

  qryFun := fCriaQuery(Self);
  Try
    cdsQuadro.DisableControls;
    Try
      cdsQuadro.First;
      While Not cdsQuadro.Eof Do
      Begin
        If cdsQuadro.FieldByName('GERCTR').AsString = 'S' Then
        Begin
          If fEmptyStr(cdsQuadro.FieldByName('AUTFUN').AsString) Then
          Begin
            cdsQuadro.Next;
            Continue;
          End;

          If cdsQuadro.FieldByName('DTAINI').IsNull Or cdsQuadro.FieldByName('DTAFIM').IsNull Then
          Begin
            cdsQuadro.Next;
            Continue;
          End;

          qryFun.Close;
          qryFun.SQL.Clear;
          qryFun.SQL.Add('SELECT F.*, C.CID_NOMCID, C.CID_ESTADO ');
          qryFun.SQL.Add('FROM CADFUN F ');
          qryFun.SQL.Add('LEFT JOIN CADCID C ON C.CID_CODCID = F.FUN_CODCID ');
          qryFun.SQL.Add('WHERE F.AUTOINCREM = :AUTFUN');
          qryFun.ParamByName('AUTFUN').AsString := cdsQuadro.FieldByName('AUTFUN').AsString;
          qryFun.Open;

          If qryFun.IsEmpty Then
          Begin
            lstProblemas.Add(cdsQuadro.FieldByName('NOMFUN').AsString + ': não encontrado no cadastro.');
            cdsQuadro.Next;
            Continue;
          End;

          strArqDes := ExtractFilePath(Application.ExeName) + 'CONTRATOS EVENTOS\CONTRATO_' +
             FormatDateTime('yyyymmdd', Trunc(fNow)) + '_' +
             Trim(qryFun.FieldByName('FUN_CODFUN').AsString) + '.docx';

          If FileExists(strArqDes) Then
            System.SysUtils.DeleteFile(strArqDes);

          If FileExists(strArqDes) Then
            strArqDes := ExtractFilePath(Application.ExeName) + 'CONTRATOS EVENTOS\CONTRATO_' +
               FormatDateTime('yyyymmdd', Trunc(fNow)) + '_' +
               Trim(qryFun.FieldByName('FUN_CODFUN').AsString) + '-' +
               FormatDateTime('hhnnss', fNow) + '.docx';

          If Not CopyFile(pChar(strArqOriContrato), pChar(strArqDes), False) Then
          Begin
            lstProblemas.Add(cdsQuadro.FieldByName('NOMFUN').AsString + ': falha ao copiar o modelo.');
            cdsQuadro.Next;
            Continue;
          End;

          Word := TWord.fCriarWord(Self);

          If Word <> Nil Then
          Begin
            Try
              If Word.AbrirArquivo(strArqDes) Then
              Begin
                Word.pGoToMainDocument;

                Word.pReplace('[NOME DO FUNCIONARIO]', qryFun.FieldByName('FUN_NOMFUN').AsString);
                Word.pReplace('[ENDEREÇO DO FUNCIONARIO]', qryFun.FieldByName('FUN_ENDERE').AsString);
                Word.pReplace('[CIDADE DO FUNCIONARIO]', qryFun.FieldByName('CID_NOMCID').AsString);
                Word.pReplace('[ESTADO DO FUNCIONARIO]', qryFun.FieldByName('CID_ESTADO').AsString);
                Word.pReplace('[NOME DA MÃE DO FUNCIONARIO]', qryFun.FieldByName('FUN_NOMMAE').AsString);
                Word.pReplace('[RG DO FUNCIONARIO]', qryFun.FieldByName('FUN_NUM_RG').AsString);
                Word.pReplace('[CPF DO FUNCIONARIO]', qryFun.FieldByName('FUN_C_P_F_').AsString);
                Word.pReplace('[FUNÇÃO]', cdsQuadro.FieldByName('FUNCAO').AsString);
                Word.pReplace('[ENDEREÇO DO EVENTO]', strEndEve);
                Word.pReplace('[DATA E HORARIO DE INICIO]',
                  FormatDateTime('dd/mm/yyyy hh:nn', cdsQuadro.FieldByName('DTAINI').AsDateTime));
                Word.pReplace('[DATA E HORARIO DE TERMINO]',
                  FormatDateTime('dd/mm/yyyy hh:nn', cdsQuadro.FieldByName('DTAFIM').AsDateTime));
                Word.pReplace('[DATA DO INICIO]',
                  FormatDateTime('dd/mm/yyyy', cdsQuadro.FieldByName('DTAINI').AsDateTime));

                Word.pSalvar;

                lstArqsGerados.Add(strArqDes);

                Inc(intAtual);
                pProgresso(intAtual, intQtdContratosSelecionados, pgbStatus);
              End
              Else
                lstProblemas.Add(cdsQuadro.FieldByName('NOMFUN').AsString + ': falha ao abrir o contrato no Word.');
            Finally
              Try
                Word.pFechar;
              Except
              End;
              FreeAndNil(Word);
            End;
          End
          Else
            lstProblemas.Add('Não foi possível iniciar o Microsoft Word.');
        End;

        cdsQuadro.Next;
      End;
    Finally
      cdsQuadro.EnableControls;
    End;
  Finally
    FreeAndNil(qryFun);
  End;
end;

function TfrmMontQuadroFuncEvento.fAplicarSaidaContratos(AListaArquivos: TStringList): Boolean;
  Var
    Word: TWord;
    strArqPdf, strNomImpContrato, strTipImpContrato: String;
    intContador: Integer;
    chrDestinoContrato: Char;
begin
  Result := True;
  Case fMensagem('Saída do Contrato', 'Os contratos foram gerados. Como deseja visualiza-los?',
                 ['&Visualizar', '&Imprimir', 'Exportar &PDF']) of
    1: chrDestinoContrato := 'V';
    2: chrDestinoContrato := 'I';
    3: chrDestinoContrato := 'P';
  Else
    Begin
      Result := False;
      Exit;
    End;
  End;

  If chrDestinoContrato = 'I' Then
  Begin
    strNomImpContrato := '';
    strTipImpContrato := '';
    TCfgRel.pCarregaConfImprRel(Self.Name, strNomImpContrato, strTipImpContrato, VS_strCodEmp, True);

    If fEmptyStr(strNomImpContrato) Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  For intContador := 0 To AListaArquivos.Count - 1 Do
  Begin
    Case chrDestinoContrato of
      'V':
        pExecArquivo(AListaArquivos[intContador], Handle);

      'I':
      Begin
        Word := TWord.fCriarWord(Self);
        If Word <> Nil Then
        Begin
          Try
            If Word.AbrirArquivo(AListaArquivos[intContador]) Then
            Begin
              Try
                TCfgRel.pPrintReport(Self.Name, ExtractFileName(AListaArquivos[intContador]), strNomImpContrato, Word);
              Except
                On E: Exception Do
                  lstProblemas.Add(ExtractFileName(AListaArquivos[intContador]) + ': falha ao imprimir - ' + E.Message);
              End;
            End
            Else
              lstProblemas.Add(ExtractFileName(AListaArquivos[intContador]) + ': falha ao abrir para impressão.');
          Finally
            Try
              Word.pFechar;
            Except
            End;
            FreeAndNil(Word);
          End;
        End
        Else
          lstProblemas.Add(ExtractFileName(AListaArquivos[intContador]) + ': não foi possível iniciar o Word para impressão.');
      End;

      'P':
      Begin
        strArqPdf := ChangeFileExt(AListaArquivos[intContador], '.pdf');
        If FileExists(strArqPdf) Then
          System.SysUtils.DeleteFile(strArqPdf);

        If FileExists(strArqPdf) Then
          strArqPdf := ChangeFileExt(AListaArquivos[intContador], '') + '-' +
                       FormatDateTime('hhnnss', fNow) + '.pdf';

        Word := TWord.fCriarWord(Self);
        If Word <> Nil Then
        Begin
          Try
            If Word.AbrirArquivo(AListaArquivos[intContador]) Then
            Begin
              Try
                Word.SaveAsPDF(strArqPdf);
              Except
                On E: Exception Do
                  lstProblemas.Add(ExtractFileName(AListaArquivos[intContador]) + ': falha ao exportar PDF - ' + E.Message);
              End;
            End
            Else
              lstProblemas.Add(ExtractFileName(AListaArquivos[intContador]) + ': falha ao abrir para exportação PDF.');
          Finally
            Try
              Word.pFechar;
            Except
            End;
            FreeAndNil(Word);
          End;
        End
        Else
          lstProblemas.Add(ExtractFileName(AListaArquivos[intContador]) + ': não foi possível iniciar o Word para exportar PDF.');
      End;
    End;
  End;
end;

end.
