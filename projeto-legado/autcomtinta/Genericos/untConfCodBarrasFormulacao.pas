unit untConfCodBarrasFormulacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, DB, UniClientDataSet, untTipoTinta;

type
  TfrmConfCodBarrasFormulacao = class(TfrmPaiConfirma)
    lblEti: TLabel;
    lblEmb: TLabel;
    edtCodBarEti: TEditFocus;
    edtCodBarEmb: TEditFocus;
    shpEti: TShape;
    shpEmb: TShape;
    tmrConfirma: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodBarEtiChange(Sender: TObject);
    procedure edtCodBarEmbChange(Sender: TObject);
    procedure tmrConfirmaTimer(Sender: TObject);
  private
    { Private declarations }
    strIdePro: String;
    tTinta: TTipoTinta;

    procedure pDefineLabel;
    procedure pDefineIdePro;
    procedure pDefineTipoTinta;
    procedure pAvisoCodigoBarras;
    function fCampoEmbalagem: String;
    function fValidaCodBarEmbalagem: Boolean;
  public
    { Public declarations }
    cdsFormul: TUniClientDataSet; //Guarda apenas o registro selecionado
    strCfgExi: String;
  end;

var
  frmConfCodBarrasFormulacao: TfrmConfCodBarrasFormulacao;

implementation

uses untFuncoesSimples, untFuncTinta;

{$R *.dfm}

procedure TfrmConfCodBarrasFormulacao.edtCodBarEmbChange(Sender: TObject);
begin
  inherited;
  If cdsFormul.Locate(fCampoEmbalagem, edtCodBarEmb.Text, []) Then
  Begin
    shpEmb.Brush.Color := clGreen;
    shpEmb.Tag := 1;
  End
  Else
  Begin
    shpEmb.Brush.Color := clRed;
    shpEmb.Tag := 0;
  End;
end;

procedure TfrmConfCodBarrasFormulacao.edtCodBarEtiChange(Sender: TObject);
begin
  inherited;
  If cdsFormul.Locate('CODBAR_ACA', edtCodBarEti.Text, []) Then
  Begin
    shpEti.Brush.Color := clGreen;
    shpEti.Tag := 1;
  End
  Else
  Begin
    shpEti.Brush.Color := clRed;
    shpEti.Tag := 0;
  End;
end;

function TfrmConfCodBarrasFormulacao.fCampoEmbalagem: String;
begin
  If tTinta = ttAutomotiva Then
    Result := 'CODBAR_EMB'
  Else
    Result := 'CODBAR_BASE';
end;

procedure TfrmConfCodBarrasFormulacao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodBarEti);
end;

procedure TfrmConfCodBarrasFormulacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Assigned(cdsFormul) Then FreeAndNil(cdsFormul);
  inherited;
end;

procedure TfrmConfCodBarrasFormulacao.FormShow(Sender: TObject);
begin
  inherited;
  pDefineIdePro;
  pDefineTipoTinta;
  pDefineLabel;
  pAvisoCodigoBarras;
end;

function TfrmConfCodBarrasFormulacao.fValidaCodBarEmbalagem: Boolean;
begin
  Result := True;

  if tTinta <> ttAutomotiva then
    Exit;

  if not fCfgSis('AUTEMB', varBoolean) then
    Exit;

  Result := not fEmptyStr(cdsFormul.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ITEEMB').AsString);

end;

procedure TfrmConfCodBarrasFormulacao.pAvisoCodigoBarras;
var
  strMens: String;
begin
  strMens := '';

  If fEmptyStr(cdsFormul.FieldByName('CODBAR_ACA').AsString) Then
    strMens := 'Código de barras da etiqueta não está cadastrado !';

  If tTinta = ttAutomotiva Then
  Begin
    If (fValidaCodBarEmbalagem) and (fEmptyStr(cdsFormul.FieldByName('CODBAR_EMB').AsString)) Then
      strMens := strMens + #13#10 + 'Código de barras da embalagem não está cadastrado !';
  End;

  If tTinta = ttImobiliaria Then
  Begin
    If fEmptyStr(cdsFormul.FieldByName('CODBAR_BASE').AsString) Then
      strMens := strMens + #13#10 + 'Código de barras da base não está cadastrado !';
  End;

  If (Not fEmptyStr(strMens)) Then
  Begin
    fMensagem('ATENÇÃO', strMens, ['&Ok']);
    btnConfirma.Enabled := False;
  End;
end;

procedure TfrmConfCodBarrasFormulacao.pDefineIdePro;
var
  strNomCam: String;
begin
  If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
    strNomCam := 'DET_IDEPRO'
  Else
    strNomCam := 'FDO_IDEPRO';

  strIdePro := cdsFormul.FieldByName(strNomCam).AsString;
end;

procedure TfrmConfCodBarrasFormulacao.pDefineLabel;
begin
  Case tTinta Of
    ttAutomotiva : lblEmb.Caption := 'Código de barras da embalagem:';
    ttImobiliaria: lblEmb.Caption := 'Código de barras da base:';
  End;
end;

procedure TfrmConfCodBarrasFormulacao.pDefineTipoTinta;
begin
  Case fTipoTinta(strIdePro) Of
    ttAutomotiva : tTinta := ttAutomotiva;
    ttIndustrial : tTinta := IIF(Pos(strIdePro, 'MZD_KIN_') > 0, ttAutomotiva, ttImobiliaria);
    ttImobiliaria: tTinta := ttImobiliaria;
  End;
end;

procedure TfrmConfCodBarrasFormulacao.tmrConfirmaTimer(Sender: TObject);
begin
  inherited;
  Try
    Screen.Cursor := crDefault;
    btnConfirma.Enabled := (shpEti.Tag > 0) And ((shpEmb.Tag > 0) or (not fValidaCodBarEmbalagem));
    If btnConfirma.Enabled Then
      btnConfirma.Click;
  Finally
    Screen.Cursor := crDefault;
  End;
end;

end.
