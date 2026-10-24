unit untTelaGiroUmaPasta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit, cxInplaceContainer, cxVGrid,
  cxCurrencyEdit, untCdsDigMultLoja, cxClasses, Data.DB,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.Buttons,
  cxTextEdit;

type
  TfrmTelaGiroUmaPasta = class(TForm)
    pnlLegenda: TPanel;
    Shape1: TShape;
    Label1: TLabel;
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
    pnlDados: TPanel;
    cxvGridGiro1: TcxVerticalGrid;
    cxcMesGir1: TcxCategoryRow;
    cxgItensVENMES: TcxEditorRow;
    cxgItensQ_V_01: TcxEditorRow;
    cxgItensQ_V_02: TcxEditorRow;
    cxgItensQ_V_03: TcxEditorRow;
    cxgItensQ_V_04: TcxEditorRow;
    cxgItensQ_V_05: TcxEditorRow;
    cxgItensQ_V_06: TcxEditorRow;
    cxvGridGiro2: TcxVerticalGrid;
    cxcMesGir2: TcxCategoryRow;
    cxgItensBranco: TcxEditorRow;
    cxgItensQ_V_07: TcxEditorRow;
    cxgItensQ_V_08: TcxEditorRow;
    cxgItensQ_V_09: TcxEditorRow;
    cxgItensQ_V_10: TcxEditorRow;
    cxgItensQ_V_11: TcxEditorRow;
    cxgItensQ_V_12: TcxEditorRow;
    cxvSugest: TcxVerticalGrid;
    cxcSugest: TcxCategoryRow;
    cxgItensMEDIA_: TcxEditorRow;
    cxgItensMEDIXX: TcxEditorRow;
    cxgItensMEDAJU: TcxEditorRow;
    cxgItensSUGEST: TcxEditorRow;
    cxgItensESTMAX: TcxEditorRow;
    cxgItensESTMIN: TcxEditorRow;
    cxgItensMLTCOM: TcxEditorRow;
    cxgItensPESOIT: TcxEditorRow;
    cxvSaldos: TcxVerticalGrid;
    cxcSaldos: TcxCategoryRow;
    cxgItensSALTRA: TcxEditorRow;
    cxgItensSALDIS: TcxEditorRow;
    cxgItensSALEXT: TcxEditorRow;
    cxgItensSALGAR: TcxEditorRow;
    cxgItensSALRES: TcxEditorRow;
    cxgItensQTDPEN: TcxEditorRow;
    cxgItensFUTPRE: TcxEditorRow;
    Panel2: TPanel;
    pnlOutrasTop: TPanel;
    cxVerticalGrid2: TcxVerticalGrid;
    cxcOutras2: TcxCategoryRow;
    cxgItensCODBAR: TcxEditorRow;
    cxVerticalGrid4: TcxVerticalGrid;
    cxcOutras1: TcxCategoryRow;
    cxgItensNVLGIR: TcxEditorRow;
    cxgItensLOCFIS: TcxEditorRow;
    Panel3: TPanel;
    cxVerticalGrid5: TcxVerticalGrid;
    cxgitensNOMFOR: TcxEditorRow;
    cxVerticalGrid8: TcxVerticalGrid;
    cxgItennDIAUCO: TcxEditorRow;
    cxgItensDTAULT: TcxEditorRow;
    cxgItensPREULT: TcxEditorRow;
    cxgItensQTDUCO: TcxEditorRow;
    cxvUltimaVenda: TcxVerticalGrid;
    cxgItensDIAUVE: TcxEditorRow;
    cxgItensDTAUVE: TcxEditorRow;
    cxgItensMADTSA: TcxEditorRow;
    cxgItensMAQTSA: TcxEditorRow;
    cxgItensPONPED: TcxEditorRow;
    cxgItensSALEND: TcxEditorRow;
    cxgItensDIAEST: TcxEditorRow;
    cxgItensDIASUG: TcxEditorRow;
    cxgItensFUTFAL: TcxEditorRow;
    cxgItensFUTAGU: TcxEditorRow;
    cxgItensORDPRO: TcxEditorRow;
    cxsBold: TcxStyle;
    cxgItensSALBAS: TcxEditorRow;
    Panel1: TPanel;
    lblSalbas: TLabel;
    cxgItensPMED_V: TcxEditorRow;
    cxgItensQESTPP: TcxEditorRow;
    procedure FormShow(Sender: TObject);
    procedure cxgItensNVLGIR2PropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
    procedure FormCreate(Sender: TObject);
    procedure lblSalbasClick(Sender: TObject);
    procedure cxgItensDIASUGPropertiesGetDisplayText(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
    procedure cxgItensDIAESTPropertiesGetDisplayText(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
  private
    { Private declarations }
    procedure pDestacaMes(intMes: Integer; cxsMes: TcxStyle);
    Procedure pAtualizaCaptions;
  public
    { Public declarations }
    cdsDigMultLoja: TCdsDigMultLoja;

    Procedure pAtualizaDadosUmaLojaPastaCompra(DataSet: TDataSet);

  end;

var
  frmTelaGiroUmaPasta: TfrmTelaGiroUmaPasta;

implementation

{$R *.dfm}

Uses
  untFuncoesPedidoSimples,
  untDemostrativoBaseCompra, untFuncoesSimples;

procedure TfrmTelaGiroUmaPasta.cxgItensDIAESTPropertiesGetDisplayText(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  If cxgItensDIAEST.Properties.Value <> Null Then
    AText :=FormatFloat('#,##0.00', cxgItensDIAEST.Properties.Value);

end;

procedure TfrmTelaGiroUmaPasta.cxgItensDIASUGPropertiesGetDisplayText(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  If cxgItensDIASUG.Properties.Value <> Null Then
    AText :=FormatFloat('#,##0.00', cxgItensDIASUG.Properties.Value);
end;

procedure TfrmTelaGiroUmaPasta.cxgItensNVLGIR2PropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  If Not Assigned(cdsDigMultLoja.cdsDadosRodapeUma) Then
    Exit;

  If Not cdsDigMultLoja.cdsDadosRodapeUma.Active Then
    Exit;

  If Not cdsDigMultLoja.cdsDadosRodapeUma.IsEmpty Then
    AText := cdsDigMultLoja.cdsDadosRodapeUma.FieldByName('ITE_NVLGIR').AsString + ' ' +
             cdsDigMultLoja.cdsDadosRodapeUma.FieldByName('ITE_NVLCRI').AsString;
end;

procedure TfrmTelaGiroUmaPasta.FormCreate(Sender: TObject);
begin
  cdsDigMultLoja := Nil;

  cxgItensVENMES.Properties.Caption := FormatDateTime('MM/YYYY', VS_Date);
end;

procedure TfrmTelaGiroUmaPasta.FormShow(Sender: TObject);
begin

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

procedure TfrmTelaGiroUmaPasta.lblSalbasClick(Sender: TObject);
begin

  If Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.cdsItens) And
     cdsDigMultLoja.cdsItens.Active And (Not cdsDigMultLoja.cdsItens.IsEmpty) Then
  TfrmDemostrativoBaseCompra.pDesmonstra(cdsDigMultLoja.cdsItens, cdsDigMultLoja.recOpcGir, cdsDigMultLoja.blnComGir);

end;

procedure TfrmTelaGiroUmaPasta.pDestacaMes(intMes: Integer; cxsMes: TcxStyle);
Begin
  If Assigned(cdsDigMultLoja) And (intMes <= cdsDigMultLoja.recOpcGir.intMesGir) And
     cdsDigMultLoja.blnComGir Then
    cxsMes.TextColor := clRed;
End;

Procedure TfrmTelaGiroUmaPasta.pAtualizaCaptions;
  Var
    stlMeses: TStringList;
    strNivGir : String;
begin
  If Assigned(cdsDigMultLoja) Then
  Begin
    stlMeses := TStringList.Create;
    stlMeses.Text := cdsDigMultLoja.recOpcGir.strMeses;

    cxvGridGiro2.Visible := cdsDigMultLoja.recOpcGir.intMesMos > 6;
    cxgItensPMED_V.Visible := fCfgSis('RNPMVE', varBoolean) And (cdsDigMultLoja.recOpcGir.strPedMlj <> 'S');

    If cdsDigMultLoja.recOpcGir.intMesMos < 6 Then
    Begin
      cxgItensQ_V_04.Visible := False;
      cxgItensQ_V_05.Visible := False;
      cxgItensQ_V_06.Visible := False;
    End;

    If cdsDigMultLoja.recOpcGir.intMesMos < 12 Then
    Begin
      cxgItensQ_V_07.Visible := False;
      cxgItensQ_V_08.Visible := False;
      cxgItensQ_V_09.Visible := False;
      cxgItensQ_V_10.Visible := False;
      cxgItensQ_V_11.Visible := False;
      cxgItensQ_V_12.Visible := False;
    End;

    If (cdsDigMultLoja.recOpcGir.intMesMos > 6) And (stlMeses.Count > 6) Then
    Begin
      cxgItensQ_V_12.Properties.Caption := stlMeses[11];
      cxgItensQ_V_11.Properties.Caption := stlMeses[10];
      cxgItensQ_V_10.Properties.Caption := stlMeses[09];
      cxgItensQ_V_09.Properties.Caption := stlMeses[08];
      cxgItensQ_V_08.Properties.Caption := stlMeses[07];
      cxgItensQ_V_07.Properties.Caption := stlMeses[06];
    End;

    If (cdsDigMultLoja.recOpcGir.intMesMos > 3) And (stlMeses.Count > 3) Then
    Begin
      cxgItensQ_V_06.Properties.Caption := stlMeses[05];
      cxgItensQ_V_05.Properties.Caption := stlMeses[04];
      cxgItensQ_V_04.Properties.Caption := stlMeses[03];
    End;

    If (stlMeses.Count > 1) Then
    Begin
      cxgItensQ_V_03.Properties.Caption := stlMeses[02];
      cxgItensQ_V_02.Properties.Caption := stlMeses[01];
      cxgItensQ_V_01.Properties.Caption := stlMeses[00];
    End;

    FreeAndNil(stlMeses);

    strNivGir := cdsDigMultLoja.cdsItens.FieldByName('ITE_NVLGIR').AsString;
    If strNivGir = '' Then
       strNivGir := ' ';



    If cdsDigMultLoja.recOpcGir.recNivEst.nivEstoque = nivNenhum Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComGer);
      cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComGer) + ' Ajustada';
    End

    Else If strNivGir[1] = 'A' Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvA);
      cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvA) + ' Ajustada';
    End

    Else If strNivGir[1] = 'B' Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvB);
      cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvB) + ' Ajustada';
    End

    Else If strNivGir[1] = 'C' Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvC);
      cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvC) + ' Ajustada';
    End;

  End;
