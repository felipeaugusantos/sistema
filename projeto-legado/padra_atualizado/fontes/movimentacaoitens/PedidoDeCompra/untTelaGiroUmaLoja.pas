unit untTelaGiroUmaLoja;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxEdit, cxVGrid, cxDBVGrid, cxInplaceContainer,
  untCdsDigMultLoja, untFuncoesPedidoSimples, Data.DB,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxClasses, cxGridCustomView,
  cxGrid, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmTelaGiroUmaLoja = class(TForm)
    dtsItens: TDataSource;
    cxsGrid: TcxStyleRepository;
    cxsColFix: TcxStyle;
    cxsMes1: TcxStyle;
    cxsMes2: TcxStyle;
    cxsMes3: TcxStyle;
    cxsMes4: TcxStyle;
    cxsMes5: TcxStyle;
    cxsMes6: TcxStyle;
    cxsMes7: TcxStyle;
    cxsMes8: TcxStyle;
    cxsMes9: TcxStyle;
    cxsMes10: TcxStyle;
    cxsMes11: TcxStyle;
    cxsMes12: TcxStyle;
    cxsVenMes: TcxStyle;
    cxStyle1: TcxStyle;
    Panel3: TPanel;
    shpMesMed: TShape;
    lblMesMed: TLabel;
    pnlRodapeItem: TPanel;
    cxvGridGiro1: TcxDBVerticalGrid;
    cxcMesGir1: TcxCategoryRow;
    cxgItensVENMES: TcxDBEditorRow;
    cxgItensQ_V_01: TcxDBEditorRow;
    cxgItensQ_V_02: TcxDBEditorRow;
    cxgItensQ_V_03: TcxDBEditorRow;
    cxgItensQ_V_04: TcxDBEditorRow;
    cxgItensQ_V_05: TcxDBEditorRow;
    cxgItensQ_V_06: TcxDBEditorRow;
    cxvGridGiro2: TcxDBVerticalGrid;
    cxcMesGir2: TcxCategoryRow;
    cxvGridGiro2CategoryRow1: TcxCategoryRow;
    cxgItensQ_V_07: TcxDBEditorRow;
    cxgItensQ_V_08: TcxDBEditorRow;
    cxgItensQ_V_09: TcxDBEditorRow;
    cxgItensQ_V_10: TcxDBEditorRow;
    cxgItensQ_V_11: TcxDBEditorRow;
    cxgItensQ_V_12: TcxDBEditorRow;
    cxDBVerticalGrid1: TcxDBVerticalGrid;
    cxcSugest: TcxCategoryRow;
    cxgItensMEDIA_: TcxDBEditorRow;
    cxgItensMEDIXX: TcxDBEditorRow;
    cxgItensSUGEST: TcxDBEditorRow;
    cxDBEditorRow5: TcxDBEditorRow;
    cxDBEditorRow6: TcxDBEditorRow;
    cxDBEditorRow7: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow1: TcxDBEditorRow;
    cxgItens2NVLGIR: TcxDBEditorRow;
    cxDBVerticalGrid4: TcxDBVerticalGrid;
    cxcSaldos: TcxCategoryRow;
    cxDBEditorRow8: TcxDBEditorRow;
    cxDBEditorRow9: TcxDBEditorRow;
    cxDBEditorRow10: TcxDBEditorRow;
    cxDBEditorRow11: TcxDBEditorRow;
    cxDBEditorRow12: TcxDBEditorRow;
    cxgItensDIAEST: TcxDBEditorRow;
    cxgItensDIASUG: TcxDBEditorRow;
    Panel1: TPanel;
    cxDBVerticalGrid2: TcxDBVerticalGrid;
    cxDBEditorRow17: TcxDBEditorRow;
    Panel2: TPanel;
    cxvUltimaVenda: TcxDBVerticalGrid;
    cxDBEditorRow27: TcxDBEditorRow;
    cxDBEditorRow23: TcxDBEditorRow;
    cxgItensMADTSA: TcxDBEditorRow;
    cxgItensMAQTSA: TcxDBEditorRow;
    cxgItens2LOCFIS: TcxDBEditorRow;
    cxgItens2CODBAR: TcxDBEditorRow;
    cxDBVerticalGrid6: TcxDBVerticalGrid;
    cxDBEditorRow18: TcxDBEditorRow;
    cxDBVerticalGrid6DBEditorRow1: TcxDBEditorRow;
    cxDBEditorRow4: TcxDBEditorRow;
    cxDBEditorRow2: TcxDBEditorRow;
    pnlOutrasTop: TPanel;
    cxDBVerticalGrid7: TcxDBVerticalGrid;
    cxcOutras2: TcxCategoryRow;
    cxgItensCODBAR: TcxDBEditorRow;
    cxDBVerticalGrid8: TcxDBVerticalGrid;
    cxcOutras1: TcxCategoryRow;
    cxgItensNVLGIR: TcxDBEditorRow;
    cxgItensLOCFIS: TcxDBEditorRow;
    cxDBVerticalGrid4DBEditorRow1: TcxDBEditorRow;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pDestacaMes(intMes: Integer; cxsMes: TcxStyle);
    Procedure pAtualizaCaptions;
  public
    { Public declarations }
    cdsDigMultLoja: TCdsDigMultLoja;
  end;

