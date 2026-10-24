unit untFrameCtaPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  untFrameCentroCustoDBEditFocus, Vcl.DBCtrls, Vcl.StdCtrls, ComboBoxFocus,
  Vcl.Mask, MaskEditFocus, DBMemoFocus, DBEditFocus, EditFocus, Vcl.Buttons,
  QColorLabel, ContaPagar.TFrameCtaPagar, cxHint, dxScreenTip, cxClasses,
  dxCustomHint, Uni, System.StrUtils, untPortadorFornecedor;

type

  TfraCtaPagar = class(TFrame)
    pnlFundo: TPanel;
    pnlDetalhe: TPanel;
    lblVeiobo: TLabel;
    Label13: TLabel;
    Label17: TLabel;
    Label4: TLabel;
    ColVeiobo: TColorLabel;
    ColorLabel1: TColorLabel;
    Label20: TLabel;
    ColorLabel3: TColorLabel;
    lblTipoDoc: TLabel;
    Label31: TLabel;
    ColorLabel5: TColorLabel;
    lbl1: TLabel;
    ColorLabel8: TColorLabel;
    lblGuia: TLabel;
    Label36: TLabel;
    spbDicaTributo: TSpeedButton;
    edtNomCta: TEditFocus;
    cbxBcoFor: TComboBoxFocus;
    LcbGuiaTributo: TDBLookupComboBox;
    LcbTipoTributo: TDBLookupComboBox;
    edtDeposi: TEditFocus;
    MemHisto: TMemo;
    edtTipDoc: TEditFocus;
    edtVeiobo: TEditFocus;
    edtVeioNF: TEditFocus;
    edtUsaChq: TEditFocus;
    edtPrevis: TEditFocus;
    lblEventos: TLabel;
    edtDesEve: TEditFocus;
    edtCodEve: TEditFocus;
    edtCodCta: TMaskEditFocus;
    edtCompet: TMaskEditFocus;
    Label34: TLabel;
    Label33: TLabel;
    ColorLabel7: TColorLabel;
    Label32: TLabel;
    ColorLabel6: TColorLabel;
    edtPagAnt: TEditFocus;
    edtUsoCon: TEditFocus;
    HintControler: TcxHintStyleController;
    procedure edtCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCtaChange(Sender: TObject);
    procedure edtTipDocExit(Sender: TObject);
    procedure edtVeioNFKeyPress(Sender: TObject; var Key: Char);
    procedure edtDeposiKeyPress(Sender: TObject; var Key: Char);
    procedure edtUsaChqKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrevisKeyPress(Sender: TObject; var Key: Char);
    procedure LcbGuiaTributoExit(Sender: TObject);
    procedure spbDicaTributoClick(Sender: TObject);
    procedure LcbGuiaTributoKeyPress(Sender: TObject; var Key: Char);
    procedure LcbTipoTributoKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdDiaExit(Sender: TObject);
    procedure cbxBcoForChange(Sender: TObject);
    procedure cbxBcoForDropDown(Sender: TObject);
    procedure edtDeposiChange(Sender: TObject);
    procedure edtVeioboKeyPress(Sender: TObject; var Key: Char);
    procedure edtCompetKeyPress(Sender: TObject; var Key: Char);
    procedure edtPagAntKeyPress(Sender: TObject; var Key: Char);
    procedure edtUsoConKeyPress(Sender: TObject; var Key: Char);
    procedure edtTipDocEnter(Sender: TObject);
    procedure edtCodCtaEnter(Sender: TObject);
    procedure edtCodCtaExit(Sender: TObject);
  private
    FobjFrameCtaPagar     :TFrameContaPagar;
    FCodFor               :String;
    FBcoFor               :String;
    FForm                 :TForm;
    FobjQryCadCta         :TUniQuery;
    FTipoDocumento        :String;
    FDataDocumento        :String;

  public

    property objFrameCtaPagar: TFrameContaPagar read FobjFrameCtaPagar write FobjFrameCtaPagar;
    property strCodFor       : String           read FCodFor           write FCodFor;
    property objForm         : TForm            read FForm             write FForm;
    property objQryCadCta    : TUniQuery        read FobjQryCadCta     write FobjQryCadCta;
    property objTipoDocumento: String           read FTipoDocumento    write FTipoDocumento;
    property strBcoFor       : String           read FBcoFor           write FBcoFor;
    property strDataDocumento : String           read FDataDocumento    write FDataDocumento;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean; blnRevalidaCampos: Boolean = False): Boolean;

    procedure InicializaObjetoFrameContaPagar(blnOcultaPagAnt: Boolean = True);
  end;

