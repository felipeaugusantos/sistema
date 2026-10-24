unit untAltEfetivacaoSelec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls,
  untAltEfetivacaoManut, untFuncoesSimples, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxCurrencyEdit, cxGridBandedTableView, cxGridDBBandedTableView,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmAltEfetivacaoSelec = class(TfrmPaiEdit)
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBBandedTableView;
    cxgItensCODITE: TcxGridDBBandedColumn;
    cxgItensDESITE: TcxGridDBBandedColumn;
    cxgItensPRECOM: TcxGridDBBandedColumn;
    cxgItensDESF01: TcxGridDBBandedColumn;
    cxgItensDESF02: TcxGridDBBandedColumn;
    cxgItensDESF03: TcxGridDBBandedColumn;
    cxgItensDESF04: TcxGridDBBandedColumn;
    cxgItensDESF05: TcxGridDBBandedColumn;
    cxgItensDESF06: TcxGridDBBandedColumn;
    cxgItensICMENT: TcxGridDBBandedColumn;
    cxgItensSUBFED: TcxGridDBBandedColumn;
    cxgItensIPIENT: TcxGridDBBandedColumn;
    cxgItensFREENT: TcxGridDBBandedColumn;
    cxgItensVALFRE: TcxGridDBBandedColumn;
    cxgItensSUBSTI: TcxGridDBBandedColumn;
    cxgItensACRFIN: TcxGridDBBandedColumn;
    cxgItensDESADB: TcxGridDBBandedColumn;
    cxgItensPRECUS: TcxGridDBBandedColumn;
    cxgItensOUTVAL: TcxGridDBBandedColumn;
    cxgItensICMSAI: TcxGridDBBandedColumn;
    cxgItensIMPFED: TcxGridDBBandedColumn;
    cxgItensDESOPE: TcxGridDBBandedColumn;
    cxgItensMARBR1: TcxGridDBBandedColumn;
    cxgItensCOMTB1: TcxGridDBBandedColumn;
    cxgItensPREVE1: TcxGridDBBandedColumn;
    cxgItensMARBR2: TcxGridDBBandedColumn;
    cxgItensCOMTB2: TcxGridDBBandedColumn;
    cxgItensPREVE2: TcxGridDBBandedColumn;
    cxgItensMARBR3: TcxGridDBBandedColumn;
    cxgItensCOMTB3: TcxGridDBBandedColumn;
    cxgItensPREVE3: TcxGridDBBandedColumn;
    cxgItensMARBR4: TcxGridDBBandedColumn;
    cxgItensCOMTB4: TcxGridDBBandedColumn;
    cxgItensPREVE4: TcxGridDBBandedColumn;
    cxgItensMARBR5: TcxGridDBBandedColumn;
    cxgItensCOMTB5: TcxGridDBBandedColumn;
    cxgItensPREVE5: TcxGridDBBandedColumn;
    cxgItensMARBR6: TcxGridDBBandedColumn;
    cxgItensCOMTB6: TcxGridDBBandedColumn;
    cxgItensPREVE6: TcxGridDBBandedColumn;
    cxgItensMARBR7: TcxGridDBBandedColumn;
    cxgItensCOMTB7: TcxGridDBBandedColumn;
    cxgItensPREVE7: TcxGridDBBandedColumn;
    cxgItensMARCAD: TcxGridDBBandedColumn;
    cxgItensPROPRI: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgItensViewColumn1: TcxGridDBBandedColumn;
    cxgItensViewCUSREA: TcxGridDBBandedColumn;
    btnGravaAteracoes: TBitBtnLocked;
    pnlLegenda: TPanel;
    shpAltera: TShape;
    Label1: TLabel;

    procedure btnGravarClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure cxgItensMARBR1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensMARBR1PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgItensPREVE1PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravaAteracoesClick(Sender: TObject);
  private
    { Private declarations }

    strMarMkp,
    strMsgErroMargem: String;

    function fValidaMargem(fltMargem: Double; intTabPreco: Integer): Boolean;

  public
    { Public declarations }

    objAltEfe: TAltEfetivacaoManut;
  end;

var
  frmAltEfetivacaoSelec: TfrmAltEfetivacaoSelec;

implementation

{$R *.dfm}

Uses
  StrUtils,
  System.UITypes;

procedure TfrmAltEfetivacaoSelec.btnMarDesClick(Sender: TObject);
begin
  inherited;

  objAltEfe.pMarcaDesmarca;
end;

