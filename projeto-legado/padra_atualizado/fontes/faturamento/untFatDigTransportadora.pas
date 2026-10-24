unit untFatDigTransportadora;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, EditFocus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatDigTransportadora = class(TfrmPaiSimples)
    lblNomTra: TLabel;
    edtCodTra: TEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    edtNomTra: TEditFocus;
    pnlFundo: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodTraChange(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaCadTra;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma : Boolean;
  end;


implementation

uses untfuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmFatDigTransportadora.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma       := False;
end;

function TfrmFatDigTransportadora.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodTra) Then
    Begin
      If (fEmptyStr(edtCodTra.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Transportadora deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaCadTra;
        If fEmptyStr(edtNomTra.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Transportadora não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmFatDigTransportadora.pCarregaCadTra;
begin
  edtNomTra.Text := fRetNomTransportadora(edtCodTra.Text);
  If Trim(edtNomTra.Text) = '-' Then
    edtNomTra.Clear;
end;

procedure TfrmFatDigTransportadora.edtCodTraChange(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodTra.Text) Then
    edtNomTra.Clear;
end;

procedure TfrmFatDigTransportadora.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigTransportadora.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigTransportadora.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

end.