implementation

uses
  untConsultas, untTypesSistema, untFuncoesSimples, untFiscCtpEntrada, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

{ TfraCtaPagar }

procedure TfraCtaPagar.cbxBcoForChange(Sender: TObject);
begin
  objFrameCtaPagar.pSetaBcoFor(FBcoFor);
end;

procedure TfraCtaPagar.cbxBcoForDropDown(Sender: TObject);
begin
  SendMessage(cbxBcoFor.Handle, CB_SETDROPPEDWIDTH, 315, 0);
end;

procedure TfraCtaPagar.edtCodCtaChange(Sender: TObject);
begin
  If edtCodCta.Focused Then
    edtCodCta.Color:= clInfoBk
  Else
  edtCodCta.Color:= clWindow;

end;

procedure TfraCtaPagar.edtCodCtaEnter(Sender: TObject);
begin
  edtCodCta.EditMask := '';
end;

procedure TfraCtaPagar.edtCodCtaExit(Sender: TObject);
begin
  If (Length(Trim(edtCodCta.Text)) < 7) Then
    edtCodCta.EditMask := ''
  Else
    edtCodCta.EditMask := '99.99.999;0;_'
end;

procedure TfraCtaPagar.edtCodCtaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCta : TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    If Not fCfgSis('USACTF', varBoolean) Then
    Begin
      If fPesqCentroCusto(objForm, objFrameCtaPagar.objCodigo_Conta, objFrameCtaPagar.objNome_Conta, nil, Key, arrCta) Then
      Begin
        objFrameCtaPagar.pCarregaCentroCusto;
      End;
    End
    Else
    Begin
      If fPesqCentroCusto(objForm, objFrameCtaPagar.objCodigo_Conta, objFrameCtaPagar.objNome_Conta, Nil, Key, arrCta, True, True, FCodFor) Then
      Begin
        objFrameCtaPagar.pCarregaCentroCusto;
      End;
    End;
  End
  Else If Key = #13 Then
    fValidaCampos(objFrameCtaPagar.objCodigo_Conta, False);

end;

procedure TfraCtaPagar.edtCodEveKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  If fEntraCons(Key) Then
    fPesqEventos(objForm, objFrameCtaPagar.objCodigo_Evento, objFrameCtaPagar.objDescricao_Evento, Nil, Key, arrEvento, True, True)
  Else If Key = #13 Then
    fValidaCampos(objFrameCtaPagar.objCodigo_Evento, False);

end;

procedure TfraCtaPagar.edtCompetKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    fValidaCampos(edtCompet, False);
end;

procedure TfraCtaPagar.edtDeposiChange(Sender: TObject);
begin
  If AsSigned(objFrameCtaPagar) Then
  Begin
    objFrameCtaPagar.pTrataBcoFor;
    If edtDeposi.Text = 'N' Then
      FBcoFor:= '';
  End;
end;

procedure TfraCtaPagar.edtDeposiKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    fValidaCampos(edtDeposi, False);
end;

procedure TfraCtaPagar.edtPagAntKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    fValidaCampos(edtPagAnt, False);
end;

procedure TfraCtaPagar.edtPrevisKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    fValidaCampos(edtPrevis, False);
end;

procedure TfraCtaPagar.edtQtdDiaExit(Sender: TObject);
begin
  HintControler.HideHint;
end;

