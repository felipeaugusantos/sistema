unit untFrameCheckListGarantiaMercadoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  untCadCheckListValidacaoGarantia, cxCheckBox, untZClient, untChkMerTypes, UniClientDataSet, untTChecklistProduto;

type
  TTipoCheckListGrupo = TTipoCheckList;

type
  TframeCheckListGarantiaMercadoria = class(TFrame, IFrameCheckList)
    pnlFraChkGar: TPanel;
    Label1: TLabel;
    pnlFraChkGarBtn: TPanel;
    btnMarcarTodos: TBitBtnLocked;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1AUTOINCREM: TcxGridDBColumn;
    cxGrid1DBTableView1CVG_CODIGO: TcxGridDBColumn;
    cxGrid1DBTableView1CVG_DESCRI: TcxGridDBColumn;
    cxGrid1DBTableView1CVG_TIPOVG: TcxGridDBColumn;
    cxGrid1DBTableView1CVG_TIPORE: TcxGridDBColumn;
    cxGrid1DBTableView1ITE_CONTEU: TcxGridDBColumn;
    cxGrid1DBTableView1ASSOCIADO: TcxGridDBColumn;
    cxGrid1DBTableView1ITE_AUTINC: TcxGridDBColumn;
    btnEditar: TBitBtnLocked;
    dtsDados: TDataSource;
    cdsDados: TUniClientDataSet;
    cdsDadosAUTOINCREM: TStringField;
    cdsDadosCVG_CODIGO: TStringField;
    cdsDadosCVG_DESCRI: TStringField;
    cdsDadosCVG_TIPORE: TStringField;
    cdsDadosCVG_TIPOVG: TStringField;
    cdsDadosASSOCIADO: TStringField;
    cdsDadosSITUACAO: TStringField;
    cdsDadosITE_CONTEU: TStringField;
    cdsDadosITE_AUTINC: TStringField;
    cdsDadosITE_CODITE: TStringField;
    btnExtrairJson: TBitBtnLocked;
    lblDelete: TLabel;
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure cxGrid1DBTableView1ASSOCIADOPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
      var ErrorText: TCaption; var Error: Boolean);
    procedure cxGrid1DBTableView1CellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure btnExtrairJsonClick(Sender: TObject);
    procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    [weak]
    FFrameEditarChkMercadoriasView: IFrameEditarChkMercadoriasView;


    FBkpOpcoes: OleVariant;
    FChecklistProduto: TChecklistProduto;

    FenuGrupo: TTipoCheckList;

    FblnSomenteLeitura: Boolean;
    FCarregandoChecklistItem: Boolean;

    procedure pAdicionarOpcoes(recItem: TRecItemCheckListGarantia);

    procedure pCarregarOpcoes;
    procedure pConfigurarCdsDados;

    function fGetstrCodIte: String;

    procedure pInserirItem(recItem: TRecItemCheckListGarantia);


    procedure pSelecionar;overload;
    procedure pSetSomenteLeitura(const Value: Boolean);
    procedure pSetEnuGrupo(enuTipo: TTipoCheckList);
    procedure pSetblnHabilitarExtrairJson(const Value: Boolean);
    function fGetblnHabilitarExtrairJson: Boolean;

    { Private declarations }
  public
    ProcEnviarItemCheckList: TEnviarItemChecklistMercadoria;
    blnSomenteOpcoesItem: Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

    procedure pAtualizarRotulo;

    procedure pCarregarChecklist(const pstrCodIte, pstrCodEmp: String);
    procedure pCarregarChecklistDeJson(const strJSon: String);

    function fGravar: Boolean;

    function fObterItemCheckList: TRecItemCheckListGarantia;

    procedure pSelecionar(const blnMarcar: Boolean; const blnTodos: Boolean);overload;
    procedure pSetFrameEdicao(const pFrameEditarChkMercadoriasView: IFrameEditarChkMercadoriasView);
    procedure pFiltrarSomenteAtivos(blnFiltrar: Boolean);
    procedure pOcultarPainel(const blnValue: Boolean);
    property enuGrupo: TTipoCheckList Read FenuGrupo Write pSetEnuGrupo;

    property strCodIte: String Read FGetstrCodIte;

    property checkListProduto: TChecklistProduto Read FChecklistProduto;
    property blnSomenteLeitura: Boolean Read FblnSomenteLeitura Write pSetSomenteLeitura;
    property blnHabilitarExtrairJson: boolean Read fGetblnHabilitarExtrairJson Write pSetblnHabilitarExtrairJson;
    { Public declarations }
  end;

implementation

uses
  System.StrUtils, untFuncoesSimples, Uni, untController.CheckListGarantia, Vcl.Clipbrd;

{$R *.dfm}

{ TFrame1 }

