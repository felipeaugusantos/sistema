unit untConsertoEquipFinalizacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.Mask, MaskEditFocus,
  untMskTelefone, Vcl.StdCtrls, EditFocus, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Uni;

type
  TfrmConsertoEquipFinalizacao = class(TfrmPai)
    pnlFundo: TPanel;
    lblReaPor: TLabel;
    edtReaPor: TEditFocus;
    Label1: TLabel;
    mskReaTel: TMaskEditTelefone;
    btnConfirma: TBitBtnLocked;
    Label2: TLabel;
    mskSitDtr: TMaskEditFocus;
    edtRea_RG: TEditFocus;
    lblRea_RG: TLabel;
    edtLocFis: TEditFocus;
    lblLocFis: TLabel;
    pnlDigitador: TPanel;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    edtCodLoc: TEditFocus;
    edtDesLoc: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryConOpe: TUniQuery;
    procedure pCarregaDigitador;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strRea_RG,
    strReaPor,
    strReaTel,
    strLocFis,
    strDigRet: String;
    dtaSitDtr: TDateTime;
  end;

implementation

uses untFuncoesSimples, untPesqAux;

{$R *.dfm}

procedure TfrmConsertoEquipFinalizacao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if not fValidaCampos(edtSenDig, True) then
    Exit;

  if (not pnlDigitador.Visible) then
    strDigRet := strLoginUsuarioLogado;

  strRea_RG := edtRea_RG.Text;
  strReaPor := edtReaPor.Text;
  strReaTel := fTiraCaracEspeciais(mskReaTel.Text);
  dtaSitDtr := StrToDateDef(mskSitDtr.Text, 0);
  btnSair.Click();
end;

procedure TfrmConsertoEquipFinalizacao.FormCreate(Sender: TObject);
begin
  inherited;
  strLocFis := '';
  strReaPor := '';
  strRea_RG := '';
  strReaTel := '';
  dtaSitDtr := 0;
  strDigRet := '';

  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);

  edtLocFis.Visible := (not fCfgSis('ULCFCE', varBoolean));
  edtCodLoc.Visible := (not edtLocFis.Visible);
  edtDesLoc.Visible := (not edtLocFis.Visible);
end;

procedure TfrmConsertoEquipFinalizacao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConOpe);
end;

procedure TfrmConsertoEquipFinalizacao.FormShow(Sender: TObject);
begin
  inherited;

  if fCfgSis('ULCFCE', varBoolean) then
  begin
    edtCodLoc.Text := strLocFis;
    edtDesLoc.Text := fRetDescLocFisicaOS(strLocFis);
  end
  else
    edtLocFis.Text := strLocFis;

  edtReaPor.Text := strReaPor;
  edtRea_RG.Text := strRea_RG;
  mskReaTel.Text := strReaTel;

  if dtaSitDtr > 0 then
    mskSitDtr.Text := DateToStr(dtaSitDtr);

  if (not fCfgSis('USADIG', varBoolean)) then
  begin
    Self.Height := Self.Height - pnlDigitador.Height;
    pnlDigitador.Visible := False;
    pSetFocus(edtReaPor);
  end
  else
    pSetFocus(edtSenDig);
end;

function TfrmConsertoEquipFinalizacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtSenDig) and (pnlDigitador.Visible) then
  begin
    if fEmptyStr(edtSenDig.Text) then
    begin
      fMensagem('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&Ok']);
      Result := False;
    end
    else
    begin
      pCarregaDigitador;

      if qryConOpe.FieldByName('OPE_CODOPE').IsNull then
      begin
        fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&Ok']);
        Result := False;
      end
      else If qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' then
      begin
        fMensagem('ATENÇÃO!', 'Digitador está inativo!', ['&Ok']);
        Result := False;
      end;
    end;
  end;
end;

procedure TfrmConsertoEquipFinalizacao.pCarregaDigitador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtSenDig.Text, True);
  edtNomDig.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  strDigRet := qryConOpe.FieldByName('OPE_CODOPE').AsString;
end;

end.
