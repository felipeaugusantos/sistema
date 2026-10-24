unit untCadConfRelatorios;

interface

uses
  Classes, Controls, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls, Mask,
  Uni,
  DBCtrls, DBEditFocus, DB, QColorLabel, Menus, AppEvnts, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, System.UITypes,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxButtonEdit, cxCheckBox,
  cxDropDownEdit, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxTextEdit, Vcl.ImgList,
  Windows, MemDS, VirtualTable, cxDBLookupComboBox, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, cxDataControllerConditionalFormattingRulesManagerDialog, SysUtils;

type
  TfrmCadConfRelatorios = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dtsTabela: TDataSource;
    gpbTipo: TGroupBox;
    Label1: TLabel;
    dbeNomPro: TDBEditFocus;
    cxDadosDBTableView1: TcxGridDBTableView;
    cxDadosLevel1: TcxGridLevel;
    cxDados: TcxGrid;
    colCodOpe: TcxGridDBColumn;
    colNomMaq: TcxGridDBColumn;
    colDescri: TcxGridDBColumn;
    colNomFil: TcxGridDBColumn;
    colImpPad: TcxGridDBColumn;
    colTipImp: TcxGridDBColumn;
    colPergun: TcxGridDBColumn;
    dtsTipImp: TDataSource;
    qryTipImp: TClientDataSet;
    qryTipImpCODTIP: TStringField;
    qryTipImpDESCRI: TStringField;
    lblInfCodOpe: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure colNomFilPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure colImpPadPropertiesChange(Sender: TObject);
    procedure cxDadosDBTableView1EditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxDadosDBTableView1EditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }

    procedure pCarregarNomeMaquinas;

    procedure pCarregaDados(strNomFrm: String);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pBeforeCancel(DataSet: TDataSet);
    procedure pEnableGrid(blnEnable: Boolean);

  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
    strNomeForm: String;
  end;

var
  frmCadConfRelatorios: TfrmCadConfRelatorios;

implementation

uses  Forms, StrUtils, untPai, untSelFilImpressao, DBAccess, EditFocus,
  untCfgRel, untFuncoesSimples, untSpoolImpressao;

{$R *.dfm}

procedure TfrmCadConfRelatorios.FormActivate(Sender: TObject);
begin
  inherited;
  TCfgRel.pSetFocus(btnIncluir, Self);
end;

procedure TfrmCadConfRelatorios.FormCreate(Sender: TObject);

begin
  inherited;
  strNomeTabela := 'CFGREL';
  strNomeCampo := 'REL_NOMPRO';
  qryTabela := TCfgRel.fCriarQuery
    ('SELECT * FROM CFGREL WHERE FALSE', Self);
  dtsTabela.DataSet := qryTabela;

  qryTabela.BeforePost := pBeforePost;
  qryTabela.BeforeCancel := pBeforeCancel;

  qryTipImp.CreateDataSet;
  qryTipImp.Append;
  qryTipImp.FieldByName('CODTIP').AsString := 'J';
  qryTipImp.FieldByName('DESCRI').AsString := IMP_JATO_LASER;
  qryTipImp.Post;

  qryTipImp.Append;
  qryTipImp.FieldByName('CODTIP').AsString := 'M';
  qryTipImp.FieldByName('DESCRI').AsString := IMP_MATRICIAL;
  qryTipImp.Post;

  If Not TCfgRel.fCfgSis('CADIMP', VarBoolean) And Not TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    qryTipImp.Append;
    qryTipImp.FieldByName('CODTIP').AsString := 'P';
    qryTipImp.FieldByName('DESCRI').AsString := 'PADRÃO CONFIGURADO';
    qryTipImp.Post;
  End;

  pCarregarNomeMaquinas;

  If TCfgRel.fCfgSis('CADIMP', VarBoolean) Or TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    colImpPad.Visible := False;
    colPergun.Visible := False;
    colNomFil.Properties.ReadOnly := True;
  End;

  If TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    colNomFil.Caption := 'Ponto de Impressão';
    colNomFil.HeaderHint := 'Selecionar Ponto de Impressão (Ctrl+Enter)';
    cxDadosDBTableView1.OptionsView.NoDataToDisplayInfoText := '<Não há pontos de impressão para esse programa>';
  End;

  qryTipImp.Open;
end;

