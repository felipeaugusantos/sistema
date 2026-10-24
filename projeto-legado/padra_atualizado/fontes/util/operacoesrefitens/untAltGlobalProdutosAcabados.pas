unit untAltGlobalProdutosAcabados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, UniClientDataSet, cxTextEdit,
  cxImageComboBox, System.ImageList, Vcl.ImgList,
  cxCheckComboBox, cxCheckBox;

type
  TfrmAltGlobalProdutosAcabados = class(TfrmPaiSimples)
    cxGProdAcabDBTableView1: TcxGridDBTableView;
    cxGProdAcabLevel1: TcxGridLevel;
    cxGProdAcab: TcxGrid;
    cxGColAlterado: TcxGridDBColumn;
    cxGColDtaVenda: TcxGridDBColumn;
    cxGColIdePro: TcxGridDBColumn;
    cxGColDescricao: TcxGridDBColumn;
    cxGColPrecoCusto: TcxGridDBColumn;
    cxGColPrecoVenda: TcxGridDBColumn;
    cxGColMargem: TcxGridDBColumn;
    cxGColPrecoVendaNovo: TcxGridDBColumn;
    cxGColMargemNova: TcxGridDBColumn;
    pnlBotoesAltGlobal: TPanel;
    btnGravar: TBitBtnLocked;
    btnFator: TBitBtnLocked;
    Shape3: TShape;
    lblEditado: TLabel;
    cxGColSaldos: TcxGridDBColumn;
    btnCancelar: TBitBtnLocked;
    cxGColCodigoAca: TcxGridDBColumn;
    cxGColPrecoVenda1: TcxGridDBColumn;
    cxGColPrecoMargemAtual1: TcxGridDBColumn;
    cxGColPrecoVendaNovo1: TcxGridDBColumn;
    cxGColMargemNova1: TcxGridDBColumn;
    cxGColPrecoVenda2: TcxGridDBColumn;
    cxGColPrecoMargemAtual2: TcxGridDBColumn;
    cxGColPrecoVendaNovo2: TcxGridDBColumn;
    cxGColPrecoMargemNova2: TcxGridDBColumn;
    cxGColPrecoVenda3: TcxGridDBColumn;
    cxGColMargemAtual3: TcxGridDBColumn;
    cxGColPrecoVendaNovo3: TcxGridDBColumn;
    cxGColMargemNova3: TcxGridDBColumn;
    cxGColPrecoVenda4: TcxGridDBColumn;
    cxGColMargemAtual4: TcxGridDBColumn;
    cxGColMargemNova4: TcxGridDBColumn;
    cxGColPrecoVenda5: TcxGridDBColumn;
    cxGColMargem5Atual: TcxGridDBColumn;
    cxGColPrecoVendaNovo5: TcxGridDBColumn;
    cxGColMargemNova5: TcxGridDBColumn;
    cxGColPrecoVenda6: TcxGridDBColumn;
    cxGColMargemAtual6: TcxGridDBColumn;
    cxGColPrecoVendaNovo6: TcxGridDBColumn;
    cxGColMargemNova6: TcxGridDBColumn;
    cxGColPrecoVendaNovo4: TcxGridDBColumn;
    cxGColPrecoVenda7: TcxGridDBColumn;
    cxGColMargem7Atual: TcxGridDBColumn;
    cxGColPrecoVendaNovo7: TcxGridDBColumn;
    cxGColMargem7Nova: TcxGridDBColumn;
    procedure cxGColPrecoVendaNovoCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFatorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGColPrecoVendaNovoPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cxGColPrecoVendaNovo1PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxGColPrecoVendaNovo2PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxGColPrecoVendaNovo4PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxGColPrecoVendaNovo5PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxGColPrecoVendaNovo6PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxGColPrecoVendaNovo7PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxGColPrecoVendaNovo3PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxGColPrecoVendaNovo1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGColPrecoVendaNovo2CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGColPrecoVendaNovo3CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGColPrecoVendaNovo4CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGColPrecoVendaNovo5CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGColPrecoVendaNovo6CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGColPrecoVendaNovo7CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    cdsProAca: TUniClientDataSet;
    dtsProAca: TDataSource;
    fltFator,
    fltfator1,
    fltfator2,
    fltfator3,
    fltfator4,
    fltfator5,
    fltfator6,
    fltfator7: Double;
    procedure pCriaTemporaria();
    procedure CalculaMargemAtual();
    procedure CalculaMargemNova();
    procedure PreencheCampoREG_EDITodos();
    procedure PreenchePrecosNovos();
    function RecalcularPrecoVenda(fltFator: Double; fltFator1: Double; fltFator2: Double; fltFator3: Double;
      fltFator4: Double; fltFator5: Double; fltFator6: Double; fltFator7: Double): Boolean;
    procedure fGravaLogAca(strCodAca: String; fltPrecus, fltPreVen, fltPreVno: Double);
    function VerificaMargemNegativa(fltFator: Double; fltFator1: Double; fltFator2: Double; fltFator3: Double;
      fltFator4: Double; fltFator5: Double; fltFator6: Double; fltFator7: Double): Double;
    function VerificaFator(intContador: Integer; fltFator1: Double; fltFator2: Double; fltFator3: Double;
      fltFator4: Double; fltFator5: Double; fltFator6: Double): Double;
    procedure GravarAcaGer();
    function fSqlProdutosAcabados(): String;
    function fVerificaEditados(): Boolean;
    procedure fGetValorFator();
    function fVerificaMargem(fltMargem: Double): Boolean;
    function fVerificaTabelaPreco(): String;
    procedure HabilitaTabelasPreco();
    procedure PreenchePrecoVendaTab(fltValor: Double; strTabela: String);
    procedure PreenchePrecoVendaTabProdutos(fltValor: Double; strTabela: String);
    function fRetornaValorFatorPrecoVenda1(strTabela: String): Double;
    function fRetornaValorFatorPrecoVenda2(strTabela: String): Double;
    function fRetornaValorFatorPrecoVenda3(strTabela: String): Double;
    function fRetornaValorFatorPrecoVenda4(strTabela: String): Double;
    function fRetornaValorFatorPrecoVenda5(strTabela: String): Double;
    function fRetornaValorFatorPrecoVenda6(strTabela: String): Double;
    function fRetornaValorFatorPrecoVenda7(strTabela: String): Double;
    procedure PreenchePrecoVendaPreVenda(fltValor: Double; strTabela: String; strTabAlterado: String);
    procedure PreenchePrecoVendaPreVenda1a3(fltValor: Double; strTabela: String; strTabAlterado: String);
    procedure PreenchePrecoVendaPreVenda4a6(fltValor: Double; strTabela: String; strTabAlterado: String);
    function RetornarMensagemMargemMarkupNegativo: string;
    function fVerificaTamanhoTela: Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmAltGlobalProdutosAcabados: TfrmAltGlobalProdutosAcabados;

