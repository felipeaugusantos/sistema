unit untConsertoEquipInformaOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, EditFocus,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmConsertoEquipInformaOS = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlFundo: TPanel;
    lblNumOSe: TLabel;
    lblEmpresa: TLabel;
    edtNumOSe: TEditFocus;
    edtDesEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strNumOSe,
    strCodEmp: String;
    blnConfirma: Boolean;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmConsertoEquipInformaOS.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if fVerificaCampos then
  begin
    strNumOSe := edtNumOSe.Text;
    strCodEmp := IIF((edtCodEmp.Visible), edtCodEmp.Text, VS_strCodEmp);
    blnConfirma := True;
    Close;
  end;
end;

procedure TfrmConsertoEquipInformaOS.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, nil, Key, arrSel) then
  begin
    if fValidaCampos(edtCodEmp, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConsertoEquipInformaOS.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

  if (not fCfgSis('MAOSEM', varBoolean)) then
  begin
    edtCodEmp.Visible := False;
    edtDesEmp.Visible := False;

    Self.Height := Self.Height - edtCodEmp.Height - 5;
  end;

  pSetFocus(edtNumOSe);
end;

function TfrmConsertoEquipInformaOS.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtNumOSe) then
  begin
    if (fEmptyStr(edtNumOSe.Text)) then
    begin
      fMensagem('','O número da OS deve ser preenchido!', ['&OK']);
      Result := False;
    end
  end
  else if (Sender = edtCodEmp) and (edtCodEmp.Visible) then
  begin
    edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

    if fEmptyStr(edtDesEmp.Text) then
    begin
      fMensagem('','O código da empresa informado não é válido!', ['&OK']);
      Result := False;
    end;
  end;

  if not (Result) then
    pSetFocus(Sender);
end;

end.
