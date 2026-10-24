unit untDigOcorrencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckBox, untPaiConfirma;

type
  TfrmDigOcorrencia = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    pnlVendasPerdidas: TPanel;
    gbVendasPerdidas: TGroupBox;
    ckbIncluirOrcVendasPerdidas: TcxCheckBox;
    pnlGbOcorrencia: TPanel;
    gbOcorrencia: TGroupBox;
    pnlHisCom: TPanel;
    lblHisCom: TLabel;
    edtHisCom: TEditFocus;
    pnlOcorrencia: TPanel;
    lbl2: TLabel;
    edtCodOco: TEditFocus;
    edtDesOco: TEditFocus;
    lblOcoCrm: TLabel;
    edtCodComplementoOcorrencia: TEditFocus;
    edtDesComplementoOcorrencia: TEditFocus;
    procedure edtCodOcoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtCodOcoExit(Sender: TObject);
    procedure ckbIncluirOrcVendasPerdidasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodComplementoOcorrenciaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodComplementoOcorrenciaExit(Sender: TObject);
  private
    { Private declarations }
    qryConOco: TUniQuery;
    strCodTipoDeOcorrenciaVenda : String;
    procedure pAjustarAlturaHistoricoComplementar;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodOco  : String;
    strDesOco  : String;
    strHisCom  : String;
    blnConfirma: Boolean;
    LEstornoCTR: Boolean;
    strOpcDoc  : String;
    blnCrm     : Boolean;

    blnUsarVendaPerdida: Boolean;
    blnInformarHisCom : Boolean;
    blnDigFatRomaneio : Boolean;

    procedure pCarregaOcorrencia;
    procedure pCarregaComplementoOcorrencia;
  end;

var
  frmDigOcorrencia: TfrmDigOcorrencia;

implementation

uses untFuncoesSimples, untPesqAux, untConsultas, untFuncIns2, untTypesSistema, StrUtils;

{$R *.dfm}

procedure TfrmDigOcorrencia.ckbIncluirOrcVendasPerdidasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  fValidaCampos(ckbIncluirOrcVendasPerdidas);
end;

procedure TfrmDigOcorrencia.edtCodComplementoOcorrenciaExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodComplementoOcorrencia);
end;

procedure TfrmDigOcorrencia.edtCodComplementoOcorrenciaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrOcorCrm: TConsultasArray;
begin
  inherited;
  if fPesqComplementosOcorrencias(Self, edtCodComplementoOcorrencia, edtDesComplementoOcorrencia, Nil, Key, arrOcorCrm, True, strCodTipoDeOcorrenciaVenda) then
  begin
    pCarregaComplementoOcorrencia;
    SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmDigOcorrencia.edtCodOcoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodOco);
end;

procedure TfrmDigOcorrencia.edtCodOcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOcor: TConsultasArray;
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE OCORRÊNCIAS *}
  {*****************************RV*}


  If fPesqOcorrencia(Self, edtCodOco, edtDesOco, Nil, Key, arrOcor) Then
  Begin
    pCarregaOcorrencia;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigOcorrencia.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConOco);
end;

procedure TfrmDigOcorrencia.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma := False;
  qryConOco   := fCriaQuery(Self);

  blnUsarVendaPerdida := False;
  blnInformarHisCom  := False;
  blnDigFatRomaneio  := False;
end;

procedure TfrmDigOcorrencia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If fIsInsert(Key) Then
  Begin
    If edtCodOco.Focused Then
    Begin
      If fVerificaAcessoSistema('frmCadOcorrencias') Then
      Begin
        edtCodOco.Text := fChamaCadOco(Key);
        If fValidaCampos(edtCodOco) Then
          SelectNext(ActiveControl, True, True);
      End
      Else
        fMensagem('','Sem permissão para Cadastro de Ocorrências',['&Ok']);
    End;
  End
  Else If Key = VK_Return Then
  Begin
    If ckbIncluirOrcVendasPerdidas.Focused Then
      fValidaCampos(ckbIncluirOrcVendasPerdidas);
  End;

end;

procedure TfrmDigOcorrencia.FormShow(Sender: TObject);
begin
  inherited;

  If Not blnInformarHisCom Then
  Begin
    pnlHisCom.Visible := False;
    edtHisCom.Visible := False;

    If Not edtHisCom.Visible Then
      Self.ClientHeight := Self.ClientHeight - edtHisCom.Height;
  End
  Else
  Begin
    pnlHisCom.Visible := True;
    edtHisCom.Visible := True;
  End;

  If Not blnUsarVendaPerdida Then
  Begin
    pnlVendasPerdidas.Visible := False;
    Self.ClientHeight := Self.ClientHeight - pnlVendasPerdidas.Height;
  End
  Else
    pnlVendasPerdidas.Visible := True;

  If blnDigFatRomaneio Then
  Begin
    frmDigOcorrencia.Caption := 'Observações de Romaneio';
    frmDigOcorrencia.edtHisCom.MaxLength := 0;
    frmDigOcorrencia.lblHisCom.Caption := 'Obs. Complementares:';
    frmDigOcorrencia.pnlOcorrencia.Visible := False;
    frmDigOcorrencia.pnlHisCom.Visible := True;
    frmDigOcorrencia.edtHisCom.Visible := True;
    gbOcorrencia.Caption := '';
  End;

  If Not fEmptyStr(strCodOco) Then
  Begin
    edtCodOco.Text := strCodOco;
    pCarregaOcorrencia;
  End;

  If pnlOcorrencia.Visible Then
    pSetFocus(edtCodOco)
  else If pnlHisCom.Visible Then
    pSetFocus(edtHisCom);


  blnCrm := blnCrm and fCfgSis('COMOCO', varBoolean);
  if blnCrm then
  Begin
    lblOcoCrm.Visible    := blnCrm;
    edtCodComplementoOcorrencia.Visible := blnCrm;
    edtDesComplementoOcorrencia.Visible := blnCrm;
    strCodTipoDeOcorrenciaVenda := IIF(strOpcDoc = 'PD', 'VENPED', 'VENORC');
    strCodTipoDeOcorrenciaVenda := fCfgSis(strCodTipoDeOcorrenciaVenda, varString);
  end else
  begin
    pnlOcorrencia.Height := (pnlOcorrencia.Height - edtCodComplementoOcorrencia.Height);
    Self.Height          := (Self.Height - edtCodComplementoOcorrencia.Height);
  end;

  pAjustarAlturaHistoricoComplementar;
