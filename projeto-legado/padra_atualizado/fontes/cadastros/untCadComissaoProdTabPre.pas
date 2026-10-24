unit untCadComissaoProdTabPre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.CheckLst, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni, untGravando, untCopiaComissao, untExcel, StrUtils,
  cxContainer, cxProgressBar;

type
  TfrmCadComissaoProdTabPre = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label5: TLabel;
    Label7: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    edtCodIte: TEditFocus;
    edtCodFor: TEditFocus;
    edtCodGru: TEditFocus;
    edtCodMar: TEditFocus;
    edtCodUni: TEditFocus;
    edtDesIte: TEditFocus;
    edtDesFor: TEditFocus;
    edtDesGru: TEditFocus;
    edtDesMar: TEditFocus;
    edtDesUni: TEditFocus;
    Label2: TLabel;
    fpnTabelaPreco: TFlowPanel;
    chkTabela1: TCheckBox;
    chkTabela2: TCheckBox;
    chkTabela3: TCheckBox;
    chkTabela4: TCheckBox;
    chkTabela5: TCheckBox;
    chkTabela6: TCheckBox;
    chkTabela7: TCheckBox;
    btnAdicionar: TBitBtnLocked;
    Panel1: TPanel;
    grdComissaoDBTableView: TcxGridDBTableView;
    grdComissaoLevel1: TcxGridLevel;
    grdComissao: TcxGrid;
    cdsComissao: TUniClientDataSet;
    cdsComissaoCODITE: TStringField;
    cdsComissaoDESITE: TStringField;
    cdsComissaoREFERE: TStringField;
    cdsComissaoCODUNI: TStringField;
    cdsComissaoDESUNI: TStringField;
    cdsComissaoTABELA: TIntegerField;
    cdsComissaoCOMVAR: TFloatField;
    cdsComissaoCOMATA: TFloatField;
    cdsComissaoCOMDIS: TFloatField;
    cdsComissaoCOMDIG: TFloatField;
    dtsComissao: TDataSource;
    grdComissaoDBTableViewCODEMP: TcxGridDBColumn;
    grdComissaoDBTableViewCODITE: TcxGridDBColumn;
    grdComissaoDBTableViewDESITE: TcxGridDBColumn;
    grdComissaoDBTableViewREFERE: TcxGridDBColumn;
    grdComissaoDBTableViewCODUNI: TcxGridDBColumn;
    grdComissaoDBTableViewTABELA: TcxGridDBColumn;
    grdComissaoDBTableViewCOMVAR: TcxGridDBColumn;
    grdComissaoDBTableViewCOMATA: TcxGridDBColumn;
    grdComissaoDBTableViewCOMDIS: TcxGridDBColumn;
    cdsComissaoSTATUS: TStringField;
    cdsComissaoCODEMP: TStringField;
    btnCopiar: TBitBtnLocked;
    Panel2: TPanel;
    pnlEditaveis: TPanel;
    Shape1: TShape;
    Label4: TLabel;
    btnGravar: TBitBtnLocked;
    cdsComissaoAUTINC: TStringField;
    btnImportar: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure grdComissaoDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grdComissaoDBTableViewCOMVARValidateDrawValue(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      const AValue: Variant; AData: TcxEditValidateInfo);
    procedure grdComissaoDBTableViewCOMATAValidateDrawValue(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      const AValue: Variant; AData: TcxEditValidateInfo);
    procedure grdComissaoDBTableViewCOMDISValidateDrawValue(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      const AValue: Variant; AData: TcxEditValidateInfo);
    procedure btnCopiarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsComissaoAfterEdit(DataSet: TDataSet);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodGruExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodUniExit(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }

    blnImportou : Boolean;

    procedure pMostraTabelaPrecoConfigurada;
    procedure pCarregaComissao;
    function fGravaRegistros(pgbProgresso: TcxProgressBar):Boolean;
    procedure pCarregaTabelas(qryComTab,qryItem: TUniQuery; stlTabela: TStringList);
    procedure pRetornaComissao(var fltComVar, fltComAta, fltComDis: Double; frmCopiaComissao: TfrmCopiaComissao);
    procedure pGravaComissao(fltComVar, fltComAta, fltComDis: Double; stlTabela: TStringList; frmCopiaComissao: TfrmCopiaComissao);
    procedure pBuscaRegistroCOMTAB(qryComTab: TUniQuery; stlItem: TStringList);
    procedure pAdicionaItensPorTabelaDePreco(stlTabela, stlItem: TStringList);
    procedure pBuscaRegistroCADITE(qryItem: TUniQuery; stlTabela: TStringList);
    function fRetornaAutoincrem(strCodIte, strCodEmp: string; intTabela: integer): string;
    function fRetornaTabelaPreco(var strTabelas: string; stlTabela: TStringList): integer;
    function fImportarExcel(pgbProgresso: TcxProgressBar):Boolean;
    function fImportarPlanilha(strPath:String; pgbProgresso: TcxProgressBar):Boolean;
    function fGetItensLinha(const strLinha : String):TUniQuery;
    function fGetStatus(const strCodIte, strCodEmp : String; const intTabela : Integer): String;
    function fStrToFloatExcel(strValor : String):Double;
  public
    { Public declarations }
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untImportSelecaoArquivo;

{$R *.dfm}

procedure TfrmCadComissaoProdTabPre.btnAdicionarClick(Sender: TObject);
var
  intIndice,
  intTotTabela: integer;