implementation

uses
  untFuncoesSimples, UniDataSetProvider, Uni, untGravando, untTabFator, System.StrUtils;

{$R *.dfm}

procedure TfrmAltGlobalProdutosAcabados.btnCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAltGlobalProdutosAcabados.btnFatorClick(Sender: TObject);
begin
  inherited;

  fGetValorFator();

  If fltFator <= 0 Then
  Begin
    fMensagem('', 'O fator deve ser maior que Zero!', ['&Ok']);
    Exit;
  End;

  fltFator1 := fRetornaValorFatorPrecoVenda1(fCfgSis('TABPRE'));
  fltFator2 := fRetornaValorFatorPrecoVenda2(fCfgSis('TABPRE'));
  fltFator3 := fRetornaValorFatorPrecoVenda3(fCfgSis('TABPRE'));
  fltfator4 := fRetornaValorFatorPrecoVenda4(fCfgSis('TABPRE'));
  fltFator5 := fRetornaValorFatorPrecoVenda5(fCfgSis('TABPRE'));
  fltFator6 := fRetornaValorFatorPrecoVenda6(fCfgSis('TABPRE'));
  fltFator7 := fRetornaValorFatorPrecoVenda7(fCfgSis('TABPRE'));

  If RecalcularPrecoVenda(fltFator, fltFator1, fltFator2, fltFator3, fltFator4, fltfator5, fltFator6, fltFator7) Then
    TfrmGravando.fExecutarModal(PreencheCampoREG_EDITodos, 'Aguarde... Aplicando fator no preço de venda.', '');
end;

procedure TfrmAltGlobalProdutosAcabados.btnGravarClick(Sender: TObject);
Var
  intMarkup: Integer;
begin
  inherited;

  If Not fValidaCampos(Self) Then
    Exit;

  intMarkup := fCfgSis('MARMKP');

  TfrmGravando.fExecutarModal(GravarAcaGer, 'Aguarde... Gravando preços de venda.', '');
  TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Atualizando preços de venda.', '');

  If Pos(IntToStr(intMarkup), '2_3_4_') > 0 Then
    TfrmGravando.fExecutarModal(CalculaMargemAtual, 'Aguarde... Atualizando Markups atuais.', '')
  Else
    TfrmGravando.fExecutarModal(CalculaMargemAtual, 'Aguarde... Atualizando Margens atuais.', '');

  TfrmGravando.fExecutarModal(PreenchePrecosNovos, 'Aguarde... Atualizando preços novos...', '');

  If Pos(IntToStr(intMarkup), '2_3_4_') > 0 Then
    TfrmGravando.fExecutarModal(CalculaMargemNova, 'Aguarde... Atualizando Markups novos.', '')
  Else
    TfrmGravando.fExecutarModal(CalculaMargemNova, 'Aguarde... Atualizando Margens novas.', '');

  PreencheCampoREG_EDITodos();
  cdsProAca.First;
end;

procedure TfrmAltGlobalProdutosAcabados.CalculaMargemAtual;
Var
  intContador: Integer;
begin
  cdsProAca.First;
  While Not cdsProAca.Eof Do
  Begin
    cdsProAca.Edit;
    cdsProAca.FieldByName('MARGEM_V').AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.FieldByName('PRECUS').AsFloat,
                                                          cdsProAca.FieldByName('PREVEN').AsFloat,
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

     For intContador := 1 To 7 Do
      cdsProAca.FieldByName('MAATU' + IntToStr(intContador)).AsFloat :=
        fCalculaPrecoVenda(2,
                           cdsProAca.FieldByName('PRECUS').AsFloat,
                           cdsProAca.FieldByName('PREVE' + IntToStr(intContador)).AsFloat,
                           0,
                           0,
                           0,
                           0,
                           0);


    cdsProAca.Post;
    cdsProAca.Next;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.CalculaMargemNova();
Var
  intContador: Integer;