function TfrmCadConfRelatorios.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    { ***************************************** }
    { * VALIDA O NOME DO PROGRAMA             * }
    { **************************************MV* }
    If (Sender = dbeNomPro) Then
    Begin
      If (TCfgRel.fEmptyStr(dbeNomPro.Text)) And
        (dbeNomPro.Enabled) Then
      Begin
        TCfgRel.fMensagem('ATENÇÃO!',
          'O Nome do Programa deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    TCfgRel.pSetFocus(Sender, Self);
end;

procedure TfrmCadConfRelatorios.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('REL_NOMPRO');
  stlCampos.Add('REL_DESPRO');
  stlCampos.Add('REL_NOMFIL');
  stlCampos.Add('REL_IDEIMP');
  stlCampos.Add('REL_PERGUN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('REL_NOMPRO');
  stlCamInd.Add('REL_DESPRO');

  stlDesInd.Add('Nome do Programa');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadConfRelatorios.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pEnableGrid(False);
end;

procedure TfrmCadConfRelatorios.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadConfRelatorios.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadConfRelatorios.btnGravarClick(Sender: TObject);
Var
  LPontoImpressao: TPontoImpressao;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  qryTabela.FieldByName('REL_PERGUN').AsString := 'N';

  If TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    LPontoImpressao := TSpoolImpressaoCitel.fGetPontoImpressao(qryTabela.FieldByName('REL_NOMFIL').AsString);
    qryTabela.FieldByName('REL_NOMPON').AsString := LPontoImpressao.Nome;
    qryTabela.FieldByName('REL_NOMIMP').AsString := LPontoImpressao.Impressora;
    qryTabela.FieldByName('REL_SPOIMP').AsString := 'S';
  End
  Else
  Begin
    qryTabela.FieldByName('REL_NOMPON').AsString := '';
    qryTabela.FieldByName('REL_NOMIMP').AsString := '';
    qryTabela.FieldByName('REL_SPOIMP').AsString := 'N';
  End;

  { ***************************************** }
  { * VALIDA A DESCRIÇÃO DO NOME DO PROGRAMA* }
  { **************************************MV* }
  If TCfgRel.fEmptyStr(qryTabela.FieldByName('REL_DESPRO')
    .AsString) Then
  Begin
    TCfgRel.pMensagemOk
      ('A Descrição do Programa deve ser preenchida!');
    Exit;
  End;

  { ***************************************** }
  { * VALIDA A DESCRIÇÃO DO NOME DO PROGRAMA* }
  { **************************************MV* }
  If Not TCfgRel.fEmptyStr(qryTabela.FieldByName('REL_CODOPE').AsString) And
    TCfgRel.fEmptyStr(TCfgRel.fRetNomeOperador(qryTabela.FieldByName('REL_CODOPE').AsString)) Then
  Begin
    TCfgRel.pMensagemOk('Nenhum operador foi encontrado com o código informado!');
    Exit;
  End;

  If Not TCfgRel.fEmptyStr(qryTabela.FieldByName('REL_NOMMAQ').AsString) And
     Not TCfgRel.fEmptyStr(qryTabela.FieldByName('REL_CODOPE').AsString) Then
  Begin
    TCfgRel.pMensagemOk('Quando informar o nome da máquina é necessário remover o código do operador!');
    Exit;
  End;

  If TCfgRel.fEmptyStr(qryTabela.FieldByName('REL_CODOPE').AsString) Then
    qryTabela.FieldByName('REL_CODOPE').Clear;

  If TCfgRel.fEmptyStr(qryTabela.FieldByName('REL_NOMMAQ').AsString) Then
    qryTabela.FieldByName('REL_NOMMAQ').Clear;

  { ***************************************** }
  { * VALIDA O TIPO DE IMPRESSÃO            * }
  { **************************************MV* }
  If TCfgRel.fEmptyStr(qryTabela.FieldByName('REL_IDEIMP')
    .AsString) Then
  Begin
    TCfgRel.pMensagemOk('O Tipo de Impressão deve ser preenchido!');
    Exit;
  End;

  { ***************************************** }
  { * VALIDA O CAMPO 'PERGUNTA'             * }
  { **************************************AF* }
  If TCfgRel.fEmptyStr(qryTabela.FieldByName('REL_PERGUN')
    .AsString) Then
  Begin
    TCfgRel.pMensagemOk('O Tipo de Impressão deve ser preenchido!');
    Exit;
  End;

  If TCfgRel.fFilaJaExiste(qryTabela.FieldByName('AUTOINCREM').AsString,
    qryTabela.FieldByName('REL_CODOPE').AsString,
    qryTabela.FieldByName('REL_NOMMAQ').AsString,
    strNomeForm, '',
    qryTabela.FieldByName('REL_NOMFIL').AsString) Then
  Begin
    If TCfgRel.fEmptyStr(qryTabela.FieldByName('REL_NOMFIL').AsString) Then
      TCfgRel.pMensagemOk('Não é permitido duas filas em branco!')
    Else
    Begin
      If TCfgRel.VS_SpoolImpressaoCitel Then
        TCfgRel.pMensagemOk('O ponto de impressão selecionado já está sendo utilizado por outra fila!')
      Else
        TCfgRel.pMensagemOk('A impressora selecionada já está sendo utilizada por outra fila!');
    End;
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadConfRelatorios.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    pEnableGrid(False);
    fCommit;
  End
  Else
    fRollBack;


  If Not TCfgRel.fEmptyStr(dbeNomPro.Text) Then
    strNomeForm := dbeNomPro.Text;

end;

procedure TfrmCadConfRelatorios.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pEnableGrid(True);

  qryTabela.FieldByName('REL_CODEMP').AsString :=
    TCfgRel.fGetEmpresaLogada();
  qryTabela.FieldByName('REL_IMPPAD').AsString := 'N';

  If TCfgRel.fEmptyStr(strNomeForm) Then
    pHabilitaCodigo(dbeNomPro, dbeNomPro, True)
  Else
  Begin
    qryTabela.FieldByName('REL_NOMPRO').AsString := strNomeForm;
    pHabilitaCodigo(dbeNomPro, dbeNomPro, False);

    colDescri.Focused := True;
    TCfgRel.pSetFocus(cxDados, Self);
  End;
end;

procedure TfrmCadConfRelatorios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeNomPro, dbeNomPro, False);

  pEnableGrid(True);

  colDescri.Focused := True;
  TCfgRel.pSetFocus(cxDados, Self);
end;

procedure TfrmCadConfRelatorios.FormShow(Sender: TObject);
begin
  inherited;

  If Not TCfgRel.fEmptyStr(strNomeForm) Then
    pCarregaDados(strNomeForm);

  pEnableGrid(False);

end;

{ *********************************************************** }
{ * PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA CGFREL * }
{ ********************************************************JU* }
procedure TfrmCadConfRelatorios.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrSel: TConsultasArray;
begin
  // inherited;

  chrKey := '?';
  If TCfgRel.fPesqConfiguracaoRel(conSimples, Self, nil, nil,
    qryTabela, chrKey, arrSel, ' WHERE REL_CODEMP = ' +
    QuotedStr(TCfgRel.fGetEmpresaLogada())) then

  Begin
    If Not TCfgRel.fEmptyStr(qryTabela.FieldByName('REL_NOMPRO')
      .AsString) Then
      pCarregaDados(qryTabela.FieldByName('REL_NOMPRO').AsString);

    TCfgRel.pSetFocus(btnAlterar, Self);
  End;
end;

procedure TfrmCadConfRelatorios.colImpPadPropertiesChange(Sender: TObject);
begin
  inherited;

  If qryTabela.FieldByName('REL_IMPPAD').AsString = 'S' Then
    qryTabela.FieldByName('REL_NOMFIL').AsString := '';

end;

procedure TfrmCadConfRelatorios.colNomFilPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
Var
  strNomImp: String;
  strTipImp: String;
begin
  inherited;

  If (qryTabela.State in [dsInsert, DsEdit]) Then
  Begin
    If TCfgRel.fSelecionaFila(strNomeForm,
                              qryTabela.FieldByName('AUTOINCREM').AsString,
                              qryTabela.FieldByName('REL_CODOPE').AsString,
                              qryTabela.FieldByName('REL_NOMMAQ').AsString,
                              strNomImp,
                              strTipImp,
                              TCfgRel.fCfgSis('CADIMP', VarBoolean) Or TCfgRel.VS_SpoolImpressaoCitel,
                              TCfgRel.VS_SpoolImpressaoCitel) Then
    Begin
      colNomFil.EditValue := strNomImp;

      qryTabela.FieldByName('REL_IMPPAD').AsString := 'N';

      If strTipImp = IMP_MATRICIAL Then
        qryTabela.FieldByName('REL_IDEIMP').AsString := 'M';

      If strTipImp = IMP_JATO_LASER Then
        qryTabela.FieldByName('REL_IDEIMP').AsString := 'J';
    End;
  End;

end;

procedure TfrmCadConfRelatorios.cxDadosDBTableView1EditKeyDown
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (qryTabela.State in [dsInsert, DsEdit]) Then
  Begin
    If Key = VK_Return Then
    Begin

      If cxDadosDBTableView1.Controller.FocusedColumn = colTipImp Then
        TCfgRel.pSetFocus(btnGravar, Self);

    End

    Else If Key = VK_DELETE Then
    Begin

      If cxDadosDBTableView1.Controller.FocusedColumn = colNomFil Then
      Begin
        qryTabela.FieldByName('REL_NOMFIL').AsString := '';
        qryTabela.FieldByName('REL_NOMPON').AsString := '';
        qryTabela.FieldByName('REL_NOMIMP').AsString := '';
      End;

      If cxDadosDBTableView1.Controller.FocusedColumn = colNomMaq Then
      Begin
        qryTabela.FieldByName('REL_NOMMAQ').AsString := '';
      End;

    End;
  End;

end;

procedure TfrmCadConfRelatorios.cxDadosDBTableView1EditKeyPress
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
Var
  qryCodOpe: TUniQuery;
  arrSel: TConsultasArray;
begin
  inherited;
  If TCfgRel.fEntraCons(Key) And (AItem = colCodOpe) And btnGravar.Enabled Then
  Begin
    qryCodOpe := TCfgRel.fCriaQuery();
    Try
      If TCfgRel.fPesqOperador(Self, nil, nil, qryCodOpe, Key, arrSel) Then
        qryTabela.FieldByName('REL_CODOPE').AsString := qryCodOpe.FieldByName('OPE_CODOPE').AsString;
    Finally
      qryCodOpe.Free;
    End;
  End;
end;

procedure TfrmCadConfRelatorios.pCarregaDados(strNomFrm: String);
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT * FROM CFGREL WHERE REL_NOMPRO = ' +
    QuotedStr(strNomFrm) + ' AND REL_CODEMP = ' +
    QuotedStr(TCfgRel.fGetEmpresaLogada()));
  qryTabela.Open;

  strNomeForm := strNomFrm;