procedure TframeCheckListGarantiaMercadoria.btnEditarClick(Sender: TObject);
  Var
    recItem: TRecItemCheckListGarantia;
begin
  if Assigned(FFrameEditarChkMercadoriasView) then
  begin
    recItem := fObterItemCheckList;
    FFrameEditarChkMercadoriasView.pEditarCheckList(recItem, pInserirItem, True);
  end;
end;

procedure TframeCheckListGarantiaMercadoria.btnExtrairJsonClick(Sender: TObject);
  Var
    strJson: String;
begin
  FcheckListProduto.pAplicarItensChkMer(cdsDados);
  strJson := FcheckListProduto.fGetAsStringJson(True);

  if Not fEmptySTr(strJson) then
  begin
    Clipboard.AsText := strJson;
    pMensagemOk('Checklist copiado para área de transferência!');
  end;
end;

procedure TframeCheckListGarantiaMercadoria.btnMarcarTodosClick(
  Sender: TObject);
begin
   pSelecionar;
end;

constructor TframeCheckListGarantiaMercadoria.Create(AOwner: TComponent);

begin
  inherited Create(AOwner);
  blnHabilitarExtrairJson := False;
  blnSomenteOpcoesItem := False;
  FBkpOpcoes := Unassigned;
  FChecklistProduto := TChecklistProduto.Create;
  FFrameEditarChkMercadoriasView := Nil;
  pConfigurarCdsDados;
end;

procedure TframeCheckListGarantiaMercadoria.cxGrid1DBTableView1ASSOCIADOPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  pSelecionar(DisplayValue = '1',False);
end;

procedure TframeCheckListGarantiaMercadoria.cxGrid1DBTableView1CellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  Var
    blnAssociar: Boolean;
begin
  AHandled := True;

  if blnSomenteLeitura then
    Exit;

  if ACellViewInfo.Item.Index = cxGrid1DBTableView1ASSOCIADO.Index then
  begin
    blnAssociar := cdsDados.FieldByName('ASSOCIADO').AsString = VB_LOG_SIM;
    pSelecionar((Not blnAssociar), False);
  end;
end;

procedure TframeCheckListGarantiaMercadoria.cxGrid1DBTableView1DblClick(
  Sender: TObject);
begin
  if Not blnSomenteLeitura then
    btnEditar.Click;
end;

procedure TframeCheckListGarantiaMercadoria.cxGrid1DBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if Not blnSomenteLeitura then
      btnEditar.Click;
  end;
end;

destructor TframeCheckListGarantiaMercadoria.Destroy;
begin
  if Assigned(FChecklistProduto) then
    FreeAndNil(FChecklistProduto);

  FBkpOpcoes := Unassigned;
  inherited;
end;

function TframeCheckListGarantiaMercadoria.fGetblnHabilitarExtrairJson: Boolean;
begin
  Result := btnExtrairJson.Enabled and btnExtrairJson.Visible;
end;

function TframeCheckListGarantiaMercadoria.fGetstrCodIte: String;
begin
  Result := FChecklistProduto.strCodIte;
end;

function TframeCheckListGarantiaMercadoria.fGravar: Boolean;
begin
  FChecklistProduto.enuGrupoChklist.pSetAsString(Self.enuGrupo.fAsString);
  FChecklistProduto.pAplicarItensChkMer(Self.cdsDados);
  Result :=  FChecklistProduto.fGravar;
end;

function TframeCheckListGarantiaMercadoria.fObterItemCheckList: TRecItemCheckListGarantia;
begin
  Result.pLimpar;
  Result.intId := Self.Tag;
  Result.strCodigo := cdsDadosCVG_CODIGO.AsString;
  Result.strCodEmp := FChecklistProduto.strCodEmp;
  Result.strDescricao := cdsDadosCVG_DESCRI.AsString;
  Result.strConteudo := cdsDadosITE_CONTEU.AsString;
  Result.strIteAutInc := cdsDadosITE_AUTINC.AsString;
  Result.strAutoincrem := cdsDadosAUTOINCREM.AsString;
  Result.strSituacao := cdsDadosSITUACAO.AsString;
  Result.blnAssociado := cdsDadosASSOCIADO.AsString = VB_LOG_SIM;
  Result.strCodIte := cdsDadosITE_CODITE.AsString;
  Result.enuChkList.pSetAsString(cdsDadosCVG_TIPOVG.AsString);
  Result.enuResultado.pSetAsString(cdsDadosCVG_TIPORE.AsString);
end;