procedure TfrmAltEfetivacaoSelec.cxgItensMARBR1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Assigned(objAltEfe) Then
    If objAltEfe.blnAlteraPreco Then
  Begin
    ACanvas.Brush.Color := shpAltera.Brush.Color;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmAltEfetivacaoSelec.cxgItensMARBR1PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    fltMargem: Double;
begin
  inherited;

  fltMargem := fStrToFloat(DisplayValue, 0);

  objAltEfe.intTabPre := StrToIntDef(TcxGridDBBandedColumn(cxgItensView.Controller.FocusedColumn).DataBinding.FieldName[10], 1);

  If Pos(strMarMkp, '1_5_') > 0 Then
  Begin

    If Not fValidaMargem(fltMargem, objAltEfe.intTabPre) Then
    Begin
      Error := True;
      ErrorText := '';
      Exit;
    End;

  End;

  objAltEfe.intPreMar := 1;
end;

procedure TfrmAltEfetivacaoSelec.cxgItensPREVE1PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    fltPreco: Double;
begin
  inherited;

  fltPreco := fStrToFloat(DisplayValue, 0);

  objAltEfe.intTabPre := StrToIntDef(TcxGridDBBandedColumn(cxgItensView.Controller.FocusedColumn).DataBinding.FieldName[10], 1);

  If fltPreco <= 0 Then
  Begin
    pMensagemOk('O Preço de Venda ' + IntToStr(objAltEfe.intTabPre) + ' deve ser maior que zero!');

    Error := True;
    ErrorText := '';
    Exit;
  End;

  objAltEfe.intPreMar := 2;
end;

function TfrmAltEfetivacaoSelec.fValidaMargem(fltMargem: Double; intTabPreco: Integer): Boolean;
  Var
    fltComissao,
    fltImpFed,
    fltIcmSai,
    fltDesOpe: Double;
begin
  fltComissao := objAltEfe.FieldByName('PRE_COMTB' + intTabPreco.ToString).AsFloat;
  fltImpFed   := objAltEfe.FieldByName('PRE_IMPFED').AsFloat;
  fltIcmSai   := objAltEfe.FieldByName('PRE_ICMSAI').AsFloat;
  fltDesOpe   := objAltEfe.FieldByName('PRE_DESOPE').AsFloat;;

  Result := Not (fltMargem +
                 fltComissao +
                 fltIcmSai +
                 fltImpFed +
                 fltDesOpe > 100);

  If Not Result Then
    pMensagemOk(strMsgErroMargem);
End;

procedure TfrmAltEfetivacaoSelec.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensMARCAD.Index]) = 'S' Then
  Begin

    ACanvas.Brush.Color := clMoneyGreen;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;

  End


end;

procedure TfrmAltEfetivacaoSelec.btnGravaAteracoesClick(Sender: TObject);
begin
  inherited;

  If Not btnGravaAteracoes.Visible Then
    Exit;

  If Not objAltEfe.fValidaMargemNegativa Then
    Exit;

  If fPergunta('Confirma a gravação das alterações?' + #13#10 +
               '(Após a gravacão os preços ainda continuarão pendentes para efetivação)') And
     objAltEfe.fSalva('Atualizando modificações, aguarde...') Then
    pMensagemOk('Dados salvos com sucesso!');

end;

procedure TfrmAltEfetivacaoSelec.btnGravarClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Confirma a exclusão dos registros selecionados?') Then
  Begin
    If objAltEfe.fApagaMarcados Then
    Begin
      pMensagemOk('Operação concluida com sucesso!');

      objAltEfe.fConsultaItens;

      cxgItensView.NavigatorButtons.First.Click;

      If objAltEfe.IsEmpty Then
        Close;
    End;
  End;
end;

procedure TfrmAltEfetivacaoSelec.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  objAltEfe.pMarcaTodos(False);
end;

procedure TfrmAltEfetivacaoSelec.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  objAltEfe.pMarcaTodos(True);
end;

procedure TfrmAltEfetivacaoSelec.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult <> mrOk Then
  Begin

    If objAltEfe.State = dsEdit Then
    Begin
      objAltEfe.Cancel;
      Action := caNone;
      Exit;
    End

    Else If Not fPergunta('Deseja abandonar a tarefa?') Then
    Begin
      Action := caNone;
      Exit;
    End;

  End;

end;

procedure TfrmAltEfetivacaoSelec.FormCreate(Sender: TObject);
  Var
    intDecUni,
    intContador: Integer;
