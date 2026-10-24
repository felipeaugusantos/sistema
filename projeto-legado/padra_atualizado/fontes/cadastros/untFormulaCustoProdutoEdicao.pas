unit untFormulaCustoProdutoEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untFormulaCustoProduto, untFuncoesSimples,
  cxTextEdit, cxCurrencyEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.ComCtrls;

type
  TfrmFormulaCustoProdutoEdicao = class(TfrmPaiConfirma)
    cxgItensLevel1: TcxGridLevel;
    cxvItens: TcxGridDBTableViewCitel;
    cxgItens: TcxGridCitel;
    cxvItensCODCAM: TcxGridDBColumn;
    cxvItensDESCAM: TcxGridDBColumn;
    cxvItensOPERAD: TcxGridDBColumn;
    cxvItensBASCAL: TcxGridDBColumn;
    cxvItensPOSCAM: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxvItensVALCAD: TcxGridDBColumn;
    cxvItensVALCAL: TcxGridDBColumn;
    cxvItensEXPUSU: TcxGridDBColumn;
    pgcPreven: TPageControl;
    tbsPreven1: TTabSheet;
    tbsPreven2: TTabSheet;
    tbsPreven3: TTabSheet;
    tbsPreven4: TTabSheet;
    tbsPreven5: TTabSheet;
    tbsPreven6: TTabSheet;
    tbsPreven7: TTabSheet;
    lblPreve1: TLabel;
    lblPreve2: TLabel;
    lblPreve3: TLabel;
    lblPreve4: TLabel;
    lblPreve5: TLabel;
    lblPreve6: TLabel;
    lblPreve7: TLabel;
    lblDesIte: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cxvItensBASCALCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensCODCAMCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvItensVALCADGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxvItensVALCALGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
   procedure tbsPreven2Show(Sender: TObject);
    procedure tbsPreven3Show(Sender: TObject);
    procedure tbsPreven4Show(Sender: TObject);
    procedure tbsPreven5Show(Sender: TObject);
    procedure tbsPreven6Show(Sender: TObject);
    procedure tbsPreven7Show(Sender: TObject);
    procedure tbsPreven1Show(Sender: TObject);
    procedure FormCreate(Sender: TObject);


  private
    { Private declarations }
    blnDesmonstrativo: Boolean;
    procedure pSetFilter(strTabela: String);

  public
    { Public declarations }
    blnDemo: Boolean;

    objFormula: TFormulaCustoProduto;
  end;

var
  frmFormulaCustoProdutoEdicao: TfrmFormulaCustoProdutoEdicao;

implementation

{$R *.dfm}

Uses
  StrUtils;

procedure TfrmFormulaCustoProdutoEdicao.cxvItensBASCALCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strCampo: String;
begin
  inherited;

  strCampo := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensCODCAM.Index]);

  If (Not AViewInfo.Selected) Then
  Begin

    If Pos(strCampo, 'VALFRE_DESF01_DESF02_DESF03_DESF04_DESF05_DESF06_') > 0 Then
      ACanvas.Brush.Color := clInfoBk

    Else If (LeftStr(strCampo, 5) <> 'PREVE') And (LeftStr(strCampo, 5) <> 'PREIM') And
            (Pos(strCampo, 'PRECOM_COMLIQ_PRECUS_CUSREA') = 0) Then
    Begin

      If (objFormula.intNumeroFormula = 4) And (Not blnDesmonstrativo) Then
        ACanvas.Brush.Color := $00EBEBEB
      Else
        ACanvas.Brush.Color := clInfoBk;

    End Else
    Begin
      ACanvas.Brush.Color := clMoneyGreen;
    End;

    ACanvas.Font.Color  := clBlack;

    If Pos(strCampo, 'ICMENT_SUBFED_IPIENT_FREENT_ACRFIN_SUBSTI_DESADB') = 0 Then
    Begin

      If AViewInfo.Selected And (Not blnDesmonstrativo)  Then
        ACanvas.Font.Color := clBlack;

    End Else
    Begin

      If AViewInfo.Selected And (Not blnDesmonstrativo)  Then
        ACanvas.Font.Color := clBlue;

    End;

  End;

