unit untTelaGiroUma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit, cxInplaceContainer, cxVGrid,
  cxCurrencyEdit, untCdsDigMultLoja, cxClasses, Data.DB,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.Buttons,
  cxTextEdit,
  cxDropDownEdit, BitBtnLockedIncrem, cxLabel;

type
  TfrmTelaGiroUma = class(TForm)
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
    cxgItensSALCOT: TcxEditorRow;
    cxvSaldos: TcxVerticalGrid;
    cxcSaldos: TcxCategoryRow;
    cxgItensSALFIS: TcxEditorRow;
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
    cxsDestaque: TcxStyle;
    cxgItensESIMDG: TcxEditorRow;
    cxsEdicao: TcxStyle;
    cxgItensPESOIT: TcxEditorRow;
    cxgItensQTDEMB: TcxEditorRow;
    cxgItensVENPER: TcxEditorRow;
    cxgItensIMPULT: TcxEditorRow;
    lblListaMesesGiro: TLabel;
    Label2: TLabel;
    cxItensPONEXP: TcxEditorRow;
    cxvSaldosSALTRA: TcxEditorRow;
    procedure FormShow(Sender: TObject);
    procedure cxgItensNVLGIR2PropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
    procedure FormCreate(Sender: TObject);
    procedure lblSalbasClick(Sender: TObject);
    procedure cxgItensDIASUGPropertiesGetDisplayText(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
    procedure cxgItensDIAESTPropertiesGetDisplayText(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
    procedure cxgItensESIMDGEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgItensESTMAXEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgItensESTMINEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvSugestKeyPress(Sender: TObject; var Key: Char);
    procedure lblListaMesesGiroClick(Sender: TObject);
  private
    blnESMILJ: Boolean;
    strEmpresasESMILJCadIte: string;
    { Private declarations }
    procedure pDestacaMes(intMes: Integer; cxsMes: TcxStyle);
    Procedure pAtualizaCaptions;
    Procedure pAtualizaOPCAO_PARA_ESTOQUE_MINIMO;
    procedure pAtualizaEstoque;
    function fRetSQLAtuEstMin: String;
    Function fValidaDataSetAlteracao: Boolean;
    function fRetEmpresas_ESMILJ_S: string;

  public
    { Public declarations }
    cdsDigMultLoja: TCdsDigMultLoja;

    Procedure pAtualizaDadosUmaLoja(strCodIte: String);

    procedure pHabilitaAlteracaEstMinMax;
  end;

var
  frmTelaGiroUma: TfrmTelaGiroUma;

implementation

{$R *.dfm}

Uses
  StrUtils,
  Uni,
  untAltEst,
  untFuncoesPedidoSimples,
  untDemostrativoBaseCompra,
  untFuncoesSimples, untTGiroPromocao;

procedure TfrmTelaGiroUma.cxgItensDIAESTPropertiesGetDisplayText(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  If cxgItensDIAEST.Properties.Value <> Null Then
    AText :=FormatFloat('#,##0.00', cxgItensDIAEST.Properties.Value);

end;

procedure TfrmTelaGiroUma.cxgItensDIASUGPropertiesGetDisplayText(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  If cxgItensDIASUG.Properties.Value <> Null Then
    AText :=FormatFloat('#,##0.00', cxgItensDIASUG.Properties.Value);
end;

Function TfrmTelaGiroUma.fValidaDataSetAlteracao: Boolean;
Begin
  Result := False;

  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  If Not Assigned(cdsDigMultLoja.cdsDadosRodapeUma) Then
    Exit;

  If Not cdsDigMultLoja.cdsDadosRodapeUma.Active Then
    Exit;

  If cdsDigMultLoja.cdsDadosRodapeUma <> cdsDigMultLoja.cdsItens Then
    Exit;

  Result := True;
End;

procedure TfrmTelaGiroUma.cxgItensESIMDGEditPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  If cdsDigMultLoja.cdsItens.IsEmpty Then
     DisplayValue := ''
  Else
  Begin
    If Not fValidaDataSetAlteracao Then
      Exit;

    If cdsDigMultLoja.cdsItens.FieldByName('ITE_ESMIDG').AsString <> DisplayValue Then
    Begin
      cdsDigMultLoja.cdsItens.Edit;
      If DisplayValue = 'Gerado' Then
        cdsDigMultLoja.cdsItens.FieldByName('ITE_ESMIDG').AsString := 'G'
      Else
        cdsDigMultLoja.cdsItens.FieldByName('ITE_ESMIDG').AsString := 'D';
      cdsDigMultLoja.cdsItens.Post;
      pAtualizaOPCAO_PARA_ESTOQUE_MINIMO;

    end;
  End;
end;

procedure TfrmTelaGiroUma.cxgItensESTMAXEditPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  If cdsDigMultLoja.cdsItens.IsEmpty Then
     DisplayValue := ''
  Else
  Begin
    If Not fValidaDataSetAlteracao Then
      Exit;

    If cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMAX').AsString <> DisplayValue Then
    Begin
      cdsDigMultLoja.cdsItens.Edit;
      cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMAX').AsString := DisplayValue;

      If cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMAX').AsFloat < cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMIN').AsFloat Then
        cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMIN').AsFloat := cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMAX').AsFloat;

      cdsDigMultLoja.cdsItens.Post;
      pAtualizaEstoque;

    end;
  End;
end;

procedure TfrmTelaGiroUma.cxgItensESTMINEditPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  If cdsDigMultLoja.cdsItens.IsEmpty Then
     DisplayValue := ''
  Else
  Begin
    If Not fValidaDataSetAlteracao Then
      Exit;

    If cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMIN').AsString <> DisplayValue Then
    Begin
      cdsDigMultLoja.cdsItens.Edit;
      cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMIN').AsString := DisplayValue;

      If cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMAX').AsFloat < cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMIN').AsFloat Then
        cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMAX').AsFloat := cdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMIN').AsFloat;

      cdsDigMultLoja.cdsItens.Post;
      pAtualizaEstoque;
    End;
  End;
