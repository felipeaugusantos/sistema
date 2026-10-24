unit untMapaDeContagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, cxGridLevel, untFuncoesSimples,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,  untTypesSistema,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGrid, untMapaDeControleContagemBalancoEstoque, cxGridDBTableView,
  EditFocus, cxCheckBox;

type
  TOpcRelDiferenca = (opcAtivo, opcInativo, opcTodos);

  TfrmMapaDeContagens = class(TfrmPai)
    dtsProdutos: TDataSource;
    cxgProdutos: TcxGrid;
    cxvProdutos: TcxGridDBBandedTableView;
    cxvProdutosColumn1: TcxGridDBBandedColumn;
    cxvProdutosColumn3: TcxGridDBBandedColumn;
    cxvProdutoSALCON: TcxGridDBBandedColumn;
    cxgProdutosLevel1: TcxGridLevel;
    cxvProdutosColumn2: TcxGridDBBandedColumn;
    Panel1: TPanel;
    BitBtnLocked1: TBitBtnLocked;
    BitBtnLocked2: TBitBtnLocked;
    edtLocIni: TEditFocus;
    Label1: TLabel;
    edtLocFin: TEditFocus;
    Label6: TLabel;
    rdgFiltro: TRadioGroup;
    btnAtualizaTela: TBitBtnLocked;
    cxvProdutosStatus: TcxGridDBBandedColumn;
    Label2: TLabel;
    cxvProdutosEmContagem: TcxGridDBBandedColumn;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Label4: TLabel;
    Shape3: TShape;
    Label5: TLabel;
    Label7: TLabel;
    Shape4: TShape;
    Shape5: TShape;
    Label8: TLabel;
    BitBtnLocked3: TBitBtnLocked;
    mnuAcoes: TPopupMenu;
    mnuMarcar: TMenuItem;
    mnuDesmarcar: TMenuItem;
    mnuExcluir: TMenuItem;
    procedure BitBtnLocked3Click(Sender: TObject);
    procedure mnuMarcarClick(Sender: TObject);
    procedure mnuDesmarcarClick(Sender: TObject);
    procedure mnuExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure getDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure rdgFiltroClick(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure BitBtnLocked2Click(Sender: TObject);
    procedure btnAtualizaTelaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvProdutosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    objMapaDeControleContagemBalancoEstoque : TMapaDeControleContagemBalancoEstoque;
    function fValidaConefe(Sender: TcxCustomGridTableView; AViewInfo: TcxGridTableDataCellViewInfo): Boolean;


    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function fInformaLocFisInicial: boolean;

  public

    { Public declarations }
  end;

var
  frmMapaDeContagens: TfrmMapaDeContagens;

implementation

{$R *.dfm}

uses untDiferencaContagemGrid, untRelBalancoEstoqueDiferenca, untFuncoesRel;

procedure TfrmMapaDeContagens.BitBtnLocked1Click(Sender: TObject);
begin
  if Assigned(prcExecutaRelatorio) then
    prcExecutaRelatorio(305, 9954, [], [], [], Sender, Nil, False);
end;

procedure TfrmMapaDeContagens.BitBtnLocked2Click(Sender: TObject);
begin
  if Assigned(prcExecutaRelatorio) then
    prcExecutaRelatorio(306, 9955, [], [], [], Sender, Nil, False);
end;

procedure TfrmMapaDeContagens.BitBtnLocked3Click(Sender: TObject);
begin
  inherited;
  mnuAcoes.Popup(Mouse.CursorPos.X + 2, Mouse.CursorPos.Y + 2);
end;

procedure TfrmMapaDeContagens.btnAtualizaTelaClick(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtLocFin, True );
end;



procedure TfrmMapaDeContagens.cxvProdutosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var item: TcxCustomGridTableItem;
begin
  inherited;
  ACanvas.Font.Color := clBlack;
  //Em Contagem
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvProdutosEmContagem.Index]) = '1' Then
    ACanvas.Brush.Color := clWebCyan
  Else
    ACanvas.Brush.Color := clWebLemonChiffon;



  //Contagem Efetivada
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvProdutoSALCON.Index]) <> '' Then
    ACanvas.Brush.Color := clMoneyGreen;

  If fValidaConefe(Sender, AViewInfo) Then
  begin
    item := cxvProdutos.DataController.GetItemByFieldName('CONEFE' + Stringreplace(TcxGridDBBandedColumn(AViewInfo.item).DataBinding.FieldName, 'CONTAGEM_',  '', []));
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Item.Index]) <> '1' Then
      ACanvas.Brush.Color := clWebTomato
    Else
      ACanvas.Brush.Color := clWebPaleGreen;
  End;

end;

procedure TfrmMapaDeContagens.FormCreate(Sender: TObject);
begin
  inherited;
  objMapaDeControleContagemBalancoEstoque := TMapaDeControleContagemBalancoEstoque.Create;
  Shape2.brush.color := clWebCyan
end;

procedure TfrmMapaDeContagens.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objMapaDeControleContagemBalancoEstoque);
end;

procedure TfrmMapaDeContagens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_f5 then
    btnAtualizaTela.Click;
end;

procedure TfrmMapaDeContagens.FormShow(Sender: TObject);
  Var
    intContador: Integer;
    cxItem: TcxCustomGridTableItem;