end;

procedure TfrmTelaGiroUmaPasta.pAtualizaDadosUmaLojaPastaCompra(DataSet: TDataSet);
begin

    cxgItensDIASUG.Properties.Value  := DataSet.FieldByName('PRE_DIASUG').Value;
    cxgItensESTMAX.Properties.Value  := DataSet.FieldByName('PRE_ESTMAX').Value;
    cxgItensMEDIA_.Properties.Value  := DataSet.FieldByName('PRE_MEDMES').Value;
    cxgItensSUGEST.Properties.Value  := DataSet.FieldByName('PRE_NECAJU').Value;
    cxgItensESTMIN.Properties.Value  := DataSet.FieldByName('PRE_ESTMIN').Value;
    cxgItensPONPED.Properties.Value  := DataSet.FieldByName('PRE_PONPED').Value;
    cxgItensQESTPP.Properties.Value  := DataSet.FieldByName('PRE_QESTPP').Value;
    cxgItensMLTCOM.Properties.Value  := DataSet.FieldByName('PRE_MLTCOM').Value;
    cxgItensNVLGIR.Properties.Value  := DataSet.FieldByName('PRE_CRIGIR').Value;
    cxgItensSALDIS.Properties.Value  := DataSet.FieldByName('PRE_ESTDIS').Value;
    cxgItensQTDPEN.Properties.Value  := DataSet.FieldByName('PRE_PEDCOM').Value;

