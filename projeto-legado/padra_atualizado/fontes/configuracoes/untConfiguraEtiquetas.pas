unit untConfiguraEtiquetas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Uni;

type
  TfrmConfiguraEtiquetas = class(TfrmPaiConfirma)
    Bevel1: TBevel;
    lblDescricaoEtiqueta: TLabel;
    chbLaser: TCheckBox;
    chbZebra: TCheckBox;
    chbArgox: TCheckBox;
    edtLaser: TEditFocus;
    edtZebra: TEditFocus;
    edtArgox: TEditFocus;
    btnLaser: TBitBtnLocked;
    btnZebra: TBitBtnLocked;
    btnArgox: TBitBtnLocked;
    procedure btnLaserClick(Sender: TObject);
    procedure btnZebraClick(Sender: TObject);
    procedure btnArgoxClick(Sender: TObject);
    procedure chbLaserClick(Sender: TObject);
    procedure chbZebraClick(Sender: TObject);
    procedure chbArgoxClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FNomCfg : String;
    procedure pCarregaConfiguracaoEtiqueta;
    procedure pGravaCfg;
  public
    procedure pSetNomCfg(strNomCfg : String);
    class procedure pShow(strNomCfg : String);
  end;




implementation

uses
  untFuncoesSimples, untCfgRel;

{$R *.dfm}

{ TfrmConfiguraEtiquetas }

procedure TfrmConfiguraEtiquetas.btnArgoxClick(Sender: TObject);
begin
  inherited;
  edtArgox.Text := TCfgRel.fSelecionaFila(FNomCfg, '', fCfgSis('CADIMP', VarBoolean) Or TCfgRel.VS_SpoolImpressaoCitel);
  chbArgox.Checked := not fEmptyStr(edtArgox.Text);
end;

procedure TfrmConfiguraEtiquetas.btnLaserClick(Sender: TObject);
begin
  inherited;
  edtLaser.Text := TCfgRel.fSelecionaFila(FNomCfg, '', fCfgSis('CADIMP', VarBoolean) Or TCfgRel.VS_SpoolImpressaoCitel);
  chbLaser.Checked := not fEmptyStr(edtLaser.Text);
end;

procedure TfrmConfiguraEtiquetas.btnZebraClick(Sender: TObject);
begin
  inherited;
  edtZebra.Text := TCfgRel.fSelecionaFila(FNomCfg, '', fCfgSis('CADIMP', VarBoolean) Or TCfgRel.VS_SpoolImpressaoCitel);
  chbZebra.Checked := not fEmptyStr(edtZebra.Text);
end;

procedure TfrmConfiguraEtiquetas.chbArgoxClick(Sender: TObject);
begin
  inherited;
  if chbArgox.Checked Then
  Begin
    if fEmptyStr(edtArgox.Text) Then
      btnArgoxClick(Nil);
  End
  Else
    edtArgox.Clear;
end;

procedure TfrmConfiguraEtiquetas.chbLaserClick(Sender: TObject);
begin
  inherited;
  if chbLaser.Checked Then
  Begin
    if fEmptyStr(edtLaser.Text) Then
      btnLaserClick(Nil);
  End
  Else
    edtLaser.Clear;
end;

procedure TfrmConfiguraEtiquetas.chbZebraClick(Sender: TObject);
begin
  inherited;
  if chbZebra.Checked Then
  Begin
    if fEmptyStr(edtZebra.Text) Then
      btnZebraClick(Nil);
  End
  Else
    edtZebra.Clear;
end;

procedure TfrmConfiguraEtiquetas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If ModalResult = MrOK Then
    pGravaCfg;
  inherited;

end;

procedure TfrmConfiguraEtiquetas.pGravaCfg;
  Var
    qryCfgEti : TUniQuery;
Begin
  Try
    qryCfgEti := fCriaQuery;
    With qryCfgEti, SQL Do
    Begin
      Close;
      Clear;
      Add('REPLACE INTO CFGETI(CFG_NOMETI, CFG_CODEMP, CFG_ARGOX_, CFG_LASER_, CFG_ZEBRA_) ');
      Add('VALUE(:NOMETI, :CODEMP, :ARGOX_, :LASER_, :ZEBRA_) ');

      ParamByName('NOMETI').AsString := FNomCfg;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ARGOX_').AsString := edtArgox.Text;
      ParamByName('LASER_').AsString := edtLaser.Text;
      ParamByName('ZEBRA_').AsString := edtZebra.Text;

      ExecSQL;

    End;
  Finally
    FreeAndNil(qryCfgEti);
  End;

End;

procedure TfrmConfiguraEtiquetas.pSetNomCfg(strNomCfg: String);
begin
  FNomCfg := strNomCfg;
  pCarregaConfiguracaoEtiqueta;
end;

procedure TfrmConfiguraEtiquetas.pCarregaConfiguracaoEtiqueta;
  Var
    qryCfgEti : TUniQuery;
Begin
  Try
    lblDescricaoEtiqueta.Caption := 'Configurando: ' + fCampoTabela('SIS_DESCRI', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], [FNomCfg, VS_strCodEmp]);
    qryCfgEti := fCriaQuery;
    With qryCfgEti, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM CFGETI       ');
      Add('WHERE CFG_NOMETI = :NOMETI ');
      Add('  AND CFG_CODEMP = :CODEMP ');

      ParamByName('NOMETI').AsString := FNomCfg;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      edtLaser.Text := FieldByName('CFG_LASER_').AsString;
      edtZebra.Text := FieldByName('CFG_ZEBRA_').AsString;
      edtArgox.Text := FieldByName('CFG_ARGOX_').AsString;

      chbLaser.Checked := not fEmptyStr(FieldByName('CFG_LASER_').AsString);
      chbZebra.Checked := not fEmptyStr(FieldByName('CFG_ZEBRA_').AsString);
      chbArgox.Checked := not fEmptyStr(FieldByName('CFG_ARGOX_').AsString);
    End;

  Finally
    FreeAndNil(qryCfgEti);
  End;

End;

class procedure TfrmConfiguraEtiquetas.pShow(strNomCfg: String);
  var
    frmConfiguraEtiquetas: TfrmConfiguraEtiquetas;
begin
  Try
    pCriarFormularios(TfrmConfiguraEtiquetas, frmConfiguraEtiquetas);
    frmConfiguraEtiquetas.pSetNomCfg(strNomCfg);
    frmConfiguraEtiquetas.ShowModal();
  Finally
    FreeAndNIl(frmConfiguraEtiquetas)
  End;

end;

end.
