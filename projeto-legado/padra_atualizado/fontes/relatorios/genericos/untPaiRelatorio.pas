unit untPaiRelatorio;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, Buttons, ExtCtrls, Printers, EditFocus,
  MaskEditFocus, QColorLabel, Menus, RLFilters, RLDraftFilter, RLReport,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, frxADOComponents, Uni,
  frxDesgn, StrUtils, AppEvnts, BitBtnLockedIncrem, Mask,
  frxExportCSVTestabilidade;

type
  TfrmPaiRelatorio = class(TfrmPai)
    btnImprimir: TBitBtnLocked;
    pnlDados: TPanel;
    gpbDestino: TGroupBox;
    edtDestino: TEditFocus;
    ColorLabel1: TColorLabel;
    rldFiltro: TRLDraftFilter;
    frxExpRTF: TfrxRTFExport;
    frxExpXLS: TfrxXLSExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpPDF: TfrxPDFExport;
    frxMatricial: TfrxDotMatrixExport;
    frxRelatorio: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxDesigner: TfrxDesigner;
    frxComandos: TfrxUserDataSet;
    shpMultSel: TShape;
    btnConfigurar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure frxGenGetValue(const VarName: String; var Value: Variant);
    procedure frxComandosGetValue(const VarName: String;
      var Value: Variant);
    procedure FormActivate(Sender: TObject);
  private
    Const
      TFocusedTypes : array[0..4] of TWinControlClass = (TEdit, TRadioButton, TCheckBox, TComboBox, TMaskEdit );

  protected
    procedure pTabelaVazia;
    procedure pSetaFocusPrimeiroCampo(ctlContainer: TWinControl);    
  public
    { Public declarations }
    blnExcel  : Boolean;
    blnImprime: Boolean;
    strTipImp : String;
    strNomImp : String;
    intCount  : Integer;
    strFilRel : String;
    blnPerFil : Boolean;
  end;

Const
  MSG_IMPINVALIDA = 'Houve um erro ao enviar o relatório para a impressora.' + #13#10 +
                    'Verifique se a impressora selecionada é válida ou seu nome está digitado corretamente.';

var
  frmPaiRelatorio: TfrmPaiRelatorio;

implementation

uses untFuncoesFactory, untIFuncoes, untCadConfRelatorios, untModulo, untCfgRel;

{$R *.dfm}

{ TfrmPaiRelatorio }


procedure TfrmPaiRelatorio.pSetaFocusPrimeiroCampo(ctlContainer: TWinControl);
  function MatchClass(const AClass : TComponent; const AValues : array of TWinControlClass) : Boolean;
  var
    intCorre: Integer;
  begin
    Result := False;
    for intCorre := Low(AValues) to High(AValues) do
      if (AClass is AValues[intCorre]) then
      begin
        Result := True;
        Break;
      end;
  end;

  Var
    intCorre : Integer;
    intTabOrder : Integer;
Begin
  intTabOrder  := 0;
  For intCorre := 0 to ctlContainer.ControlCount - 1 do
  Begin
    If TWinControl(ctlContainer.Controls[intCorre]).TabOrder = intTabOrder Then
    Begin

      if MatchClass(ctlContainer.Controls[intCorre], TFocusedTypes) then
      Begin
        If TWinControl(ctlContainer.Controls[intCorre]).CanFocus Then
        Begin
          pSetFocus(TWinControl(ctlContainer.Controls[intCorre]));
          Break;
        End
        Else
          Inc(intTabOrder);
      End;

      if (ctlContainer.Controls[intCorre] is TRadioGroup) Then
      Begin
        pSetFocus(TRadioGroup(ctlContainer.Controls[intCorre]).Buttons[TRadioGroup(ctlContainer.Controls[intCorre]).ItemIndex]);
        Break;
      End;

      if (ctlContainer.Controls[intCorre] is TCustomPanel) Or
         (ctlContainer.Controls[intCorre] is TGroupBox) Then
      Begin
        pSetaFocusPrimeiroCampo(TCustomPanel(ctlContainer.Controls[intCorre]));
        Break;
      End;

    End;

  End;

end;

procedure TfrmPaiRelatorio.pTabelaVazia;
begin
  fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);
end;

procedure TfrmPaiRelatorio.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaConfImpr(qryCfgRel, Self.Name);

  {***************************************}
  {* POSICIONA O SHAPE Q IDENTIFICA SE O *}
  {* RELATÓRIO POSSUI CONSULTAS COM      *}
  {* MULTISELEÇÃO                        *}
  {***08/02/2008***********************ER*}
  shpMultSel.Left := pnlInfo.Width - shpMultSel.Width;
end;

