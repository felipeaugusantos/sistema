unit untLimiteCredito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, untLiberacao;

type
  TfrmLimiteCredito = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label1: TLabel;
    lblCpfCnpjCliente: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    edtCpfCnpjCliente: TEditFocus;
    Panel2: TPanel;
    Label42: TLabel;
    edtNovoLimCre: TEditFocus;
    Label2: TLabel;
    edtLimCreAtual: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FObjLiberacao: TLiberacao;
    FLimCreAnt: Double;
    FLimCreAntIni: Double;
    FCodCliente: String;
    procedure Atualizar;
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    class procedure AlterarLimiteCredito(ACodCliente: String);
  end;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica, untConstantes, Uni, untCadClientes;

{$R *.dfm}

{ TfrmLimiteCredito }

class procedure TfrmLimiteCredito.AlterarLimiteCredito(ACodCliente: String);
var
  frmLimiteCredito: TfrmLimiteCredito;
begin
  frmLimiteCredito := TfrmLimiteCredito.Create(Nil);
  try
    frmLimiteCredito.FCodCliente := ACodCliente;
    if frmLimiteCredito.ShowModal = MrOk then
      frmLimiteCredito.Atualizar;
  finally
    pFreeAndNil(frmLimiteCredito);
  end;
end;

procedure TfrmLimiteCredito.Atualizar;
var
  LQryConsulta: TUniQuery;
begin
  LQryConsulta := fCriaQuery;
  try
    LQryConsulta.SQL.Add('SELECT');
    LQryConsulta.SQL.Add('  CLI_CODCLI, CLI_LIMCRE');
    LQryConsulta.SQL.Add('FROM CADCLI');
    LQryConsulta.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
    LQryConsulta.ParamByName('CODCLI').AsString := FCodCliente;
    LQryConsulta.Open;

    fStartTransaction;
    try
      TfrmCadClientes.fGeraLogLimiteStatusCliente(FCodCliente,
                                                  VS_Date,
                                                  fTime(),
                                                  strLoginUsuarioLogado,
                                                  'CLI_LIMCRE',
                                                  '',
                                                  '',
                                                  FLimCreAntIni,
                                                  fStrToFloat(edtNovoLimCre.Text),
                                                  False);

      LQryConsulta.Edit;
      LQryConsulta.FieldByName('CLI_LIMCRE').AsFloat := fStrToFloat(edtNovoLimCre.Text);
      LQryConsulta.Post;

      fCommit;
    Except

      On E : Exception do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[Erro ao Gravar a Alteração de Limite de Crédito]');
      End;

    End;
  finally
    LQryConsulta.Free;
  end;
end;

procedure TfrmLimiteCredito.FormCreate(Sender: TObject);
begin
  inherited;
  FObjLiberacao := TLiberacao.Create;
end;

procedure TfrmLimiteCredito.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FObjLiberacao);
  inherited;
end;

procedure TfrmLimiteCredito.FormShow(Sender: TObject);
var
  LQryConsulta: TUniQuery;
begin
  inherited;
  edtCodCliente.Text := FCodCliente;

  LQryConsulta := fCriaQuery;
  try
    LQryConsulta.SQL.Add('SELECT');
    LQryConsulta.SQL.Add('  CLI_NOMCLI, CLI_C_G_C_, CLI_CGCCPF, CLI_LIMCRE');
    LQryConsulta.SQL.Add('FROM CADCLI');
    LQryConsulta.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
    LQryConsulta.ParamByName('CODCLI').AsString := FCodCliente;
    LQryConsulta.Open;

    edtDesCliente.Text := LQryConsulta.FieldByName('CLI_NOMCLI').AsString;
    edtCpfCnpjCliente.Text := fFormataCpfCgc(LQryConsulta.FieldByName('CLI_C_G_C_').AsString, fSetaPais);
    if LQryConsulta.FieldByName('CLI_CGCCPF').AsString = '1' then
      lblCpfCnpjCliente.Caption := 'CNPJ:'
    else
      lblCpfCnpjCliente.Caption := 'CPF:';

    FLimCreAnt := LQryConsulta.FieldByName('CLI_LIMCRE').AsFloat;
    FLimCreAntIni := LQryConsulta.FieldByName('CLI_LIMCRE').AsFloat;
    edtLimCreAtual.Text := FloatToStrF(FLimCreAnt, ffFixed, 15, 2);
  finally
    LQryConsulta.Free;
  end;

  pSetFocus(edtNovoLimCre);
end;

