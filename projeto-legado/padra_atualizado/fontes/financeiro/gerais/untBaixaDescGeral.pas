unit untBaixaDescGeral;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Data.DB, Datasnap.DBClient, UniClientDataSet;

type
  TfrmBaixaDescGeral = class(TfrmPai)
    pnlValores: TPanel;
    Label6: TLabel;
    edtValBaixaTotal: TEditFocus;
    edtQtdBaixaTotal: TEditFocus;
    Label1: TLabel;
    edtQtdBaixaParcial: TEditFocus;
    edtValBaixaParcial: TEditFocus;
    Label2: TLabel;
    edtQtdGeral: TEditFocus;
    edtValGeral: TEditFocus;
    pnlTotais: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtValBaixaTotalDesc: TEditFocus;
    edtQtdBaixaTotal2: TEditFocus;
    edtQtdBaixaParcial2: TEditFocus;
    edtValBaixaParcialDesc: TEditFocus;
    edtQtdGeral2: TEditFocus;
    edtValGeralDesc: TEditFocus;
    pnlDesconto: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    edtPerDesc: TEditFocus;
    edtValDesc: TEditFocus;
    btnConfirma: TBitBtnLocked;
    Label9: TLabel;
    Label10: TLabel;
    edtQtdCredito: TEditFocus;
    edtValCredito: TEditFocus;
    edtQtdCredito2: TEditFocus;
    edtValCredito2: TEditFocus;
    rgpTipDes: TRadioGroup;
    rgpDescSobre: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure rgpDescSobreClick(Sender: TObject);
  private
    FblnCtaPagar  : Boolean;
    FblnCtaReceber: Boolean;
    FfltValDes    : Double;
    FblnConfirma  : Boolean;
    FcdsDuplicatas: TUniClientDataSet;
    FstrTipDes    : string;
    FfltValBaiTot : Double;
    FfltValTotGer : Double;

    FMotivoDoDesconto: String;

    FResumoDeCaixa: Boolean;

    procedure pSetDuplicatas(const cdsOrigem: TUniClientDataSet);
    procedure pCalculaDesconto(Sender: TWinControl);
    procedure pInicializaVariaveis;
    procedure pCarregaValores;
    procedure pLimpaTela;

    function RetornaCampoValorRecebido: String;
    function RetornaCampoValorCorrigido: String;
    function RetornaFiltroTipoBaixa(AParcial: Boolean): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    property fltValDes    : Double  read FfltValDes;
    property fltValBaiTot : Double  read FfltValBaiTot;
    property fltValTotGer : Double  read FfltValTotGer;
    property blnConfirma  : Boolean read FblnConfirma;
    property strTipDes    : string  read FstrTipDes;
    property blnCtaPagar  : Boolean           write FblnCtaPagar;
    property cdsDuplicatas: TUniClientDataSet write pSetDuplicatas;
    property blnCtaReceber: Boolean           write FblnCtaReceber;

    property MotivoDoDesconto: String read FMotivoDoDesconto;

    property ResumoDeCaixa: Boolean write FResumoDeCaixa;
  end;

var
  frmBaixaDescGeral: TfrmBaixaDescGeral;

implementation

uses untFuncoesSimples, System.Math, untInputDialog;

{$R *.dfm}

{ TfrmDescontoGeral }

procedure TfrmBaixaDescGeral.btnConfirmaClick(Sender: TObject);
  Var
    frmInputDialog: TfrmInputDialog;
