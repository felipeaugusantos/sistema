unit untTabelasDoItemFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxStyles, cxClasses,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxEdit,
  cxCurrencyEdit, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxVGrid, cxDBVGrid, cxInplaceContainer, cxCheckBox, Uni,
  untTabelasDoItem, cxTextEdit, Vcl.ExtCtrls, Data.DB, Vcl.Buttons, cxLabel,
  Vcl.StdCtrls;

type
  TVisibilidadePadrao = Record
   Name : String;
   VisibilidadePadrao : Boolean;
  End;



  TArrVisibilidadePadrao = array of TVisibilidadePadrao;

  TfrmTabelasDoItemFrame = class(TFrame)
    cxStyleRepository: TcxStyleRepository;
    cxStyleZebra: TcxStyle;
    cxsColunaFixa: TcxStyle;
    cxsColunaFixaDestaque: TcxStyle;
    cxsPreco: TcxStyle;
    cxsMargem: TcxStyle;
    cxsTituloBlue: TcxStyle;
    cxsTituloRed: TcxStyle;
    cxsNegrito: TcxStyle;
    cxsDolar: TcxStyle;
    cxvPrecos: TcxDBVerticalGrid;
    cxvPrecosTABELA: TcxDBEditorRow;
    cxvPrecosTabFornecedor: TcxDBEditorRow;
    cxvPrecosAbreviacaoICMS: TcxCategoryRow;
    cxvPrecosCODABF: TcxDBEditorRow;
    cxvPrecosCategoryRow1: TcxCategoryRow;
    cxvPrecosPREDOL: TcxDBEditorRow;
    cxvPrecosPRECOM: TcxDBEditorRow;
    cxvPrecosDESF01: TcxDBEditorRow;
    cxvPrecosDESF02: TcxDBEditorRow;
    cxvPrecosDESF03: TcxDBEditorRow;
    cxvPrecosDESF04: TcxDBEditorRow;
    cxvPrecosDESF05: TcxDBEditorRow;
    cxvPrecosDESF06: TcxDBEditorRow;
    cxvPrecosCOMLIQ: TcxDBEditorRow;
    cxvPrecosCatPreCus: TcxCategoryRow;
    cxvPrecosICMENT: TcxDBEditorRow;
    cxvPrecosSUBFED: TcxDBEditorRow;
    cxvPrecosIPIENT: TcxDBEditorRow;
    cxvPrecosFREENT: TcxDBEditorRow;
    cxvPrecosVALFRE: TcxDBEditorRow;
    cxvPrecosACRFIN: TcxDBEditorRow;
    cxvPrecosSUBSTI: TcxDBEditorRow;
    cxvPrecosDESADB: TcxDBEditorRow;
    cxvPrecosTCIFCU: TcxDBEditorRow;
    cxvPrecosTSCUST: TcxDBEditorRow;
    cxvPrecosDEPICO: TcxDBEditorRow;
    cxvPrecosDEICMS: TcxDBEditorRow;
    cxvPrecosFATREG: TcxDBEditorRow;
    cxvPrecosPRECUS: TcxDBEditorRow;
    cxvPrecosCatCusRea: TcxCategoryRow;
    cxvPrecosOUTVAL: TcxDBEditorRow;
    cxvPrecosICMSAI: TcxDBEditorRow;
    cxvPrecosIMPFED: TcxDBEditorRow;
    cxvPrecosDESOPE: TcxDBEditorRow;
    cxvPrecosCUSREA: TcxDBEditorRow;
    cxvPrecosCatPreVen: TcxCategoryRow;
    cxvPrecosMARBRU: TcxDBEditorRow;
    cxvPrecosMARMK3: TcxDBEditorRow;
    cxvPrecosCOMTBL: TcxDBEditorRow;
    cxvPrecosPREVEN: TcxDBEditorRow;
    cxvPrecosVENDOL: TcxDBEditorRow;
    cxvPrecosCatMarIde: TcxCategoryRow;
    cxvPrecosMARIDE: TcxDBEditorRow;
    cxvPrecosPREIDE: TcxDBEditorRow;
    cxvPrecosDBEditorRow2: TcxDBEditorRow;
    cxvPrecosDBEditorRow3: TcxDBEditorRow;
    cxvPrecosPromocao: TcxCategoryRow;
    cxvPrecosPRO_MARGEM: TcxDBEditorRow;
    cxvPrecosPRO_PREVEN: TcxDBEditorRow;
    cxvPrecosIVA: TcxDBEditorRow;
    cxvPrecosPREREV: TcxDBEditorRow;
    cxvPrecosDESREV: TcxDBEditorRow;
    cxvPrecosGiro: TcxCategoryRow;
    cxvPrecosMARGIR: TcxDBEditorRow;
    cxvPrecosVENGIR: TcxDBEditorRow;

    Panel1: TPanel;
    btnExpand: TSpeedButton;
    btnCollapse: TSpeedButton;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxvPrecosCUSATI: TcxDBEditorRow;
    pnlLegenda: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    cxvPrecosPREEMB: TcxDBEditorRow;
    procedure cxvPrecosDESF01PropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
    procedure cxvPrecosPRECOMPropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
    procedure cxvPrecosMARBRUEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvPrecosPREVENEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvPrecosCOMTBLEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvPrecosEditing(Sender: TObject;
      ARowProperties: TcxCustomEditorRowProperties; var Allow: Boolean);
    procedure cxvPrecosItemChanged(Sender: TObject; AOldRow: TcxCustomRow;
      AOldCellIndex: Integer);
    procedure cxvPrecosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxvPrecosPRECOMEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvPrecosDESF01EditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvPrecosKeyPress(Sender: TObject; var Key: Char);
    procedure cxvPrecosCODABFPropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
    procedure cxvPrecosDBEditorRow1EditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvPrecosPRO_MARGEMPropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
    procedure btnExpandClick(Sender: TObject);
    procedure cxvPrecosPRO_PREVENPropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
    procedure cxvPrecosDrawValue(Sender: TObject; ACanvas: TcxCanvas;
      APainter: TcxvgPainter; AValueInfo: TcxRowValueInfo; var Done: Boolean);
    procedure cxvPrecosCUSATIPropertiesGetDisplayText(
      Sender: TcxCustomEditorRowProperties; ARecord: Integer;
      var AText: string);
  private
    { Private declarations }
    FRecolher: Boolean;
    cxdUltimoAtivo: TcxCustomRow;
    FblnInclusao: Boolean;
    FArrVisibilidadePadrao: TArrVisibilidadePadrao;
    blnFormacaoPreco: Boolean;

    Function fUltimoCampoPrecoAtivo: TcxCustomRow;
    procedure pProcessaKeyPressTabFornecedor(Sender: TObject; var Key: Char);
    procedure pSetBlnRecolher(const Value: boolean);
    procedure pAjustaVisibilidade;
    function  fSetVisibleComponent(AName: String): Boolean;
    function  fPodeTornarVisivel(AName: String): Boolean;
    function fValidaFornecedorTabela(intTabela: Integer): Boolean;
    Procedure pAlimentaVisibilidadePadrao;
    Procedure AddArrVisibilidadePadrao(ACompName: String; ADefVisible: Boolean; APosition: Integer);
  public
    { Public declarations }
    objTabelas: TTabelasDoItem;
    frmPai: TForm;
    property blnRecolher: boolean read FRecolher write pSetBlnRecolher;

    Procedure pHabilitaCampos(blnInclusao: Boolean; blnPreMat: Boolean; blnAlteracao: Boolean);
    procedure pGerenciaEdicaoIcmsSaida(blnEdicao: Boolean);
    procedure pGerenciaEdicaoImpostosFederais(blnEdicao: Boolean);

    Procedure pInicializaDados(qryCadIte, qryIteger: TDataSet; AblnFormacaoPreco: Boolean = False; dts: TDataSource = nil);
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples, untConsultas, untTypesSistema, untCalculaComposicaoCusto,
  untPai, untSalvaConfiguracaoGrid;