begin
  cdsProAca.First;
  While Not cdsProAca.Eof Do
  Begin
    cdsProAca.Edit;
    cdsProAca.FieldByName('MARGEM_N').AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.FieldByName('PRECUS').AsFloat,
                                                          cdsProAca.FieldByName('PREVNO').AsFloat,
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);


     For intContador := 1 To 7 Do
      cdsProAca.FieldByName('MANOV' + IntToStr(intContador)).AsFloat :=
        fCalculaPrecoVenda(2,
                           cdsProAca.FieldByName('PRECUS').AsFloat,
                           cdsProAca.FieldByName('PREVN' + IntToStr(intContador)).AsFloat,
                           0,
                           0,
                           0,
                           0,
                           0);

    cdsProAca.Post;
    cdsProAca.Next;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clYellow;
  ACanvas.Font.Color := clBlack;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo1PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef(DisplayValue, 0) <= 0 Then
  Begin
    pMensagemOk('O novo preço de venda deve ser maior que Zero!');
    Error := True;
    ErrorText := '';
  End
  Else
  Begin
    If cdsProAca.Fields[5].AsString = DisplayValue Then
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'N_EDITADO';
      cdsProAca.Fields[28].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[30].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '1');

      cdsProAca.Post;
    End
    Else
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'EDITADO';
      cdsProAca.Fields[28].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[30].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '1');


      If Not fVerificaMargem(cdsProAca.Fields[30].AsFloat) Then
      Begin
        cdsProAca.Cancel;
        Exit;
      End;

      cdsProAca.Post;
    End;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo2CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clYellow;
  ACanvas.Font.Color := clBlack;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo2PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef(DisplayValue, 0) <= 0 Then
  Begin
    pMensagemOk('O novo preço de venda deve ser maior que Zero!');
    Error := True;
    ErrorText := '';
  End
  Else
  Begin
    If cdsProAca.Fields[6].AsString = DisplayValue Then
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'N_EDITADO';
      cdsProAca.Fields[31].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[33].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '2');

      cdsProAca.Post;
    End
    Else
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'EDITADO';
      cdsProAca.Fields[31].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[33].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '2');

      If Not fVerificaMargem(cdsProAca.Fields[33].AsFloat) Then
      Begin
        cdsProAca.Cancel;
        Exit;
      End;

      cdsProAca.Post;
    End;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo3CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clYellow;
  ACanvas.Font.Color := clBlack;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo3PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef(DisplayValue, 0) <= 0 Then
  Begin
    pMensagemOk('O novo preço de venda deve ser maior que Zero!');
    Error := True;
    ErrorText := '';
  End
  Else
  Begin
    If cdsProAca.Fields[7].AsString = DisplayValue Then
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'N_EDITADO';
      cdsProAca.Fields[34].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[36].AsFloat := fCalculaPrecoVenda(2,
                                                         cdsProAca.Fields[12].AsFloat,
                                                         StrToFloat(DisplayValue),
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '3');

      cdsProAca.Post;
    End
    Else
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'EDITADO';
      cdsProAca.Fields[34].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[36].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '3');

      If Not fVerificaMargem(cdsProAca.Fields[36].AsFloat) Then
      Begin
        cdsProAca.Cancel;
        Exit;
      End;

      cdsProAca.Post;
    End;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo4CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clYellow;
  ACanvas.Font.Color := clBlack;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo4PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef(DisplayValue, 0) <= 0 Then
  Begin
    pMensagemOk('O novo preço de venda deve ser maior que Zero!');
    Error := True;
    ErrorText := '';
  End
  Else
  Begin
    If cdsProAca.Fields[8].AsString = DisplayValue Then
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'N_EDITADO';
      cdsProAca.Fields[37].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[39].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '4');

      cdsProAca.Post;
    End
    Else
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'EDITADO';
      cdsProAca.Fields[37].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[39].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '4');

      If Not fVerificaMargem(cdsProAca.Fields[39].AsFloat) Then
      Begin
        cdsProAca.Cancel;
        Exit;
      End;

      cdsProAca.Post;
    End;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo5CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clYellow;
  ACanvas.Font.Color := clBlack;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo5PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef(DisplayValue, 0) <= 0 Then
  Begin
    pMensagemOk('O novo preço de venda deve ser maior que Zero!');
    Error := True;
    ErrorText := '';
  End
  Else
  Begin
    If cdsProAca.Fields[9].AsString = DisplayValue Then
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'N_EDITADO';
      cdsProAca.Fields[40].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[42].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '5');

      cdsProAca.Post;
    End
    Else
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'EDITADO';
      cdsProAca.Fields[40].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[42].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '5');

      If Not fVerificaMargem(cdsProAca.Fields[42].AsFloat) Then
      Begin
        cdsProAca.Cancel;
        Exit;
      End;

      cdsProAca.Post;
    End;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo6CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clYellow;
  ACanvas.Font.Color := clBlack;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo6PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef(DisplayValue, 0) <= 0 Then
  Begin
    pMensagemOk('O novo preço de venda deve ser maior que Zero!');
    Error := True;
    ErrorText := '';
  End
  Else
  Begin
    If cdsProAca.Fields[10].AsString = DisplayValue Then
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'N_EDITADO';
      cdsProAca.Fields[43].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[45].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '6');

      cdsProAca.Post;
    End
    Else
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'EDITADO';
      cdsProAca.Fields[43].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[45].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '6');

      If Not fVerificaMargem(cdsProAca.Fields[45].AsFloat) Then
      Begin
        cdsProAca.Cancel;
        Exit;
      End;

      cdsProAca.Post;
    End;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo7CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clYellow;
  ACanvas.Font.Color := clBlack;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovo7PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef(DisplayValue, 0) <= 0 Then
  Begin
    pMensagemOk('O novo preço de venda deve ser maior que Zero!');
    Error := True;
    ErrorText := '';
  End
  Else
  Begin
    If cdsProAca.Fields[11].AsString = DisplayValue Then
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'N_EDITADO';
      cdsProAca.Fields[46].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[48].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '7');

      cdsProAca.Post;
    End
    Else
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'EDITADO';
      cdsProAca.Fields[46].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[48].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);

      PreenchePrecoVendaPreVenda(StrToFloat(DisplayValue), fCfgSis('TABPRE'), '7');

      If Not fVerificaMargem(cdsProAca.Fields[48].AsFloat) Then
      Begin
        cdsProAca.Cancel;
        Exit;
      End;

      cdsProAca.Post;
    End;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clYellow;
  ACanvas.Font.Color := clBlack;
end;

procedure TfrmAltGlobalProdutosAcabados.cxGColPrecoVendaNovoPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef(DisplayValue, 0) <= 0 Then
  Begin
    pMensagemOk('O novo preço de venda deve ser maior que Zero!');
    Error := True;
    ErrorText := '';
  End
  Else
  Begin
    If cdsProAca.Fields[3].AsString = DisplayValue Then
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'N_EDITADO';
      cdsProAca.Fields[4].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[26].AsFloat := fCalculaPrecoVenda(2,
                                                         cdsProAca.Fields[12].AsFloat,
                                                         StrToFloat(DisplayValue),
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0);

      PreenchePrecoVendaTab(StrToFloat(DisplayValue), fCfgSis('TABPRE'));



      cdsProAca.Post;
    End
    Else
    Begin
      cdsProAca.Edit;
      cdsProAca.Fields[27].AsString := 'EDITADO';
      cdsProAca.Fields[4].AsFloat  := StrToFloat(DisplayValue);
      cdsProAca.Fields[26].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          StrToFloat(DisplayValue),
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);


      PreenchePrecoVendaTab(StrToFloat(DisplayValue), fCfgSis('TABPRE'));





      If Not fVerificaMargem(cdsProAca.Fields[26].AsFloat) Then
      Begin
        cdsProAca.Cancel;
        Exit;
      End;

      cdsProAca.Post;
    End;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.fGetValorFator();
Var
  objForm : TfrmTabFator;
begin
  Try
    objForm := TfrmTabFator.Create(Nil);
    ObjForm.strTabPreco := fVerificaTabelaPreco;
    ObjForm.dblQtde := 1;
    objForm.lblQuantidade.Caption := 'Fator Pr. Venda:';
    objForm.pnlAmbiente.Visible := False;
    objForm.pnlQuantidade.Align := alClient;
    objForm.Position := poMainFormCenter;
    objForm.Width := 125;

    If objForm.ShowModal = mrOk Then
    Begin
      fltFator  := StrToFloatDef(objForm.edtQtde.Text, 0);
      fltFator1 := StrToFloatDef(objForm.edtFator1.Text, 0);
      fltFator2 := StrToFloatDef(objForm.edtFator2.Text, 0);
      fltFator3 := StrToFloatDef(objForm.edtFator3.Text, 0);
      fltFator4 := StrToFloatDef(objForm.edtFator4.Text, 0);
      fltFator5 := StrToFloatDef(objForm.edtFator5.Text, 0);
      fltFator6 := StrToFloatDef(objForm.edtFator6.Text, 0);
      fltFator7 := StrToFloatDef(objForm.edtFator7.Text, 0);
    End
    Else
    Begin
      fltFator  := 1;
      fltFator1 := 1;
      fltFator2 := 1;
      fltFator3 := 1;
      fltFator4 := 1;
      fltFator5 := 1;
      fltFator6 := 1;
      fltFator7 := 1;
    End;



  Finally
    FreeAndNil(objForm);
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.fGravaLogAca(strCodAca: String;
  fltPrecus, fltPreVen, fltPreVno: Double);
Var
  qryGen: TUniQuery;
  strSQL: String;
  intContador: Integer;
