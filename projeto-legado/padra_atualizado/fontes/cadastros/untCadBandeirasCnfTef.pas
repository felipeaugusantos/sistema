unit untCadBandeirasCnfTef;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.DBCtrls, DBComboBoxFocus,
  Vcl.Mask, DBEditFocus, Datasnap.DBClient, UniClientDataSet;

type
  TfrmCadBandeirasCnfTef = class(TfrmPaiConfirma)
    dtsCnfTef: TDataSource;
    dbeTftBan: TDBEditFocus;
    dbeTfBan2: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeTipCar: TDBComboBoxFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FcdsVerifica: TUniClientDataSet ;
    function fVerificaJaCadastradoNoCds(): Boolean ;
  public
    { Public declarations }
    property CdsVerifica: TUniClientDataSet read FcdsVerifica write FcdsVerifica ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untfuncoesSimples ;

{$R *.dfm}

{ TfrmCadBandeirasCnfTef }

procedure TfrmCadBandeirasCnfTef.btnConfirmaClick(Sender: TObject);
begin
  if fVerificaJaCadastradoNoCds then
    Exit ;

  ModalResult := mrOk ;
end;

procedure TfrmCadBandeirasCnfTef.FormCreate(Sender: TObject);
begin
  inherited;
  FcdsVerifica := Nil ;
end;

function TfrmCadBandeirasCnfTef.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    if (Sender = dbeTftBan) then
    begin
      dbeTftBan.Field.AsString := fStrZero(dbeTftBan.Field.AsString, 5) ;
    end
    else if (Sender = dbeTfBan2) then
    begin
      dbeTfBan2.Field.AsString := fStrZero(dbeTfBan2.Field.AsString, 5) ;
    end ;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmCadBandeirasCnfTef.fVerificaJaCadastradoNoCds: Boolean;
begin
  Result := False ;
  if not Assigned(FcdsVerifica) then
    Exit ;

  if FcdsVerifica.Locate('BAN_TFTBAN', dbeTftBan.Text, []) then
  begin
    fMensagem('ATENÇÃO!', format('Cód. Bandeira Fiserv-ClisiTef [%s] já cadastrada!', [dbeTftBan.Text]), ['&OK']);
    pSetFocus(dbeTftBan);
    exit(True) ;
  end ;

  if FcdsVerifica.Locate('BAN_TFBAN2', dbeTfBan2.Text, []) then
  begin
    fMensagem('ATENÇÃO!', format('Cód. Bandeira ConexãoTech-Scope [%s] já cadastrada!', [dbeTfBan2.Text]), ['&OK']);
    pSetFocus(dbeTfBan2);
    exit(True) ;
  end ;
end;

end.