Function TfrmTabelasDoItemFrame.fUltimoCampoPrecoAtivo: TcxCustomRow;
Begin
  Result := cxvPrecosPREVEN;
End;

procedure TfrmTabelasDoItemFrame.cxvPrecosCODABFPropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
   If AText <> '' Then
     AText := AText + ' - ' + fRetDesAbfIcm(AText);
end;

procedure TfrmTabelasDoItemFrame.cxvPrecosCOMTBLEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin

  If fEmptyStr(DisplayValue) Then
    DisplayValue := 0;

  If Not objTabelas.fValidaMargem(objTabelas.cdsDados.FieldByName('ITE_MARBRU').AsFloat,
                              fStrToFloat(DisplayValue)) Then
  Begin
    ErrorText := '';
    Error := True;
  End;

end;

procedure TfrmTabelasDoItemFrame.cxvPrecosCUSATIPropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  If AText = '1' Then
    AText := 'Sim'
  Else
    AText := 'Não';
end;

procedure TfrmTabelasDoItemFrame.cxvPrecosDBEditorRow1EditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    strTabela: String;
begin

  If fEmptyStr(DisplayValue) Then
  Begin
    Error := True;
    ErrorText := '';
    pMensagemOk('Informe o código da tabela de preço do fornecedor!');
  End Else
  Begin
    strTabela := DisplayValue ;
    DisplayValue := fStrZero(strTabela, 6);

    If fRetNomTabelaPreco(DisplayValue).IsEmpty Then
    Begin
      Error := True;
      ErrorText := '';
      pMensagemOk('Tabela de preço não encontrada!');
    End
    Else
    Begin
      objTabelas.pPreencheTabela(Nil, DisplayValue);
      If Assigned(objTabelas.dbeCodFor) Then
      Begin
        If objTabelas.dbeCodFor.Field.AsString = '' Then
        Begin
          If objTabelas.strCfgTBOFPC[objTabelas.cdsTabelas.FieldByName('TABELA').AsInteger] = 'S' Then
            objTabelas.dbeCodFor.Field.AsString := objTabelas.cdsTabelas.FieldByName('CODFOR').AsString;
        End
        Else If Not fValidaFornecedorTabela(objTabelas.cdsTabelas.FieldByName('TABELA').AsInteger) Then
        Begin
          Error := True;
          ErrorText := '';
          DisplayValue := '';
          pMensagemOk('Devido a configuração CFG_TBOFPC(Obrigar que a tabela de preço do fornecedor ativa, ' + #13 +
                      'ou que será ativada para o custo, tenha o mesmo fornecedor na tabela de preço, do Fornecedor Principal) ' + #13 +
                      'Então o Fornecedor da tabela deve ser igual ao Fornecedor Principal.' + #13 +
                      'Principal: ' + objTabelas.dbeCodFor.Field.AsString + '-' + fRetNomFornecedor(objTabelas.dbeCodFor.Field.AsString) + '.', 600);
        End;
      End;
    End;
  End;