begin
  Try
    qryGen := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGACA(       ';
    strSQL := strSQL + '    LOG_DTAALT,             ';
    strSQL := strSQL + '    LOG_HORALT,             ';
    strSQL := strSQL + '    LOG_OPEALT,             ';
    strSQL := strSQL + '    LOG_CODACA,             ';
    strSQL := strSQL + '    LOG_EMPACA,             ';
    strSQL := strSQL + '    LOG_PRECUS,             ';
    strSQL := strSQL + '    LOG_PREVEN,             ';
    strSQL := strSQL + '    LOG_PREVNO,             ';
    strSQL := strSQL + '    LOG_PREVE1,             ';
    strSQL := strSQL + '    LOG_PREVN1,             ';
    strSQL := strSQL + '    LOG_PREVE2,             ';
    strSQL := strSQL + '    LOG_PREVN2,             ';
    strSQL := strSQL + '    LOG_PREVE3,             ';
    strSQL := strSQL + '    LOG_PREVN3,             ';
    strSQL := strSQL + '    LOG_PREVE4,             ';
    strSQL := strSQL + '    LOG_PREVN4,             ';
    strSQL := strSQL + '    LOG_PREVE5,             ';
    strSQL := strSQL + '    LOG_PREVN5,             ';
    strSQL := strSQL + '    LOG_PREVE6,             ';
    strSQL := strSQL + '    LOG_PREVN6,             ';
    strSQL := strSQL + '    LOG_PREVE7,             ';
    strSQL := strSQL + '    LOG_PREVN7              ';
    strSQL := strSQL + '        )                   ';
    strSQL := strSQL + '  VALUES(                   ';
    strSQL := strSQL + '    :DTAALT,                ';
    strSQL := strSQL + '    :HORALT,                ';
    strSQL := strSQL + '    :OPEALT,                ';
    strSQL := strSQL + '    :CODACA,                ';
    strSQL := strSQL + '    :EMPACA,                ';
    strSQL := strSQL + '    :PRECUS,                ';
    strSQL := strSQL + '    :PREVEN,                ';
    strSQL := strSQL + '    :PREVNO,                ';
    strSQL := strSQL + '    :PREVE1,                ';
    strSQL := strSQL + '    :PREVN1,                ';
    strSQL := strSQL + '    :PREVE2,                ';
    strSQL := strSQL + '    :PREVN2,                ';
    strSQL := strSQL + '    :PREVE3,                ';
    strSQL := strSQL + '    :PREVN3,                ';
    strSQL := strSQL + '    :PREVE4,                ';
    strSQL := strSQL + '    :PREVN4,                ';
    strSQL := strSQL + '    :PREVE5,                ';
    strSQL := strSQL + '    :PREVN5,                ';
    strSQL := strSQL + '    :PREVE6,                ';
    strSQL := strSQL + '    :PREVN6,                ';
    strSQL := strSQL + '    :PREVE7,                ';
    strSQL := strSQL + '    :PREVN7                 ';
    strSQL := strSQL + '            );              ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('DTAALT').AsDateTime := VS_Date;
    qryGen.ParamByName('HORALT').AsDateTime := fTime();
    qryGen.ParamByName('OPEALT').AsString := fGetUsuarioLogado;
    qryGen.ParamByName('CODACA').AsString := strCodAca;
    qryGen.ParamByName('EMPACA').AsString := VS_strCodEmp;
    qryGen.ParamByName('PRECUS').AsFloat := fltPrecus;
    qryGen.ParamByName('PREVEN').AsFloat := fltPreVen;
    qryGen.ParamByName('PREVNO').AsFloat := fltPreVno;

    For intContador := 1 To 7 Do
    Begin
      If cdsProAca.FieldByName('PREVE' + IntToStr(intContador)).AsFloat = cdsProAca.FieldByName('PREVN' + IntToStr(intContador)).AsFloat Then
      Begin
        qryGen.ParamByName('PREVE' + IntToStr(intContador)).AsFloat := 0.0;
        qryGen.ParamByName('PREVN' + IntToStr(intContador)).AsFloat := 0.0;
      End
      Else
      Begin
        qryGen.ParamByName('PREVE' + IntToStr(intContador)).AsFloat := cdsProAca.FieldByName('PREVE' + IntToStr(intContador)).AsFloat;
        qryGen.ParamByName('PREVN' + IntToStr(intContador)).AsFloat := cdsProAca.FieldByName('PREVN' + IntToStr(intContador)).AsFloat;
      End;
    End;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.FormCreate(Sender: TObject);
begin
  inherited;
  cdsProAca := TUniClientDataSet.Create(Self);
  dtsProAca := fCriaDataSource(cdsProAca);
  cxGProdAcabDBTableView1.DataController.DataSource := dtsProAca;
  TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Carregando Produtos Acabados.', '');

  If fVerificaTamanhoTela Then
    Self.WindowState := wsMaximized;
end;

procedure TfrmAltGlobalProdutosAcabados.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsProAca);
end;

procedure TfrmAltGlobalProdutosAcabados.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    Key := 0;
    If btnGravar.Enabled Then btnGravar.Click;
  End
  Else If Key = VK_F2 Then
  Begin
    Key := 0;
    If btnFator.Enabled Then btnFator.Click;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.FormShow(Sender: TObject);
Var
  intMarkup: Integer;
begin
  inherited;
  HabilitaTabelasPreco;

  intMarkup := fCfgSis('MARMKP');

  If Pos(IntToStr(intMarkup), '2_3_4_') > 0 Then
  Begin
    cxGProdAcabDBTableView1.Columns[8].Caption := 'Markup Atual';
    cxGProdAcabDBTableView1.Columns[10].Caption := 'Markup Novo';
    cxGProdAcabDBTableView1.Columns[12].Caption := 'Markup 1 Atual';
    cxGProdAcabDBTableView1.Columns[14].Caption := 'Markup 1 Novo';
    cxGProdAcabDBTableView1.Columns[16].Caption := 'Markup 2 Atual';
    cxGProdAcabDBTableView1.Columns[18].Caption := 'Markup 2 Novo';
    cxGProdAcabDBTableView1.Columns[20].Caption := 'Markup 3 Atual';
    cxGProdAcabDBTableView1.Columns[22].Caption := 'Markup 3 Novo';
    cxGProdAcabDBTableView1.Columns[24].Caption := 'Markup 4 Atual';
    cxGProdAcabDBTableView1.Columns[26].Caption := 'Markup 4 Novo';
    cxGProdAcabDBTableView1.Columns[28].Caption := 'Markup 5 Atual';
    cxGProdAcabDBTableView1.Columns[30].Caption := 'Markup 5 Novo';
    cxGProdAcabDBTableView1.Columns[32].Caption := 'Markup 6 Atual';
    cxGProdAcabDBTableView1.Columns[34].Caption := 'Markup 6 Novo';
    cxGProdAcabDBTableView1.Columns[36].Caption := 'Markup 7 Atual';
    cxGProdAcabDBTableView1.Columns[38].Caption := 'Markup 7 Novo';
  End;

  CalculaMargemAtual();
  PreenchePrecosNovos();
  CalculaMargemNova();
  PreencheCampoREG_EDITodos();
  cdsProAca.First;
