unit untHerancaCampanha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Uni;

type
  TfrmHerancaCampanha = class(TfrmPai)
    pnlCliente: TPanel;
    lblCliente: TLabel;
    edtDesCmg: TEditFocus;
    edtCodCmg: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure edtCodCmgKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodCmg : String;
    strEmpCmg : String;
    blnConfirma   : Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmHerancaCampanha.btnConfirmaClick(Sender: TObject);
begin

  inherited;

  if not fVerificaCampos then
    Exit;

  strCodCmg := edtCodCmg.Text;

  blnConfirma := True;
  Close;

end;

procedure TfrmHerancaCampanha.edtCodCmgKeyPress(Sender: TObject; var Key: Char);
var
  qryCamGer : TUniQuery;
  arrSel    : TConsultasArray;

begin
  inherited;

  qryCamGer := fCriaQuery;

  if fPesqCampanha(Self, edtCodCmg, edtDesCmg, nil, Key, arrSel) then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndnil(qryCamGer);
end;

procedure TfrmHerancaCampanha.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

function TfrmHerancaCampanha.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin

    If Sender = edtCodCmg Then
    Begin
      edtDesCmg.Text := fCampoTabela('CMG_DESCMG', 'CAMGER', ['CMG_CODCMG'], [edtCodCmg.Text]);
      strEmpCmg      := fCampoTabela('CMG_CODEMP', 'CAMGER', ['CMG_CODCMG'], [edtCodCmg.Text]);

      If fEmptyStr(edtCodCmg.Text) Then
      Begin
        pMensagemOk('Informe o código da campanha!');
        Result := False;
      End
      Else If fEmptyStr(edtDesCmg.Text) Then
      Begin
        pMensagemOk('Campanha não encontrada com este código!');
        Result := False;
      End
    End;

    If Not Result Then
      pSetFocus(Sender);

  End;

end;

end.