end;

procedure TfrmDigOcorrencia.pAjustarAlturaHistoricoComplementar;
begin
  // As reducoes do FormShow partem da altura externa do form; na Skin Nova a borda e mais
  // grossa e o Historico Complementar ficava cortado. Cresce so o que faltar.
  If pnlHisCom.Visible And (pnlHisCom.ClientHeight < edtHisCom.Top + edtHisCom.Height + 2) Then
    Self.ClientHeight := Self.ClientHeight + (edtHisCom.Top + edtHisCom.Height + 2 - pnlHisCom.ClientHeight);
end;

function TfrmDigOcorrencia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodOco) Then
    Begin
      If fEmptyStr(edtCodOco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A ocorrência deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaOcorrencia;
        If qryConOco.FieldByName('OCO_CODOCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa ocorrência não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          strCodOco   := edtCodOco.Text;
          strDesOco   := edtDesOco.Text;

          If Not edtHisCom.Visible Then
          Begin
            Result      := True;
            ModalResult := mrOk;
          End;
        End;
      End;
    End
    Else If (Sender = edtHisCom) And edtHisCom.Visible Then
    Begin
      if (not pnlOcorrencia.Visible) then
      begin
        strHisCom   := edtHisCom.Text;
        Result      := True;
        ModalResult := mrOk;
      end
      else If fEmptyStr(edtCodOco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A ocorrência deve ser preenchida!', ['&O k']);
        Result := False;
      End
      else if (StrToIntDef(VarToStrDef(fCfgSis('CANCHC'),'0'),0) > 0) and
              (Length(Trim(edtHisCom.Text)) < StrToIntDef(VarToStrDef(fCfgSis('CANCHC'),'0'),0)) And Not LEstornoCTR then
      begin
        fMensagem('ATENÇÃO!', 'Informe o Histórico Complementar com no mínimo de ' + VarToStrDef(fCfgSis('CANCHC'),'0') + ' caracteres!', ['&O k']);
        pSetFocus(edtHisCom);
        Result := False;
      end
      else if (StrToIntDef(VarToStrDef(fCfgSis('QTMIHD'),'0'),0) > 0) and
              (Length(Trim(edtHisCom.Text)) < StrToIntDef(VarToStrDef(fCfgSis('QTMIHD'),'0'),0)) And
              (Pos(strOpcDoc, 'DV_PR') > 0) then
      begin
        fMensagem('ATENÇÃO!', 'Informe o Histórico Complementar com no mínimo de ' + VarToStrDef(fCfgSis('QTMIHD'),'0') + ' caracteres! CFG_QTMIHD', ['&O k']);
        pSetFocus(edtHisCom);
        Result := False;
      end
      Else
      Begin
        pCarregaOcorrencia;
        If qryConOco.FieldByName('OCO_CODOCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa ocorrência não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          strHisCom   := edtHisCom.Text;
          If Not blnUsarVendaPerdida Then
          Begin
            Result      := True;
            ModalResult := mrOk;
          End;
        End;
      End;
    End
    Else If (Sender = ckbIncluirOrcVendasPerdidas) And blnUsarVendaPerdida Then
    Begin
      Result      := True;
      ModalResult := mrOk;
    End
    Else If (Sender = edtCodComplementoOcorrencia)
      And (Not edtCodComplementoOcorrencia.Focused) And edtCodComplementoOcorrencia.Visible Then
    Begin
      pCarregaComplementoOcorrencia;
      If fEmptyStr(edtCodComplementoOcorrencia.Text) then
      Begin
        fMensagem('ATENÇÃO!', 'Complemento da ocorrência deve ser preenchido!', ['&O k']);
        Result := False;
      End Else If fEmptyStr(edtDesComplementoOcorrencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Codigo de complemento da ocorrência inválido!', ['&O k']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigOcorrencia.pCarregaComplementoOcorrencia;
begin
  pPesquisaCadCoc(Nil, qryConOco, edtCodComplementoOcorrencia.Text);
  if ContainsStr(qryConOco.FieldByName('COC_CODTOC').AsString, strCodTipoDeOcorrenciaVenda) then
    edtDesComplementoOcorrencia.Text := qryConOco.FieldByName('COC_DESCOC').AsString
  else
    edtDesComplementoOcorrencia.Text := EmptyStr;
end;

procedure TfrmDigOcorrencia.pCarregaOcorrencia;
begin
  pPesquisaCadOco(Nil, qryConOco, edtCodOco.Text);
  edtDesOco.Text := qryConOco.FieldByName('OCO_DESOCO').AsString;
end;

end.