end;

function TfrmAltGlobalProdutosAcabados.fRetornaValorFatorPrecoVenda1(
  strTabela: String): Double;
begin
  Result := fltfator1;

  If strTabela = '1' Then
    Result := fltFator;
end;

function TfrmAltGlobalProdutosAcabados.fRetornaValorFatorPrecoVenda2(
  strTabela: String): Double;
begin
  Result := fltFator2;

  If strTabela = '2' Then
    Result := fltFator;
end;

function TfrmAltGlobalProdutosAcabados.fRetornaValorFatorPrecoVenda3(
  strTabela: String): Double;
begin
  Result := fltFator3;

  If strTabela = '3' Then
    Result := fltFator;
end;

function TfrmAltGlobalProdutosAcabados.fRetornaValorFatorPrecoVenda4(
  strTabela: String): Double;
begin
  Result := fltFator4;

  If strTabela = '4' Then
    Result := fltFator;
end;

function TfrmAltGlobalProdutosAcabados.fRetornaValorFatorPrecoVenda5(
  strTabela: String): Double;
begin
  Result := fltFator5;

  If strTabela = '5' Then
    Result := fltFator;
end;

function TfrmAltGlobalProdutosAcabados.fRetornaValorFatorPrecoVenda6(
  strTabela: String): Double;
begin
  Result := fltFator6;

  If strTabela = '6' Then
    Result := fltFator;
end;

function TfrmAltGlobalProdutosAcabados.fRetornaValorFatorPrecoVenda7(
  strTabela: String): Double;
begin
  Result := fltFator7;

  If strTabela = '7' Then
    Result := fltFator;
end;

function TfrmAltGlobalProdutosAcabados.fSqlProdutosAcabados: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                        ';

  Result := Result + '    A.ACA_CODACA,               ';
  Result := Result + '    G.ACA_CODACA AS CODACA,     ';
  Result := Result + '    A.ACA_CODEMP,               ';
  Result := Result + '    G.ACA_PREVEN AS PREVEN,     ';
  Result := Result + '    0.0 AS PREVNO,              ';

  For intContador := 1 To 7 Do
    Result := Result + '    G.ACA_PREVE' + IntToStr(intContador) + ' AS PREVE' + IntToStr(intContador) + ',     ';

  Result := Result + '    G.ACA_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ACA_SALDOS AS SALDOS,     ';
  Result := Result + '    G.ACA_PREMED AS PREMED,     ';
  Result := Result + '    G.ACA_PREULT AS PREULT,     ';
  Result := Result + '    G.ACA_IMPULT AS IMPULT,     ';
  Result := Result + '    G.ACA_OUTVAL AS OUTVAL,     ';
  Result := Result + '    G.ACA_ICMSAI AS ICMSAI,     ';
  Result := Result + '    G.ACA_IMPFED AS IMPFED,     ';
  Result := Result + '    G.ACA_DESOPE AS DESOPE,     ';
  Result := Result + '    G.ACA_COMLIQ AS COMLIQ,     ';
  Result := Result + '    A.ACA_DESCRI AS DESCRI,     ';
  Result := Result + '    T.DET_IDEPRO AS IDEPRO,     ';
  Result := Result + '    T.DET_DTAENT AS DTAVEN,     ';
  Result := Result + '    0.00 AS MARGEM_V,           ';
  Result := Result + '    0.00 AS MARGEM_N,            ';
  Result := Result + '    IF(G.ACA_PREVEN < 0, "EDITADO", "N_EDITADO") AS REG_EDI,   ';

  For intContador := 1 To 7 Do
  Begin
    Result := Result + ' 0.00 AS PREVN' + IntToStr(intContador) + ',   ';
    Result := Result + ' 0.00 AS MAATU' + IntToStr(intContador) + ',   ';
    Result := Result + ' 0.00 AS MANOV' + IntToStr(intContador);

    If intContador < 7 Then
      Result := Result + ',   ';
  End;


  Result := Result + '  FROM                          ';
  Result := Result + '    CADACA A                    ';
  Result := Result + '  JOIN ACAGER G ON                   ';
  Result := Result + '    G.ACA_CODACA = A.ACA_CODACA AND         ';
  Result := Result + '    G.ACA_CODEMP = A.ACA_CODEMP             ';
  Result := Result + '  JOIN MOVDET M ON                   ';
  Result := Result + '    M.DET_CODACA = A.ACA_CODACA AND         ';
  Result := Result + '    M.DET_EMPACA = A.ACA_CODEMP             ';
  Result := Result + '  INNER JOIN TINDET T ON             ';
  Result := Result + '    T.DET_NUMDOC = M.DET_NUMDOC AND         ';
  Result := Result + '    T.DET_ESPDOC = M.DET_ESPDOC AND         ';
  Result := Result + '    T.DET_CODEMP = M.DET_CODEMP AND         ';
  Result := Result + '    T.DET_CODACA = M.DET_CODACA AND         ';
  Result := Result + '    T.DET_EMPACA = M.DET_EMPACA AND         ';
  Result := Result + '    T.DET_DESCRI = M.DET_DESCRI             ';
  Result := Result + '  WHERE                         ';
  Result := Result + '    G.ACA_SALDOS > 0 AND                    ';
  Result := Result + '    G.ACA_CODEMP = ' + VS_strCodEmp + ' AND ';
  Result := Result + '    G.ACA_EMPEST = ' + VS_strCodEmp + '     ';
  Result := Result + '  ORDER BY T.DET_DTAENT, T.DET_IDEPRO, A.ACA_DESCRI     ';
end;

function TfrmAltGlobalProdutosAcabados.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Not fVerificaEditados Then
  Begin
    Result := False;
    pMensagemOk('Não é possivel gravar os registros pois nenhum preço foi alterado!');
  End;
end;

function TfrmAltGlobalProdutosAcabados.fVerificaEditados: Boolean;
Var
  cdsGen: TUniClientDataSet;
begin
  Try
    cdsGen := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsGen, cdsProAca);

    Begin
      cdsGen.Filtered := False;
      cdsGen.Filter := 'REG_EDI = ' + QuotedStr('EDITADO');
      cdsGen.Filtered := True;
    End;

    Result := cdsGen.RecordCount > 0;
  Finally
    FreeAndNil(cdsGen);
  End;
end;

function TfrmAltGlobalProdutosAcabados.fVerificaMargem(fltMargem: Double): Boolean;
Var
  intMarkUp: Integer;
  strMensagem: String;