begin
  inherited;
  If fEmptyStr(edtValDesc.Text) And (fStrToFloat(edtValBaixaTotal.Text) <> 0) Or
    (fStrToFloat(edtValDesc.Text) = 0) And(fStrToFloat(edtPerDesc.Text) <> 0) And
    (fStrToFloat(edtValBaixaTotal.Text) <> 0) Then
  Begin
    pCalculaDesconto(edtPerDesc);
  End
  Else If fValidaCampos(edtValDesc) Then
  Begin
    If rgpTipDes.Visible Then
    Begin
      Case rgpTipDes.ItemIndex Of
        0: FstrTipDes := 'D';
        1: FstrTipDes := 'B';
        2: FstrTipDes := 'O';
      End;
    End
    Else
      FstrTipDes := '';

    If (fStrToFloat(edtValDesc.Text) > 0) And
       (fStrToFloat(edtValBaixaTotalDesc.Text) = 0.0) And
       (fStrToFloat(edtValBaixaTotal.Text) > 0.0) And
       (fMensagem('','Desconto Geral de 100%.' + #13#10 +
                     'Esta operação não gravará movimento bancário.' + #13#10 +
                     'Confirma?', ['&Sim', '&Não']) = 2) Then
    Begin
      pSetFocus(edtValDesc);
      Exit;
    End;

    If fCfgSis('MDERCX', varBoolean) Then
    Begin
      If FResumoDeCaixa Then
      Begin
        Try
          pCriarFormularios(TfrmInputDialog, frmInputDialog);
          frmInputDialog.Caption := 'Motivo do desconto';
          frmInputDialog.lblPrompt.Caption := 'Digite o motivo do desconto';
          frmInputDialog.ShowModal;

          If frmInputDialog.ModalResult <> mrOK Then
            Exit;

          If fEmptyStr(frmInputDialog.edtValue.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Você precisa digitar o motivo de desconto.', ['&Ok']);
            Exit;
          End;

          FMotivoDoDesconto := frmInputDialog.edtValue.Text;
        Finally
          FreeAndNil(frmInputDialog);
        End;
      End;
    End;

    FfltValDes := fStrToFloat(edtValDesc.Text);
    FfltValBaiTot := fStrToFloat(edtValBaixaTotal.Text);
    FfltValTotGer := fStrToFloat(edtValGeral.Text);
    FblnConfirma := True;
    Close;
  End;
end;

procedure TfrmBaixaDescGeral.FormCreate(Sender: TObject);
begin
  inherited;
  pInicializaVariaveis;
  pLimpaTela;
end;

procedure TfrmBaixaDescGeral.FormShow(Sender: TObject);
begin
  inherited;

  rgpTipDes.Visible := FblnCtaPagar;

  rgpDescSobre.Visible := (Not FblnCtaPagar) And (Not FblnCtaReceber);
  rgpDescSobre.ItemIndex := fCfgSis('DESGER', varInteger);

  Self.Height := IIF(Not FblnCtaPagar,
                     Self.Height - rgpTipDes.Height + 5,
                     Self.Height);

  If FblnCtaPagar or FblnCtaReceber Then
  Begin
     label7.top     := label7.top - rgpDescSobre.Height;
     edtPerDesc.top := edtPerDesc.top - rgpDescSobre.Height;
     label8.top     := label8.top - rgpDescSobre.Height;
     edtValDesc.top := edtValDesc.top - rgpDescSobre.Height;
     rgpTipDes.top  := rgpTipDes.top  - rgpDescSobre.Height;
     Self.Height    := Self.Height - rgpDescSobre.Height;
  End;


  pCarregaValores;
  pCalculaDesconto(edtPerDesc);
  pSetFocus(edtPerDesc);
end;

function TfrmBaixaDescGeral.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtPerDesc) Then
  Begin
    If (Not fEmptyStr(edtPerDesc.Text)) Then
      Result := fValidaEscala(edtPerDesc.Text, 0, 100);

    If Result And (Not fEmptyStr(edtPerDesc.Text)) Then
      pCalculaDesconto(Sender);
  End;
  If (Sender = edtValDesc) Then
  Begin
    pCalculaDesconto(edtValDesc);
    If fEmptyStr(edtValDesc.Text) Then
    Begin
      fMensagem('ATENÇÃO','O valor do desconto deve ser preenchido!',['&O K']);
      Result := False;
    End
    Else If (fStrToFloat(edtValDesc.Text) < 0.00) Then
    Begin
      fMensagem('ATENÇÃO','O valor do desconto deve ser maior ou igual a zero!',['&O K']);
      Result := False;
    End
    Else If (fStrToFloat(edtValDesc.Text) > 0.00) And (fStrToFloat(edtValDesc.Text) > (fStrToFloat(edtValBaixaTotal.Text) + fStrToFloat(edtValCredito.Text))) Then
    Begin
      fMensagem('ATENÇÃO','O valor do desconto deve ser menor ou igual ao valor da baixa total menos o valor do crédito!',['&O K']);
      Result := False;
    End;

    If Result Then
      pCalculaDesconto(Sender);
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaDescGeral.pCalculaDesconto(Sender: TWinControl);
begin
  If (Sender = edtPerDesc) Then
  Begin
    If rgpDescSobre.ItemIndex = 0 Then
       edtValDesc.Text := FloatToStrF(fStrToFloat(edtValGeral.Text) *
                                     (fStrToFloat(edtPerDesc.Text) / 100), ffNumber, 12, 2)
    Else
       edtValDesc.Text := FloatToStrF(fStrToFloat(edtValBaixaTotal.Text) *
                                     (fStrToFloat(edtPerDesc.Text) / 100), ffNumber, 12, 2);
  End
  Else If (Sender = edtValDesc) Then
  Begin
    If rgpDescSobre.ItemIndex = 0 Then
    Begin
       If(fStrToFloat(edtValGeral.Text) > 0) Then
          edtPerDesc.Text := FloatToStrF((fStrToFloat(edtValDesc.Text)  * 100) /
                                        fStrToFloat(edtValGeral.Text), ffNumber, 12, 2)
    End
    Else
    Begin
       If(fStrToFloat(edtValBaixaTotal.Text) > 0) Then
          edtPerDesc.Text := FloatToStrF((fStrToFloat(edtValDesc.Text)  * 100) /
                                        fStrToFloat(edtValBaixaTotal.Text), ffNumber, 12, 2);
    End;
  End;

  If (fStrToFloat(edtValBaixaTotal.Text) > 0) Then
      edtValBaixaTotalDesc.Text   := FloatToStrF(fStrToFloat(edtValBaixaTotal.Text) - fStrToFloat(edtValDesc.Text), ffNumber, 12, 2);

  edtValBaixaParcialDesc.Text := edtValBaixaParcial.Text;
  edtValCredito2.Text         := edtValCredito.Text;
  edtValGeralDesc.Text        := FloatToStrF(fStrToFloat(edtValBaixaTotalDesc.Text) +
                                             fStrToFloat(edtValBaixaParcialDesc.Text) +
                                             fStrToFloat(edtValCredito2.Text), ffNumber, 12, 2);
