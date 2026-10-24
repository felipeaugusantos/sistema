unit untFatDigPrecoCusto;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus,
  DB, UniClientDataSet, Grids, DBGridCitel, DBGrids, EditFocus, Uni, DBCtrls,
  DBEditFocus, AppEvnts, frxClass, frxDMPExport, frxDBSet, BitBtnLockedIncrem,
  untFuncoesSimples, StrUtils, untTypesSistema, frxExportCSVTestabilidade, untZClient,
  Datasnap.DBClient, untLiberacao, untPaiSimples, Vcl.ComCtrls;
Type
  TTipoValor = (tvPrecoCusto, tvCreditoFornecedor);

type
  TfrmFatDigPrecoCusto = class(TfrmPaiSimples)
    pnlDados: TPanel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    lblNome: TLabel;
    edtPreCus: TEditFocus;
    btnCancelaDados: TBitBtnLocked;
    Label49: TLabel;
    dbeNcmOut: TEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FtvTipoValor: TTipoValor;
    strNomeTipoValor: String;
    FGarantia: Boolean;
    FblnRetornoFornecedor: Boolean;
    procedure SetblnRetornoFornecedor(const Value: Boolean);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    fltPreCus: Double;
    strNcmOut: String;
    strValor:String;
    blnUsarLiberacaoGarantia: Boolean;

    property tvTipoValor: TTipoValor Read FtvTipoValor Write FtvTipoValor;
    property blnGarantia: Boolean Read FGarantia  Write FGarantia;
    property blnRetornoFornecedor: Boolean Read FblnRetornoFornecedor Write SetblnRetornoFornecedor;

  end;


implementation

uses  untConstantes;

{$R *.dfm}

{ TfrmFatDigPrecoCusto }

function TfrmFatDigPrecoCusto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtPreCus) Then
    Begin

      If fEmptyStr(edtPreCus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor de ' + strNomeTipoValor + ' deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtPreCus.Text) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor de ' + strNomeTipoValor + ' deve ser maior que Zero!', ['&O k']);
        Result := False;
      End;

    End
    Else If ((Sender = dbeNcmOut) and dbeNcmOut.Visible) Then
    Begin
      If fEmptyStr(dbeNcmOut.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o NCM do item!', ['&O k']);
        Result := False;
      End
      Else If Not fEmptyStr(dbeNcmOut.Text) And (Length(dbeNcmOut.Text) <> MAX_CLAIPI) Then
      Begin
        fMensagem('ATENÇÃO!', 'O NCM deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&Ok']);
        Result := False;
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmFatDigPrecoCusto.btnConfirmaDadosClick(Sender: TObject);
var
  objLiberacao :TLiberacao;
begin
  inherited;
  If fVerificaCampos Then
  Begin
    If (blnGarantia And blnUsarLiberacaoGarantia) Then
    Begin
      If (strValor <> edtPreCus.Text) Then
      Begin
        objLiberacao := TLiberacao.Create;
        Try
          objLiberacao.strDirAce := 'SENAVG';
          objLiberacao.strSenLib := fCfgSis('SENAVG');

          objLiberacao.objMsgLibera.pAddTexto('Geração de crédito para Fornecedor (Garantia)');
          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddTextoCaption('Valor do item alterado de', strValor+' para '+edtPreCus.Text);

          objLiberacao.strMsgSen := 'Permitir alterar o valor (Garantia) '+#13+
                                    'de R$'+strValor+' para R$'+edtPreCus.Text+'.';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.strCodDig := strLoginUsuarioLogado;

          If (Not objLiberacao.fLibera) Then
            Exit
          Else
            blnConfirma := True;

        Finally
          if Assigned(objLiberacao) then
            FreeAndNil(objLiberacao);
        End;
      End
      Else
        blnConfirma := True;
    End
    Else
      blnConfirma := True;
    Close;
  End;
end;

procedure TfrmFatDigPrecoCusto.btnCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFatDigPrecoCusto.FormCreate(Sender: TObject);
begin
  inherited;
  FblnRetornoFornecedor := False;
  blnUsarLiberacaoGarantia := True;
  blnConfirma := False;
  blnGarantia := False;
  strValor    := '';
  tvTipoValor := tvPrecoCusto;

  fltPreCus := 0;
end;

procedure TfrmFatDigPrecoCusto.FormShow(Sender: TObject);
begin
  inherited;

  If tvTipoValor = tvCreditoFornecedor Then
  Begin
    strNomeTipoValor := 'Crédito Fornecedor';
    Self.Caption     := 'Digitação de Crédito Fornecedor';
    lblNome.Caption  := 'Crédito Fornecedor: ';

    dbeNcmOut.Visible := Not blnRetornoFornecedor;
    Label49.Visible := dbeNcmOut.Visible;

  End
  Else If tvTipoValor = tvPrecoCusto Then
  Begin
    strNomeTipoValor := 'Preço Custo';
    Self.Caption     := 'Digitação de Preço de Custo';
    lblNome.Caption  := 'Preço de Custo: ';
    edtPreCus.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    edtPreCus.Text       := FloatToStrF(0, ffFixed, 12, fCfgSis('DECUNI', varInteger));

    dbeNcmOut.Visible := True;
    Label49.Visible := dbeNcmOut.Visible;
  End;

  If (fltPreCus > 0) Then
    edtPreCus.Text := FloatToStrF(fltPreCus, ffFixed, 12, fCfgSis('DECUNI', varInteger));

  dbeNcmOut.Text := strNcmOut;
end;

procedure TfrmFatDigPrecoCusto.SetblnRetornoFornecedor(const Value: Boolean);
begin
  FblnRetornoFornecedor := Value;
  if FblnRetornoFornecedor Then
    blnUsarLiberacaoGarantia := False;
end;


end.