begin
  Result := True;

  intMarkup := fCfgSis('MARMKP');

  If Pos(IntToStr(intMarkup), '2_3_4_') > 0 Then
    strMensagem := 'Existe Markup negativo, deseja realmente continuar?'
  Else
    strMensagem := 'Existe margem negativa, deseja realmente continuar?';

  If fltMargem < 0 Then
  Begin
    If fMensagem('', strMensagem, ['&Sim', '&Não']) = 2 Then
      Result := False;
  End;
end;

function TfrmAltGlobalProdutosAcabados.fVerificaTabelaPreco: String;
begin
  Result := fCfgSis('TABPRC');
end;

function TfrmAltGlobalProdutosAcabados.fVerificaTamanhoTela: Boolean;
begin
 {Se resolução disponível for inferior ou igual à (1366 x 768), maximiza a tela!}
  Result := False;
  If ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) <= 768) Then
  Begin
    Result := True;
    Exit;
  End;

  If (Screen.Width <= 1366) Then
    Result := True
end;

procedure TfrmAltGlobalProdutosAcabados.GravarAcaGer;
Var
  qryAcaGer: TUniQuery;
  strSQL: String;
begin
  Try
    cdsProAca.Filtered := False;
    cdsProAca.Filter := 'REG_EDI = ' + QuotedStr('EDITADO');
    cdsProAca.Filtered := True;

    qryAcaGer := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + ' UPDATE                 ';
    strSQL := strSQL + '    ACAGER              ';
    strSQL := strSQL + ' SET                    ';
    strSQL := strSQL + '    ACA_PREVEN  = :PREVNO,        ';
    strSQL := strSQL + '    ACA_PREVE1  = :PREVE1,        ';
    strSQL := strSQL + '    ACA_PREVE2  = :PREVE2,        ';
    strSQL := strSQL + '    ACA_PREVE3  = :PREVE3,        ';
    strSQL := strSQL + '    ACA_PREVE4  = :PREVE4,        ';
    strSQL := strSQL + '    ACA_PREVE5  = :PREVE5,        ';
    strSQL := strSQL + '    ACA_PREVE6  = :PREVE6,        ';
    strSQL := strSQL + '    ACA_PREVE7  = :PREVE7         ';
    strSQL := strSQL + ' WHERE                  ';
    strSQL := strSQL + '    ACA_CODACA = :CODACA AND      ';
    strSQL := strSQL + '    ACA_CODEMP = :CODEMP AND      ';
    strSQL := strSQL + '    ACA_EMPEST = :EMPEST          ';

    cdsProAca.First;

    While Not cdsProAca.Eof Do
    Begin
      If cdsProAca.FieldByName('REG_EDI').AsString = 'N_EDITADO' Then
      Begin
        cdsProAca.Next;
        Continue;
      End;

      qryAcaGer.Close;
      qryAcaGer.SQL.Clear;
      qryAcaGer.SQL.Add(strSQL);
      qryAcaGer.ParamByName('PREVNO').AsFloat  := cdsProAca.FieldByName('PREVNO').AsFloat;
      qryAcaGer.ParamByName('PREVE1').AsFloat  := cdsProAca.FieldByName('PREVN1').AsFloat;
      qryAcaGer.ParamByName('PREVE2').AsFloat  := cdsProAca.FieldByName('PREVN2').AsFloat;
      qryAcaGer.ParamByName('PREVE3').AsFloat  := cdsProAca.FieldByName('PREVN3').AsFloat;
      qryAcaGer.ParamByName('PREVE4').AsFloat  := cdsProAca.FieldByName('PREVN4').AsFloat;
      qryAcaGer.ParamByName('PREVE5').AsFloat  := cdsProAca.FieldByName('PREVN5').AsFloat;
      qryAcaGer.ParamByName('PREVE6').AsFloat  := cdsProAca.FieldByName('PREVN6').AsFloat;
      qryAcaGer.ParamByName('PREVE7').AsFloat  := cdsProAca.FieldByName('PREVN7').AsFloat;
      qryAcaGer.ParamByName('CODACA').AsString := cdsProAca.FieldByName('CODACA').AsString;
      qryAcaGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAcaGer.ParamByName('EMPEST').AsString := VS_strCodEmp;
      qryAcaGer.ExecSQL;

      fGravaLogAca(cdsProAca.FieldByName('CODACA').AsString,
                   cdsProAca.FieldByName('PRECUS').AsFloat,
                   cdsProAca.FieldByName('PREVEN').AsFloat,
                   cdsProAca.FieldByName('PREVNO').AsFloat);

      cdsProAca.Next;
    End;

    cdsProAca.Filtered := False;
    cdsProAca.First;
  Finally

  End;
end;

procedure TfrmAltGlobalProdutosAcabados.HabilitaTabelasPreco;
Var
  strTabPreco: String;
  intContador: Integer;
  intColuna: Integer;
begin
  intColuna := 11;

  For intContador := 1 To 7 Do
  Begin
    strTabPreco := Copy(fVerificaTabelaPreco, intContador, 1);

    If strTabPreco = 'N' Then
    Begin
      Inc(intColuna, 4);
      Continue;
    End;

    cxGProdAcabDBTableView1.Columns[intColuna].Visible := True;
    Inc(intColuna);
    cxGProdAcabDBTableView1.Columns[intColuna].Visible := True;
    Inc(intColuna);
    cxGProdAcabDBTableView1.Columns[intColuna].Visible := True;
    Inc(intColuna);
    cxGProdAcabDBTableView1.Columns[intColuna].Visible := True;
    Inc(intColuna);
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.pCriaTemporaria;
Var
  qryProAca: TUniQuery;
  dspProAca: TUniDataSetProvider;
begin
  Try
    cdsProAca.Close;
    qryProAca := fCriaQuery(Self);
    dspProAca := TUniDataSetProvider.Create(Self);
    dspProAca.DataSet := qryProAca;
    cdsProAca.SetProvider(dspProAca);

    qryProAca.Close;
    qryProAca.SQL.Clear;
    qryProAca.SQL.Add(fSqlProdutosAcabados);
    qryProAca.Open;
    pSetaClient(qryProAca);

    cdsProAca.Open;
    TFloatField(cdsProAca.FieldByName('PREVEN')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVNO')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MARGEM_V')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MARGEM_N')).DisplayFormat := '#,##0.0000';
    TDateTimeField(cdsProAca.FieldByName('DTAVEN')).EditMask := '99/99/9999';
    TFloatField(cdsProAca.FieldByName('PRECUS')).DisplayFormat := '#,##0.00';
    TFloatField(cdsProAca.FieldByName('SALDOS')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVE1')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVE2')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVE3')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVE4')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVE5')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVE6')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVE7')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVN1')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVN2')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVN3')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVN4')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVN5')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVN6')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('PREVN7')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MAATU1')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MAATU2')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MAATU3')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MAATU4')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MAATU5')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MAATU6')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MAATU7')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MANOV1')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MANOV2')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MANOV3')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MANOV4')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MANOV5')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MANOV6')).DisplayFormat := '#,##0.0000';
    TFloatField(cdsProAca.FieldByName('MANOV7')).DisplayFormat := '#,##0.0000';

    qryProAca.Close;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmAltGlobalProdutosAcabados.pCriaTemporaria]');
  End;

  cdsProAca.SetProvider(Nil);
  FreeAndNil(dspProAca);
  FreeAndNil(qryProAca);