procedure TfrmPaiRelatorio.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);

    If fEmptyStr(strFilRel) Then
      frmCadConfRelatorios.strNomeForm   := Self.Name
    Else
      frmCadConfRelatorios.strNomeForm   := strFilRel;

    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmPaiRelatorio.btnConfigurarClick]');
    End;
  End;
  pFreeAndNil(frmCadConfRelatorios);
  pCarregaConfImpr(qryCfgRel, Self.Name);
end;

procedure TfrmPaiRelatorio.btnImprimirClick(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;

  Try
    btnImprimir.Enabled := False;
    blnImprime := fVerificaCampos;

    If blnImprime Then
    begin
      If (blnPerFil) Then
      Begin
        pCarregaConfImpr(qryCfgRel, Self.Name);
        blnImprime := fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, edtDestino.Text);
      End;
    End;

    {**************************************}
    {* VERIFICA SE EXISTE UM FRX... PARA  *}
    {* MODIFICACOES PADROES               *}
    {***********************************AF*}
    If blnImprime Then
    Begin

      For intContador := 0 To Self.ComponentCount -1 Do
      Begin

        If Self.Components[intContador] Is TfrxReport Then
        Begin
          (Self.Components[intContador] As TfrxReport).PrintOptions.Printer   := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
          (Self.Components[intContador] As TfrxReport).PreviewOptions.Buttons := [pbPrint,pbSave,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator];

          if strNomImp = '' then
            (Self.Components[intContador] As TfrxReport).PrintOptions.ShowDialog := True;
        End;

      End;

    End;

  Finally
    btnImprimir.Enabled := True;
  End;

end;

procedure TfrmPaiRelatorio.FormActivate(Sender: TObject);
begin
  inherited;
  {**********************************************************}
  {* Seta o Focus no primeiro campo disponivel no Relatorio.*}
  {* Tomado como Base o TabOrder                            *}
  {*******************************************************GB*}
  pSetaFocusPrimeiroCampo(Self);
end;

procedure TfrmPaiRelatorio.FormCreate(Sender: TObject);
begin
  inherited;

  intCount  := 0;
  strFilRel := '';
  strNomImp := '';

  blnExcel  := False;
  blnPerFil := True;
end;

procedure TfrmPaiRelatorio.edtDestinoExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtDestino.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
    pSetFocus(edtDestino);
  End
  Else If Pos(edtDestino.Text, 'VI' + IfThen(blnExcel, 'E', '')) <= 0 Then
  Begin
    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser ' + IfThen(blnExcel, 'V, I ou E!', 'V ou I!'), ['&Ok']);
    pSetFocus(edtDestino);
  End;

end;

procedure TfrmPaiRelatorio.frxGenGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  If VarName = 'EMP_NOMEMP' Then
    Value := fCampoTabela('EMP_NOMEMP', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'EMP_NOMFAN' Then
    Value := fCampoTabela('EMP_NOMFAN', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name

  Else If VarName = 'EMP_NOMCID' Then
    Value := fCampoTabela('CID_NOMCID', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False);

end;

procedure TfrmPaiRelatorio.frxComandosGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  {****************************}
  {* ESPAÇAMENTO ENTRE LINHAS *}
  {*************************AF*}
  If VarName = 'UM_OITAVO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#270'

    Else
      Value := '';

  End

  Else If VarName = 'UM_OITAVO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#272'

    Else
      Value := '';

  End

  {***********}
  {* NEGRITO *}
  {********AF*}
  Else If VarName = 'NEGRITO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#69'

    Else
      Value := '';

  End

  Else If VarName = 'NEGRITO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#70'

    Else
      Value := '';

  End

  {*************}
  {* EXPANDIDO *}
  {**********AF*}
  Else If VarName = 'EXPANDIDO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#871'

    Else
      Value := '';

  End

  Else If VarName = 'EXPANDIDO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#870'

    Else
      Value := '';

  End

  {*************}
  {* ITÁLICO   *}
  {**********AF*}
  Else If VarName = 'ITALICO_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#274'

    Else
      Value := '';

  End

  Else If VarName = 'ITALICO_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#275'

    Else
      Value := '';

  End

  {*************************}
  {* CONDENSADO PARA 10CPI *}
  {**********************AF*}
  Else If VarName = 'COND_10CPI_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#15#27#80'

    Else
      Value := '';

  End

  Else If VarName = 'COND_10CPI_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#18#27#80'

    Else
      Value := '';

  End

  {*************************}
  {* CONDENSADO PARA 12CPI *}
  {**********************AF*}
  Else If VarName = 'COND_12CPI_ON' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#15#27#77'

    Else
      Value := '';

  End

  Else If VarName = 'COND_12CPI_OFF' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#18#27#77'

    Else
      Value := '';

  End

  {**************************************}
  {* RESETA                             *}
  {***********************************AF*}
  Else If VarName = 'RESETA' Then
  Begin

    If strTipImp = 'M' Then
      Value := '#27#64#18#27#80'

    Else
      Value := '';

  End;

end;

end.