var
  frmTelaGiroUmaLoja: TfrmTelaGiroUmaLoja;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmTelaGiroUmaLoja.FormShow(Sender: TObject);
begin
  dtsItens.DataSet := cdsDigMultLoja.cdsItens;

  pAtualizaCaptions;

  pDestacaMes(1, cxsMes1);
  pDestacaMes(2, cxsMes2);
  pDestacaMes(3, cxsMes3);
  pDestacaMes(4, cxsMes4);
  pDestacaMes(5, cxsMes5);
  pDestacaMes(6, cxsMes6);
  pDestacaMes(7, cxsMes7);
  pDestacaMes(8, cxsMes8);
  pDestacaMes(9, cxsMes9);
  pDestacaMes(10, cxsMes10);
  pDestacaMes(11, cxsMes11);
  pDestacaMes(12, cxsMes12);

  If Assigned(cdsDigMultLoja) And cdsDigMultLoja.recOpcGir.blnConsMesAtu And
     cdsDigMultLoja.blnComGir Then
    pDestacaMes(0, cxsVenMes);
end;

procedure TfrmTelaGiroUmaLoja.pDestacaMes(intMes: Integer; cxsMes: TcxStyle);
Begin
  If Assigned(cdsDigMultLoja) And (intMes <= cdsDigMultLoja.recOpcGir.intMesGir) And
     cdsDigMultLoja.blnComGir Then
    cxsMes.TextColor := clRed;
End;

Procedure TfrmTelaGiroUmaLoja.pAtualizaCaptions;
  Var
    stlMeses: TStringList;
begin
  If Assigned(cdsDigMultLoja) Then
  With cdsDigMultLoja, cdsItens, recOpcGir Do
  Begin
    stlMeses := TStringList.Create;
    stlMeses.Text := strMeses;

    If intMesMos < 6 Then
    Begin
      cxgItensQ_V_04.Visible := False;
      cxgItensQ_V_05.Visible := False;
      cxgItensQ_V_06.Visible := False;
    End;

    If intMesMos < 12 Then
    Begin
      cxgItensQ_V_07.Visible := False;
      cxgItensQ_V_08.Visible := False;
      cxgItensQ_V_09.Visible := False;
      cxgItensQ_V_10.Visible := False;
      cxgItensQ_V_11.Visible := False;
      cxgItensQ_V_12.Visible := False;
    End;

    If (intMesMos > 6) And (stlMeses.Count > 6) Then
    Begin
      cxgItensQ_V_12.Properties.Caption := stlMeses[11];
      cxgItensQ_V_11.Properties.Caption := stlMeses[10];
      cxgItensQ_V_10.Properties.Caption := stlMeses[09];
      cxgItensQ_V_09.Properties.Caption := stlMeses[08];
      cxgItensQ_V_08.Properties.Caption := stlMeses[07];
      cxgItensQ_V_07.Properties.Caption := stlMeses[06];
    End;

    If (intMesMos > 3) And (stlMeses.Count > 3) Then
    Begin
      cxgItensQ_V_06.Properties.Caption := stlMeses[05];
      cxgItensQ_V_05.Properties.Caption := stlMeses[04];
      cxgItensQ_V_04.Properties.Caption := stlMeses[03];
    End;

    If (intMesMos > 3) And (stlMeses.Count > 1) Then
    Begin
      cxgItensQ_V_03.Properties.Caption := stlMeses[02];
      cxgItensQ_V_02.Properties.Caption := stlMeses[01];
      cxgItensQ_V_01.Properties.Caption := stlMeses[00];
    End;

    FreeAndNil(stlMeses);

    If Not blnUsaNvGir Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(intDiaComGer);
    End

    Else If FieldByName('ITE_NVLGIR').AsString = 'A' Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(intDiaComNvA)
    End

    Else If FieldByName('ITE_NVLGIR').AsString = 'B' Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(intDiaComNvB)
    End

    Else If FieldByName('ITE_NVLGIR').AsString = 'C' Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(intDiaComNvC);
    End;

  End;
end;

end.