//    cxgItensSALTRA.Properties.Value  := DataSet.FieldByName('PRE_SALTRA').Value;

    cxgItensDIAEST.Properties.Value  := DataSet.FieldByName('PRE_DESTRE').Value;
    cxgItensVENMES.Properties.Value  := DataSet.FieldByName('PRE_VMES00').Value;
    cxgItensQ_V_01.Properties.Value  := DataSet.FieldByName('PRE_VMES01').Value;
    cxgItensQ_V_02.Properties.Value  := DataSet.FieldByName('PRE_VMES02').Value;
    cxgItensQ_V_03.Properties.Value  := DataSet.FieldByName('PRE_VMES03').Value;
    cxgItensQ_V_04.Properties.Value  := DataSet.FieldByName('PRE_VMES04').Value;
    cxgItensQ_V_05.Properties.Value  := DataSet.FieldByName('PRE_VMES05').Value;
    cxgItensQ_V_06.Properties.Value  := DataSet.FieldByName('PRE_VMES06').Value;
    cxgItensQ_V_07.Properties.Value  := DataSet.FieldByName('PRE_VMES07').Value;
    cxgItensQ_V_08.Properties.Value  := DataSet.FieldByName('PRE_VMES08').Value;
    cxgItensQ_V_09.Properties.Value  := DataSet.FieldByName('PRE_VMES09').Value;
    cxgItensQ_V_10.Properties.Value  := DataSet.FieldByName('PRE_VMES10').Value;
    cxgItensQ_V_11.Properties.Value  := DataSet.FieldByName('PRE_VMES11').Value;
    cxgItensQ_V_12.Properties.Value  := DataSet.FieldByName('PRE_VMES12').Value;
    cxgItensDTAULT.Properties.Value  := DataSet.FieldByName('ITE_DTAULT').Value;
    cxgItensPREULT.Properties.Value  := DataSet.FieldByName('ITE_PREULT').Value;
    cxgItensQTDUCO.Properties.Value  := DataSet.FieldByName('ITE_QTDUCO').Value;


    If DataSet.FieldByName('ITE_DTAULT').AsString <> '' Then
      cxgItennDIAUCO.Properties.Value  := Trunc(VS_Date - DataSet.FieldByName('ITE_DTAULT').Value);

    cxgItensCODBAR.Properties.Value  := DataSet.FieldByName('ITE_CODBAR').Value;
    cxgItensLOCFIS.Properties.Value  := DataSet.FieldByName('ITE_LOCFIS').Value;
    cxgitensNOMFOR.Properties.Value  := DataSet.FieldByName('ITE_FORULT').AsString + '-' + DataSet.FieldByName('FOR_NOMFOR').AsString;

    If DataSet.FieldByName('ITE_DTAUVE').AsString <> '' Then
      cxgItensDIAUVE.Properties.Value  := Trunc(VS_Date - DataSet.FieldByName('ITE_DTAUVE').AsDateTime);

    cxgItensDTAUVE.Properties.Value  := DataSet.FieldByName('ITE_DTAUVE').Value;

    cxgItensSALEXT.Properties.Value  := DataSet.FieldByName('ITE_SALEXT').Value;
end;

end.