end;

procedure TfrmBaixaDescGeral.pCarregaValores;
Var
  fldValBaixa: TAggregateField;
  fldValBaixaP: TAggregateField;
  cdsDesconto: TUniClientDataSet;
  intQtdTotal,
  intQtdParcial,
  intQtdCredito: Integer;
begin
  cdsDesconto := TUniClientDataSet.Create(Self);
  fldValBaixa := TAggregateField.Create(Self);
  fldValBaixaP:= TAggregateField.Create(Self);

  Try
    With fldValBaixa Do
    Begin
      FieldName := 'FLDVALBAIXA';
      DataSet := cdsDesconto;
      DisplayFormat := '#,##0.00';
      Expression := 'SUM(' + RetornaCampoValorCorrigido + ')';
      Active := True;
    End;

    With fldValBaixaP Do
    Begin
      FieldName := 'FLDVALBAIXAP';
      DataSet := cdsDesconto;
      DisplayFormat := '#,##0.00';
      Expression := 'SUM(' + RetornaCampoValorRecebido + ')';
      Active := True;
    End;

    With cdsDesconto Do
    Begin
      Data := FcdsDuplicatas.Data;
      AggregatesActive := True;

      {* Total e quantidade de Baixa Total *}
      Filtered := False;
      Filter   := 'CT' + IIF(FblnCtaPagar, 'P', 'R') + '_MARDES = ''M'' AND ' +
                  RetornaFiltroTipoBaixa(False) + ' AND ' +
                  RetornaCampoValorCorrigido + ' > 0';
      Filtered := True;

      edtQtdBaixaTotal.Text := IntToStr(RecordCount);
      edtQtdBaixaTotal2.Text:= IntToStr(RecordCount);
      edtValBaixaTotal.Text := FloatToStrF(IIF(VarIsNull(fldValBaixa.Value), 0, fldValBaixa.Value), ffNumber, 12, 2);

      {* Total e quantidade de Baixa Parcial *}
      Filtered := False;
      Filter   := 'CT' + IIF(FblnCtaPagar, 'P', 'R') + '_MARDES = ''M'' AND ' +
                  RetornaFiltroTipoBaixa(True) + ' AND ' +
                  RetornaCampoValorRecebido + ' > 0';
      Filtered := True;

      edtQtdBaixaParcial.Text := IntToStr(RecordCount);
      edtQtdBaixaParcial2.Text:= IntToStr(RecordCount);
      edtValBaixaParcial.Text := FloatToStrF(IIF(VarIsNull(fldValBaixaP.Value), 0, fldValBaixaP.Value), ffNumber, 12, 2);

      {* Total e quantidade de Créditos *}
      Filtered := False;
      Filter   := 'CT' + IIF(FblnCtaPagar, 'P', 'R') + '_MARDES = ''M'' AND ' +
                  RetornaCampoValorRecebido + ' < 0';
      Filtered := True;

      edtQtdCredito.Text  := IntToStr(RecordCount);
      edtQtdCredito2.Text := IntToStr(RecordCount);
      edtValCredito.Text  := FloatToStrF(IIF(VarIsNull(fldValBaixaP.Value), 0, fldValBaixaP.Value), ffNumber, 12, 2);

      intQtdTotal   := StrToInt(edtQtdBaixaTotal.Text);
      intQtdParcial := StrToInt(edtQtdBaixaParcial.Text);
      intQtdCredito := StrToInt(edtQtdCredito.Text);

      edtQtdGeral.Text := IntToStr((intQtdTotal + intQtdParcial + intQtdCredito));
      edtQtdGeral2.Text:= edtQtdGeral.Text;
      edtValGeral.Text := FloatToStrF(fStrToFloat(edtValBaixaTotal.Text) +
                                      fStrToFloat(edtValBaixaParcial.Text) +
                                      fStrToFloat(edtValCredito.Text), ffNumber, 12, 2);
    End;
  Finally
    FreeAndNil(fldValBaixa);
    FreeAndNil(fldValBaixaP);
    FreeAndNil(cdsDesconto);
  End;