function TfrmLimiteCredito.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  {*****************************************}
  {* VALIDA O LIMITE DE CREDITO            *}
  {**************************************MV*}
  If (Sender = edtNovoLimCre) Then
  Begin
    If (fStrToFloat(edtNovoLimCre.Text) > fLimiteCreditoCliente(FCodCliente)) And (fCfgSis('CREAUT', varBoolean)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Sistema configurado para calcular aumento de Limite '+
                            'de Crédito automaticamente - [CFG_CREAUT]. Utilizar '+
                            'o botão [ATUALIZAR LIMITE CRÉDITO] no Cadastro de Clientes', ['&Ok']);
      edtNovoLimCre.Text := FloatToStrF(FLimCreAnt, ffFixed, 15, 2);
      Result := False;
    End
    Else If (fEmptyStr(edtNovoLimCre.Text)) Or (fStrToFloat(edtNovoLimCre.Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Limite de Crédito deve ser maior ou igual Zero!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtNovoLimCre.Text) > MAX_VALMON Then
    Begin
      fMensagem('ATENÇÃO!', 'O Limite de Crédito deve estar entre 0 e 999999,99!', ['&Ok']);
      Result := False;
    End
    Else If (fCfgSis('LMCROP', VarBoolean)) And
            (FloatToStrF(FLimCreAnt, ffFixed, 15, 2) <> FloatToStrF(fStrToFloat(edtNovoLimCre.Text), ffFixed, 15, 2)) And
            (fStrToFloat(edtNovoLimCre.Text) > fLimCredOperador('', FCodCliente)) Then
    Begin
      if fCfgSis('LMCRTR', VarString) = '1' then
      begin
        fMensagem('ATENÇÃO!', 'O valor do limite de crédito informado ultrapassa o limite permitido para o operador!', ['&Ok']);
        Result := False;
      end
      else
      begin
        FObjLiberacao.Clear;
        FObjLiberacao.strDirAce    := 'LCRCLIOPE';
        FObjLiberacao.strSenLib    := fCfgSis('SENCRE');
        FObjLiberacao.strMsgSen    := 'Limite de Crédito';
        FObjLiberacao.strCodOpe    := strLoginUsuarioLogado;
        FObjLiberacao.strCodDig    := strLoginUsuarioLogado;
        FObjLiberacao.strCliente   := (FCodCliente + '-' + edtDesCliente.Text);
        FObjLiberacao.strCpfCnpj   := edtCpfCnpjCliente.Text;
        FObjLiberacao.objMsgLibera.pAddTexto('Alteração de limite de crédito maior que alçada do operador');
        FObjLiberacao.objMsgLibera.pAddTextoCaption('Limite de Crédito Atual', fPadL(FloatToStrF(FLimCreAnt, ffFixed, 15, 2), 15)               , 15);
        FObjLiberacao.objMsgLibera.pAddTextoCaption('Novo Limite de Crédito'   , fPadL(FloatToStrF(fStrToFloat(edtNovoLimCre.Text), ffFixed, 15, 2), 15), 15);

        If FObjLiberacao.fLibera Then
        Begin
          FLimCreAnt := fStrToFloat(edtNovoLimCre.Text);
          edtNovoLimCre.Text := FloatToStrF(FLimCreAnt, ffFixed, 15, 2);
          pSetFocus(edtNovoLimCre);
          blnMudarFoco := True;
        End
        Else
        Begin
          edtNovoLimCre.Text := FloatToStrF(FLimCreAnt, ffFixed, 15, 2);
          blnMudarFoco := False;
          pSetFocus(edtNovoLimCre);
        End;
      end;

    End
    Else If (((FloatToStrF(FLimCreAnt, ffFixed, 15, 2) <> FloatToStrF(fStrToFloat(edtNovoLimCre.Text), ffFixed, 15, 2)))  Or
             ((FloatToStrF(FLimCreAnt, ffFixed, 15, 2) <> FloatToStrF(fStrToFloat(edtNovoLimCre.Text), ffFixed, 15, 2)))) Then
    Begin
      FObjLiberacao.Clear;
      FObjLiberacao.strDirAce    := 'LCRCLI';
      FObjLiberacao.strSenLib    := fCfgSis('SENCRE');
      FObjLiberacao.strMsgSen    := 'Limite de Crédito';
      FObjLiberacao.strCodOpe    := strLoginUsuarioLogado;
      FObjLiberacao.strCodDig    := strLoginUsuarioLogado;
      FObjLiberacao.strCliente   := (FCodCliente + '-' + edtDesCliente.Text);
      FObjLiberacao.strCpfCnpj   := edtCpfCnpjCliente.Text;
      FObjLiberacao.objMsgLibera.pAddTexto('Troca de limite de crédito.');
      FObjLiberacao.objMsgLibera.pAddTextoCaption('Limite Anterior', fPadL(FloatToStrF(FLimCreAnt, ffFixed, 15, 2), 15)               , 15);
      FObjLiberacao.objMsgLibera.pAddTextoCaption('Limite Atual'   , fPadL(FloatToStrF(fStrToFloat(edtNovoLimCre.Text), ffFixed, 15, 2), 15), 15);

      If FObjLiberacao.fLibera Then
      Begin
        FLimCreAnt := fStrToFloat(edtNovoLimCre.Text);
        edtNovoLimCre.Text := FloatToStrF(FLimCreAnt, ffFixed, 15, 2);
        pSetFocus(edtNovoLimCre);
        blnMudarFoco := True;
      End
      Else
      Begin
        edtNovoLimCre.Text := FloatToStrF(FLimCreAnt, ffFixed, 15, 2);
        blnMudarFoco := False;
        pSetFocus(edtNovoLimCre);
      End;
    End;
  End;
end;

end.