end;

procedure TfrmTelaGiroUma.cxgItensNVLGIR2PropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  If Not Assigned(cdsDigMultLoja.cdsDadosRodapeUma) Then
    Exit;

  If Not cdsDigMultLoja.cdsDadosRodapeUma.Active Then
    Exit;

  With cdsDigMultLoja.cdsDadosRodapeUma Do
  If Not IsEmpty Then
    AText := FieldByName('ITE_NVLGIR').AsString + ' ' + FieldByName('ITE_NVLCRI').AsString;
end;


procedure TfrmTelaGiroUma.cxvSugestKeyPress(Sender: TObject; var Key: Char);
begin

  Case Key Of
    '-': Key := #0;
  End;
end;

procedure TfrmTelaGiroUma.FormCreate(Sender: TObject);
begin
  cdsDigMultLoja := Nil;
  blnESMILJ := (Not fCfgSis('ESMILJ', varBoolean)); // N -> Iteger / S -> Cadite
  strEmpresasESMILJCadIte := '';
  If not blnESMILJ then
    strEmpresasESMILJCadIte := fRetEmpresas_ESMILJ_S;

  cxgItensVENMES.Properties.Caption := FormatDateTime('MM/YYYY', VS_Date);
end;

procedure TfrmTelaGiroUma.FormShow(Sender: TObject);
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

  pHabilitaAlteracaEstMinMax;
end;

