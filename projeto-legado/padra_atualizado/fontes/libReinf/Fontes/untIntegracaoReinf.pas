unit untIntegracaoReinf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, ACBrReinf, Data.DB,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, Uni,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, EditFocus, ComboBoxFocus, untEventoR1000,
  untReinfEventos, untFechamentoReaberturaEventos;

type
  TfrmIntegracaoReinf = class(TfrmPaiConfirma)
    pnlSuperior: TPanel;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    rdgEventos: TRadioGroup;
    pnlEventos: TPanel;
    lblAmbiente: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdgEventosClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpChange(Sender: TObject);
  private
    { Private declarations }
    ACBrReinf: TACBrReinf;

    FfrmEventoR1000: TfrmEventoR1000;
    FfrmEventoR2010: TfrmEventosReinf;
    FfrmEventoR2020: TfrmEventosReinf;
    FfrmEventoR4010: TfrmEventosReinf;
    FfrmEventoR4020: TfrmEventosReinf;
    FfrmEventoR4080: TfrmEventosReinf;
    FfrmFechamentoReaberturaEventos2000: TfrmFechamentoReaberturaEventos;
    FfrmFechamentoReaberturaEventos4000: TfrmFechamentoReaberturaEventos;

    strPathReinf: String;
    blnIntegracaoConfigurada: Boolean;

    procedure pConfigurarIntegracao;
    procedure pEnabledR4080;
    procedure pEnabledR4020;
    procedure pEnabledR4010;
    procedure pEnabledR2020;
    procedure pEnabledR2010;
    procedure pEnabledR1000;
    procedure pEnabledFechAber2000;
    procedure pEnabledFechAber4000;
    procedure pCriarTelaEvento;
    procedure pCriaFrmR1000;
    procedure pCriaFrmR2010;
    procedure pCriaFrmR2020;
    procedure pCriaFrmR4010;
    procedure pCriaFrmR4020;
    procedure pCriaFrmR4080;
    procedure pCriaFrmFechamentoReaberturaEventos2000;
    procedure pCriaFrmFechamentoReaberturaEventos4000;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando, ACBrDFeSSL, pcnConversaoReinf, blcksock,
  pcnConversao, untConsultas, untTypesSistema;

procedure TfrmIntegracaoReinf.edtCodEmpChange(Sender: TObject);
begin
  inherited;
  blnIntegracaoConfigurada := False;

  if Assigned(FfrmEventoR2020) then
    FfrmEventoR2020.Enabled := False;

  if Assigned(FfrmEventoR2010) then
    FfrmEventoR2010.Enabled := False;

  if Assigned(FfrmEventoR1000) then
    FfrmEventoR1000.Enabled := False;

  if Assigned(FfrmEventoR4010) then
    FfrmEventoR4010.Enabled := False;

  if Assigned(FfrmEventoR4020) then
    FfrmEventoR4020.Enabled := False;

  if Assigned(FfrmEventoR4080) then
    FfrmEventoR4080.Enabled := False;

  if Assigned(FfrmFechamentoReaberturaEventos2000) then
    FfrmFechamentoReaberturaEventos2000.Enabled := False;

  if Assigned(FfrmFechamentoReaberturaEventos4000) then
    FfrmFechamentoReaberturaEventos4000.Enabled := False;
end;

procedure TfrmIntegracaoReinf.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrSel, True, True) Then
    fValidaCampos(edtCodEmp, True);
end;

procedure TfrmIntegracaoReinf.FormCreate(Sender: TObject);
begin
  inherited;
  blnIntegracaoConfigurada := False;

  strPathReinf := ExtractFileDir(Application.ExeName) + '\Reinf';

  If Not DirectoryExists(strPathReinf) Then
  Begin
    CreateDir(strPathReinf);
  End;
end;

procedure TfrmIntegracaoReinf.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FfrmEventoR1000) then
    FreeAndNil(FfrmEventoR1000);

  if Assigned(FfrmEventoR2010) then
    FreeAndNil(FfrmEventoR2010);

  if Assigned(FfrmEventoR2020) then
    FreeAndNil(FfrmEventoR2020);

  if Assigned(FfrmEventoR4010) then
    FreeAndNil(FfrmEventoR4010);

  if Assigned(FfrmEventoR4020) then
    FreeAndNil(FfrmEventoR4020);

  if Assigned(FfrmEventoR4080) then
    FreeAndNil(FfrmEventoR4080);

  if Assigned(FfrmFechamentoReaberturaEventos2000) then
    FreeAndNil(FfrmFechamentoReaberturaEventos2000);

  if Assigned(FfrmFechamentoReaberturaEventos4000) then
    FreeAndNil(FfrmFechamentoReaberturaEventos4000);

  if Assigned(ACBrReinf) then
    FreeAndNil(ACBrReinf);