end;

function TfrmTabelasDoItemFrame.fValidaFornecedorTabela(intTabela: Integer): Boolean;
begin
  Result := True;
  If Not Assigned(objTabelas.dbeCodFor) Then
    Exit;
  If objTabelas.strCfgTBOFPC[intTabela] = 'S' Then
    If objTabelas.dbeCodFor.Field.AsString <> objTabelas.cdsTabelas.FieldByName('CODFOR').AsString Then
      Result := false;
End;



procedure TfrmTabelasDoItemFrame.cxvPrecosDESF01EditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin

  If fStrToFloat(DisplayValue) < 0 Then
  Begin
    ErrorText := '';
    Error := True;
    pMensagemOk('O valor de "' + TcxDBEditorRow(cxvPrecos.FocusedRow).Properties.Caption  + '" deve ser maior ou igual a zero!');
  End;




end;

procedure TfrmTabelasDoItemFrame.cxvPrecosDESF01PropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  AText := FormatFloat(fMskDigitos(2), fStrToFloat(AText)) + ' %';
end;

procedure TfrmTabelasDoItemFrame.cxvPrecosDrawValue(Sender: TObject;
  ACanvas: TcxCanvas; APainter: TcxvgPainter; AValueInfo: TcxRowValueInfo;
  var Done: Boolean);

begin
  If AValueInfo.Row = cxvPrecosCUSATI Then
  Begin
     If Not (VarIsNull(AValueInfo.DisplayValue)) Then
       If AValueInfo.DisplayValue =  1 Then
         ACanvas.FrameRect(AValueInfo.BoundsRect, clYellow, 2, [bLeft, bRight])
       Else
         ACanvas.FrameRect(AValueInfo.BoundsRect, clSilver, 2, [bLeft, bRight]);
  End;


  If cxvPrecosCUSATI.Visible Then
  Begin
    If AValueInfo.Row.Tag = 1 Then
      ACanvas.FrameRect(AValueInfo.BoundsRect, clMoneyGreen, 2, [bLeft, bRight]);

  End;


end;

procedure TfrmTabelasDoItemFrame.cxvPrecosEditing(Sender: TObject;
  ARowProperties: TcxCustomEditorRowProperties; var Allow: Boolean);
begin
  objTabelas.strCampoFocado := TcxDBEditorRow(cxvPrecos.FocusedRow).Properties.DataBinding.FieldName;
end;

procedure TfrmTabelasDoItemFrame.cxvPrecosItemChanged(Sender: TObject;
  AOldRow: TcxCustomRow; AOldCellIndex: Integer);
begin
  If objTabelas.cdsDados.State In dsEditModes Then
    objTabelas.cdsDados.Post;
end;