procedure TfrmTelaGiroUma.pHabilitaAlteracaEstMinMax;
Begin
  If (Not fValidaDataSetAlteracao) Or
     ((Not cdsDigMultLoja.recOpcGir.strEmpGir.IsEmpty) And (cdsDigMultLoja.recOpcGir.strEmpGir <> QuotedStr(VS_strCodEmp))) Or
     ((Not cdsDigMultLoja.FCotacao) And (cdsDigMultLoja.strEmpresaDestino <> VS_strCodEmp)) Then
  Begin
    cxgItensESTMAX.Styles.Content := Nil;
    cxgItensESTMIN.Styles.Content := Nil;
    cxgItensESIMDG.Styles.Content := Nil;

    cxgItensESTMAX.Properties.Options.Editing := False;
    cxgItensESTMIN.Properties.Options.Editing := False;
    cxgItensESIMDG.Properties.Options.Editing := False;
  End Else
  Begin
    cxgItensESTMAX.Styles.Content := cxsEdicao;
    cxgItensESTMIN.Styles.Content := cxsEdicao;
    cxgItensESIMDG.Styles.Content := cxsEdicao;

    cxgItensESTMAX.Properties.Options.Editing := True;
    cxgItensESTMIN.Properties.Options.Editing := True;
    cxgItensESIMDG.Properties.Options.Editing := True;
  End;
End;

procedure TfrmTelaGiroUma.lblListaMesesGiroClick(Sender: TObject);
  var intMesMos: integer;
    cdsItens: TDataSet;
    ArrGirPromocao: TArrGirPromocao;
    dtaDataBaseGir : TDateTime;
    i: integer;
    blnCampoMesDes: Boolean;
    procedure pAlimetaArray(posicao: integer);
      var strComplemento: String;
    Begin
      strComplemento := fStrZero(posicao, 2);
      If blnCampoMesDes And (posicao <> 0) Then
        ArrGirPromocao[posicao].Mes :=  cdsItens.FieldByName('ITE_DESM'+ strComplemento).AsString
      Else
        ArrGirPromocao[posicao].Mes := FormatDateTime('mm/yyyy', IncMonth(dtaDataBaseGir, -posicao));
      If posicao = 0 Then
      Begin
        ArrGirPromocao[posicao].QtdVenProm := cdsItens.FieldByName('ITE_Q_VPME').AsFloat;
        ArrGirPromocao[posicao].QtdVendida := cdsItens.FieldByName('ITE_VENMES').AsFloat;
        ArrGirPromocao[posicao].QtdSemProm := ArrGirPromocao[posicao].QtdVendida - ArrGirPromocao[posicao].QtdVenProm;
      End
      Else
      Begin
        ArrGirPromocao[posicao].QtdVenProm := cdsItens.FieldByName('ITE_Q_VP'+ strComplemento).AsFloat;
        ArrGirPromocao[posicao].QtdVendida := cdsItens.FieldByName('ITE_Q_V_'+ strComplemento ).AsFloat;
        ArrGirPromocao[posicao].QtdSemProm := ArrGirPromocao[posicao].QtdVendida - ArrGirPromocao[posicao].QtdVenProm;
      End;
    End;
begin
  inherited;

  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  If Not Assigned(cdsDigMultLoja.cdsDadosRodapeUma) Then
    Exit;

  If Not cdsDigMultLoja.cdsDadosRodapeUma.Active Then
    Exit;

  With cdsDigMultLoja.cdsDadosRodapeUma Do  {}
  Begin



    intMesMos :=  TCdsDigMultLoja(cdsDigMultLoja).recOpcGir.intMesMos;
    cdsItens  := cdsDigMultLoja.cdsItens;
    dtaDataBaseGir := TCdsDigMultLoja(cdsDigMultLoja).recOpcGir.dtaDataBaseGir;
    If intMesMos > 6 Then
      SetLength(ArrGirPromocao, 13)
    Else If intMesMos > 3 Then
      SetLength(ArrGirPromocao, 7)
    Else
      SetLength(ArrGirPromocao, 4);
    blnCampoMesDes := Not fEmptyStr(cdsItens.FieldByName('ITE_DESM01').AsString);
    For i := 0 To  Length(ArrGirPromocao) -1 do
    Begin
      ArrGirPromocao[i].Mes := '';
      ArrGirPromocao[i].QtdVenProm := 0;
      ArrGirPromocao[i].QtdVendida := 0;
      ArrGirPromocao[i].QtdSemProm := 0;
    End;
    If intMesMos > 6 Then
    Begin
        pAlimetaArray(12);
        pAlimetaArray(11);
        pAlimetaArray(10);
        pAlimetaArray(09);
        pAlimetaArray(08);
        pAlimetaArray(07);

    End;
    If intMesMos > 3 Then
    Begin
      pAlimetaArray(06);
      pAlimetaArray(05);
      pAlimetaArray(04);
    End;
    pAlimetaArray(03);
    pAlimetaArray(02);
    pAlimetaArray(01);

    pAlimetaArray(00);
    TfrmGiroPromocao.pExecuta(ArrGirPromocao, cdsItens.FieldByName('ITE_CODITE').AsString,
                                              cdsItens.FieldByName('ITE_REFERE').AsString,
                                              cdsItens.FieldByName('ITE_SIGUNI').AsString);
  end;