procedure TfraCtaPagar.edtTipDocEnter(Sender: TObject);
begin
  {****************************}
  {* SHOW HINT TIPO DOCUMENTO *}
  {*18/08/2020**************GR*}
  if Assigned(frmFiscCtpEntrada) then
    HintControler.ShowHint(10 + frmFiscCtpEntrada.Left + edtTipDoc.Left + edtTipDoc.Width,
                           20 + frmFiscCtpEntrada.Top + edtTipDoc.Top + edtTipDoc.Height, 'Tipos de Documento:', edtTipDoc.Hint);
end;

procedure TfraCtaPagar.edtTipDocExit(Sender: TObject);
begin
  {****************************}
  {* HIDE HINT TIPO DOCUMENTO *}
  {*18/08/2020**************GR*}
  HintControler.HideHint;

  fValidaCampos(edtTipDoc, False);
end;

procedure TfraCtaPagar.edtUsaChqKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    fValidaCampos(edtUsaChq, False);
end;

procedure TfraCtaPagar.edtUsoConKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    fValidaCampos(edtUsoCon, False);
end;

procedure TfraCtaPagar.edtVeioboKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    fValidaCampos(edtVeiobo, False);
end;

procedure TfraCtaPagar.edtVeioNFKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    fValidaCampos(edtVeioNF, False);
end;

function TfraCtaPagar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean; blnRevalidaCampos: Boolean = False): Boolean;
begin
  Result := True;

  Begin

    If (Sender = edtUsaChq) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objUsa_Cheque  := edtUsaChq;
      Try
        objFrameCtaPagar.pValidaUsaChe;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(edtUsaChq);
          Result:= False;
          Exit;
        End;

      End;

    End;

    If (Sender = edtPagAnt) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objPagamentoAntecipado  := edtPagAnt;
      Try
        objFrameCtaPagar.pValidaPagamentoAntecipado;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(edtPagAnt);
          Result:= False;
          Exit;
        End;

      End;

    End;

    If (Sender = edtUsoCon) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objUsoConsumo  := edtUsoCon;
      Try
        objFrameCtaPagar.pValidaUsoConsumo;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(edtUsoCon);
          Result:= False;
          Exit;
        End;

      End;

    End;

    If (Sender = edtCompet) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objCompet  := edtCompet;
      Try
        objFrameCtaPagar.pValidaCompetencia;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(edtCompet);
          Result:= False;
          Exit;
        End;

      End;

    End;


    If (Sender = edtVeioBO) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objVeio_Boleto  := edtVeioBO;
      Try
        objFrameCtaPagar.pValidaVeioBO;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(edtVeioBO);
          Result:= False;
          Exit;
        End;

      End;

    End;

    If (Sender = edtDeposi) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objDeposito  := edtDeposi;
      Try
        objFrameCtaPagar.pValidaDeposito;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(edtDeposi);
          Result:= False;
          Exit;
        End;

      End;

    End;

    If (Sender = edtVeioNF) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objVeio_Nota_Fiscal  := edtVeioNF;
      Try
        objFrameCtaPagar.pValidaVeioNF;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(edtVeioNF);
          Result:= False;
          Exit;
        End;

      End;

    End;

    If (Sender = edtPrevis) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objPrevisao  := edtPrevis;
      Try
        objFrameCtaPagar.pValidaPrevisao;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(edtPrevis);
          Result:= False;
          Exit;
        End;

      End;

    End;


    If (Sender = edtCodCta) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objCodigo_Conta := edtCodCta;
      objFrameCtaPagar.objNome_Conta   := edtNomCta;
      objFrameCtaPagar.objQryCadCta:= FobjQryCadCta;
      Try
        objFrameCtaPagar.pValidaContaCusto;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(edtCodCta);
          Result:= False;
          Exit;
        End;

      End;

    End;

    If (Sender = edtCodEve) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objCodigo_Evento   := edtCodEve;
      objFrameCtaPagar.objDescricao_Evento:= edtDesEve;
      Try
        objFrameCtaPagar.pValidaCentroCusto;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(edtCodEve);
          Result:= False;
          Exit;
        End;

      End;

    End;


    If (Sender = edtTipDoc) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objTipo_Documento  := edtTipDoc;
      Try
        objFrameCtaPagar.pValidaTipoDocumento(FTipoDocumento);
        If FTipoDocumento <> '2' Then
        Begin
          objFrameCtaPagar.objLcbTipoTributo  := LcbTipoTributo;
          objFrameCtaPagar.pValidaTipoTributo;
        End;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(edtTipDoc);
          Result:= False;
          Exit;
        End;

      End;

    End;

    If (Sender = LcbTipoTributo) Or (blnRevalidaCampos) Then
    Begin

      objFrameCtaPagar.objLcbTipoTributo  := LcbTipoTributo;
      Try
        objFrameCtaPagar.pValidaTipoTributo;
      Except
        on E: Exception do
        Begin
          pMensagemOk(E.Message);
          pSetFocus(LcbTipoTributo);
          Result:= False;
          Exit;
        End;

      End;

    End;

  End;