begin
  inherited;

  dtsProdutos.DataSet := objMapaDeControleContagemBalancoEstoque.cdsContagem;

  For intContador := 1 To objMapaDeControleContagemBalancoEstoque.intQuantidadeContagem Do
  Begin

    If intContador < objMapaDeControleContagemBalancoEstoque.intQuantidadeContagem  Then
    Begin
      cxItem := cxvProdutos.DataController.CreateItemByField(
      objMapaDeControleContagemBalancoEstoque.cdsContagem.FieldByName('CONEFE' +  intContador.ToString));

      TcxGridDBBandedColumn(cxItem).Position.BandIndex := 1;
      TcxGridDBColumn(cxItem).HeaderAlignmentHorz := taCenter;
      TcxGridDBColumn(cxItem).Options.Editing := False;
      TcxGridDBColumn(cxItem).Name := 'CONEFE' +  intContador.ToString;

      TcxGridDBColumn(cxItem).Caption := 'CONTAGEM_EFETIVADA';
      TcxGridDBColumn(cxItem).Width := 120;
      TcxGridDBColumn(cxItem).Visible := False;
    End;

    cxItem := cxvProdutos.DataController.CreateItemByField(
    objMapaDeControleContagemBalancoEstoque.cdsContagem.FieldByName('OPE_' +  intContador.ToString));

    TcxGridDBBandedColumn(cxItem).Position.BandIndex := 1;
    TcxGridDBColumn(cxItem).HeaderAlignmentHorz := taCenter;
    TcxGridDBColumn(cxItem).Options.Editing := False;
    TcxGridDBColumn(cxItem).Caption := 'Operador ' + intContador.ToString;
    TcxGridDBColumn(cxItem).Width := 120;


    cxItem := cxvProdutos.DataController.CreateItemByField(
    objMapaDeControleContagemBalancoEstoque.cdsContagem.FieldByName('CONTAGEM_' +  intContador.ToString));

    TcxGridDBBandedColumn(cxItem).Position.BandIndex := 1;
    TcxGridDBColumn(cxItem).HeaderAlignmentHorz := taCenter;
    TcxGridDBColumn(cxItem).Options.Editing := False;
    TcxGridDBColumn(cxItem).Caption := 'Cotagem ' + intContador.ToString;
    TcxGridDBColumn(cxItem).Width := 85;
    TcxGridDBColumn(cxItem).OnGetDisplayText := getDisplayText;

    TcxGridDBColumn(cxItem).PropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(TcxGridDBColumn(cxItem).Properties).DecimalPlaces := 3;
    TcxCurrencyEditProperties(TcxGridDBColumn(cxItem).Properties).DisplayFormat := ',0.000;-,0.000';
  End;

  cxvProdutos.DataController.DataSource := dtsProdutos;
  cxvProdutos.ApplyBestFit;

end;

procedure TfrmMapaDeContagens.getDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  If AText = '-1,000' Then
    AText := '';

end;

procedure TfrmMapaDeContagens.mnuDesmarcarClick(Sender: TObject);
begin
  inherited;
  objMapaDeControleContagemBalancoEstoque.pMarcarDesmarcaAbertos(False);
end;

procedure TfrmMapaDeContagens.mnuExcluirClick(Sender: TObject);
begin
  inherited;
  objMapaDeControleContagemBalancoEstoque.ExcluirContagensAberta;
  fValidaCampos(edtLocFin, True );
end;

procedure TfrmMapaDeContagens.mnuMarcarClick(Sender: TObject);
begin
  inherited;
  objMapaDeControleContagemBalancoEstoque.pMarcarDesmarcaAbertos(True);
end;

procedure TfrmMapaDeContagens.rdgFiltroClick(Sender: TObject);
begin
  inherited;

  case rdgFiltro.ItemIndex of
    0: objMapaDeControleContagemBalancoEstoque.pSetFiltro(tcbTodos, '', '');
    1: objMapaDeControleContagemBalancoEstoque.pSetFiltro(tcpComContagem, '', '');
    2: objMapaDeControleContagemBalancoEstoque.pSetFiltro(tcpSemContagem, '', '');
  End;
end;

function TfrmMapaDeContagens.fValidaCampos(
  Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtLocFin) Then
    Begin
      If fInformaLocFisInicial() Then
      Begin
        pMensagemOk('Informe a localização inicial!');
        pSetFocus(edtLocIni);
      End
      Else
      Begin
        case rdgFiltro.ItemIndex of
          0: objMapaDeControleContagemBalancoEstoque.pSetFiltro(tcbTodos, edtLocIni.Text, edtLocFin.Text, True);
          1: objMapaDeControleContagemBalancoEstoque.pSetFiltro(tcpComContagem, edtLocIni.Text, edtLocFin.Text, True);
          2: objMapaDeControleContagemBalancoEstoque.pSetFiltro(tcpSemContagem, edtLocIni.Text, edtLocFin.Text, True);
        End;
        dtsProdutos.DataSet := objMapaDeControleContagemBalancoEstoque.cdsContagem;
        cxvProdutos.DataController.DataSource := dtsProdutos;
        cxvProdutos.ApplyBestFit;

      End;

    End;

  End;
  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmMapaDeContagens.fValidaConefe(Sender: TcxCustomGridTableView; AViewInfo: TcxGridTableDataCellViewInfo): Boolean;
begin
  Result := false;
  If Pos('CONTAGEM_', TcxGridDBBandedColumn(AViewInfo.item).DataBinding.FieldName)> 0 Then
    If  VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, AViewInfo.Item.Index]) <> '-1' Then
      If TcxGridDBBandedColumn(AViewInfo.item).DataBinding.FieldName <> 'CONTAGEM_' + IntToStr(objMapaDeControleContagemBalancoEstoque.intQuantidadeContagem) Then
        Result := True;

end;

function TfrmMapaDeContagens.fInformaLocFisInicial: boolean;
begin
  Result := False;
  If not fEmptyStr(edtLocFin.Text) Then
    If fEmptyStr(edtLocIni.Text) Then
      Result := True;
end;

end.