end;

procedure TfrmFormulaCustoProdutoEdicao.cxvItensCODCAMCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strCampo: String;
begin
  inherited;

  strCampo := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensCODCAM.Index]);

  If (Not AViewInfo.Selected) Then
  Begin

    If (LeftStr(strCampo, 5) = 'PREVE') Or (LeftStr(strCampo, 5) = 'PREIM') Or
       (Pos(strCampo, 'PRECOM_COMLIQ_PRECUS_CUSREA') > 0) Then
    Begin

      ACanvas.Brush.Color := clMoneyGreen;

    End

    Else Begin
      ACanvas.Brush.Color := clInfoBk;
    End;

    ACanvas.Font.Color  := clBlack;

    If Pos(strCampo, 'ICMENT_SUBFED_IPIENT_FREENT_ACRFIN_SUBSTI_DESADB') = 0 Then
    Begin

      If AViewInfo.Selected And (Not blnDesmonstrativo) Then
        ACanvas.Font.Color := clBlack;

    End Else
    Begin

      If AViewInfo.Selected And (Not blnDesmonstrativo) Then
        ACanvas.Font.Color := clBlue;

    End;

  End;

end;

procedure TfrmFormulaCustoProdutoEdicao.cxvItensVALCADGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  Var
    strCampo: String;
begin
  inherited;

  strCampo := VarToStr(Sender.DataBinding.DataController.Values[ARecord.RecordIndex, cxvItensCODCAM.Index]);

  If (LeftStr(strCampo, 5) = 'SUBTO') Then
    AText := ''
  Else IF (LeftStr(strCampo, 5) = 'CUSVE') Then
    AText := ''
  // REFTRI: o Preco de Venda c/ Impostos nao tem aliquota.
  Else If (LeftStr(strCampo, 5) = 'PREIM') Then
    AText := ''
  Else If (LeftStr(strCampo, 5) <> 'PREVE') And
          (Pos(strCampo, 'PRECOM_COMLIQ_VALFRE_PRECUS_OUTVAL_CUSREA_') = 0) Then
        AText := FormatFloat('#0.00', fStrToFloat(AText)) + '%';
end;

procedure TfrmFormulaCustoProdutoEdicao.cxvItensVALCALGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If Pos(VarToStr(Sender.DataBinding.DataController.Values[ARecord.RecordIndex,
                   cxvItensCODCAM.Index]), 'OUTVAL_ICMSAI_IMPFED_DESOPE_') > 0 Then
    AText := ''
  Else
    AText := VarToStr(Sender.DataBinding.DataController.Values[ARecord.RecordIndex,
                       cxvItensOPERAD.Index]) + AText;
end;

procedure TfrmFormulaCustoProdutoEdicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (Not blnDesmonstrativo) Then
    Action := canone;
end;

procedure TfrmFormulaCustoProdutoEdicao.FormCreate(Sender: TObject);
begin
  inherited;
  blnDemo := False;
end;

procedure TfrmFormulaCustoProdutoEdicao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_RETURN: If objFormula.State In dsEditModes Then
               Begin
                 objFormula.Post;
                 cxvItens.NavigatorButtons.Next.Click;
               End;

    VK_ESCAPE: Begin

                 If objFormula.State In dsEditModes Then
                  objFormula.Cancel;

                 Key := 0;

               End;

    Else inherited;
  End;

end;