end;

procedure TfrmAltGlobalProdutosAcabados.PreencheCampoREG_EDITodos;
Var
  intContador: Integer;
begin
  cdsProAca.First;
  While Not cdsProAca.Eof Do
  Begin
    cdsProAca.Edit;
    If (cdsProAca.FieldByName('PREVEN').AsFloat <> cdsProAca.FieldByName('PREVNO').AsFloat) Then
      cdsProAca.FieldByName('REG_EDI').AsString := 'EDITADO'
    Else
      cdsProAca.FieldByName('REG_EDI').AsString := 'N_EDITADO';

    For intContador := 1 To 7 Do
    Begin
      If (cdsProAca.FieldByName('PREVE' + IntToStr(intContador)).AsFloat <> cdsProAca.FieldByName('PREVN' + IntToStr(intContador)).AsFloat) Then
      Begin
        cdsProAca.FieldByName('REG_EDI').AsString := 'EDITADO';
        Break;
      End
      Else
        cdsProAca.FieldByName('REG_EDI').AsString := 'N_EDITADO';
    End;
    cdsProAca.Post;
    cdsProAca.Next;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.PreenchePrecosNovos;
Var
  intContador: Integer;
begin
  cdsProAca.First;
  While Not cdsProAca.Eof Do
  Begin
    cdsProAca.Edit;
    cdsProAca.FieldByName('PREVNO').AsFloat := cdsProAca.FieldByName('PREVEN').AsFloat;

    For intContador := 1 To 7 Do
      cdsProAca.FieldByName('PREVN' + IntToStr(intContador)).AsFloat := cdsProAca.FieldByName('PREVE' + IntToStr(intContador)).AsFloat;

    cdsProAca.Post;
    cdsProAca.Next;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.PreenchePrecoVendaPreVenda4a6(fltValor: Double; strTabela: String; strTabAlterado: String);
begin
  If strTabela = '1' Then
  Begin
    If strTabAlterado = '1' Then
    Begin
      cdsProAca.Fields[4].AsFloat  := fltValor;
      cdsProAca.Fields[26].AsFloat := fCalculaPrecoVenda(2,
                                                         cdsProAca.Fields[12].AsFloat,
                                                         fltValor,
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0);
    End;
  End
  Else If strTabela = '2' Then
  Begin
    If strTabAlterado = '2' Then
    Begin
      cdsProAca.Fields[4].AsFloat  := fltValor;
      cdsProAca.Fields[26].AsFloat := fCalculaPrecoVenda(2,
                                                         cdsProAca.Fields[12].AsFloat,
                                                         fltValor,
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0);
    End;
  End
  Else If strTabela = '3' Then
  Begin
    If strTabAlterado = '3' Then
    Begin
      cdsProAca.Fields[4].AsFloat  := fltValor;
      cdsProAca.Fields[26].AsFloat := fCalculaPrecoVenda(2,
                                                         cdsProAca.Fields[12].AsFloat,
                                                         fltValor,
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0);
    End;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.PreenchePrecoVendaPreVenda(fltValor: Double; strTabela, strTabAlterado: String);
begin
  PreenchePrecoVendaPreVenda1a3(fltValor, strTabela, strTabAlterado);
  PreenchePrecoVendaPreVenda4a6(fltValor, strTabela, strTabAlterado);

  If strTabela = '7' Then
  Begin
    If strTabAlterado = '7' Then
    Begin
      cdsProAca.Fields[4].AsFloat  := fltValor;
      cdsProAca.Fields[26].AsFloat := fCalculaPrecoVenda(2,
                                                         cdsProAca.Fields[12].AsFloat,
                                                         fltValor,
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0);
    End;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.PreenchePrecoVendaPreVenda1a3(fltValor: Double; strTabela: String; strTabAlterado: String);
begin
  If strTabela = '4' Then
  Begin
    If strTabAlterado = '4' Then
    Begin
      cdsProAca.Fields[4].AsFloat  := fltValor;
      cdsProAca.Fields[26].AsFloat := fCalculaPrecoVenda(2,
                                                         cdsProAca.Fields[12].AsFloat,
                                                         fltValor,
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0);
    End;
  End
  Else If strTabela = '5' Then
  Begin
    If strTabAlterado = '5' Then
    Begin
      cdsProAca.Fields[4].AsFloat  := fltValor;
      cdsProAca.Fields[26].AsFloat := fCalculaPrecoVenda(2,
                                                         cdsProAca.Fields[12].AsFloat,
                                                         fltValor,
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0);
    End;
  End
  Else If strTabela = '6' Then
  Begin
    If strTabAlterado = '6' Then
    Begin
      cdsProAca.Fields[4].AsFloat  := fltValor;
      cdsProAca.Fields[26].AsFloat := fCalculaPrecoVenda(2,
                                                         cdsProAca.Fields[12].AsFloat,
                                                         fltValor,
                                                         0,
                                                         0,
                                                         0,
                                                         0,
                                                         0);
    End;
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.PreenchePrecoVendaTab(fltValor: Double;
  strTabela: String);
begin
  If strTabela <> '7' Then
    PreenchePrecoVendaTabProdutos(fltValor, strTabela)
  Else
  Begin
    cdsProAca.Fields[46].AsFloat  := fltValor;
    cdsProAca.Fields[48].AsFloat  := fCalculaPrecoVenda(2,
                                                        cdsProAca.Fields[12].AsFloat,
                                                        fltValor,
                                                        0,
                                                        0,
                                                        0,
                                                        0,
                                                        0);
  End;
end;