begin
  inherited;

  if not fVerificaCampos then
    Exit;

  intTotTabela := 0;

  for intIndice := 0 to fpnTabelaPreco.ControlCount - 1 do
  begin
    if fpnTabelaPreco.Controls[intIndice] is TCheckBox then
    begin
      if (TCheckBox(fpnTabelaPreco.Controls[intIndice]).Visible) then
      begin
        if (TCheckBox(fpnTabelaPreco.Controls[intIndice]).Checked) then
        begin
          Inc(intTotTabela);
        end;
      end;
    end;
  end;

  if intTotTabela = 0 then
  begin
    fMensagem('','Informe ao menos uma tabela!', ['&Ok']);
    pSetFocus(chkTabela1);
    Exit;
  end;

  fExecutarModal(pCarregaComissao, 'Por favor, aguarde...', '');
end;

procedure TfrmCadComissaoProdTabPre.btnCopiarClick(Sender: TObject);
var
  frmCopiaComissao: TfrmCopiaComissao;
  intIndice,
  intPosicao: integer;
  fltComVar,
  fltComAta,
  fltComDis: Double;
  stlTabela: TStringList;
begin
  inherited;
  pCriarFormularios(TfrmCopiaComissao, frmCopiaComissao);
  stlTabela := TStringList.Create;

  try
    intPosicao := cdsComissao.RecNo;
    if frmCopiaComissao.ShowModal = mrOk then
    begin
      fltComVar := - 1;
      fltComAta := - 1;
      fltComDis := - 1;

      pRetornaComissao(fltComVar, fltComAta, fltComDis, frmCopiaComissao);

      for intIndice := 0 to frmCopiaComissao.flwpnlTabelas.ControlCount - 1 do
      begin
        if frmCopiaComissao.flwpnlTabelas.Controls[intIndice] is TCheckBox then
        begin
          if (TCheckBox(frmCopiaComissao.flwpnlTabelas.Controls[intIndice]).Visible) then
          begin
            if (TCheckBox(frmCopiaComissao.flwpnlTabelas.Controls[intIndice]).Checked) then
            begin
              stlTabela.Add(IntToStr(intIndice + 1));
            end;
          end;
        end;
      end;

      pGravaComissao(fltComVar, fltComAta, fltComDis, stlTabela, frmCopiaComissao);

      cdsComissao.RecNo := intPosicao;
    end;
  finally
    pFreeAndNil(frmCopiaComissao);
    FreeAndNil(stlTabela);
    cdsComissao.EnableControls;
  end;
end;

procedure TfrmCadComissaoProdTabPre.btnGravarClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fGravaRegistros, 'Aguarde, inserindo registros...');

  blnImportou := False;
end;

procedure TfrmCadComissaoProdTabPre.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmCadComissaoProdTabPre.btnImportarClick(Sender: TObject);
begin
  If (cdsComissao.RecordCount > 0) Then
    pMensagemOk('Aviso! Ao importar uma planilha, as alterações que ainda não foram salvas serão perdidas!');

  fChamaTelaGravando(fImportarExcel, 'Importando Planilha...');
end;

procedure TfrmCadComissaoProdTabPre.cdsComissaoAfterEdit(DataSet: TDataSet);
begin
  inherited;
  if cdsComissaoSTATUS.AsString = 'N' then
  begin
    cdsComissaoSTATUS.AsString := 'A';
  end;
end;

procedure TfrmCadComissaoProdTabPre.edtCodForExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtCodFor.Text) then
  begin
    edtDesFor.Clear;
    Exit;
  end;
end;

procedure TfrmCadComissaoProdTabPre.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
var
  arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End
  Else 
  If Key = #13 then
  begin     
    fValidaCampos(edtCodFor, True);
  end;
end;

procedure TfrmCadComissaoProdTabPre.edtCodGruExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtCodGru.Text) then
  begin
    edtDesGru.Clear;
    Exit;
  end;
end;

procedure TfrmCadComissaoProdTabPre.edtCodGruKeyPress(Sender: TObject;
  var Key: Char);
var
  arrGrupos: TConsultasArray;
begin
  inherited;

  If fPesqGrupo(Self, edtCodGru, edtDesGru, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(edtCodGru, True) Then
      SelectNext(ActiveControl, True, True);
  End
  Else If Key = #13 then
  begin     
    fValidaCampos(edtCodGru, True);
  end;
end;

procedure TfrmCadComissaoProdTabPre.edtCodIteExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtCodIte.Text) then
  begin
    edtDesIte.Clear;
    Exit;
  end;
end;

procedure TfrmCadComissaoProdTabPre.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End
  Else If Key = #13 then
  begin     
    fValidaCampos(edtCodIte, True);
  end;
end;

procedure TfrmCadComissaoProdTabPre.edtCodMarExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtCodMar.Text) then
  begin
    edtDesMar.Clear;
    Exit;
  end;
end;

procedure TfrmCadComissaoProdTabPre.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
var
  arrMarca : TConsultasArray;
begin
  inherited;

  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, True) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End
  Else If Key = #13 then
  begin     
    fValidaCampos(edtCodMar, True);
  end;
end;

procedure TfrmCadComissaoProdTabPre.edtCodUniExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtCodUni.Text) then
  begin
    edtDesUni.Clear;
    Exit;
  end;
end;

procedure TfrmCadComissaoProdTabPre.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
var
  arrUnidades: TConsultasArray;
begin
  inherited;

  If fPesqUnidade(Self, edtCodUni, edtDesUni, Nil, Nil, Key, arrUnidades) Then
  Begin
    If fValidaCampos(edtCodUni, True) Then
      SelectNext(ActiveControl, True, True);
  End
  Else If Key = #13 then
  begin     
    fValidaCampos(edtCodUni, True);
  end;
end;

function TfrmCadComissaoProdTabPre.fImportarExcel(pgbProgresso: TcxProgressBar): Boolean;
Var
  strPath : String;