begin
  inherited;

  intDecUni := fCfgSis('DECUNI', varInteger);

  cxgItensOUTVAL.Caption := fCfgSis('DOVCPP');
  cxgItensDESADB.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';

  TcxCurrencyEditProperties(cxgItensPREVE1.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxgItensPREVE1.Properties).DisplayFormat := ',0.' + fStrZero('0', intDecUni) + ';-,0.' + fStrZero('0', intDecUni);

  TcxCurrencyEditProperties(cxgItensPREVE2.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxgItensPREVE2.Properties).DisplayFormat := ',0.' + fStrZero('0', intDecUni) + ';-,0.' + fStrZero('0', intDecUni);

  TcxCurrencyEditProperties(cxgItensPREVE3.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxgItensPREVE3.Properties).DisplayFormat := ',0.' + fStrZero('0', intDecUni) + ';-,0.' + fStrZero('0', intDecUni);

  TcxCurrencyEditProperties(cxgItensPREVE4.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxgItensPREVE4.Properties).DisplayFormat := ',0.' + fStrZero('0', intDecUni) + ';-,0.' + fStrZero('0', intDecUni);

  TcxCurrencyEditProperties(cxgItensPREVE5.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxgItensPREVE5.Properties).DisplayFormat := ',0.' + fStrZero('0', intDecUni) + ';-,0.' + fStrZero('0', intDecUni);

  TcxCurrencyEditProperties(cxgItensPREVE6.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxgItensPREVE6.Properties).DisplayFormat := ',0.' + fStrZero('0', intDecUni) + ';-,0.' + fStrZero('0', intDecUni);

  TcxCurrencyEditProperties(cxgItensPREVE7.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxgItensPREVE7.Properties).DisplayFormat := ',0.' + fStrZero('0', intDecUni) + ';-,0.' + fStrZero('0', intDecUni);

  cxgItensVALFRE.Caption := fCfgSis('DESVFR');

  For intContador := 1 To 7 Do
  If Not SameText(VS_strTabPrc[intContador], 'S') Then
  Begin
    Case intContador Of
      1: Begin
           cxgItensMARBR1.Visible := False;
           cxgItensCOMTB1.Visible := False;
           cxgItensPREVE1.Visible := False;
         End;

      2: Begin
           cxgItensMARBR2.Visible := False;
           cxgItensCOMTB2.Visible := False;
           cxgItensPREVE2.Visible := False;
         End;

      3: Begin
           cxgItensMARBR3.Visible := False;
           cxgItensCOMTB3.Visible := False;
           cxgItensPREVE3.Visible := False;
         End;

      4: Begin
           cxgItensMARBR4.Visible := False;
           cxgItensCOMTB4.Visible := False;
           cxgItensPREVE4.Visible := False;
         End;

      5: Begin
           cxgItensMARBR5.Visible := False;
           cxgItensCOMTB5.Visible := False;
           cxgItensPREVE5.Visible := False;
         End;

      6: Begin
           cxgItensMARBR6.Visible := False;
           cxgItensCOMTB6.Visible := False;
           cxgItensPREVE6.Visible := False;
         End;

      7: Begin
           cxgItensMARBR7.Visible := False;
           cxgItensCOMTB7.Visible := False;
           cxgItensPREVE7.Visible := False;
         End;
    End;

  End;

  cxgItensView.NavigatorButtons.First.Click;
end;

procedure TfrmAltEfetivacaoSelec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6    : btnMarcaTodos.Click;
    VK_F7    : btnDesmarcaTodos.Click;
    VK_F8    : btnGravar.Click;
    VK_F10   : btnGravaAteracoes.Click;
  End;
end;

procedure TfrmAltEfetivacaoSelec.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  Case Key Of
    ' ': btnMarDes.Click;
  End;

end;

procedure TfrmAltEfetivacaoSelec.FormShow(Sender: TObject);
begin
  inherited;

  strMarMkp := fCfgSis('MARMKP');

  pnlLegenda.Visible        := objAltEfe.blnAlteraPreco;
  btnGravaAteracoes.Visible := objAltEfe.blnAlteraPreco;

  cxgItensView.OptionsData.Editing := objAltEfe.blnAlteraPreco;

  strMsgErroMargem := 'A soma do ( ICMS Saída + Impostos Federais + Despesas Operacionais + Margem Bruta ' + IIF(fCfgSis('PCMPRO') = '2', '+ Comissão ', '') + '  ) não pode ser superior a 100%.';
end;

end.
