{***************************}
{* qryConOpe -> CADOPE     *}
{************************JB*}
unit untCtrLiberaPedidosObs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  QColorLabel, EditFocus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, dxGDIPlusClasses, MemoFocus;

type
  TfrmCtrLiberaPedidosObs = class(TfrmPaiSimples)
    Panel1: TPanel;
    pnlRodape: TPanel;
    pnlTopo: TPanel;
    edtObsL01: TEditFocus;
    lblObs: TColorLabel;
    edtObsL02: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    rdbNega: TRadioButton;
    rdbLibera: TRadioButton;
    imgSetaBaixo: TImage;
    Image1: TImage;
    pnlObsAnt: TPanel;
    ColorLabel1: TColorLabel;
    memObsAnt: TMemoFocus;
    pnlDigitador: TPanel;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    qryConOpe: TUniQuery;

    blnInformaDigitador: Boolean;

    procedure pCarregaDigitador;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodDig, strNomDig: String;
    blnFiltroFinanc : Boolean;
  end;

var
  frmCtrLiberaPedidosObs: TfrmCtrLiberaPedidosObs;

implementation

uses untfuncoesSimples, untPesqAux, Data.DB;

{$R *.dfm}

procedure TfrmCtrLiberaPedidosObs.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  rdbLibera.Checked := True;
  blnInformaDigitador := True;
end;

procedure TfrmCtrLiberaPedidosObs.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If btnConfirma.Enabled Then
  Begin
    If (Key = VK_F10) Then
      btnConfirma.Click;
  End;
end;

procedure TfrmCtrLiberaPedidosObs.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtObsL01);

  If fCfgSis('LPVDAC', VarBoolean) Then
    blnInformaDigitador := (Not fVerificaAcessoSistema(IIF(blnFiltroFinanc,'frmCtrLiberacaoFiltros', 'frmCtrLiberacaoFiltrosComercial'), strLoginUsuarioLogado));

  pnlDigitador.Visible := blnInformaDigitador;

  If (Not blnInformaDigitador) Then
  Begin
    edtNomDig.Text := fRetNomeOperador(strLoginUsuarioLogado);
    strCodDig := strLoginUsuarioLogado;
    strNomDig := edtNomDig.Text;
  End;
end;

procedure TfrmCtrLiberaPedidosObs.btnCancelaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Close;
end;

procedure TfrmCtrLiberaPedidosObs.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (Not fValidaCampos(edtSenDig, True)) Then
  Begin
    Exit;
  End;

  blnConfirma := True;
  Close;
end;

function TfrmCtrLiberaPedidosObs.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtSenDig) And (edtSenDig.Enabled) Then
    Begin
      If blnInformaDigitador Then
      Begin
        If fEmptyStr(edtSenDig.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
          pCarregaDigitador;

          If qryConOpe.IsEmpty Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&O k']);
            Result := False;
          End

          {*************************************************}
          {* VERIFICA SE O DIGITADOR TEM DIREITO DE ACESSO *}
          {**********************************************JB*}
          Else If Not fVerificaAcessoSistema(IIF(blnFiltroFinanc,'frmCtrLiberacaoFiltros', 'frmCtrLiberacaoFiltrosComercial'), strCodDig) Then
          Begin

            fMensagem('ATENÇÃO!', 'Esse digitador não tem direito de acesso!', ['&O k']);
            Result := False;

          End;

        End;
      End;

    End

  End;
End;

procedure TfrmCtrLiberaPedidosObs.pCarregaDigitador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtSenDig.Text, True);
  With qryConOpe Do
  Begin
    edtNomDig.Text := FieldByName('OPE_NOMOPE').AsString;
    strCodDig := FieldByName('OPE_CODOPE').AsString;
    strNomDig := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

end.