begin
  Result := False;
  If TfrmImportSelecaoArquivo.fSelecionarArquivo(strPath, FILTER_PLANILHAS) Then
    Result := fImportarPlanilha(strPath, pgbProgresso);
end;

procedure TfrmCadComissaoProdTabPre.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (blnImportou) And (cdsComissao.RecordCount > 0) Then
  Begin
    If (Not (fMensagem('Aviso!', 'Deseja realmente sair?'+#10+#13+'Os dados importados ainda não foram salvos.', ['&Sim', '&Não']) = 1)) Then
    Begin
      Action := caNone;
    End;
  End;

  inherited;
end;

procedure TfrmCadComissaoProdTabPre.FormCreate(Sender: TObject);
begin
  inherited;
  cdsComissao.CreateDataSet;
  blnImportou := False;
end;

procedure TfrmCadComissaoProdTabPre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_F2 then
  begin
    btnCopiar.Click;
  end
  else if key = VK_F3 then
  begin
    btnGravar.Click;
  end;
end;

procedure TfrmCadComissaoProdTabPre.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
  pMostraTabelaPrecoConfigurada;
end;

function TfrmCadComissaoProdTabPre.fRetornaAutoincrem(strCodIte,
  strCodEmp: string; intTabela: integer): string;
var
  qryAutInc: TUniQuery;
begin
  qryAutInc := fCriaQuery;

  try
    qryAutInc.Close;
    qryAutInc.SQL.Clear;

    qryAutInc.SQL.Add('SELECT AUTOINCREM FROM COMTAB');
    qryAutInc.SQL.Add('WHERE TAB_CODITE = :CODITE');
    qryAutInc.SQL.Add('AND TAB_CODEMP = :CODEMP');
    qryAutInc.SQL.Add('AND TAB_TABELA = :TABELA');

    qryAutInc.ParamByName('CODITE').AsString  := strCodIte;
    qryAutInc.ParamByName('CODEMP').AsString  := strCodEmp;
    qryAutInc.ParamByName('TABELA').AsInteger := intTabela;

    qryAutInc.Open;

    if qryAutInc.IsEmpty then
    begin
      Result := fRetAutoIncrem('COMTAB', strCodEmp);
    end
    else
    begin
      Result := qryAutInc.FieldByName('AUTOINCREM').AsString;
    end;
  finally
    FreeAndNil(qryAutInc);
  end;
end;

function TfrmCadComissaoProdTabPre.fRetornaTabelaPreco(
  var strTabelas: string; stlTabela: TStringList): integer;
var
  intIndice: integer;
begin
  Result := 0;
  strTabelas := EmptyStr;

  for intIndice := 0 to fpnTabelaPreco.ControlCount - 1 do
  begin
    if fpnTabelaPreco.Controls[intIndice] is TCheckBox then
    begin
      if (TCheckBox(fpnTabelaPreco.Controls[intIndice]).Visible) then
      begin
        if (TCheckBox(fpnTabelaPreco.Controls[intIndice]).Checked) then
        begin
          if Result > 0 then
          begin
            strTabelas := strTabelas + ' OR ';
          end;

          strTabelas := strTabelas + ' TAB_TABELA = '+IntToStr(intIndice + 1)+' ';
          Inc(Result);
          stlTabela.Add(IntToStr(intIndice + 1));
        end;
      end;
    end;
  end;
end;

function TfrmCadComissaoProdTabPre.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    if (Sender = edtCodIte) then
    begin
      if not fEmptyStr(edtCodIte.Text) then
      begin
        edtCodIte.Text := fStrZero(edtCodIte.Text, 5);
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
        if fEmptyStr(edtDesIte.Text) then
        begin
          fMensagem('','Produto não encontrado!', ['&Ok']);
          edtCodIte.Clear;
          Result := False;
        end;
      end;
    end
    else
    if (Sender = edtCodFor) then
    begin
      if not fEmptyStr(edtCodFor.Text) then
      begin
        edtCodFor.Text := fStrZero(edtCodFor.Text, 8);
        edtDesFor.Text := fRetNomFornecedor(edtCodFor.Text);
        if fEmptyStr(edtDesFor.Text) then
        begin
          fMensagem('','Fornecedor não encontrado!', ['&Ok']);
          edtCodFor.Clear;
          Result := False;
        end;        
      end;
    end
    else
    if (Sender = edtCodGru) then
    begin
      if not fEmptyStr(edtCodGru.Text) then
      begin
        edtCodGru.Text := fStrZero(edtCodGru.Text, 6); 
        edtDesGru.Text := fRetNomeLinhaGrupo(edtCodGru.Text);
        if fEmptyStr(edtDesGru.Text) then
        begin
          fMensagem('','Linha/Grupo não encontrado!', ['&Ok']);
          edtCodGru.Clear;
          Result := False;
        end;        
      end;
    end
    else
    if (Sender = edtCodMar) then
    begin
      if not fEmptyStr(edtCodMar.Text) then
      begin
        edtCodMar.Text := fStrZero(edtCodMar.Text, 6);
        edtDesMar.Text := fRetNomMarca(edtCodMar.Text);
        if fEmptyStr(edtDesMar.Text) then
        begin
          fMensagem('','Marca não encontrada!', ['&Ok']);
          edtCodMar.Clear;
          Result := False;
        end;        
      end;
    end
    else
    if (Sender = edtCodUni) then
    begin
      if not fEmptyStr(edtCodUni.Text) then
      begin
        edtDesUni.Text := fRetNomUnidade(edtCodUni.Text);
        if fEmptyStr(edtDesUni.Text) then
        begin
          fMensagem('','Unidade não encontrada!', ['&Ok']);
          edtCodUni.Clear;
          Result := False;
        end;        
      end;    
    end;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadComissaoProdTabPre.grdComissaoDBTableViewCOMATAValidateDrawValue(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  const AValue: Variant; AData: TcxEditValidateInfo);
begin
  inherited;
  try
    if (AValue < 0) then
    begin
      fMensagem('','O valor informado deve ser maior que zero!', ['&Ok']);
      grdComissaoDBTableViewCOMATA.EditValue := 0.00;
      Exit;
    end;

    if (AValue > 100) then
    begin
      fMensagem('','O valor informado deve ser menor que 100!', ['&Ok']);
      grdComissaoDBTableViewCOMATA.EditValue := 0.00;
      Exit;
    end;
  except
    grdComissaoDBTableViewCOMATA.EditValue := 0.00;
  end;
end;

procedure TfrmCadComissaoProdTabPre.grdComissaoDBTableViewCOMDISValidateDrawValue(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  const AValue: Variant; AData: TcxEditValidateInfo);
begin
  inherited;
  try
    if (AValue < 0) then
    begin
      fMensagem('','O valor informado deve ser maior que zero!', ['&Ok']);
      grdComissaoDBTableViewCOMDIS.EditValue := 0.00;
      Exit;
    end;

    if (AValue > 100) then
    begin
      fMensagem('','O valor informado deve ser menor que 100!', ['&Ok']);
      grdComissaoDBTableViewCOMDIS.EditValue := 0.00;
      Exit;
    end;
  except
    grdComissaoDBTableViewCOMDIS.EditValue := 0.00;
  end;
end;

procedure TfrmCadComissaoProdTabPre.grdComissaoDBTableViewCOMVARValidateDrawValue(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  const AValue: Variant; AData: TcxEditValidateInfo);
begin
  inherited;
  try
    if (AValue < 0) then
    begin
      fMensagem('','O valor informado deve ser maior que zero!', ['&Ok']);
      grdComissaoDBTableViewCOMVAR.EditValue := 0.00;
      Exit;
    end;

    if (AValue > 100) then
    begin
      fMensagem('','O valor informado deve ser menor que 100!', ['&Ok']);
      grdComissaoDBTableViewCOMVAR.EditValue := 0.00;
      Exit;
    end;
  except
    grdComissaoDBTableViewCOMVAR.EditValue := 0.00;
  end;
end;

procedure TfrmCadComissaoProdTabPre.grdComissaoDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.Item.Options.Editing Then
  Begin
    ACanvas.Brush.Color := $0075FFFF;
    ACanvas.Font.Color  := clBlack;
  End;
end;

procedure TfrmCadComissaoProdTabPre.pAdicionaItensPorTabelaDePreco(stlTabela,
  stlItem: TStringList);
var
  intTabIndice,
  intIndice: integer;
begin
  for intIndice := 0 to stlItem.Count - 1 do
  begin
    for intTabIndice := 0 to stlTabela.Count - 1 do
    begin
      if not cdsComissao.Locate('CODITE;CODEMP;TABELA', VarArrayOf([stlItem[intIndice], VS_strCodEmp, StrToInt(stlTabela[intTabIndice])]) ,[]) then
      begin
        cdsComissao.Append;
        cdsComissaoCODEMP.AsString  := VS_strCodEmp;
        cdsComissaoCODITE.AsString  := stlItem[intIndice];
        cdsComissaoDESITE.AsString  := fRetNomProduto(stlItem[intIndice]);
        cdsComissaoREFERE.AsString  := fRetReferenciaProd(stlItem[intIndice]);
        cdsComissaoCODUNI.AsString  := fRetUnidadeItem(stlItem[intIndice]);
        cdsComissaoDESUNI.AsString  := fRetSiglaUnidadePorCodIte(stlItem[intIndice]);
        cdsComissaoTABELA.AsInteger := StrToInt(stlTabela[intTabIndice]);
        cdsComissaoCOMVAR.AsFloat   := 0.00;
        cdsComissaoCOMATA.AsFloat   := 0.00;
        cdsComissaoCOMDIS.AsFloat   := 0.00;
        cdsComissaoSTATUS.AsString  := 'I';
        cdsComissao.Post;
      end;
    end;
  end;
end;

procedure TfrmCadComissaoProdTabPre.pBuscaRegistroCADITE(qryItem: TUniQuery;
  stlTabela: TStringList);
var
  intIndice: integer;
begin
  if not qryItem.IsEmpty then
  begin
    while not qryItem.Eof do
    begin
      if not cdsComissao.Locate('CODITE;CODEMP', VarArrayOf([qryItem.FieldByName('ITE_CODITE').AsString, VS_strCodEmp]), []) then
      begin
        for intIndice := 0 to stlTabela.Count - 1 do
        begin
          cdsComissao.Append;
          cdsComissaoCODEMP.AsString  := VS_strCodEmp;
          cdsComissaoCODITE.AsString  := qryItem.FieldByName('ITE_CODITE').AsString;
          cdsComissaoDESITE.AsString  := qryItem.FieldByName('ITE_DESITE').AsString;
          cdsComissaoREFERE.AsString  := qryItem.FieldByName('ITE_REFERE').AsString;
          cdsComissaoCODUNI.AsString  := qryItem.FieldByName('ITE_CODUNI').AsString;
          cdsComissaoDESUNI.AsString  := fRetSiglaUnidadePorCodIte(qryItem.FieldByName('ITE_CODITE').AsString);
          cdsComissaoTABELA.AsInteger := StrToInt(stlTabela[intIndice]);
          cdsComissaoCOMVAR.AsFloat   := 0.00;
          cdsComissaoCOMATA.AsFloat   := 0.00;
          cdsComissaoCOMDIS.AsFloat   := 0.00;
          cdsComissaoSTATUS.AsString  := 'I';
          cdsComissao.Post;
        end;
      end;
      qryItem.Next;
    end;
  end;
end;

procedure TfrmCadComissaoProdTabPre.pBuscaRegistroCOMTAB(qryComTab: TUniQuery; stlItem: TStringList);
begin
  if not qryComTab.IsEmpty then
  begin
    while not qryComTab.Eof do
    begin
      cdsComissao.Append;
      cdsComissaoAUTINC.AsString  := qryComTab.FieldByName('AUTOINCREM').AsString;
      cdsComissaoCODEMP.AsString  := qryComTab.FieldByName('TAB_CODEMP').AsString;
      cdsComissaoCODITE.AsString  := qryComTab.FieldByName('TAB_CODITE').AsString;
      cdsComissaoDESITE.AsString  := fRetNomProduto(qryComTab.FieldByName('TAB_CODITE').AsString);
      cdsComissaoREFERE.AsString  := fRetReferenciaProd(qryComTab.FieldByName('TAB_CODITE').AsString);
      cdsComissaoCODUNI.AsString  := qryComTab.FieldByName('TAB_CODUNI').AsString;
      cdsComissaoDESUNI.AsString  := fRetSiglaUnidade(qryComTab.FieldByName('TAB_CODUNI').AsString);
      cdsComissaoTABELA.AsInteger := qryComTab.FieldByName('TAB_TABELA').AsInteger;
      cdsComissaoCOMVAR.AsFloat   := qryComTab.FieldByName('TAB_COMVAR').AsFloat;
      cdsComissaoCOMATA.AsFloat   := qryComTab.FieldByName('TAB_COMATA').AsFloat;
      cdsComissaoCOMDIS.AsFloat   := qryComTab.FieldByName('TAB_COMDIS').AsFloat;
      cdsComissaoSTATUS.AsString  := 'N';
      cdsComissao.Post;

      if (stlItem.IndexOf(qryComTab.FieldByName('TAB_CODITE').AsString) = -1) then
      begin
        stlItem.Add(qryComTab.FieldByName('TAB_CODITE').AsString);
      end;

      qryComTab.Next;
    end;
  end;
end;

procedure TfrmCadComissaoProdTabPre.pCarregaComissao;
var
  qryComTab,
  qryItem: TUniQuery;
  stlItem,
  stlTabela: TStringList;
begin
  qryComTab := fCriaQuery;
  qryItem := fCriaQuery;
  stlItem := TStringList.Create;
  stlTabela := TStringList.Create;
  cdsComissao.DisableControls;

  try
    pCarregaTabelas(qryComTab, qryItem, stlTabela);

    qryComTab.Open;

    qryItem.Open;

    cdsComissao.EmptyDataSet;

    pBuscaRegistroCOMTAB(qryComTab, stlItem);

    pAdicionaItensPorTabelaDePreco(stlTabela, stlItem);

    pBuscaRegistroCADITE(qryItem, stlTabela);

    if cdsComissao.RecordCount > 0 then
    begin
      cdsComissao.IndexFieldNames := 'DESITE;CODUNI;TABELA';
    end;

  finally
    FreeAndNil(qryComTab);
    FreeAndNil(qryItem);
    FreeAndNil(stlItem);
    FreeAndNil(stlTabela);
    cdsComissao.EnableControls;
  end;
end;

procedure TfrmCadComissaoProdTabPre.pCarregaTabelas(qryComTab,
  qryItem: TUniQuery; stlTabela: TStringList);
var
  strTabelas: string;
  intTotTab: integer;
begin
  qryComTab.Close;
  qryComTab.SQL.Clear;

  qryItem.Close;
  qryItem.SQL.Clear;

  qryComTab.SQL.Add('SELECT * FROM COMTAB');
  qryComTab.SQL.Add('WHERE TAB_CODEMP = :CODEMP');
  qryComTab.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryItem.SQL.Add('SELECT ITE_CODITE, ITE_DESITE, ITE_REFERE, ITE_CODUNI');
  qryItem.SQL.Add('FROM CADITE');
  qryItem.SQL.Add('WHERE 1 = 1');

  if not fEmptyStr(edtDesIte.Text) then
  begin
    qryComTab.SQL.Add('AND TAB_CODITE = :CODITE');
    qryComTab.ParamByName('CODITE').AsString := edtCodIte.Text;

    qryItem.SQL.Add('AND ITE_CODITE = :CODITE');
    qryItem.ParamByName('CODITE').AsString := edtCodIte.Text;
  end;

  if not fEmptyStr(edtDesFor.Text) then
  begin
    qryComTab.SQL.Add('AND TAB_CODFOR = :CODFOR');
    qryComTab.ParamByName('CODFOR').AsString := edtCodFor.Text;

    qryItem.SQL.Add('AND ITE_CODFOR = :CODFOR');
    qryItem.ParamByName('CODFOR').AsString := edtCodFor.Text;
  end;

  if not fEmptyStr(edtDesGru.Text) then
  begin
    qryComTab.SQL.Add('AND TAB_CODGRU = :CODGRU');
    qryComTab.ParamByName('CODGRU').AsString := edtCodGru.Text;

    qryItem.SQL.Add('AND ITE_CODGRU = :CODGRU');
    qryItem.ParamByName('CODGRU').AsString := edtCodGru.Text;
  end;

  if not fEmptyStr(edtDesMar.Text) then
  begin
    qryComTab.SQL.Add('AND TAB_CODMAR = :CODMAR');
    qryComTab.ParamByName('CODMAR').AsString := edtCodMar.Text;

    qryItem.SQL.Add('AND ITE_CODMAR = :CODMAR');
    qryItem.ParamByName('CODMAR').AsString := edtCodMar.Text;
  end;

  if not fEmptyStr(edtDesUni.Text) then
  begin
    qryComTab.SQL.Add('AND TAB_CODUNI = :CODUNI');
    qryComTab.ParamByName('CODUNI').AsString := edtCodUni.Text;

    qryItem.SQL.Add('AND ITE_CODUNI = :CODUNI');
    qryItem.ParamByName('CODUNI').AsString := edtCodUni.Text;
  end;

  intTotTab := fRetornaTabelaPreco(strTabelas, stlTabela);

  if intTotTab > 0 then
  begin
    strTabelas := ' AND (' + strTabelas + ')';
    qryComTab.SQL.Add(strTabelas);
  end;

  qryComTab.SQL.Add('ORDER BY TAB_CODITE, TAB_TABELA');

  qryItem.SQL.Add('ORDER BY ITE_CODITE');
end;

procedure TfrmCadComissaoProdTabPre.pGravaComissao(fltComVar, fltComAta,
  fltComDis: Double; stlTabela: TStringList; frmCopiaComissao: TfrmCopiaComissao);
begin
  if stlTabela.Count > 0 then
  begin
    cdsComissao.DisableControls;
    cdsComissao.First;

    while not cdsComissao.Eof do
    begin
      if stlTabela.IndexOf(IntToStr(cdsComissaoTABELA.AsInteger)) > -1 then
      begin
        cdsComissao.Edit;
        if frmCopiaComissao.chkComVar.Checked then
        begin
          cdsComissaoCOMVAR.AsFloat := fltComVar;
        end;

        if frmCopiaComissao.chkComAta.Checked then
        begin
          cdsComissaoCOMATA.AsFloat := fltComAta;
        end;

        if frmCopiaComissao.chkComDis.Checked then
        begin
          cdsComissaoCOMDIS.AsFloat := fltComDis;
        end;

        if cdsComissaoSTATUS.AsString = 'N' then
        begin
          cdsComissaoSTATUS.AsString := 'A';
        end;

        cdsComissao.Post;
      end;
      cdsComissao.Next;
    end;
  end;
end;

function TfrmCadComissaoProdTabPre.fGravaRegistros(pgbProgresso: TcxProgressBar):Boolean;
var
  qryEmpresas,
  qryInsere,
  qryAltera: TUniQuery;
begin
  inherited;

  Result := False;

  qryEmpresas := fCriaQuery;
  qryInsere := fCriaQuery;
  qryAltera := fCriaQuery;

  try
    try
      fStartTransaction;

      qryEmpresas.Close;
      qryEmpresas.SQL.Clear;

      qryInsere.Close;
      qryInsere.SQL.Clear;

      qryAltera.Close;
      qryAltera.SQL.Clear;

      qryEmpresas.SQL.Add('SELECT EMP_CODEMP FROM CADEMP ORDER BY EMP_CODEMP');

      qryInsere.SQL.Add('INSERT INTO COMTAB(AUTOINCREM, TAB_CODITE, TAB_CODEMP, TAB_CODFOR, TAB_CODGRU, TAB_CODMAR, TAB_CODUNI, TAB_TABELA, TAB_COMVAR, TAB_COMATA, TAB_COMDIS)');
      qryInsere.SQL.Add('VALUES(:AUTINC, :CODITE, :CODEMP, :CODFOR, :CODGRU, :CODMAR, :CODUNI, :TABELA, :COMVAR, :COMATA, :COMDIS)');

      qryAltera.SQL.Add('UPDATE COMTAB SET TAB_COMVAR = :COMVAR,');
      qryAltera.SQL.Add('TAB_COMATA = :COMATA,');
      qryAltera.SQL.Add('TAB_COMDIS = :COMDIS');
      qryAltera.SQL.Add('WHERE AUTOINCREM = :AUTINC');

      qryEmpresas.Open;

      pgbProgresso.Properties.Max := cdsComissao.RecordCount;

      Try
        cdsComissao.DisableControls;
        cdsComissao.First;

        while not cdsComissao.Eof do
        begin
          qryEmpresas.First;

          while not qryEmpresas.Eof do
          begin

            If blnImportou Then
            Begin
              cdsComissao.Edit;
              cdsComissaoSTATUS.AsString  := fGetStatus(cdsComissaoCODITE.AsString,
                                                        qryEmpresas.FieldByName('EMP_CODEMP').AsString,
                                                        cdsComissaoTABELA.AsInteger);
              cdsComissao.Post;
            End;


            if cdsComissaoSTATUS.AsString = 'I' then
            begin
              qryInsere.Close;
              qryInsere.ParamByName('AUTINC').AsString  := fRetAutoIncrem('COMTAB', qryEmpresas.FieldByName('EMP_CODEMP').AsString);
              qryInsere.ParamByName('CODITE').AsString  := cdsComissaoCODITE.AsString;
              qryInsere.ParamByName('CODEMP').AsString  := qryEmpresas.FieldByName('EMP_CODEMP').AsString;
              qryInsere.ParamByName('CODFOR').AsString  := fRetFornecedorItem(cdsComissaoCODITE.AsString);
              qryInsere.ParamByName('CODGRU').AsString  := fRetGrupoItem(cdsComissaoCODITE.AsString);
              qryInsere.ParamByName('CODMAR').AsString  := fRetNomMarcaItem(cdsComissaoCODITE.AsString);
              qryInsere.ParamByName('CODUNI').AsString  := fRetUnidadeItem(cdsComissaoCODITE.AsString);
              qryInsere.ParamByName('TABELA').AsInteger := cdsComissaoTABELA.AsInteger;
              qryInsere.ParamByName('COMVAR').AsFloat   := cdsComissaoCOMVAR.AsFloat;
              qryInsere.ParamByName('COMATA').AsFloat   := cdsComissaoCOMATA.AsFloat;
              qryInsere.ParamByName('COMDIS').AsFloat   := cdsComissaoCOMDIS.AsFloat;
              qryInsere.Execute;
            end
            else if cdsComissaoSTATUS.AsString = 'A' then
            begin
              qryAltera.Close;
              qryAltera.ParamByName('COMVAR').AsFloat  := cdsComissaoCOMVAR.AsFloat;
              qryAltera.ParamByName('COMATA').AsFloat  := cdsComissaoCOMATA.AsFloat;
              qryAltera.ParamByName('COMDIS').AsFloat  := cdsComissaoCOMDIS.AsFloat;
              qryAltera.ParamByName('AUTINC').AsString := fRetornaAutoincrem(cdsComissaoCODITE.AsString, qryEmpresas.FieldByName('EMP_CODEMP').AsString, cdsComissaoTABELA.AsInteger);
              qryAltera.Execute;
            end;

            qryEmpresas.Next;
          end;
          cdsComissao.Next;

          pgbProgresso.Position := cdsComissao.RecNo;
          Application.ProcessMessages;
        end;
      Finally
        cdsComissao.First;
        cdsComissao.EnableControls;
      End;

      fCommit;
      fMensagem('','Registros gravados com sucesso!', ['&Ok']);

      If blnImportou Then
        cdsComissao.EmptyDataSet
      Else
        pCarregaComissao;

      Result := True;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[pGravaRegistros]');
      End;
    end;

  finally
    FreeAndNil(qryEmpresas);
    FreeAndNil(qryInsere);
    FreeAndNil(qryAltera);
  end;
end;

function TfrmCadComissaoProdTabPre.fGetItensLinha(const strLinha : String):TUniQuery;
begin
  Result := fCriaQuery();
  Result.SQL.Add('  SELECT                ' +
                 '    ITE_CODITE,         ' +
                 '    ITE_DESITE,         ' +
                 '    ITE_REFERE,         ' +
                 '    ITE_CODUNI,         ' +
                 '    ITE_CODGRU          ' +
                 '  FROM                  ' +
                 '    CADITE              ' +
                 '  WHERE                 ' +
                 '    ITE_CODGRU=:CODGRU  ');

  Result.ParamByName('CODGRU').AsString := strLinha;

  Result.Open;
end;

function TfrmCadComissaoProdTabPre.fGetStatus(const strCodIte, strCodEmp : String; const intTabela : Integer):String;
Var
  qryStatus : TUniQuery;
begin
  qryStatus := fCriaQuery();
  Try
    qryStatus.SQL.Add('  SELECT                   ' +
                      '    AUTOINCREM             ' +
                      '  FROM                     ' +
                      '    COMTAB                 ' +
                      '  WHERE                    ' +
                      '    TAB_CODITE=:CODITE AND ' +
                      '    TAB_CODEMP=:CODEMP AND ' +
                      '    TAB_TABELA=:TABELA     ');

    qryStatus.ParamByName('CODITE').AsString  := strCodIte;
    qryStatus.ParamByName('CODEMP').AsString  := strCodEmp;
    qryStatus.ParamByName('TABELA').AsInteger := intTabela;

    qryStatus.Open;

    If qryStatus.IsEmpty Then
      Result := 'I'
    Else
      Result := 'A';
  Finally
    FreeAndNil(qryStatus);
  End;
end;

function TfrmCadComissaoProdTabPre.fStrToFloatExcel(strValor : String):Double;
begin
  Result := StrToFloatDef(AnsiReplaceStr(strValor, '.', ','), 0);
end;

function TfrmCadComissaoProdTabPre.fImportarPlanilha(strPath: String; pgbProgresso: TcxProgressBar):Boolean;
Var
  objExcel  : TExcel;
  intIndex  : Integer;
  intTabela : Integer;
  qryItens  : TUniQuery;

Const
  cLinha   = 'A';
  cVenInt1 = 'B';
  cVenInt2 = 'C';
  cVenInt3 = 'D';
  cVenInt4 = 'E';
  cVenInt5 = 'F';
  cVenInt6 = 'G';
  cVenInt7 = 'H';
  cRepLoj1 = 'I';
  cRepLoj2 = 'J';
  cRepLoj3 = 'K';
  cRepLoj4 = 'L';
  cRepLoj5 = 'M';
  cRepLoj6 = 'N';
  cRepLoj7 = 'O';
  cRepDis1 = 'P';
  cRepDis2 = 'Q';
  cRepDis3 = 'R';
  cRepDis4 = 'S';
  cRepDis5 = 'T';
  cRepDis6 = 'U';
  cRepDis7 = 'V';
begin
  blnImportou := True;

  Result := False;
  Try
    cdsComissao.DisableControls;
    cdsComissao.EmptyDataSet;

    objExcel := TExcel.fCriarExcel(Self);
    objExcel.FblnShowOnTerminate := False;
    objExcel.AbrirArquivo(strPath);

    pgbProgresso.Properties.Max := objExcel.MaximodeLinhas;

    For intIndex := 1 To objExcel.MaximodeLinhas Do
    Begin
      If (Not TryStrToInt(objExcel.Ler_Celula(cLinha + IntToStr(intIndex)), intTabela)) Then
      Begin
        pgbProgresso.Position := intIndex;
        Continue;
      End;

      Try
        qryItens := fGetItensLinha(objExcel.Ler_Celula(cLinha + IntToStr(intIndex)));

        qryItens.First;
        While (Not qryItens.Eof) Do
        Begin
          For intTabela := 1 To 7 Do
          Begin
            If Not cdsComissao.Locate('CODITE;CODEMP;TABELA', VarArrayOf([qryItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, intTabela]) ,[]) Then
            Begin
              cdsComissao.Append;
              cdsComissaoCODEMP.AsString  := VS_strCodEmp;
              cdsComissaoCODITE.AsString  := qryItens.FieldByName('ITE_CODITE').AsString;
              cdsComissaoDESITE.AsString  := qryItens.FieldByName('ITE_DESITE').AsString;
              cdsComissaoREFERE.AsString  := qryItens.FieldByName('ITE_REFERE').AsString;
              cdsComissaoCODUNI.AsString  := qryItens.FieldByName('ITE_CODUNI').AsString;
              cdsComissaoDESUNI.AsString  := fRetSiglaUnidadePorCodIte(qryItens.FieldByName('ITE_CODITE').AsString);
              cdsComissaoTABELA.AsInteger := intTabela;

              Case intTabela Of
                01:Begin
                  cdsComissaoCOMVAR.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cVenInt1 + IntToStr(intIndex)));
                  cdsComissaoCOMATA.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepLoj1 + IntToStr(intIndex)));
                  cdsComissaoCOMDIS.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepDis1 + IntToStr(intIndex)));
                End;
                02:Begin
                  cdsComissaoCOMVAR.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cVenInt2 + IntToStr(intIndex)));
                  cdsComissaoCOMATA.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepLoj2 + IntToStr(intIndex)));
                  cdsComissaoCOMDIS.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepDis2 + IntToStr(intIndex)));
                End;
                03:Begin
                  cdsComissaoCOMVAR.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cVenInt3 + IntToStr(intIndex)));
                  cdsComissaoCOMATA.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepLoj3 + IntToStr(intIndex)));
                  cdsComissaoCOMDIS.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepDis3 + IntToStr(intIndex)));
                End;
                04:Begin
                  cdsComissaoCOMVAR.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cVenInt4 + IntToStr(intIndex)));
                  cdsComissaoCOMATA.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepLoj4 + IntToStr(intIndex)));
                  cdsComissaoCOMDIS.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepDis4 + IntToStr(intIndex)));
                End;
                05:Begin
                  cdsComissaoCOMVAR.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cVenInt5 + IntToStr(intIndex)));
                  cdsComissaoCOMATA.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepLoj5 + IntToStr(intIndex)));
                  cdsComissaoCOMDIS.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepDis5 + IntToStr(intIndex)));
                End;
                06:Begin
                  cdsComissaoCOMVAR.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cVenInt6 + IntToStr(intIndex)));
                  cdsComissaoCOMATA.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepLoj6 + IntToStr(intIndex)));
                  cdsComissaoCOMDIS.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepDis6 + IntToStr(intIndex)));
                End;
                07:Begin
                  cdsComissaoCOMVAR.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cVenInt7 + IntToStr(intIndex)));
                  cdsComissaoCOMATA.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepLoj7 + IntToStr(intIndex)));
                  cdsComissaoCOMDIS.AsFloat   := fStrToFloatExcel(objExcel.Ler_Celula(cRepDis7 + IntToStr(intIndex)));
                End;
              End;

              cdsComissao.Post;
            End;
          End;


          qryItens.Next;
        End;

        Result := True;
      Finally
        FreeAndNil(qryItens);

        pgbProgresso.Position := intIndex;
      End;
    End;
  Finally
    If Assigned(objExcel) Then
    Begin
      objExcel.FecharArquivo;
      FreeAndNil(objExcel);
    End;

    cdsComissao.First;
    cdsComissao.EnableControls;
  End;
