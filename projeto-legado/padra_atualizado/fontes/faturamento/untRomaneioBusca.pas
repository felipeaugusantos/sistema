unit untRomaneioBusca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons;

type
  TfrmRomaneioBusca = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    Label2: TLabel;
    lblDocum: TLabel;
    Label3: TLabel;
    edtNomCli: TEditFocus;
    edtNumDoc: TEditFocus;
    edtNomCid: TEditFocus;
    edtEspDoc: TEditFocus;
    Label1: TLabel;
    lblCliFor: TLabel;
    edtCodCli: TEditFocus;
    lblPedVen: TLabel;
    edtPedVen: TEditFocus;
    chkAutomatico: TCheckBox;
    btnHlpAutomatico: TBitBtnLocked;
    lblEmpDoc: TLabel;
    edtEmpDoc: TEditFocus;
    pnlLoteSep: TPanel;
    Label13: TLabel;
    Label62: TLabel;
    Bevel1: TBevel;
    edtNumLot: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtEndere: TEditFocus;
    Label4: TLabel;
    edtBairro: TEditFocus;
    lblBairro: TLabel;
    edtPesIni: TEditFocus;
    lblPeso: TLabel;
    edtPesFin: TEditFocus;
    lblPesoAte: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnHlpAutomaticoClick(Sender: TObject);
  private
    intTamDoc : Integer;
    { Private declarations }
  public
    blnConfirma     : Boolean;
    strFiltroNumDoc : String;
    strFiltroEspDoc : String;
    strFiltroEmpDoc : String;
    strFiltroNomCli : String;
    strFiltroNomCid : String;
    strFiltroCodCli : String;
    strFiltroPedVen : String;
    strFiltroNumLot : String;
    strFiltroEmpLot : String;
    strFiltroEndere : String;
    strFiltroBairro : String;
    fltFiltroPesIni : Double;
    fltFiltroPesFin : Double;

    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untMensagemExplicativa;

{$R *.dfm}


function TfrmRomaneioBusca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

  procedure pFecharTela;
  begin
    strFiltroNumDoc := edtNumDoc.Text;
    strFiltroEspDoc := edtEspDoc.Text;
    strFiltroEmpDoc := edtEmpDoc.Text;
    strFiltroNomCli := edtNomCli.Text;
    strFiltroNomCid := edtNomCid.Text;
    strFiltroCodCli := edtCodCli.Text;
    strFiltroPedVen := edtPedVen.Text;
    strFiltroNumLot := edtNumLot.Text;
    strFiltroEmpLot := edtCodEmp.Text;
    strFiltroEndere := edtEndere.Text;
    strFiltroBairro := edtBairro.Text;
    fltFiltroPesIni := StrToFloatDef(edtPesIni.Text,0);
    fltFiltroPesFin := StrToFloatDef(edtPesFin.Text,0);

    blnConfirma := True;
    Close;
  end;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O DOCUMENTO                    *}
    {**************************************JC*}
    If (Sender = edtNumDoc) Then
    Begin
      If (Not fEmptyStr(edtNumDoc.Text)) Then
      Begin
        edtNumDoc.Text := fPreencheEspaco(edtNumDoc.Text, 12, False, '0');
        If (Length(edtNumDoc.Text) = 12) Then
        Begin
          pFecharTela;
        End
        Else If (Length(edtNumDoc.Text) = 20) Then
        Begin
          //D = DOCUMENTO  T = TIPO (ESPECIE) E = EMPRESA V = VOLUME
          //DDDDDDDDDDDDTTEEEVVV
          edtEmpDoc.Text := Copy(edtNumDoc.Text, 15, 3);
          edtEspDoc.Text := fRetCodigoEspecieBarraRomaneio(Copy(edtNumDoc.Text, 13, 2));
          edtNumDoc.Text := Copy(edtNumDoc.Text, 1, 12);

          pFecharTela;
        End
        Else If (Length(edtNumDoc.Text) >= intTamDoc+3) And (fEhLetra(edtNumDoc.Text[intTamDoc+2])) And (fEhLetra(edtNumDoc.Text[intTamDoc+3])) Then
        Begin
          //D = DOCUMENTO  E = (ESPECIE)
          //DDDDDDDDDDDD-EE
          edtEspDoc.Text := Copy(edtNumDoc.Text, intTamDoc+2, 2);
          edtNumDoc.Text := Copy(edtNumDoc.Text, 1, intTamDoc);
          pFecharTela;
        End
        Else
        Begin
          edtNumDoc.Text := fStrZero(edtNumDoc.Text,12);
        End
      End;
    End

    {*****************************************}
    {* VALIDA A ESPECIE                      *}
    {**************************************JC*}
    Else If (Sender = edtEspDoc) Then
    Begin
      If (Not fEmptyStr(edtNumDoc.Text)) and (Not fEmptyStr(edtEspDoc.Text)) then
        pFecharTela;
    End

    Else If (Sender = edtEmpDoc) Then
    Begin

      If (Not fEmptyStr(edtEmpDoc.Text)) And
         fEmptyStr(fRetNomeEmpresaSelec(edtEmpDoc.Text)) Then
      Begin
        pMensagemOk('Empresa não econtrada!');
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O NOME DA CIDADE               *}
    {**************************************JC*}
    Else If (Sender = edtNomCid) Then
    Begin

    End

    Else If (Sender = edtCodCli) Then
    Begin

      If (Not fEmptyStr(edtCodCli.Text)) And
         fEmptyStr(fRetNomCliente(edtCodCli.Text)) Then
      Begin
        pMensagemOk('Cliente não econtrado!');
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O ENDERECO                     *}
    {**************************************JC*}
    Else If (Sender = edtEndere) Then
    Begin
      
    End

    {*****************************************}
    {* VALIDA O NOME DO CLIENTE              *}
    {**************************************JC*}
    Else If (Sender = edtPedVen) Then
    Begin
      If edtPedVen.Visible Then
        pFecharTela;
    End

    Else If (Sender = edtNumLot) and pnlLoteSep.Visible Then
    Begin
      If not fEmptyStr(edtNumLot.Text) Then
      Begin
        Result := not fEmptyStr(fCampoTabela('AUTOINCREM', 'ROMLGE', ['RLG_NUMLOT', 'RLG_CODEMP'], [edtNumLot.Text, edtCodEmp.Text]));
        If not Result Then
          fMensagem('', 'Lote de separação não encontrado!', ['&OK'])
        Else
        Begin
          blnconfirma := True;
          pFecharTela;
        End;
      End

    End

    Else If (Sender = edtPesFin) Then
    Begin
      If StrToFloatDef(edtPesIni.Text,0) > StrToFloatDef(edtPesFin.Text,0)  Then
      Begin
        fMensagem('', 'O Peso Inicial não pode ser maior do que o Peso Final!', ['&OK']);
        Result := False;
      End
      Else
      If Not edtPedVen.Visible Then
        pFecharTela;
    End;

  End;
