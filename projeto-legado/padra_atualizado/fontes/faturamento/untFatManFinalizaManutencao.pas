unit untFatManFinalizaManutencao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus, Uni;

type
  TfrmFatManFinalizaManutencao = class(TfrmPaiConfirma)
    pnlDigitador: TPanel;
    pnlDtaManutencao: TPanel;
    lblDigita: TLabel;
    edtNomOpe: TEditFocus;
    Label2: TLabel;
    mskFinMan: TMaskEditFocus;
    edtCodOpe: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    qryConOpe: TUniQuery;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strDigMan: string;
    dtaFinMan: TDateTime;
  end;

implementation

uses
  untPesqAux, untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatManFinalizaManutencao.btnConfirmaClick(Sender: TObject);
begin
  ModalResult := mrNone;

  if (not fVerificaCampos) then
    Exit;

  if (pnlDtaManutencao.Visible) then
    dtaFinMan := StrToDateDef(mskFinMan.Text, 0);

  inherited;
end;

procedure TfrmFatManFinalizaManutencao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConOpe);
end;

procedure TfrmFatManFinalizaManutencao.FormShow(Sender: TObject);
begin
  inherited;

  if (not fCfgSis('USADIG', varBoolean)) or (not fCfgSis('FXSDFM', varBoolean)) then
  begin
    Self.Height := Self.Height - pnlDigitador.Height;
    pnlDigitador.Visible := False;
    pnlDtaManutencao.Align := alClient;
    pSetFocus(mskFinMan);
  end
  else
    pSetFocus(edtCodOpe);

  if (not fCfgSis('FXDTFM', varBoolean)) then
  begin
    Self.Height := Self.Height - pnlDtaManutencao.Height;
    pnlDtaManutencao.Visible := False;
    pnlDigitador.Align := alClient;
  end;

  dtaFinMan := VS_Date;
  strDigMan := strLoginUsuarioLogado;
end;

function TfrmFatManFinalizaManutencao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtCodOpe) and (pnlDigitador.Visible) then
  begin
    If fEmptyStr(edtCodOpe.Text) Then
    Begin
      fMensagem('AVISO!', 'O operador deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtNomOpe.Text := fRetNomeOperador(edtCodOpe.Text);
      strDigMan := edtCodOpe.Text;

      if fEmptyStr(edtNomOpe.Text) then
      begin
        fMensagem('AVISO', 'Operador não encontrado!', ['&Ok']);
        Result := False;
      end;
    End;
  end
  else if (Sender = mskFinMan) And (pnlDtaManutencao.Visible) Then
  begin
    if (not fEmptyDate(mskFinMan.Text)) Then
    begin
      if StrToDateDef(mskFinMan.Text, 0) <= StrToDate('31/12/1899') Then
      begin
        fMensagem('AVISO', 'Informa uma data válida!', ['&Ok']);
        Result := False;
      end;
    end;
  end;

  if not (Result) then
    pSetFocus(Sender);
end;

end.
