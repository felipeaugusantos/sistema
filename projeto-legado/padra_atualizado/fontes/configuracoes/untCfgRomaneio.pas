unit untCfgRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DBCtrls, DBEditFocus, StdCtrls, EditFocus,
  QColorLabel, Menus, Buttons, ExtCtrls, AppEvnts;

type
  TfrmCfgRomaneio = class(TfrmPai)
    btnGravar: TBitBtn;
    pnlCentral: TPanel;
    Label5: TLabel;
    ColorLabel5: TColorLabel;
    dbeOpcRom: TDBEditFocus;
    Label1: TLabel;
    ColorLabel1: TColorLabel;
    dbeTrBrRo: TDBEditFocus;
    Label2: TLabel;
    dbeDiaRom: TDBEditFocus;
    dbeMesRo1: TDBEditFocus;
    Label3: TLabel;
    dbeMesRo2: TDBEditFocus;
    Label4: TLabel;
    Label6: TLabel;
    ColorLabel2: TColorLabel;
    dbeRomPar: TDBEditFocus;
    edtSenRom: TEditFocus;
    Label41: TLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    procedure pGravaArqIni;
    procedure pCarregaArqIni;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCfgRomaneio: TfrmCfgRomaneio;

implementation

uses untModulo, untFuncoes, untfuncoesSimples;

{$R *.dfm}

{ TfrmCfgRomaneio }

function TfrmCfgRomaneio.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeOpcRom) Then
  Begin

    If Pos(dbeOpcRom.Text,'1_2_') <= 0 Then
      Result := False;
      
  End

  Else If (Sender = dbeTrBrRo) Then
  Begin

    If Pos(dbeTrBrRo.Text,'S_N_') <= 0 Then
      Result := False;

  End

  Else If (Sender = dbeDiaRom) Then
  Begin

    If (fEmptyStr(dbeDiaRom.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de dias para romaneio deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (StrToInt(dbeDiaRom.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de dias para romaneio deve maoir ou igual a Zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeRomPar) Then
  Begin

    If Pos(dbeRomPar.Text,'S_N_') <= 0 Then
      Result := False;

  End;

  If (Not Result) Then
    Sender.SetFocus;

end;

procedure TfrmCfgRomaneio.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    pGravaArqIni;

    Close;
    ModalResult := mrOk;
  End;

end;

procedure TfrmCfgRomaneio.pCarregaArqIni;
begin
  {************************************}
  {* SENHA PARA VISUALIZAR O ROMANEIO *}
  {*********************************JB*}
  edtSenRom.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENROM').AsString;

end;

procedure TfrmCfgRomaneio.pGravaArqIni;
begin
  {************************************}
  {* SENHA PARA VISUALIZAR O ROMANEIO *}
  {*********************************JB*}
  frmModulo.qryCadCfg.FieldByName('CFG_SENROM').AsString := edtSenRom.Text;

end;


procedure TfrmCfgRomaneio.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaArqIni;

end;

initialization
  RegisterClass(TfrmCfgRomaneio);
finalization
  UnRegisterClass(TfrmCfgRomaneio);

end.