procedure TframeCheckListGarantiaMercadoria.pAdicionarOpcoes(recItem: TRecItemCheckListGarantia);
begin
  if cdsDados.Locate('AUTOINCREM', recItem.strAutoincrem,[]) then
    Exit;
  if (recItem.enuChkList <> FenuGrupo) and (FenuGrupo.fAsString <> EmptyStr) then
    Exit;

  cdsDados.Append;
  cdsDadosAUTOINCREM.AsString := recItem.strAutoincrem;
  cdsDadosCVG_CODIGO.AsString := recItem.strCodigo;
  cdsDadosCVG_DESCRI.AsString := recItem.strDescricao;
  cdsDadosCVG_TIPORE.AsString := recItem.enuResultado.fAsString;
  cdsDadosCVG_TIPOVG.AsString := recItem.enuChkList.fAsString;
  cdsDadosASSOCIADO.AsString  := VB_LOG_NAO;
  cdsDadosSITUACAO.AsString   := VB_LOG_NAO;
  cdsDadosITE_CONTEU.AsString := recItem.fGetConteudo;
  cdsDadosITE_CODITE.AsString := EmptyStr;
  cdsDadosITE_AUTINC.AsString := EmptyStr;
  cdsDados.Post;
end;

procedure TframeCheckListGarantiaMercadoria.pAtualizarRotulo;
  Var
    strTitulo: String;
begin
  case FenuGrupo of
    TTipoCheckList.Garantia: strTitulo := 'Checklist de Validação de Garantia de Mercadoria';
    TTipoCheckList.Troca: strTitulo := 'Checklist de Validação de Troca de Mercadoria';
    else
      strTitulo := 'Checklist de Validação de Mercadoria';
  end;

  if Tag > 0 then
    Label1.Caption := Format('%d. %s',[Tag, strTitulo])
  else
    Label1.Caption := strTitulo;
end;

procedure TframeCheckListGarantiaMercadoria.pSelecionar;
  Var
    blnMarcar: Boolean;
begin
  blnMarcar := btnMarcarTodos.Tag = 1;
  pSelecionar(blnMarcar, True);

  blnMarcar := Not blnMarcar;
  if blnMarcar then
  begin
    btnMarcarTodos.Caption := 'Marcar Todos';
    btnMarcarTodos.Tag := 1;
  end
  else
  begin
    btnMarcarTodos.Caption := 'Desmarcar Todos';
    btnMarcarTodos.Tag := 0;
  end;

end;

procedure TframeCheckListGarantiaMercadoria.pSetblnHabilitarExtrairJson(const Value: Boolean);
begin
  btnExtrairJson.Enabled := Value;
  btnExtrairJson.Visible := btnExtrairJson.Enabled;
end;

procedure TframeCheckListGarantiaMercadoria.pSetEnuGrupo(enuTipo: TTipoCheckList);
begin
  FenuGrupo := enuTipo;
  pAtualizarRotulo;
  pCarregarOpcoes;
end;

procedure TframeCheckListGarantiaMercadoria.pSetFrameEdicao(
  const pFrameEditarChkMercadoriasView: IFrameEditarChkMercadoriasView);
begin
  FFrameEditarChkMercadoriasView := pFrameEditarChkMercadoriasView;
end;

procedure TframeCheckListGarantiaMercadoria.pSetSomenteLeitura(
  const Value: Boolean);
begin
  if (Not Value) and (Assigned(ProcEnviarItemCheckList) or Assigned(FFrameEditarChkMercadoriasView)) then
    FblnSomenteLeitura := False
  else
    FblnSomenteLeitura := True;

  cxGrid1.Enabled := Not FblnSomenteLeitura;
  cxGrid1DBTableView1.OptionsData.Deleting := Not FblnSomenteLeitura;
  btnEditar.visible := Not FblnSomenteLeitura;
  btnEditar.Enabled := btnEditar.visible;

  btnMarcarTodos.Visible := Not FblnSomenteLeitura;
  btnMarcarTodos.Enabled := btnMarcarTodos.Visible;
  lblDelete.Visible := Not Value;
end;

procedure TframeCheckListGarantiaMercadoria.pSelecionar(const blnMarcar,
  blnTodos: Boolean);
  Var
    recItem: TRecItemCheckListGarantia;

begin
  if blnTodos then
  begin
    Try
      cdsDados.DisableControls;
      cdsDados.First;
      While Not cdsDados.Eof do
      begin
        pSelecionar(blnMarcar, False);
        cdsDados.Next;
      end;
    Finally
      cdsDados.First;
      cdsDados.EnableControls;
    End;
  end
  else
  begin
    recItem := fObterItemCheckList;
    if recItem.blnAssociado = blnMarcar then
      Exit;
    recItem.blnAssociado := blnMarcar;
    if blnMarcar and (recItem.enuResultado <> ttipoResultado.NA) then
    begin
      if Not recItem.fTemConteudo then
        Exit;
    end;

    cdsDados.Edit;
    cdsDados.FieldByName('SITUACAO').AsString := recItem.fDefinirSituacao;
    cdsDados.FieldByName('ASSOCIADO').AsString := ifthen(blnMarcar, VB_LOG_SIM, VB_LOG_NAO);
    cdsDados.Post;
  end;