end;

procedure TfrmIntegracaoReinf.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //inherited;
  if Assigned(FfrmEventoR1000) then
    FfrmEventoR1000.blnMudarFoco := False;

  if Assigned(FfrmEventoR2010) then
    FfrmEventoR2010.blnMudarFoco := False;

  if Assigned(FfrmEventoR2020) then
    FfrmEventoR2020.blnMudarFoco := False;

  if Assigned(FfrmEventoR4010) then
    FfrmEventoR4010.blnMudarFoco := False;

  if Assigned(FfrmEventoR4020) then
    FfrmEventoR4020.blnMudarFoco := False;

  if Assigned(FfrmEventoR4080) then
    FfrmEventoR4080.blnMudarFoco := False;

  if Assigned(FfrmFechamentoReaberturaEventos2000) then
    FfrmFechamentoReaberturaEventos2000.blnMudarFoco := False;

  if Assigned(FfrmFechamentoReaberturaEventos4000) then
    FfrmFechamentoReaberturaEventos4000.blnMudarFoco := False;

  if Key = VK_RETURN then
    Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmIntegracaoReinf.FormShow(Sender: TObject);
begin
  inherited;
  ACBrReinf := TACBrReinf.Create(Self);

  if fCfgSis('AMBREI', varInteger) = 1 then
  begin
    lblAmbiente.Caption := 'AMBIENTE: PRODUÇÃO     ';
    lblAmbiente.Font.Color := $0000CC00;
  end;

  pCriarTelaEvento;
end;