procedure TfrmAltGlobalProdutosAcabados.PreenchePrecoVendaTabProdutos(fltValor: Double; strTabela: String);
begin
  If strTabela = '1' Then
  Begin
    cdsProAca.Fields[28].AsFloat  := fltValor;
    cdsProAca.Fields[30].AsFloat := fCalculaPrecoVenda(2,
                                                          cdsProAca.Fields[12].AsFloat,
                                                          fltValor,
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                          0);
  End
  Else If strTabela = '2' Then
  Begin
    cdsProAca.Fields[31].AsFloat  := fltValor;
    cdsProAca.Fields[33].AsFloat := fCalculaPrecoVenda(2,
                                                       cdsProAca.Fields[12].AsFloat,
                                                       fltValor,
                                                       0,
                                                       0,
                                                       0,
                                                       0,
                                                       0);
  End
  Else If strTabela = '3' Then
  Begin
    cdsProAca.Fields[34].AsFloat  := fltValor;
    cdsProAca.Fields[36].AsFloat := fCalculaPrecoVenda(2,
                                                       cdsProAca.Fields[12].AsFloat,
                                                       fltValor,
                                                       0,
                                                       0,
                                                       0,
                                                       0,
                                                       0);
  End
  Else If strTabela = '4' Then
  Begin
    cdsProAca.Fields[37].AsFloat  := fltValor;
    cdsProAca.Fields[39].AsFloat := fCalculaPrecoVenda(2,
                                                       cdsProAca.Fields[12].AsFloat,
                                                       fltValor,
                                                       0,
                                                       0,
                                                       0,
                                                       0,
                                                       0);
  End
  Else If strTabela = '5' Then
  Begin
    cdsProAca.Fields[40].AsFloat  := fltValor;
    cdsProAca.Fields[42].AsFloat := fCalculaPrecoVenda(2,
                                                       cdsProAca.Fields[12].AsFloat,
                                                       fltValor,
                                                       0,
                                                       0,
                                                       0,
                                                       0,
                                                       0);
  End
  Else If strTabela = '6' Then
  Begin
    cdsProAca.Fields[43].AsFloat  := fltValor;
    cdsProAca.Fields[45].AsFloat := fCalculaPrecoVenda(2,
                                                       cdsProAca.Fields[12].AsFloat,
                                                       fltValor,
                                                       0,
                                                       0,
                                                       0,
                                                       0,
                                                       0);
  End;
end;

function TfrmAltGlobalProdutosAcabados.RetornarMensagemMargemMarkupNegativo: string;
var
  intMarkUp: Integer;
begin
  intMarkup := fCfgSis('MARMKP');

  If Pos(IntToStr(intMarkup), '2_3_4_') > 0 Then
  Begin
    Result := 'Existe produtos com markups negativos, deseja realmente continuar?';
    Exit;
  end;

  Result := 'Existe produtos com margens negativas, deseja realmente continuar?';
end;

function TfrmAltGlobalProdutosAcabados.RecalcularPrecoVenda(fltFator: Double; fltFator1: Double; fltFator2: Double; fltFator3: Double;
      fltFator4: Double; fltFator5: Double; fltFator6: Double; fltFator7: Double): Boolean;
Var
  fltMargem: Double;
  blnSim: Boolean;
  strMensagem: String;
begin
  blnSim := True;
  Result := False;

  strMensagem := RetornarMensagemMargemMarkupNegativo;

  {*********************************************************}
  {** ANTES DE GRAVAR OS PREÇOS VERIFICA SE EXISTE MARGEM **}
  {** /MARKUP COM PREÇOS NEGATIVOS, CASO EXISTE APAR. MSG **}
  {******************************************************RG*}
  cdsProAca.First;
  While Not cdsProAca.Eof Do
  Begin
    fltMargem := VerificaMargemNegativa(fltFator, fltFator1, fltFator2, fltFator3, fltFator4, fltFator5, fltFator6, fltFator7);

    If fltMargem < 0 Then
    Begin
      If fMensagem('', strMensagem, ['&Sim', '&Não']) = 2 Then
        blnSim := False;
      Break;
    End;

    cdsProAca.Next;
  End;




  If blnSim Then
  Begin
    cdsProAca.First;
    While Not cdsProAca.Eof Do
    Begin
      cdsProAca.Edit;
      cdsProAca.FieldByName('PREVNO').AsFloat := cdsProAca.FieldByName('PREVEN').AsFloat * fltFator;
      cdsProAca.FieldByName('PREVN1').AsFloat := cdsProAca.FieldByName('PREVE1').AsFloat * fltFator1;
      cdsProAca.FieldByName('PREVN2').AsFloat := cdsProAca.FieldByName('PREVE2').AsFloat * fltFator2;
      cdsProAca.FieldByName('PREVN3').AsFloat := cdsProAca.FieldByName('PREVE3').AsFloat * fltFator3;
      cdsProAca.FieldByName('PREVN4').AsFloat := cdsProAca.FieldByName('PREVE4').AsFloat * fltFator4;
      cdsProAca.FieldByName('PREVN5').AsFloat := cdsProAca.FieldByName('PREVE5').AsFloat * fltFator5;
      cdsProAca.FieldByName('PREVN6').AsFloat := cdsProAca.FieldByName('PREVE6').AsFloat * fltFator6;
      cdsProAca.FieldByName('PREVN7').AsFloat := cdsProAca.FieldByName('PREVE7').AsFloat * fltFator7;
      cdsProAca.Post;
      cdsProAca.Next;
    End;
    CalculaMargemNova();
    Result := True;
  End;
end;

function TfrmAltGlobalProdutosAcabados.VerificaFator(intContador: Integer; fltFator1, fltFator2,
  fltFator3, fltFator4, fltFator5, fltFator6: Double): Double;
begin
  Result := 0;

  If intContador = 1 Then
    Result := cdsProAca.FieldByName('PREVE1').AsFloat * fltFator1
  Else If intContador = 2 Then
    Result := cdsProAca.FieldByName('PREVE2').AsFloat * fltFator2
  Else If intContador = 3 Then
    Result := cdsProAca.FieldByName('PREVE3').AsFloat * fltFator3
  Else If intContador = 4 Then
    Result := cdsProAca.FieldByName('PREVE4').AsFloat * fltFator4
  Else If intContador = 5 Then
    Result := cdsProAca.FieldByName('PREVE5').AsFloat * fltFator5
  Else If intContador = 6 Then
    Result := cdsProAca.FieldByName('PREVE6').AsFloat * fltFator6;
end;

function TfrmAltGlobalProdutosAcabados.VerificaMargemNegativa(fltFator, fltFator1, fltFator2, fltFator3, fltFator4, fltFator5, fltFator6,
  fltFator7: Double): Double;
Var
  intContador: Integer;
  fltPreVen: Double;
begin
  For intContador := 0 To 7 Do
  Begin

    If intContador = 0 Then
      fltPreVen := cdsProAca.FieldByName('PREVEN').AsFloat * fltFator
    Else If intContador <= 6 Then
      fltPreVen := VerificaFator(intContador, fltFator1, fltFator2, fltFator3, fltFator4, fltFator5, fltFator6)
    Else
      fltPreVen := cdsProAca.FieldByName('PREVE7').AsFloat * fltFator7;


    Result := fCalculaPrecoVenda(2,
                                 cdsProAca.FieldByName('PRECUS').AsFloat,
                                 fltPreVen,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0);

    If Result < 0 Then
      Break;
  End;
end;

end.