end;


procedure TframeCheckListGarantiaMercadoria.pCarregarCheckList(const pstrCodIte, pstrCodEmp: String);
begin
  cdsDados.EmptyDataSet;
  FChecklistProduto.pCarregar(pstrCodIte,FenuGrupo, blnSomenteOpcoesItem, pstrCodEmp);
  cdsDados.Data := FChecklistProduto.cdsItensChkMer.Data;
end;

procedure TframeCheckListGarantiaMercadoria.pCarregarChecklistDeJson(const strJSon: String);
  Var
    strIndexFieldNames: String;
begin
  strIndexFieldNames := cdsDados.IndexFieldNames;

  if FChecklistProduto.fCarregarJson(strJSon) then
  begin
    cdsDados.Close;
    cdsDados.Data := FChecklistProduto.cdsItensChkMer.Data;
    cdsDados.IndexFieldNames := strIndexFieldNames
  end;
end;

procedure TframeCheckListGarantiaMercadoria.pCarregarOpcoes;
begin
  if Not cdsDados.Active then
    cdsDados.CreateDataSet
  else
    cdsDados.EmptyDataSet;
  FChecklistProduto.pCarregar(EmptyStr, enuGrupo, False, VS_strCodEmp);
  FChecklistProduto.pPercorrerItens(pAdicionarOpcoes);
  FBkpOpcoes := cdsDados.Data;
end;

procedure TframeCheckListGarantiaMercadoria.pConfigurarCdsDados;
  Var
    objFieldDef: TFieldDef;

begin
  cdsDados.CreateDataSet;

  objFieldDef := cdsDados.FieldDefs.Find('ITE_CODITE');
  if Assigned(objFieldDef) then
    psetaCodIte(objFieldDef);

end;

procedure TframeCheckListGarantiaMercadoria.pFiltrarSomenteAtivos(
  blnFiltrar: Boolean);
begin
  cdsDados.Filtered := False;
  cdsDados.Filter := EmptyStr;
  if blnFiltrar then
    cdsDados.Filter := ' SITUACAO = '+ QuotedStr(SITUACAO_ITEM_ASSOCIADO);

  cdsDados.Filtered := Not fEmptyStr(cdsDados.Filter);
end;

procedure TframeCheckListGarantiaMercadoria.pInserirItem(recItem: TRecItemCheckListGarantia);
  Var
    lRecAnt: TRecItemCheckListGarantia;
begin

  if (FenuGrupo.fAsString <> '') and (recItem.enuChkList <> FenuGrupo) then
    Exit;

  if Not cdsDados.Locate('AUTOINCREM', recItem.strAutoincrem,[]) then
    FCarregandoChecklistItem := True;

  lRecAnt := fObterItemCheckList;

  if fEmptyStr(recItem.strCodIte) then
  begin
    recItem.strCodIte := FChecklistProduto.strCodIte;
    recItem.strCodEmp := FChecklistProduto.strCodEmp;
  end;

  recItem.strSituacao := recItem.fDefinirSituacao;

  Try
    if FCarregandoChecklistItem then
    begin
      cdsDados.Append;
      cdsDados.FieldByName('ITE_AUTINC').AsString := recItem.strIteAutInc;
      cdsDados.FieldByName('ITE_CODITE').AsString := recItem.strCodIte;
      cdsDados.FieldByName('AUTOINCREM').AsString := RecItem.strAutoincrem;
      cdsDados.FieldBYName('CVG_TIPORE').AsString := RecItem.enuResultado.fAsString;
      cdsDados.FieldByName('CVG_TIPOVG').AsString := RecItem.enuChkList.fAsString;
      cdsDados.FieldByName('CVG_DESCRI').AsString := RecItem.strDescricao;
      cdsDados.FieldByName('CVG_CODIGO').AsString := RecItem.strCodigo;
    end
    else
      cdsDados.Edit;

    cdsDados.FieldByName('ITE_CONTEU').AsString := recItem.fGetConteudo;
    cdsDados.FieldByName('ASSOCIADO').AsString  := ifthen(recItem.blnAssociado, VB_LOG_SIM, VB_LOG_NAO);
    cdsDados.FieldByName('SITUACAO').AsString   := recItem.strSituacao;
    cdsDados.Post;
  Finally
    FCarregandoChecklistItem := False;
  End;
end;


procedure TframeCheckListGarantiaMercadoria.pOcultarPainel(
  const blnValue: Boolean);
begin
  pnlFraChkGarBtn.Visible := Not blnValue;
end;

end.