end;

procedure TfrmBaixaDescGeral.pInicializaVariaveis;
begin
  FblnCtaPagar  := False;
  FblnCtaReceber:= False;
  FfltValDes    := 0;
  FblnConfirma  := False;

  FResumoDeCaixa := False;

  If Not Assigned(FcdsDuplicatas) Then
    FcdsDuplicatas := TUniClientDataSet.Create(Self);
  If Not FcdsDuplicatas.IsEmpty Then
    FcdsDuplicatas.EmptyDataSet;
end;

procedure TfrmBaixaDescGeral.pLimpaTela;
begin
  edtQtdBaixaTotal.Text       := '0';
  edtQtdBaixaParcial.Text     := '0';
  edtQtdGeral.Text            := '0';
  edtQtdBaixaTotal2.Text      := '0';
  edtQtdBaixaParcial2.Text    := '0';

  edtValBaixaTotal.Text       := '0.00';
  edtValBaixaParcial.Text     := '0.00';
  edtValGeral.Text            := '0.00';
  edtValBaixaTotalDesc.Text   := '0.00';
  edtValBaixaParcialDesc.Text := '0.00';
  edtValGeralDesc.Text        := '0.00';

  edtValDesc.Clear;
  edtPerDesc.Clear;
  rgpTipDes.ItemIndex         := 3;
end;

procedure TfrmBaixaDescGeral.pSetDuplicatas(const cdsOrigem: TUniClientDataSet);
begin
  Try
    With FcdsDuplicatas Do
    Begin
      Data := cdsOrigem.Data;
      Filtered  := False;
      Filter    := 'CT' + IIF(FblnCtaPagar, 'P', 'R') + '_MARDES = ''M''';
      Filtered := True;

      If IsEmpty Then
      Begin
        fMensagem('Informação', 'Nenhuma duplicata selecionada!', ['&OK']);
        Abort;
      End;
    End;
  Finally
    FcdsDuplicatas.Filtered := False;
  End;
end;

function TfrmBaixaDescGeral.RetornaCampoValorCorrigido: String;
begin
  Result := 'CTR_VALCAL';

  If FResumoDeCaixa Then
    Result := 'CTR_VALCOR'
  Else If FblnCtaPagar Then
    Result := 'TOTDUP';
end;

function TfrmBaixaDescGeral.RetornaCampoValorRecebido: String;
begin
  Result := 'CTR_VALREC';

  If FblnCtaPagar Then
    Result := 'TOTDUP';
end;

function TfrmBaixaDescGeral.RetornaFiltroTipoBaixa(AParcial: Boolean): String;
begin
  Result := 'CTR_TIPBAI = ' + QuotedStr(IIF(AParcial, 'P', 'T'));

  If FblnCtaPagar Then
    Result := 'CTP_TIPBAI = ' + QuotedStr(IIF(AParcial, 'P', 'T'))
  Else If FResumoDeCaixa Then
    Result := 'CTR_BAIPAR = ' + QuotedStr(IIF(AParcial, 'S', 'N'));
end;

procedure TfrmBaixaDescGeral.rgpDescSobreClick(Sender: TObject);
 Var
     blnres : Boolean;
begin
  inherited;
  blnres := False;
  If (Not fEmptyStr(edtPerDesc.Text)) Then
     blnres := fValidaEscala(edtPerDesc.Text, 0, 100);

  If blnres And (Not fEmptyStr(edtPerDesc.Text)) Then
     pCalculaDesconto(edtPerDesc);
end;

end.