end;

procedure TfrmTelaGiroUma.lblSalbasClick(Sender: TObject);
begin

  If Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.cdsItens) And
     cdsDigMultLoja.cdsItens.Active And (Not cdsDigMultLoja.cdsItens.IsEmpty) Then
  TfrmDemostrativoBaseCompra.pDesmonstra(cdsDigMultLoja.cdsItens, cdsDigMultLoja.recOpcGir, cdsDigMultLoja.blnComGir);

end;

procedure TfrmTelaGiroUma.pDestacaMes(intMes: Integer; cxsMes: TcxStyle);
Begin
  If Assigned(cdsDigMultLoja) And (intMes <= cdsDigMultLoja.recOpcGir.intMesGir) And
     cdsDigMultLoja.blnComGir Then
    cxsMes.TextColor := clRed;
End;

Procedure TfrmTelaGiroUma.pAtualizaCaptions;
  Var
    stlMeses: TStringList;
    strNivGir: String;
begin
  If Assigned(cdsDigMultLoja) Then
  With cdsDigMultLoja, cdsItens, recOpcGir, recNivEst Do
  Begin
    stlMeses := TStringList.Create;
    stlMeses.Text := strMeses;

    cxvGridGiro2.Visible := intMesMos > 6;
    cxgItensPMED_V.Visible := fCfgSis('RNPMVE', varBoolean) And (strPedMlj <> 'S');

    cxItensPONEXP.Visible := fCfgSis('PONEXP', varString) = 'S';

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

    If (stlMeses.Count > 1) Then
    Begin
      cxgItensQ_V_03.Properties.Caption := stlMeses[02];
      cxgItensQ_V_02.Properties.Caption := stlMeses[01];
      cxgItensQ_V_01.Properties.Caption := stlMeses[00];
    End;

    FreeAndNil(stlMeses);
    strNivGir := FieldByName('ITE_NVLGIR').AsString;
    if strNivGir = '' Then
      strNivGir := ' ';
    If nivEstoque = nivNenhum Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(intDiaComGer);
      cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(intDiaComGer) + ' Ajustada';
    End

    Else If strNivGir[1] = 'A' Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(intDiaComNvA);
      cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(intDiaComNvA) + ' Ajustada';
    End

    Else If strNivGir[1] = 'B' Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(intDiaComNvB);
      cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(intDiaComNvB) + ' Ajustada';
    End

    Else If strNivGir[1] = 'C' Then
    Begin
      cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(intDiaComNvC);
      cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(intDiaComNvC) + ' Ajustada';
    End;

  End;
end;