function TfrmIntegracaoReinf.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    if Sender = edtCodEmp then
    begin
      blnIntegracaoConfigurada := False;

      if fEmptyStr(edtCodEmp.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Informe a Empresa!', ['&Ok']);
        Result := False;
      end
      else
      begin
        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
        if fEmptyStr(edtNomEmp.Text) then
        begin
          fMensagem('ATENÇÃO!', 'Empresa inválida!', ['&Ok']);
          Result := False;
        end
        else
        begin
          rdgEventos.ItemIndex := 0;
          pConfigurarIntegracao;

          if blnIntegracaoConfigurada then
          begin
            pEnabledR4080;
            pEnabledR4020;
            pEnabledR4010;
            pEnabledR2020;
            pEnabledR2010;
            pEnabledR1000;
            pEnabledFechAber2000;
            pEnabledFechAber4000;
          end;

        end;
      end;
    end;
  end;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmIntegracaoReinf.pEnabledR4080;
begin
  if not Assigned(FfrmEventoR4080) then
    Exit;

  FfrmEventoR4080.strCodEmp := edtCodEmp.Text;
  FfrmEventoR4080.Enabled := True;
end;

procedure TfrmIntegracaoReinf.pEnabledR4020;
begin
  if not Assigned(FfrmEventoR4020) then
    Exit;

  FfrmEventoR4020.strCodEmp := edtCodEmp.Text;
  FfrmEventoR4020.Enabled := True;
end;

procedure TfrmIntegracaoReinf.pEnabledR4010;
begin
  if not Assigned(FfrmEventoR4010) then
    Exit;

  FfrmEventoR4010.strCodEmp := edtCodEmp.Text;
  FfrmEventoR4010.Enabled := True;
end;

procedure TfrmIntegracaoReinf.pEnabledR2020;
begin
  if not Assigned(FfrmEventoR2020) then
    Exit;

  FfrmEventoR2020.strCodEmp := edtCodEmp.Text;
  FfrmEventoR2020.Enabled := True;
end;

procedure TfrmIntegracaoReinf.pEnabledR2010;
begin
  if not Assigned(FfrmEventoR2010) then
    Exit;

  FfrmEventoR2010.strCodEmp := edtCodEmp.Text;
  FfrmEventoR2010.Enabled := True;
end;

procedure TfrmIntegracaoReinf.pEnabledR1000;
begin
  if not Assigned(FfrmEventoR1000) then
    Exit;

  FfrmEventoR1000.strCodEmp := edtCodEmp.Text;
  FfrmEventoR1000.Enabled := True;
  FfrmEventoR1000.pCarregaR1000;
end;

procedure TfrmIntegracaoReinf.pEnabledFechAber2000;
begin
  if not Assigned(FfrmFechamentoReaberturaEventos2000) then
    Exit;

  FfrmFechamentoReaberturaEventos2000.strCodEmp := edtCodEmp.Text;
  FfrmFechamentoReaberturaEventos2000.Enabled := True;
end;

procedure TfrmIntegracaoReinf.pEnabledFechAber4000;
begin
  if not Assigned(FfrmFechamentoReaberturaEventos4000) then
    Exit;

  FfrmFechamentoReaberturaEventos4000.strCodEmp := edtCodEmp.Text;
  FfrmFechamentoReaberturaEventos4000.Enabled := True;
end;

procedure TfrmIntegracaoReinf.pConfigurarIntegracao;
var
  qryAux: TUniQuery;
  Ok: Boolean;

  LPathReinf,
  LSenhaCertificado: String;
begin
  inherited;
  ACBrReinf.Configuracoes.Geral.Salvar         := False;
  ACBrReinf.Configuracoes.Geral.SSLLib         := TSSLLib(4);
  ACBrReinf.Configuracoes.Geral.SSLCryptLib    := TSSLCryptLib(3);
  ACBrReinf.Configuracoes.Geral.SSLHttpLib     := TSSLHttpLib(2);
  ACBrReinf.Configuracoes.Geral.SSLXmlSignLib  := TSSLXmlSignLib(4);
  ACBrReinf.Configuracoes.Geral.VersaoDF       := TVersaoReinf(6);

  ACBrReinf.SSL.DescarregarCertificado;
  ACBrReinf.SSL.SSLDgst := dgstSHA256;
  ACBrReinf.SSL.SSLType := TSSLType(5);

  ACBrReinf.Configuracoes.WebServices.Salvar     := False;
  ACBrReinf.Configuracoes.WebServices.Ambiente   := StrToTpAmb(Ok,IntToStr(fCfgSis('AMBREI', varInteger))); // 1 - produção 2 - homologação
  ACBrReinf.Configuracoes.WebServices.Visualizar := False;
  ACBrReinf.Configuracoes.WebServices.Salvar     := False;
  ACBrReinf.Configuracoes.WebServices.AjustaAguardaConsultaRet := False;
  ACBrReinf.Configuracoes.WebServices.AguardarConsultaRet := 10000;
  ACBrReinf.Configuracoes.WebServices.Tentativas := 5;
  ACBrReinf.Configuracoes.WebServices.IntervaloTentativas := 0;
  ACBrReinf.Configuracoes.WebServices.TimeOut   := 5000;
  ACBrReinf.Configuracoes.WebServices.ProxyHost := EmptyStr;
  ACBrReinf.Configuracoes.WebServices.ProxyPort := EmptyStr;
  ACBrReinf.Configuracoes.WebServices.ProxyUser := EmptyStr;
  ACBrReinf.Configuracoes.WebServices.ProxyPass := EmptyStr;

  ACBrReinf.Configuracoes.Arquivos.Salvar := False;
  ACBrReinf.Configuracoes.Arquivos.SepararPorMes    := False;
  ACBrReinf.Configuracoes.Arquivos.AdicionarLiteral := False;
  ACBrReinf.Configuracoes.Arquivos.EmissaoPathReinf := False;
  ACBrReinf.Configuracoes.Arquivos.SepararPorCNPJ   := False;
  ACBrReinf.Configuracoes.Arquivos.SepararPorModelo := False;
  ACBrReinf.Configuracoes.Arquivos.PathSchemas      := EmptyStr;
  ACBrReinf.Configuracoes.Arquivos.PathReinf        := EmptyStr;
  ACBrReinf.Configuracoes.Arquivos.PathSalvar       := ACBrReinf.Configuracoes.Arquivos.GetPathReinf(0);

  qryAux := fCriaQuery(Self);
  try
    qryAux.Close;
    qryAux.SQL.Text :=
    ' SELECT '+
    '   EMP_C_G_C_, '+
    '   CID_ESTADO, '+
    '   CER_ARQPFX, '+
    '   CER_SENHA_  '+
    ' FROM '+
    '   CADEMP '+
    ' INNER JOIN CADCID ON '+
    '   EMP_CODCID = CID_CODCID '+
    ' LEFT JOIN CADCER ON '+
    '   EMP_CODEMP = CER_CODEMP '+
    ' WHERE '+
    '   EMP_CODEMP = :CODEMP ';

    qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryAux.Open;

    if not qryAux.IsEmpty then
    begin
      ACBrReinf.Configuracoes.Geral.IdContribuinte := qryAux.FieldByName('EMP_C_G_C_').AsString; //cnpj do emitente
      ACBrReinf.Configuracoes.WebServices.UF := qryAux.FieldByName('CID_ESTADO').AsString; // estado do emitente

      if not fEmptyStr(qryAux.FieldByName('CER_ARQPFX').AsString) then
      begin
        LPathReinf  := strPathReinf + '\' + edtCodEmp.Text + '_CERTIFICADO.PFX';
        LSenhaCertificado := fDecriptar(qryAux.FieldByName('CER_SENHA_').AsString);

        DeleteFile(LPathReinf);
        TBlobField(qryAux.FieldByName('CER_ARQPFX')).SaveToFile(LPathReinf);

        ACBrReinf.Configuracoes.Certificados.ArquivoPFX := LPathReinf;
        ACBrReinf.Configuracoes.Certificados.Senha := AnsiString(LSenhaCertificado);

        blnIntegracaoConfigurada := True;
      end
      else
        fMensagem('ATENÇÃO', 'Certificado digital não encontrado no cadastro da empresa!', ['&Ok']);
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmIntegracaoReinf.pCriarTelaEvento;
begin
  case rdgEventos.ItemIndex of
    0: TfrmGravando.fExecutarModal(pCriaFrmR1000, 'Aguarde...', '');
    1: TfrmGravando.fExecutarModal(pCriaFrmR2010, 'Aguarde...', '');
    2: TfrmGravando.fExecutarModal(pCriaFrmR2020, 'Aguarde...', '');
    3: TfrmGravando.fExecutarModal(pCriaFrmFechamentoReaberturaEventos2000, 'Aguarde...', '');
    4: TfrmGravando.fExecutarModal(pCriaFrmR4010, 'Aguarde...', '');
    5: TfrmGravando.fExecutarModal(pCriaFrmR4020, 'Aguarde...', '');
    6: TfrmGravando.fExecutarModal(pCriaFrmR4080, 'Aguarde...', '');
    7: TfrmGravando.fExecutarModal(pCriaFrmFechamentoReaberturaEventos4000, 'Aguarde...', '');
  end;
end;

procedure TfrmIntegracaoReinf.rdgEventosClick(Sender: TObject);
begin
  inherited;
  pCriarTelaEvento;
end;

procedure TfrmIntegracaoReinf.pCriaFrmR1000;
Begin
  if not Assigned(FfrmEventoR1000) then
    FreeAndNil(FfrmEventoR1000);

  pCriarFormularios(TfrmEventoR1000, FfrmEventoR1000);

  FfrmEventoR1000.ACBrReinf := Self.ACBrReinf;

  if blnIntegracaoConfigurada then
    FfrmEventoR1000.strCodEmp := edtCodEmp.Text
  else
    FfrmEventoR1000.Enabled := False;

  FfrmEventoR1000.Align := alClient;
  FfrmEventoR1000.Dock(pnlEventos, pnlEventos.BoundsRect);
  FfrmEventoR1000.Show;
End;

procedure TfrmIntegracaoReinf.pCriaFrmR2010;
begin
  if Assigned(FfrmEventoR2010) then
    FreeAndNil(FfrmEventoR2010);

  pCriarFormularios(TfrmEventosReinf, FfrmEventoR2010);
  FfrmEventoR2010.ACBrReinf := Self.ACBrReinf;
  FfrmEventoR2010.tpEvento := R2010;

  if blnIntegracaoConfigurada then
    FfrmEventoR2010.strCodEmp := edtCodEmp.Text
  else
    FfrmEventoR2010.Enabled := False;

  FfrmEventoR2010.Align := alClient;
  FfrmEventoR2010.Dock(pnlEventos, pnlEventos.BoundsRect);
  FfrmEventoR2010.Show;
end;

procedure TfrmIntegracaoReinf.pCriaFrmR2020;
begin
  if Assigned(FfrmEventoR2020) then
    FreeAndNil(FfrmEventoR2020);

  pCriarFormularios(TfrmEventosReinf, FfrmEventoR2020);
  FfrmEventoR2020.ACBrReinf := Self.ACBrReinf;
  FfrmEventoR2020.tpEvento := R2020;

  if blnIntegracaoConfigurada then
    FfrmEventoR2020.strCodEmp := edtCodEmp.Text
  else
    FfrmEventoR2020.Enabled := False;

  FfrmEventoR2020.Align := alClient;
  FfrmEventoR2020.Dock(pnlEventos, pnlEventos.BoundsRect);
  FfrmEventoR2020.Show;
end;

procedure TfrmIntegracaoReinf.pCriaFrmR4010;
begin
  if Assigned(FfrmEventoR4010) then
    FreeAndNil(FfrmEventoR4010);

  pCriarFormularios(TfrmEventosReinf, FfrmEventoR4010);
  FfrmEventoR4010.ACBrReinf := Self.ACBrReinf;
  FfrmEventoR4010.tpEvento := R4010;

  if blnIntegracaoConfigurada then
    FfrmEventoR4010.strCodEmp := edtCodEmp.Text
  else
    FfrmEventoR4010.Enabled := False;

  FfrmEventoR4010.Align := alClient;
  FfrmEventoR4010.Dock(pnlEventos, pnlEventos.BoundsRect);
  FfrmEventoR4010.Show;
end;

procedure TfrmIntegracaoReinf.pCriaFrmR4020;
begin
  if Assigned(FfrmEventoR4020) then
    FreeAndNil(FfrmEventoR4020);

  pCriarFormularios(TfrmEventosReinf, FfrmEventoR4020);
  FfrmEventoR4020.ACBrReinf := Self.ACBrReinf;
  FfrmEventoR4020.tpEvento := R4020;

  if blnIntegracaoConfigurada then
    FfrmEventoR4020.strCodEmp := edtCodEmp.Text
  else
    FfrmEventoR4020.Enabled := False;

  FfrmEventoR4020.Align := alClient;
  FfrmEventoR4020.Dock(pnlEventos, pnlEventos.BoundsRect);
  FfrmEventoR4020.Show;
end;

procedure TfrmIntegracaoReinf.pCriaFrmR4080;
begin
  if Assigned(FfrmEventoR4080) then
    FreeAndNil(FfrmEventoR4080);

  pCriarFormularios(TfrmEventosReinf, FfrmEventoR4080);
  FfrmEventoR4080.ACBrReinf := Self.ACBrReinf;
  FfrmEventoR4080.tpEvento := R4080;

  if blnIntegracaoConfigurada then
    FfrmEventoR4080.strCodEmp := edtCodEmp.Text
  else
    FfrmEventoR4080.Enabled := False;

  FfrmEventoR4080.Align := alClient;
  FfrmEventoR4080.Dock(pnlEventos, pnlEventos.BoundsRect);
  FfrmEventoR4080.Show;
end;

procedure TfrmIntegracaoReinf.pCriaFrmFechamentoReaberturaEventos2000;
Begin
  if not Assigned(FfrmFechamentoReaberturaEventos2000) then
    FreeAndNil(FfrmFechamentoReaberturaEventos2000);

  pCriarFormularios(TfrmFechamentoReaberturaEventos, FfrmFechamentoReaberturaEventos2000);

  FfrmFechamentoReaberturaEventos2000.ACBrReinf := Self.ACBrReinf;
  FfrmFechamentoReaberturaEventos2000.tpEventoFechamentoReabertura := serieR2000;

  if blnIntegracaoConfigurada then
    FfrmFechamentoReaberturaEventos2000.strCodEmp := edtCodEmp.Text
  else
    FfrmFechamentoReaberturaEventos2000.Enabled := False;

  FfrmFechamentoReaberturaEventos2000.Align := alClient;
  FfrmFechamentoReaberturaEventos2000.Dock(pnlEventos, pnlEventos.BoundsRect);
  FfrmFechamentoReaberturaEventos2000.Show;
End;

procedure TfrmIntegracaoReinf.pCriaFrmFechamentoReaberturaEventos4000;
Begin
  if not Assigned(FfrmFechamentoReaberturaEventos4000) then
    FreeAndNil(FfrmFechamentoReaberturaEventos4000);

  pCriarFormularios(TfrmFechamentoReaberturaEventos, FfrmFechamentoReaberturaEventos4000);

  FfrmFechamentoReaberturaEventos4000.ACBrReinf := Self.ACBrReinf;
  FfrmFechamentoReaberturaEventos4000.tpEventoFechamentoReabertura := serieR4000;

  if blnIntegracaoConfigurada then
    FfrmFechamentoReaberturaEventos4000.strCodEmp := edtCodEmp.Text
  else
    FfrmFechamentoReaberturaEventos4000.Enabled := False;

  FfrmFechamentoReaberturaEventos4000.Align := alClient;
  FfrmFechamentoReaberturaEventos4000.Dock(pnlEventos, pnlEventos.BoundsRect);
  FfrmFechamentoReaberturaEventos4000.Show;
End;

end.