end;

procedure TfrmCadComissaoProdTabPre.pMostraTabelaPrecoConfigurada;
var
  strTabelas: string;
  intIndice: integer;
begin
  strTabelas := fCfgSis('TABPRC');

  for intIndice := 1 to Length(strTabelas) do
  begin
    case intIndice of
      1:begin
        chkTabela1.Visible := strTabelas[intIndice] = 'S';
        chkTabela1.Checked := chkTabela1.Visible;
      end;

      2:begin
        chkTabela2.Visible := strTabelas[intIndice] = 'S';
        chkTabela2.Checked := chkTabela2.Visible;
      end;

      3:begin
        chkTabela3.Visible := strTabelas[intIndice] = 'S';
        chkTabela3.Checked := chkTabela3.Visible;
      end;

      4:begin
        chkTabela4.Visible := strTabelas[intIndice] = 'S';
        chkTabela4.Checked := chkTabela4.Visible;
      end;

      5:begin
        chkTabela5.Visible := strTabelas[intIndice] = 'S';
        chkTabela5.Checked := chkTabela5.Visible;
      end;

      6:begin
        chkTabela6.Visible := strTabelas[intIndice] = 'S';
        chkTabela6.Checked := chkTabela6.Visible;
      end;

      7:begin
        chkTabela7.Visible := strTabelas[intIndice] = 'S';
        chkTabela7.Checked := chkTabela7.Visible;
      end;
    end;
  end;
end;


procedure TfrmCadComissaoProdTabPre.pRetornaComissao(var fltComVar, fltComAta,
  fltComDis: Double; frmCopiaComissao: TfrmCopiaComissao);
begin
  if frmCopiaComissao.chkComVar.Checked then
  begin
    fltComVar := cdsComissaoCOMVAR.AsFloat;
  end;

  if frmCopiaComissao.chkComAta.Checked then
  begin
    fltComAta := cdsComissaoCOMATA.AsFloat;
  end;

  if frmCopiaComissao.chkComDis.Checked then
  begin
    fltComDis := cdsComissaoCOMDIS.AsFloat;
  end;
end;

end.