Procedure TfrmTelaGiroUma.pAtualizaDadosUmaLoja(strCodIte: String);
var LocalRecOpcGir: TRecOpcoesGiro;
Begin
  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  If Not Assigned(cdsDigMultLoja.cdsDadosRodapeUma) Then
    Exit;

  If Not cdsDigMultLoja.cdsDadosRodapeUma.Active Then
    Exit;

  With cdsDigMultLoja.cdsDadosRodapeUma Do
  Begin
    pnlDados.Visible := FieldByName('ITE_CODITE').AsString = strCodIte;
    cxItensPONEXP.Properties.Value   := cdsDigMultLoja.cdsDadosRodapeUma.FieldByName('ITE_PONEXP').DisplayText;
    If Assigned(cdsDigMultLoja.cdsItensSint) Then
    Begin
      cxgItensPESOIT.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_PESOIT').Value;
      cxgItensDIASUG.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_DIASUG').Value;
      cxItensPONEXP.Properties.Value   := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_PONEXP').DisplayText;

      cxgItensLOCFIS.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_LOCFIS').asString;
      cxgitensNOMFOR.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_FORULT').AsString + '-' + FieldByName('ITE_NOMFOR').AsString;
      cxgItennDIAUCO.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_DIAUCO').Value;
      cxgItensDTAULT.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_DTAULT').Value;
      cxgItensPREULT.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_PREULT').DisplayText;
      cxgItensQTDUCO.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_QTDUCO').DisplayText;
      cxgItensDIAUVE.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_DIAUVE').Value;
      cxgItensDTAUVE.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_DTAUVE').Value;
      cxgItensIMPULT.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_IMPULT').DisplayText;
      cxgItensQTDPEN.Properties.Value  := cdsDigMultLoja.cdsItensSint.FieldByName('ITE_QTDPEN').Value;
    End
    Else
    Begin
      cxgItensLOCFIS.Properties.Value  := FieldByName('ITE_LOCFIS').Value;
      cxgitensNOMFOR.Properties.Value  := FieldByName('ITE_FORULT').AsString + '-' + FieldByName('ITE_NOMFOR').AsString;
      cxgItennDIAUCO.Properties.Value  := FieldByName('ITE_DIAUCO').Value;
      cxgItensDTAULT.Properties.Value  := FieldByName('ITE_DTAULT').Value;
      cxgItensPREULT.Properties.Value  := FieldByName('ITE_PREULT').DisplayText;
      cxgItensQTDUCO.Properties.Value  := FieldByName('ITE_QTDUCO').DisplayText;
      cxgItensDIAUVE.Properties.Value  := FieldByName('ITE_DIAUVE').Value;
      cxgItensDTAUVE.Properties.Value  := FieldByName('ITE_DTAUVE').Value;
      cxgItensIMPULT.Properties.Value  := FieldByName('ITE_IMPULT').DisplayText;
      cxgItensQTDPEN.Properties.Value  := FieldByName('ITE_QTDPEN').Value;
    End;

    If FieldByName('ITE_ESMIDG').Value = 'G' Then
      cxgItensESIMDG.Properties.Value  := 'Gerado'
    Else
      cxgItensESIMDG.Properties.Value  := 'Digitado';


    If Assigned(cdsDigMultLoja) Then
    With cdsDigMultLoja, cdsItens, recOpcGir, recNivEst Do
    Begin
      LocalRecOpcGir :=  recOpcGir;
      If nivEstoque = nivNenhum Then
      Begin
        cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(intDiaComGer);
        cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(intDiaComGer) + ' Ajustada';
      End

      Else If FieldByName('ITE_NVLGIR').AsString = 'A' Then
      Begin
        cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(recNivEst.intDiaComNvA);
        cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(intDiaComNvA) + ' Ajustada';
      End

      Else If FieldByName('ITE_NVLGIR').AsString = 'B' Then
      Begin
        cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(intDiaComNvB);
        cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(intDiaComNvB) + ' Ajustada';
      End

      Else If FieldByName('ITE_NVLGIR').AsString = 'C' Then
      Begin
        cxgItensMEDIXX.Properties.Caption := 'Média ' + IntToStr(intDiaComNvC);
        cxgItensMEDAJU.Properties.Caption := 'Média ' + IntToStr(intDiaComNvC) + ' Ajustada';
      End;
    End;

    cxgItensESTMAX.Properties.Value  := FieldByName('ITE_ESTMAX').Value;
    cxgItensMEDIA_.Properties.Value  := FieldByName('ITE_MEDIA_').Value;
    cxgItensMEDIXX.Properties.Value  := FieldByName('ITE_MEDIXX').Value;
    cxgItensMEDAJU.Properties.Value  := FieldByName('ITE_MEDAJU').Value;
    cxgItensSUGEST.Properties.Value  := FieldByName('ITE_SUGEST').Value;
    cxgItensESTMIN.Properties.Value  := FieldByName('ITE_ESTMIN').Value;
    cxgItensPONPED.Properties.Value  := FieldByName('ITE_PONPED').Value;
    cxgItensMLTCOM.Properties.Value  := FieldByName('ITE_MLTCOM').Value;
    cxgItensNVLGIR.Properties.Value  := FieldByName('ITE_NVLGIR').Value;

    cxgItensSALFIS.Properties.Value  := FieldByName('ITE_SALFIS').Value;
    cxgItensSALEXT.Properties.Value  := FieldByName('ITE_SALEXT').Value;
    cxgItensSALDIS.Properties.Value  := FieldByName('ITE_SALDIS').Value;
    cxgItensSALBAS.Properties.Value  := FieldByName('ITE_SALBAS').Value;

    cxgItensSALGAR.Properties.Value  := FieldByName('ITE_SALGAR').Value;
    cxgItensSALEND.Properties.Value  := FieldByName('ITE_SALEND').Value;
    cxgItensSALRES.Properties.Value  := FieldByName('ITE_SALRES').Value;

    cxvSaldosSALTRA.Properties.Value := FieldByName('ITE_SALTRA').Value;

    cxgItensVENPER.Properties.Value  := FieldByName('ITE_VENPER').Value;


    cxgItensFUTPRE.Properties.Value  := FieldByName('ITE_QTEF_P').Value;
    cxgItensFUTAGU.Properties.Value  := FieldByName('ITE_QTEF_A').Value;
    cxgItensFUTFAL.Properties.Value  := FieldByName('ITE_QTEF_F').Value;

    cxgItensORDPRO.Properties.Value  := FieldByName('ITE_QTPD_P').Value;
    cxgItensPMED_V.Properties.Value  := FieldByName('ITE_PMED_V').Value;

    cxgItensDIAEST.Properties.Value  := FieldByName('ITE_DIAEST').Value;

    cxgItensSALCOT.Properties.Value  := FieldByName('ITE_SALCOT').Value;

    If FindField('ITE_MADTSA') <> Nil Then
      cxgItensMADTSA.Properties.Value  := FieldByName('ITE_MADTSA').Value;

    If FindField('ITE_MAQTSA') <> Nil Then
      cxgItensMAQTSA.Properties.Value  := FieldByName('ITE_MAQTSA').Value;

    If FindField('ITE_VENMES') <> Nil Then
     cxgItensVENMES.Properties.Value  := FieldByName('ITE_VENMES').Value;

    If FindField('ITE_Q_V_01') <> Nil Then
    Begin
      cxgItensQ_V_01.Properties.Value  := FieldByName('ITE_Q_V_01').Value;
      cxgItensQ_V_01.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_01.Properties.Caption, '(*)', '');
      cxgItensQ_V_01.Properties.Caption := cxgItensQ_V_01.Properties.Caption +
                                           IIf(FieldByName('ITE_Q_VP01').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;


    If FindField('ITE_Q_V_02') <> Nil Then
    Begin
      cxgItensQ_V_02.Properties.Value  := FieldByName('ITE_Q_V_02').Value;
      cxgItensQ_V_02.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_02.Properties.Caption, '(*)', '');
      cxgItensQ_V_02.Properties.Caption := cxgItensQ_V_02.Properties.Caption +
                                           IIf(FieldByName('ITE_Q_VP02').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;

    If FindField('ITE_Q_V_03') <> Nil Then
    Begin
      cxgItensQ_V_03.Properties.Value  := FieldByName('ITE_Q_V_03').Value;
      cxgItensQ_V_03.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_03.Properties.Caption, '(*)', '');
      cxgItensQ_V_03.Properties.Caption := cxgItensQ_V_03.Properties.Caption +
                                           IIf(FieldByName('ITE_Q_VP03').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;

    If FindField('ITE_Q_V_04') <> Nil Then
    Begin
      cxgItensQ_V_04.Properties.Value  := FieldByName('ITE_Q_V_04').Value;
      cxgItensQ_V_04.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_04.Properties.Caption, '(*)', '');
      cxgItensQ_V_04.Properties.Caption := cxgItensQ_V_04.Properties.Caption +
                                           IIf(FieldByName('ITE_Q_VP04').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;

    If FindField('ITE_Q_V_05') <> Nil Then
    Begin
      cxgItensQ_V_05.Properties.Value  := FieldByName('ITE_Q_V_05').Value;
      cxgItensQ_V_05.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_05.Properties.Caption, '(*)', '');
      cxgItensQ_V_05.Properties.Caption := cxgItensQ_V_05.Properties.Caption +
                                           IIf(FieldByName('ITE_Q_VP05').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;

    If FindField('ITE_Q_V_06') <> Nil Then
    Begin
      cxgItensQ_V_06.Properties.Value  := FieldByName('ITE_Q_V_06').Value;
      cxgItensQ_V_06.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_06.Properties.Caption, '(*)', '');
      cxgItensQ_V_06.Properties.Caption := cxgItensQ_V_06.Properties.Caption +
                                           IIf(FieldByName('ITE_Q_VP06').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;

    If FindField('ITE_Q_V_07') <> Nil Then
    Begin
      cxgItensQ_V_07.Properties.Value  := FieldByName('ITE_Q_V_07').Value;
      cxgItensQ_V_07.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_07.Properties.Caption, '(*)', '');
      cxgItensQ_V_07.Properties.Caption := cxgItensQ_V_07.Properties.Caption + +
                                           IIf(FieldByName('ITE_Q_VP07').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;

    If FindField('ITE_Q_V_08') <> Nil Then
    Begin
      cxgItensQ_V_08.Properties.Value  := FieldByName('ITE_Q_V_08').Value;
      cxgItensQ_V_08.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_08.Properties.Caption, '(*)', '');
      cxgItensQ_V_08.Properties.Caption := cxgItensQ_V_08.Properties.Caption +
                                           IIf(FieldByName('ITE_Q_VP08').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;

    If FindField('ITE_Q_V_09') <> Nil Then
    Begin
      cxgItensQ_V_09.Properties.Value  := FieldByName('ITE_Q_V_09').Value;
      cxgItensQ_V_09.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_09.Properties.Caption, '(*)', '');
      cxgItensQ_V_09.Properties.Caption := cxgItensQ_V_09.Properties.Caption +
                                           IIf(FieldByName('ITE_Q_VP09').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;

    If FindField('ITE_Q_V_10') <> Nil Then
    Begin
      cxgItensQ_V_10.Properties.Value  := FieldByName('ITE_Q_V_10').Value;
      cxgItensQ_V_10.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_10.Properties.Caption, '(*)', '');
      cxgItensQ_V_10.Properties.Caption := cxgItensQ_V_10.Properties.Caption +
                                           IIf(FieldByName('ITE_Q_VP10').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;

    If FindField('ITE_Q_V_11') <> Nil Then
    Begin
      cxgItensQ_V_11.Properties.Value  := FieldByName('ITE_Q_V_11').Value;
      cxgItensQ_V_11.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_11.Properties.Caption, '(*)', '');
      cxgItensQ_V_11.Properties.Caption := cxgItensQ_V_11.Properties.Caption +
                                           IIf(FieldByName('ITE_Q_VP11').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;

    If FindField('ITE_Q_V_12') <> Nil Then
    Begin
      cxgItensQ_V_12.Properties.Value  := FieldByName('ITE_Q_V_12').Value;
      cxgItensQ_V_12.Properties.Caption := AnsiReplaceStr(cxgItensQ_V_12.Properties.Caption, '(*)', '');
      cxgItensQ_V_12.Properties.Caption := cxgItensQ_V_12.Properties.Caption +
                                           IIf(FieldByName('ITE_Q_VP12').Value > 0, fEscreAsteriscoPromocao(LocalRecOpcGir), '');
    End;

    If FindField('ITE_QTDEMB') <> Nil Then
      cxgItensQTDEMB.Properties.Value  := FieldByName('ITE_QTDEMB').Value;

    cxgItensVENMES.Properties.Caption := StringReplace(cxgItensVENMES.Properties.Caption, '(*)', '', []);
    If FieldByName('ITE_Q_VPME').AsFloat > 0 Then
       cxgItensVENMES.Properties.Caption := cxgItensVENMES.Properties.Caption + fEscreAsteriscoPromocao(LocalRecOpcGir);

    cxgItensCODBAR.Properties.Value  := FieldByName('ITE_CODBAR').Value;
  End;
End;

procedure TfrmTelaGiroUma.pAtualizaOPCAO_PARA_ESTOQUE_MINIMO;
var    qryEst: TUniQuery;
begin
  qryEst := fCriaQuery;
  Try
    qryEst.SQL.Add(CdsDigMultLoja.fRetSQLAtuESMIDG(IIF(not blnESMILJ, strEmpresasESMILJCadIte, '')));

    fStartTransaction;
    Try
      qryEst.ParamByName('ESMIDG').AsString := CdsDigMultLoja.cdsItens.FieldByName('ITE_ESMIDG').AsString;
      qryEst.ParamByName('CODITE').AsString := CdsDigMultLoja.cdsItens.FieldByName('ITE_CODITE').AsString;
      If blnESMILJ then
        qryEst.ParamByName('CODEMP').AsString := VS_StrCodEmp;
      qryEst.ExecSQL;
      fCommit;
    Except
      fRollback;
    End;
  Finally
    FreeAndNil(qryEst);
  End;
end;

function TfrmTelaGiroUma.fRetEmpresas_ESMILJ_S: string;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Result := '';
  try
    qryConsulta.SQL.Add('SELECT SIS_CODEMP FROM CFGSIS WHERE SIS_CODCFG = "CFG_ESMILJ" AND SIS_VALCFG = "S"');
    qryConsulta.Open;
    while not qryConsulta.Eof Do
    begin
      Result := Result + '"' + qryConsulta.FieldByName('SIS_CODEMP').AsString + '"';
      qryConsulta.Next;
    End;
    If Result <> '' Then
      Result := StringReplace(Result, '""', '","', [rfReplaceAll]);

  finally
    FreeAndNil(qryConsulta)
  end;

end;

function TfrmTelaGiroUma.fRetSQLAtuEstMin: String;
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'UPDATE   ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'SET      ';
  strSQL := strSQL + '  ITE_ESTMIN = :ESTMIN, ';
  strSQL := strSQL + '  ITE_ESTMAX = :ESTMAX  ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP     ';

  Result := strSQL;

end;

procedure TfrmTelaGiroUma.pAtualizaEstoque;
  var
    strSQL: String;
    qryEst: TUniQuery;
begin
  strSQL := fRetSQLAtuEstMin;
  qryEst := fCriaQuery;
  Try
    Try
      fStartTransaction;
      TAltEst.fGravaLog(Self,
                        CdsDigMultLoja.cdsItens.FieldByName('ITE_CODITE').AsString,
                        VS_strCodemp,
                        CdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMIN').AsFloat,
                        CdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMAX').AsFloat,
                        True,
                        False);
      qryEst.Close;
      qryEst.SQL.Clear;
      qryEst.SQL.Add(strSQL);
      qryEst.ParamByName('ESTMIN').AsFloat  := CdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMIN').AsFloat;
      qryEst.ParamByName('ESTMAX').AsFloat  := CdsDigMultLoja.cdsItens.FieldByName('ITE_ESTMAX').AsFloat;
      qryEst.ParamByName('CODITE').AsString := CdsDigMultLoja.cdsItens.FieldByName('ITE_CODITE').AsString;
      qryEst.ParamByName('CODEMP').AsString := VS_StrCodEmp;
      qryEst.ExecSQL;
      fCommit;
    Except
      fRollback;
    End;
  Finally
    FreeAndNil(qryEst);
  End;
End;

end.