procedure TfrmFormulaCustoProdutoEdicao.FormShow(Sender: TObject);
var i: integer;
begin
  inherited;

  cxvItens.DataController.DataSource := objFormula.dtsSource;

  cxvItens.NavigatorButtons.First.Click;

  cxvItensBASCAL.Focused := True;

  blnDesmonstrativo := cxvItensEXPUSU.Visible;

  pgcPreven.Visible := False;
  If blnDemo then
  Begin
    lblDesIte.Visible := True;
    pgcPreven.Align := alClient;
    lblDesIte.Caption := objFormula.FieldByName('DESITE').AsString;

    pgcPreven.Visible := True;
    For i := 1 to 7 do
    begin
      case i of
        1: tbsPreven1.TabVisible := VS_strTabPrc[i] = 'S';
        2: tbsPreven2.TabVisible := VS_strTabPrc[i] = 'S';
        3: tbsPreven3.TabVisible := VS_strTabPrc[i] = 'S';
        4: tbsPreven4.TabVisible := VS_strTabPrc[i] = 'S';
        5: tbsPreven5.TabVisible := VS_strTabPrc[i] = 'S';
        6: tbsPreven6.TabVisible := VS_strTabPrc[i] = 'S';
        7: tbsPreven7.TabVisible := VS_strTabPrc[i] = 'S';
      End;
    End;

    case fRetPrimeiraTabPrecoAtiva of
      1: pgcPreven.ActivePage := tbsPreven1;
      2: pgcPreven.ActivePage := tbsPreven2;
      3: pgcPreven.ActivePage := tbsPreven3;
      4: pgcPreven.ActivePage := tbsPreven4;
      5: pgcPreven.ActivePage := tbsPreven5;
      6: pgcPreven.ActivePage := tbsPreven6;
      7: pgcPreven.ActivePage := tbsPreven7;
    End;

  End;
end;

procedure TfrmFormulaCustoProdutoEdicao.pSetFilter(strTabela: String);
begin
  If not blnDemo Then
    Exit;
  objFormula.Filtered := False;
  objFormula.Filter := 'TABELA = ' + QuotedStr(strTabela);
  objFormula.Filtered := True;
end;

procedure TfrmFormulaCustoProdutoEdicao.tbsPreven2Show(Sender: TObject);
begin
  inherited;
  If not blnDemo Then
    Exit;
  cxgItens.Parent := tbsPreven2;
  pSetFilter('2');
  lblPreve2.Caption := objFormula.FieldByName('TABFOR').AsString;
end;

procedure TfrmFormulaCustoProdutoEdicao.tbsPreven3Show(Sender: TObject);
begin
  inherited;
  If not blnDemo Then
    Exit;
  cxgItens.Parent := tbsPreven3;
  pSetFilter('3');
  lblPreve3.Caption := objFormula.FieldByName('TABFOR').AsString;
end;

procedure TfrmFormulaCustoProdutoEdicao.tbsPreven4Show(Sender: TObject);
begin
  inherited;
  If not blnDemo Then
    Exit;
  cxgItens.Parent := tbsPreven4;
  pSetFilter('4');
  lblPreve4.Caption := objFormula.FieldByName('TABFOR').AsString;
end;

procedure TfrmFormulaCustoProdutoEdicao.tbsPreven5Show(Sender: TObject);
begin
  inherited;
  If not blnDemo Then
    Exit;
  cxgItens.Parent := tbsPreven5;
  pSetFilter('5');
  lblPreve5.Caption := objFormula.FieldByName('TABFOR').AsString;
end;

procedure TfrmFormulaCustoProdutoEdicao.tbsPreven6Show(Sender: TObject);
begin
  inherited;
  If not blnDemo Then
    Exit;
  cxgItens.Parent := tbsPreven6;
  pSetFilter('6');
  lblPreve6.Caption := objFormula.FieldByName('TABFOR').AsString;
end;

procedure TfrmFormulaCustoProdutoEdicao.tbsPreven7Show(Sender: TObject);
begin
  inherited;
  If not blnDemo Then
    Exit;
  cxgItens.Parent := tbsPreven7;
  pSetFilter('7');
  lblPreve7.Caption := objFormula.FieldByName('TABFOR').AsString;
end;

procedure TfrmFormulaCustoProdutoEdicao.tbsPreven1Show(Sender: TObject);
begin
  inherited;
  If not blnDemo Then
    Exit;
  cxgItens.Parent := tbsPreven1;
  pSetFilter('1');
  lblPreve1.Caption := objFormula.FieldByName('TABFOR').AsString;
end;

end.