procedure TfrmTabelasDoItemFrame.cxvPrecosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
     VK_RETURN: If (TcxDBVerticalGrid(Sender).InplaceEditor <> nil) and
                   (TcxDBVerticalGrid(Sender).FocusedRow = cxdUltimoAtivo) Then
                Begin
                  If objTabelas.cdsDados.State In dsEditModes Then
                    objTabelas.cdsDados.Post;

                  If (TcxDBVerticalGrid(Sender).DataController.FocusedRecordIndex <> TcxDBVerticalGrid(Sender).DataController.RecordCount - 1) then
                    TcxDBVerticalGrid(Sender).DataController.FocusedRecordIndex := TcxDBVerticalGrid(Sender).DataController.FocusedRecordIndex + 1
                  Else
                    TcxDBVerticalGrid(Sender).DataController.FocusedRecordIndex := 0;

                  Key := 0;

                  If cxvPrecosPRECOM.Properties.Options.Editing Then
                    cxvPrecosPRECOM.Focused := True
                  Else
                    cxvPrecosMARBRU.Focused := True;
                end;
  End;

end;

procedure TfrmTabelasDoItemFrame.pProcessaKeyPressTabFornecedor(Sender: TObject; var Key: Char);
var
   arrTabela : TConsultasArray;
   qryTabela: TUniQuery;
Begin
  If TcxDBVerticalGrid(Sender).FocusedRow = cxvPrecosTabFornecedor Then
  begin
    If Not TcxDBVerticalGrid(Sender).OptionsData.Editing Then
      Exit;

    If fEntraCons(Key) Then
    Begin
      qryTabela := fCriaQuery;
      Try

        If fPesqTabelaPreco(frmPai, Nil, Nil, qryTabela, Key, arrTabela) Then
        Begin
          objTabelas.pPreencheTabela(qryTabela, '');
          TcxDBVerticalGrid(Sender).Navigator.Buttons.Next;
        End;
      Finally
        FreeAndNil(qryTabela);
      End;
    End
  End;
End;


procedure TfrmTabelasDoItemFrame.pSetBlnRecolher(const Value: boolean);
begin
  FRecolher := Value;
  pAjustaVisibilidade;
end;

procedure TfrmTabelasDoItemFrame.btnExpandClick(Sender: TObject);
begin
  Self.blnRecolher := Not Self.blnRecolher;
  btnExpand.Visible := Self.blnRecolher;
  btnCollapse.Visible := Not Self.blnRecolher;
  TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxvPrecos, IIf(blnFormacaoPreco, '_formPreco', ''));

end;

procedure TfrmTabelasDoItemFrame.cxvPrecosKeyPress(Sender: TObject;
  var Key: Char);
  var qryConAbf: TUniQuery;
      arrSel: TConsultasArray;
      strValOri: String;


begin
  If Key = '/' Then
  begin
{    If Not (TcxDBVerticalGrid(Sender).DataController.DataSource.DataSet.State in dsEditModes) Then
      If cxvPrecos.OptionsData.Editing Then
        TcxDBVerticalGrid(Sender).DataController.DataSource.DataSet.Edit;}

    If Not (objTabelas.cdsDados.State in dsEditModes) Then
    Begin
      If FblnInclusao then
        objTabelas.cdsDados.Edit
      else
      begin
        Key := #0;
        Exit;
      end;
    End;

    If TcxDBVerticalGrid(Sender).FocusedRow = cxvPrecosCODABF Then
    Begin
      qryConAbf := fCriaQuery;
      Try
        strValOri := objTabelas.cdsDados.FieldByName('ITE_CODABF').AsString;
        If fPesqAbrevFiscal(TForm(Self.Owner), nil, nil, qryConAbf, Key, arrSel, True) Then
        begin
          objTabelas.cdsDados.FieldByName('ITE_CODABF').AsString := qryConAbf.FieldByName('ABF_CODABF').AsString;
          objTabelas.cdsDados.Post;

        End;
      Finally
        FreeAndNil(qryConAbf);
        Key := #0;
      End;
    End;
  End;


  pProcessaKeyPressTabFornecedor(Sender, Key);

end;

procedure TfrmTabelasDoItemFrame.cxvPrecosMARBRUEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fEmptyStr(DisplayValue) Then
    DisplayValue := 0;

  If Not objTabelas.fValidaMargem(fStrToFloat(DisplayValue),
                              objTabelas.cdsDados.FieldByName('ITE_COMTBL').AsFloat) Then
  Begin
    ErrorText := '';
    Error := True;
  End;

end;

procedure TfrmTabelasDoItemFrame.cxvPrecosPRECOMEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin

  If fStrToFloat(DisplayValue) <= 0 Then
  Begin
    ErrorText := '';
    Error := True;
    pMensagemOk('O preço de compra deve ser maior que zero!');
  End;
end;

procedure TfrmTabelasDoItemFrame.cxvPrecosPRECOMPropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
  AText :=  AText + '    '
end;

