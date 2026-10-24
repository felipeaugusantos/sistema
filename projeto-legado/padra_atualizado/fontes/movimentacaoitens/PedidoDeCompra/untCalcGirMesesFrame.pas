unit untCalcGirMesesFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, Vcl.StdCtrls, ComboBoxFocus, Vcl.CheckLst, QColorLabel, EditFocus,
  Vcl.ExtCtrls, cxGroupBox, untMesesGiro, untFuncoesPedidoSimples, untTEditFocusWithTConsultasArray;

type
  TfraCalcGirMesesFrame = class(TFrame)
    gpbCalcGir: TcxGroupBox;
    pnlFixo: TPanel;
    lblDiaComGer: TLabel;
    lblPerConGer: TLabel;
    cxGroupBox9: TcxGroupBox;
    lblSelMes: TLabel;
    rdgOpcGir: TRadioGroup;
    chkInfMes: TCheckBox;
    chkMesAtu: TCheckBox;
    edtDiaComGer_: TEditFocus;
    grbBasGir: TcxGroupBox;
    lstBasGir: TCheckListBox;
    grbNivel: TcxGroupBox;
    cmbTipNiv: TComboBoxFocus;
    cxgNivel: TcxGridCitel;
    cxvNivel: TcxGridDBTableViewCitel;
    cxvNivelNIVGIR: TcxGridDBColumn;
    cxvNivelUSANIV: TcxGridDBColumn;
    cxvNivelQTDDIA: TcxGridDBColumn;
    cxvNivelPERCON: TcxGridDBColumn;
    cxgNivelLevel1: TcxGridLevel;
    edtPerConGer: TEditFocus;
    pnlRodape: TPanel;
    grbOpcGir: TcxGroupBox;
    ColorLabel4: TColorLabel;
    edtFilGir: TEditFocus;
    chkExibItens: TCheckBox;
    chkEmbala: TCheckBox;
    rdgTipMed: TRadioGroup;
    procedure chkInfMesClick(Sender: TObject);
    procedure cmbTipNivChange(Sender: TObject);
    procedure cxvNivelEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure lblSelMesClick(Sender: TObject);
    procedure lstBasGirClickCheck(Sender: TObject);
    procedure rdgOpcGirClick(Sender: TObject);
    procedure lstBasGirKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxvNivelQTDDIAPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

    intOpcGir  : Integer;

    blnCarregandoDados,
    blnSolBasGir: Boolean;

    strMeses   : String;

    frmPai: TForm;

    cdsMeses:  TMesesGiro;

    objNiveis: TNivelGiroCriticidade;

    Function fRetNroMeses: Integer;

    function fContaSelecaoBaseGiro: Integer;

    Procedure pInicializaDados;

    procedure pAtualizaBaseGir;

    procedure pAjustaDiaCom;


  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

Procedure TfraCalcGirMesesFrame.pInicializaDados;
Begin
  blnSolBasGir:= fCfgSis('BASGIR', varBoolean);

  If Not blnSolBasGir Then
  Begin
    grbBasGir.Visible := False;
  End;

  chkExibItens.Checked := True;

  objNiveis := TNivelGiroCriticidade.Create(Self);

  cxvNivel.DataController.DataSource := objNiveis.dtsSource;

  chkEmbala.Visible := fCfgSis('CNVEMB') <> 'N';
  rdgOpcGir.Enabled := fCfgSis('METGIR') = '1';

  cdsMeses :=  TMesesGiro.Create(Self, 12);

  cxvNivel.NavigatorButtons.First.Click;

  edtPerConGer.EditFormat := fMskDigitos(2);

  pAtualizaBaseGir;

  If {Not grbBasGir.Visible} fContaSelecaoBaseGiro = 0 Then
    lstBasGir.Checked[0] := True;

  cmbTipNiv.Items.Add('Nenhum');
  cmbTipNiv.Items.Add('Nível de Giro');
  cmbTipNiv.Items.Add('Nível de Criticidade');
  cmbTipNiv.Items.Add('Nível de Giro + Nível de Criticidade');
  If fCfgSis('TABPRD', VarBoolean) Then
    cmbTipNiv.Items.Add('Nível de Giro por Fornecedor');
  cmbTipNiv.ItemIndex := 0;
End;