end;

procedure TfraCtaPagar.InicializaObjetoFrameContaPagar(blnOcultaPagAnt: Boolean = True);
begin
  objFrameCtaPagar.objCodigo_Evento        := edtCodEve;
  objFrameCtaPagar.objDescricao_Evento     := edtDesEve;
  objFrameCtaPagar.objCodigo_Conta         := edtCodCta;
  objFrameCtaPagar.objNome_Conta           := edtNomCta;
  objFrameCtaPagar.objVeio_Boleto          := edtVeiobo;
  objFrameCtaPagar.objVeio_Nota_Fiscal     := edtVeioNF;
  objFrameCtaPagar.objPrevisao             := edtPrevis;
  objFrameCtaPagar.objUsa_Cheque           := edtUsaChq;
  objFrameCtaPagar.objDeposito             := edtDeposi;
  objFrameCtaPagar.objLcbGuiaTributo       := LcbGuiaTributo;
  objFrameCtaPagar.objLcbTipoTributo       := LcbTipoTributo;
  objFrameCtaPagar.objTipo_Documento       := edtTipDoc;
  objFrameCtaPagar.objLblTipo_Documento    := lblTipoDoc;
  objFrameCtaPagar.objSpbDica_Tributo      := spbDicaTributo;
  objFrameCtaPagar.objCbxBanco_Fornecedor  := cbxBcoFor;
  objFrameCtaPagar.objLblGuia_Tributo      := LblGuia;
  objFrameCtaPagar.objQryCadCta            := FobjQryCadCta;
  objFrameCtaPagar.strDataDocumento        := strDataDocumento;
  objFrameCtaPagar.objCompet               := edtCompet;
  objFrameCtaPagar.objPagamentoAntecipado  := edtPagAnt;
  objFrameCtaPagar.objUsoConsumo           := edtUsoCon;
  objFrameCtaPagar.strCodigo_Fornecedor    := FCodFor;

  objFrameCtaPagar.pCarregaValoresPadroes;
  objFrameCtaPagar.pCarregaGuiasETributos;
  objFrameCtaPagar.pCarregaDadosBancariosFornecedor;
  objFrameCtaPagar.pCarregaCentroCusto;
  objFrameCtaPagar.pCarregaEvento;

  Label32.Visible := Not blnOcultaPagAnt;
  edtPagAnt.Visible :=  Not blnOcultaPagAnt;
  ColorLabel6.Visible :=  Not blnOcultaPagAnt;
  If blnOcultaPagAnt Then
     edtPagAnt.Text := 'N';


  pSetFocus(edtVeioNF);

end;

procedure TfraCtaPagar.LcbGuiaTributoExit(Sender: TObject);
begin
  objFrameCtaPagar.pChamaEventoSairComponenteGuiaTributo;
end;

procedure TfraCtaPagar.LcbGuiaTributoKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    fValidaCampos(LcbGuiaTributo, False);
end;

procedure TfraCtaPagar.LcbTipoTributoKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    fValidaCampos(LcbTipoTributo, False);
end;

procedure TfraCtaPagar.spbDicaTributoClick(Sender: TObject);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(220, 7736, [],
                        [],
                        [],
                        Sender,
                        nil,
                        True);
  End;

end;

end.