end;

procedure TfrmRomaneioBusca.FormCreate(Sender: TObject);
begin
  inherited;
  intTamDoc := fTamDocCadRec;

  edtPedVen.TamCampo  := fTamDocCadRec;
  edtPedVen.MaxLength := fTamDocCadRec;

  If Not (fCfgSis('CFVLCB', varBoolean)) Then
  Begin
    lblPedVen.Visible := False;
    edtPedVen.Visible := False;
    Self.Height       := Self.Height - edtPedVen.Height;
  End;

end;

procedure TfrmRomaneioBusca.FormShow(Sender: TObject);
begin
  inherited;
  Self.Height := 340;
  blnConfirma := False;
  Keybd_Event(VK_F2, 0, 0, 0);

  edtNumDoc.Clear;
  edtNomCid.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtPedVen.Clear;
  edtEmpDoc.Clear;
  edtEndere.Clear;

  if not chkAutomatico.Checked then
    edtEspDoc.Clear;

  If Not (fCfgSis('ROMLOT', varBoolean) And (Pos(fCfgSis('OPCROM', varString), '2_3_4_') > 0)) Then
  Begin
    pnlLoteSep.Visible := False;
    Self.Height := Self.Height - pnlLoteSep.Height;
    Self.Width  := 539;
  End
  Else
  Begin
    edtCodEmp.Text := VS_strCodEmp;
    edtNomEmp.Text := fRetNomeEmpresa;
  End;

  If pnlLoteSep.Visible Then
    pSetFocus(edtNumLot)
  Else
    pSetFocus(edtNumDoc);

end;

procedure TfrmRomaneioBusca.btnHlpAutomaticoClick(Sender: TObject);
Var
  strMensag: String;
begin
  strMensag := 'Quando selecionada esta opção, o sistema vai iniciar uma nova busca automaticamente após a última.';

  Try
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    frmMensagemExplicativa.Caption := 'Instrução';
    frmMensagemExplicativa.mmoInstru.Lines.Add(strMensag);
    frmMensagemExplicativa.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmRomaneioBusca.btnHlpLinClick]')
  End;

  pFreeAndNil(frmMensagemExplicativa);

end;

procedure TfrmRomaneioBusca.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, Nil, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRomaneioBusca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not blnConfirma Then
  Begin
    strFiltroNumLot := '';
    strFiltroEmpLot := '';
    strFiltroNumDoc := '';
    strFiltroEspDoc := '';
    strFiltroEmpDoc := '';
    strFiltroNomCli := '';
    strFiltroNomCid := '';
    strFiltroCodCli := '';
    strFiltroPedVen := '';
    strFiltroEndere := '';
  End;
end;

end.