procedure TfraCalcGirMesesFrame.rdgOpcGirClick(Sender: TObject);
begin
  intOpcGir := rdgOpcGir.ItemIndex;

  rdgTipMed.Enabled := intOpcGir <> 0;

  If Not rdgTipMed.Enabled Then
    rdgTipMed.ItemIndex := 0;
end;

procedure TfraCalcGirMesesFrame.chkInfMesClick(Sender: TObject);
begin
  If Not frmPai.Showing Then
    Exit;

  lblSelMes.Enabled := chkInfMes.Checked;

  If Not chkInfMes.Checked Then
    chkMesAtu.Enabled := True;

  If chkInfMes.Checked Then
    lblSelMesClick(lblSelMes);

  grbBasGir.Enabled := Not chkInfMes.Checked;
end;

procedure TfraCalcGirMesesFrame.cmbTipNivChange(Sender: TObject);
begin

  Case cmbTipNiv.ItemIndex Of
    0: objNiveis.pMontaSemNivel;
    1: objNiveis.pMontaNivelGiro;
    2: objNiveis.pMontaNivelCriticidade;
    3: objNiveis.pMontaNivelAmbos;
    4: objNiveis.pMontaNivelGiro;
  End;

  pAjustaDiaCom;
end;

procedure TfraCalcGirMesesFrame.pAjustaDiaCom;
Begin
  edtDiaComGer_.Enabled := cmbTipNiv.ItemIndex <= 0;
  lblDiaComGer.Enabled  := cmbTipNiv.ItemIndex <= 0;

  edtPerConGer.Enabled  := cmbTipNiv.ItemIndex <= 0;
  lblPerConGer.Enabled  := cmbTipNiv.ItemIndex <= 0;
End;

procedure TfraCalcGirMesesFrame.cxvNivelEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
  Var
    intRecNo: Integer;
begin
  inherited;

  Case Key Of
    VK_RETURN: If cxvNivelPERCON.Focused Then
               Begin
                 If objNiveis.State = dsEdit Then
                   objNiveis.Post;

                 intRecNo := objNiveis.RecNo;
                 cxvNivel.NavigatorButtons.Next.Click;

                 cxvNivelUSANIV.Focused := True;
                 Key := 0;

                 If intRecNo = objNiveis.RecNo Then
                   SelectNext(frmPai.ActiveControl,True,True);
               End;

  End;
end;

procedure TfraCalcGirMesesFrame.cxvNivelQTDDIAPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin

  If StrToIntDef(DisplayValue, -1) < 0 Then
  Begin
    ErrorText := '';
    pMensagemOk('A quantidade de dias de compra deve ser maior ou igual a zero!');
  End;

end;

procedure TfraCalcGirMesesFrame.lblSelMesClick(Sender: TObject);
begin

  If Not blnCarregandoDados Then
  Begin
    If cdsMeses.fSelecionaMeses(fRetNroMeses, strMeses) And
       cdsMeses.fSelecionouMesAtual Then
    Begin
      chkMesAtu.Checked := False;
    End;
  End;

  chkMesAtu.Enabled := (Not cdsMeses.fSelecionouMesAtual);

end;

procedure TfraCalcGirMesesFrame.lstBasGirClickCheck(Sender: TObject);
  Var
    intContador: Integer;
    intIndex   : Integer;
begin
  inherited;

  intIndex := lstBasGir.ItemIndex;

  For intContador := 0 To lstBasGir.Items.Count -1 Do
  Begin

    If intContador <> intIndex Then
    Begin
      lstBasGir.Checked[intContador] := False;
    End;

  End;
end;

procedure TfraCalcGirMesesFrame.lstBasGirKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of
    VK_Return: SelectNext(frmPai.ActiveControl,True,True);
    VK_Escape: frmPai.Close;
  End;

end;

procedure TfraCalcGirMesesFrame.pAtualizaBaseGir;
Begin
  pRetListaMesAno(lstBasGir.Items);
End;

Function TfraCalcGirMesesFrame.fRetNroMeses: Integer;
Begin
  Case rdgOpcGir.ItemIndex of
    1:   Result := 06;
    2:   Result := 12;
    Else Result := 03;
  end;
End;

function TfraCalcGirMesesFrame.fContaSelecaoBaseGiro: Integer;
  Var
    intContador: Integer;
begin
  Result := 0;
  For intContador := 0 To lstBasGir.Items.Count -1 Do
    If lstBasGir.Checked[intContador] Then
      Inc(Result);
end;


end.