end;

procedure TfrmCadConfRelatorios.pCarregarNomeMaquinas;
Var
  LQuery: TUniQuery;
begin
  TcxComboBoxProperties(colNomMaq.Properties).Items.Clear;
  TcxComboBoxProperties(colNomMaq.Properties).Items.Add(EmptyStr);
  LQuery := TCfgRel.fCriaQuery(nil);
  Try
    LQuery.SQL.Add('SELECT DISTINCT ');
    LQuery.SQL.Add('  LOG_WTSMAQ AS NOMMAQ ');
    LQuery.SQL.Add('FROM ');
    LQuery.SQL.Add('  LOGACE ');
    LQuery.SQL.Add('WHERE TRUE ');
    LQuery.SQL.Add('  AND LOG_DTAENT >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH) ');
    LQuery.SQL.Add('  AND LOG_WTSMAQ <> "" ');
    LQuery.SQL.Add('ORDER BY NOMMAQ ');
    LQuery.Open;
    While Not LQuery.Eof Do
    Begin
      TcxComboBoxProperties(colNomMaq.Properties).Items.Add(LQuery.FieldByName('NOMMAQ').AsString);
      LQuery.Next;
    End;
  Finally
    LQuery.Free;
  End;
end;

procedure TfrmCadConfRelatorios.pBeforePost(DataSet: TDataSet);
begin

  If pnlInfo.Caption <> 'Gravando registro! Aguarde....' Then
    Abort;

end;

procedure TfrmCadConfRelatorios.pBeforeCancel(DataSet: TDataSet);
begin

  If Not btnCancela.Focused Then
  Begin
    TCfgRel.pSetFocus(btnCancela, Self);
    btnCancela.Click;
  End;

end;

procedure TfrmCadConfRelatorios.pEnableGrid(blnEnable: Boolean);
begin
  cxDadosDBTableView1.OptionsData.Editing := blnEnable;

  colCodOpe.Options.Editing := blnEnable;
  colDescri.Options.Editing := blnEnable;
  colNomFil.Options.Editing := blnEnable;

  If TCfgRel.fCfgSis('CADIMP', VarBoolean) Or TCfgRel.VS_SpoolImpressaoCitel Then
    blnEnable := False;

  colImpPad.Options.Editing := blnEnable;
  colTipImp.Options.Editing := blnEnable;
  colPergun.Options.Editing := blnEnable;
End;

end.