procedure TfrmTabelasDoItemFrame.cxvPrecosPREVENEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin

  If fStrToFloat(DisplayValue) <= 0 Then
  Begin
    ErrorText := '';
    Error := True;
    pMensagemOk('O Preço de Venda deve ser maior que zero!');
    Exit;
  End;

  If Not objTabelas.fValidaMargem(objTabelas.cdsDados.FieldByName('ITE_MARBRU').AsFloat,
                                  objTabelas.cdsDados.FieldByName('ITE_COMTBL').AsFloat) Then
  Begin
    ErrorText := '';
    Error := True;
  End;
end;


procedure TfrmTabelasDoItemFrame.cxvPrecosPRO_MARGEMPropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
 If Not fEmptyStr(AText) Then
  If StrToFloat(AText) = 0 Then
    AText := '';
end;

procedure TfrmTabelasDoItemFrame.cxvPrecosPRO_PREVENPropertiesGetDisplayText(
  Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
begin
 If Not fEmptyStr(AText) Then
  If StrToFloat(AText) = 0 Then
    AText := '';

end;

Procedure TfrmTabelasDoItemFrame.pInicializaDados(qryCadIte, qryIteger: TDataSet; AblnFormacaoPreco: Boolean = False; dts: TDataSource = nil);
var intDecUni: integer;
Begin
  If Assigned(dts) Then
    cxvPrecos.DataController.DataSource := dts
  Else
    cxvPrecos.DataController.DataSource := objTabelas.cdsDados.dtsSource;

  blnFormacaoPreco:= AblnFormacaoPreco;
  If fCfgSis('PCMPRO') = '1' Then
    cxvPrecosCOMTBL.Visible := False;

  cxvPrecosPREDOL.Visible := objTabelas.blnCotDor;
  cxvPrecosVENDOL.Visible := objTabelas.blnCotDor;

  cxvPrecosTCIFCU.Visible := (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4');
  cxvPrecosTSCUST.Visible := cxvPrecosTCIFCU.Visible;
  cxvPrecosDEPICO.Visible := cxvPrecosTCIFCU.Visible;
  cxvPrecosDEICMS.Visible := cxvPrecosTCIFCU.Visible;
  cxvPrecosFATREG.Visible := cxvPrecosTCIFCU.Visible;

  cxvPrecosDESADB.Properties.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')   ';
  cxvPrecosVALFRE.Properties.Caption := fCfgSis('DESVFR') + ' (+)   ';
  cxvPrecosOUTVAL.Properties.Caption := fCfgSis('DOVCPP') + ' (+)   ';
  cxvPrecosCOMTBL.Properties.Caption := fCfgSis('TCOMTB') + '   ';

  cxdUltimoAtivo := fUltimoCampoPrecoAtivo;
  FRecolher := False;
  pAlimentaVisibilidadePadrao;

  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxvPrecos, Self.Name + IIf(AblnFormacaoPreco, '_formPreco', ''));
  FRecolher := Not cxvPrecosDESF01.Visible;
  btnCollapse.Visible := Not FRecolher;
  btnExpand.Visible := FRecolher;

  cxvPrecosPREREV.Visible := False;
  cxvPrecosDESREV.Visible := False;
  cxvPrecosMARGIR.Visible := False;
  cxvPrecosVENGIR.Visible := False;
  cxvPrecosCUSATI.Visible := False;
  cxvPrecosPREEMB.Visible := False;

  pnlLegenda.Visible := False;
  cxvPrecosGiro.Visible := False;
  If blnFormacaoPreco Then
  Begin
    intDecUni := fCfgSis('DECUNI', varInteger);
    If intDecUni <= 0 Then
      intDecUni := 2;

    cxvPrecosPREEMB.Visible := True;

    cxvPrecosPREEMB.Properties.DataBinding.FieldName := 'ITE_PRECOM';
    cxvPrecosPRECOM.Properties.DataBinding.FieldName := 'CNV_PRECOM';
    cxvPrecosOUTVAL.Properties.DataBinding.FieldName := 'CNV_OUTVAL';
    cxvPrecosVALFRE.Properties.DataBinding.FieldName := 'CNV_VALFRE';
    cxvPrecosPREVEN.Properties.DataBinding.FieldName := 'CNV_PREVEN';
    cxvPrecosVENGIR.Properties.DataBinding.FieldName := 'CNV_VENGIR';
    cxvPrecosCUSREA.Properties.DataBinding.FieldName := 'CNV_CUSREA';
    cxvPrecosCOMLIQ.Properties.DataBinding.FieldName := 'CNV_COMLIQ';
    cxvPrecosPRECUS.Properties.DataBinding.FieldName := 'CNV_PRECUS';

    cxvPrecosPREVEN.Properties.DataBinding.FieldName := 'CNV_PREVEN';
    TcxCurrencyEditProperties(cxvPrecosPREVEN.Properties.EditProperties).DecimalPlaces := intDecUni;

    cxvPrecosGiro.Visible := True;
    cxvPrecosTabFornecedor.Visible := False;
    cxvPrecosDBEditorRow2.Visible := False;
    cxvPrecosAbreviacaoICMS.Visible := False;
    pnlLegenda.Visible := True;
    cxvPrecosCODABF.Visible := False;
    cxvPrecosIVA.Visible := False;
    cxvPrecosPromocao.Visible := False;
    cxvPrecosPRO_MARGEM.Visible := False;
    cxvPrecosPRO_PREVEN.Visible := False;
    cxvPrecosMARGIR.Visible := True;
    cxvPrecosVENGIR.Visible := True;

    cxvPrecosTabFornecedor.Properties.Options.Editing := True;
    cxvPrecosPREDOL.Properties.Options.Editing := True;
    cxvPrecosCUSATI.Visible := True;
    cxvPrecosPREEMB.Properties.Options.Editing := True;
    cxvPrecosPRECOM.Properties.Options.Editing := True;
    cxvPrecosDESF01.Properties.Options.Editing := True;
    cxvPrecosDESF02.Properties.Options.Editing := True;
    cxvPrecosDESF03.Properties.Options.Editing := True;
    cxvPrecosDESF04.Properties.Options.Editing := True;
    cxvPrecosDESF05.Properties.Options.Editing := True;
    cxvPrecosDESF06.Properties.Options.Editing := True;
    cxvPrecosICMENT.Properties.Options.Editing := False;
    cxvPrecosIPIENT.Properties.Options.Editing := True;
    cxvPrecosFREENT.Properties.Options.Editing := True;
    cxvPrecosVALFRE.Properties.Options.Editing := True;
    cxvPrecosACRFIN.Properties.Options.Editing := True;
    cxvPrecosSUBSTI.Properties.Options.Editing := False;
    cxvPrecosDESADB.Properties.Options.Editing := True;
    cxvPrecosTCIFCU.Properties.Options.Editing := True;
    cxvPrecosTSCUST.Properties.Options.Editing := True;
    cxvPrecosDEPICO.Properties.Options.Editing := True;
    cxvPrecosDEICMS.Properties.Options.Editing := True;
    cxvPrecosFATREG.Properties.Options.Editing := True;

    cxvPrecosSUBFED.Properties.Options.Editing := True;
    cxvPrecosIMPFED.Properties.Options.Editing := True;
    cxvPrecosICMSAI.Properties.Options.Editing := True;
    cxvPrecosDESOPE.Properties.Options.Editing := True;
    cxvPrecosOUTVAL.Properties.Options.Editing := True;
    cxvPrecosPREREV.Properties.Options.Editing := False;
    cxvPrecosDESREV.Properties.Options.Editing := False;

    cxvPrecosCODABF.Properties.Options.Editing := False;
    cxvPrecosMARBRU.Properties.Options.Editing := not False;
    cxvPrecosPREVEN.Properties.Options.Editing := not False;

    cxvPrecosPRO_MARGEM.Properties.Options.Editing := False;
    cxvPrecosPRO_PREVEN.Properties.Options.Editing := False;

  End;


End;


procedure TfrmTabelasDoItemFrame.AddArrVisibilidadePadrao(ACompName: String; ADefVisible: Boolean; APosition: Integer);
begin

  FArrVisibilidadePadrao[APosition].Name := ACompName;
  FArrVisibilidadePadrao[APosition].VisibilidadePadrao := ADefVisible;
End;

procedure TfrmTabelasDoItemFrame.pAjustaVisibilidade;
begin

{  cxvPrecosTABELA: TcxDBEditorRow;
  cxvPrecosTabFornecedor: TcxDBEditorRow;
  cxvPrecosAbreviacaoICMS: TcxCategoryRow;
  cxvPrecosCODABF: TcxDBEditorRow;
  cxvPrecosDBEditorRow2.Visible := fSetVisibleComponent(cxvPrecosDBEditorRow2.Name);
  cxvPrecosDBEditorRow3.Visible := fSetVisibleComponent(cxvPrecosDBEditorRow3.Name);
  }
//  cxvPrecosCategoryRow1.Visible := fSetVisibleComponent(cxvPrecosCategoryRow1.Name);
//  cxvPrecosPRECOM.Visible := fSetVisibleComponent(cxvPrecosPRECOM.Name);
  cxvPrecosPREDOL.Visible := fSetVisibleComponent(cxvPrecosPREDOL.Name);
  cxvPrecosDESF01.Visible := fSetVisibleComponent(cxvPrecosDESF01.Name);
  cxvPrecosDESF02.Visible := fSetVisibleComponent(cxvPrecosDESF02.Name);
  cxvPrecosDESF03.Visible := fSetVisibleComponent(cxvPrecosDESF03.Name);
  cxvPrecosDESF04.Visible := fSetVisibleComponent(cxvPrecosDESF04.Name);
  cxvPrecosDESF05.Visible := fSetVisibleComponent(cxvPrecosDESF05.Name);
  cxvPrecosDESF06.Visible := fSetVisibleComponent(cxvPrecosDESF06.Name);
//  cxvPrecosCOMLIQ.Visible := fSetVisibleComponent(cxvPrecosCOMLIQ.Name);
//  cxvPrecosCatPreCus.Visible := fSetVisibleComponent(cxvPrecosCatPreCus.Name);
  cxvPrecosICMENT.Visible := fSetVisibleComponent(cxvPrecosICMENT.Name);
  cxvPrecosSUBFED.Visible := fSetVisibleComponent(cxvPrecosSUBFED.Name);
  cxvPrecosIPIENT.Visible := fSetVisibleComponent(cxvPrecosIPIENT.Name);
  cxvPrecosFREENT.Visible := fSetVisibleComponent(cxvPrecosFREENT.Name);
  cxvPrecosVALFRE.Visible := fSetVisibleComponent(cxvPrecosVALFRE.Name);
  cxvPrecosACRFIN.Visible := fSetVisibleComponent(cxvPrecosACRFIN.Name);
  cxvPrecosSUBSTI.Visible := fSetVisibleComponent(cxvPrecosSUBSTI.Name);
  cxvPrecosDESADB.Visible := fSetVisibleComponent(cxvPrecosDESADB.Name);
  cxvPrecosTCIFCU.Visible := fSetVisibleComponent(cxvPrecosTCIFCU.Name);
  cxvPrecosTSCUST.Visible := fSetVisibleComponent(cxvPrecosTSCUST.Name);
  cxvPrecosDEPICO.Visible := fSetVisibleComponent(cxvPrecosDEPICO.Name);
  cxvPrecosDEICMS.Visible := fSetVisibleComponent(cxvPrecosDEICMS.Name);
  cxvPrecosFATREG.Visible := fSetVisibleComponent(cxvPrecosFATREG.Name);
//  cxvPrecosPRECUS.Visible := fSetVisibleComponent(cxvPrecosPRECUS.Name);
  cxvPrecosOUTVAL.Visible := fSetVisibleComponent(cxvPrecosOUTVAL.Name);
  cxvPrecosICMSAI.Visible := fSetVisibleComponent(cxvPrecosICMSAI.Name);
  cxvPrecosIMPFED.Visible := fSetVisibleComponent(cxvPrecosIMPFED.Name);
  cxvPrecosDESOPE.Visible := fSetVisibleComponent(cxvPrecosDESOPE.Name);
//  cxvPrecosCUSREA.Visible := fSetVisibleComponent(cxvPrecosCUSREA.Name);
//  cxvPrecosCatPreVen.Visible := fSetVisibleComponent(cxvPrecosCatPreVen.Name);
//  cxvPrecosMARBRU.Visible := fSetVisibleComponent(cxvPrecosMARBRU.Name);
  cxvPrecosMARMK3.Visible := fSetVisibleComponent(cxvPrecosMARMK3.Name);
  cxvPrecosCOMTBL.Visible := fSetVisibleComponent(cxvPrecosCOMTBL.Name);
//  cxvPrecosPREVEN.Visible := fSetVisibleComponent(cxvPrecosPREVEN.Name);
  cxvPrecosVENDOL.Visible := fSetVisibleComponent(cxvPrecosVENDOL.Name);
  cxvPrecosCatMarIde.Visible := fSetVisibleComponent(cxvPrecosCatMarIde.Name);
{  cxvPrecosMARIDE.Visible := fSetVisibleComponent(cxvPrecosMARIDE.Name);
  cxvPrecosPREIDE.Visible := fSetVisibleComponent(cxvPrecosPREIDE.Name);}
//  cxvPrecosPromocao.Visible := fSetVisibleComponent(cxvPrecosPromocao.Name);
{  cxvPrecosPRO_MARGEM.Visible := fSetVisibleComponent(cxvPrecosPRO_MARGEM.Name);
  cxvPrecosPRO_PREVEN.Visible := fSetVisibleComponent(cxvPrecosPRO_PREVEN.Name);}

  If blnFormacaoPreco Then
  Begin
    cxvPrecosTabFornecedor.Visible := False;
    cxvPrecosDBEditorRow2.Visible := False;
    cxvPrecosAbreviacaoICMS.Visible := False;
    cxvPrecosCODABF.Visible := False;
    cxvPrecosIVA.Visible := False;

    cxvPrecosPromocao.Visible := False;
    cxvPrecosPRO_MARGEM.Visible := False;
    cxvPrecosPRO_PREVEN.Visible := False;
  End;


end;

function  TfrmTabelasDoItemFrame.fSetVisibleComponent(AName: String): Boolean;
begin
  If Not FRecolher Then
    If not fPodeTornarVisivel(AName) Then
      Exit(False);
  Result := Not FRecolher;
End;

function  TfrmTabelasDoItemFrame.fPodeTornarVisivel(AName: String): Boolean;
var i: TVisibilidadePadrao;
Begin
  Result := True;
  for i in FArrVisibilidadePadrao Do
  Begin
    If i.Name = AName then
    Begin
      If not i.VisibilidadePadrao Then
        Exit(False);
    End;
  End;
End;


Procedure TfrmTabelasDoItemFrame.pAlimentaVisibilidadePadrao;
var i: Integer;
begin
  SetLength(FArrVisibilidadePadrao, cxvPrecos.Rows.Count);
  For i := 0 To cxvPrecos.Rows.Count -1 do
  Begin
    AddArrVisibilidadePadrao(cxvPrecos.Rows[i].Name,
                             cxvPrecos.Rows[i].Visible, i);
  End;
  FRecolher := False;
End;


procedure TfrmTabelasDoItemFrame.pGerenciaEdicaoIcmsSaida(blnEdicao: Boolean);
begin
  cxvPrecosICMSAI.Properties.Options.Editing := blnEdicao;
end;

procedure TfrmTabelasDoItemFrame.pGerenciaEdicaoImpostosFederais(
  blnEdicao: Boolean);
begin
  Try
    cxvPrecosSUBFED.Properties.Options.Editing := blnEdicao;
    cxvPrecosIMPFED.Properties.Options.Editing := blnEdicao;
  Except
  End;
end;

Procedure TfrmTabelasDoItemFrame.pHabilitaCampos(blnInclusao: Boolean; blnPreMat: Boolean; blnAlteracao: Boolean);
Begin
  cxvPrecosTabFornecedor.Properties.Options.Editing := blnInclusao;
  cxvPrecosPREDOL.Properties.Options.Editing := blnInclusao;
  cxvPrecosPRECOM.Properties.Options.Editing := blnInclusao;
  cxvPrecosDESF01.Properties.Options.Editing := blnInclusao;
  cxvPrecosDESF02.Properties.Options.Editing := blnInclusao;
  cxvPrecosDESF03.Properties.Options.Editing := blnInclusao;
  cxvPrecosDESF04.Properties.Options.Editing := blnInclusao;
  cxvPrecosDESF05.Properties.Options.Editing := blnInclusao;
  cxvPrecosDESF06.Properties.Options.Editing := blnInclusao;
  cxvPrecosICMENT.Properties.Options.Editing := False;
  cxvPrecosIPIENT.Properties.Options.Editing := blnInclusao;
  cxvPrecosFREENT.Properties.Options.Editing := blnInclusao;
  cxvPrecosVALFRE.Properties.Options.Editing := blnInclusao;
  cxvPrecosACRFIN.Properties.Options.Editing := blnInclusao;
  cxvPrecosSUBSTI.Properties.Options.Editing := False;
  cxvPrecosDESADB.Properties.Options.Editing := blnInclusao;
  cxvPrecosTCIFCU.Properties.Options.Editing := blnInclusao;
  cxvPrecosTSCUST.Properties.Options.Editing := blnInclusao;
  cxvPrecosDEPICO.Properties.Options.Editing := blnInclusao;
  cxvPrecosDEICMS.Properties.Options.Editing := blnInclusao;
  cxvPrecosFATREG.Properties.Options.Editing := blnInclusao;

  cxvPrecosSUBFED.Properties.Options.Editing := False;
  cxvPrecosIMPFED.Properties.Options.Editing := False;
  cxvPrecosICMSAI.Properties.Options.Editing := False;
  cxvPrecosDESOPE.Properties.Options.Editing := False;
  cxvPrecosOUTVAL.Properties.Options.Editing := False;

  cxvPrecosCODABF.Properties.Options.Editing := blnInclusao;
  If blnAlteracao Then
  Begin
    cxvPrecosMARBRU.Properties.Options.Editing := not blnPreMat;
    cxvPrecosPREVEN.Properties.Options.Editing := not blnPreMat;
  End;

  cxvPrecosPRO_MARGEM.Properties.Options.Editing := False;
  cxvPrecosPRO_PREVEN.Properties.Options.Editing := False;


  FblnInclusao := blnInclusao;
End;

end.


