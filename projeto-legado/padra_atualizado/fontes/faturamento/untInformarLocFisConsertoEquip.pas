unit untInformarLocFisConsertoEquip;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus;

type
  TfrmInformarLocFisConsertoEquip = class(TfrmPaiConfirma)
    pnlLocFis: TPanel;
    lblLocFis: TLabel;
    edtLocFis: TEditFocus;
    edtDesLoc: TEditFocus;
    edtCodLoc: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodLocKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    strLocFis: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmInformarLocFisConsertoEquip.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if fCfgSis('ULCFCE', varBoolean) then
    strLocFis := edtCodLoc.Text
  else
    strLocFis := edtLocFis.Text;
end;

procedure TfrmInformarLocFisConsertoEquip.edtCodLocKeyPress(Sender: TObject; var Key: Char);
var
  LLoc: TConsultasArray;
begin
  inherited;

  if fPesqLocFisConsertoEquip(Self, edtCodLoc, edtDesLoc, nil, Key, LLoc) then
  begin
    if fValidaCampos(edtCodLoc, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmInformarLocFisConsertoEquip.FormCreate(Sender: TObject);
begin
  inherited;

  strLocFis := '';
  edtLocFis.Visible := (not fCfgSis('ULCFCE', varBoolean));
  edtCodLoc.Visible := (not edtLocFis.Visible);
  edtDesLoc.Visible := (not edtLocFis.Visible);
  Self.Height := 115;
end;

function TfrmInformarLocFisConsertoEquip.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (inherited fValidaCampos(Sender)) then
  begin
    if (Sender = edtCodLoc) and edtCodLoc.Visible then
    begin
      if (not fEmptyStr(edtCodLoc.Text)) then
      begin
        edtDesLoc.Text := fRetDescLocFisicaOS(edtCodLoc.Text);

        if fEmptyStr(edtDesLoc.Text) then
        begin
          Result := False;
          fMensagem('Aviso', 'Localização não encontrada!', ['&Ok']);
        end;
      end
      else
      begin
        Result := False;
        fMensagem('Aviso', 'Informa a localização!', ['&Ok']);
      end;
    end;
  end;

  if (not Result) then
    pSetFocus(Sender);
end;

end.
