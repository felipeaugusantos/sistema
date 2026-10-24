unit untFatTrocaCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  untFuncFat, Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untLiberacao;

type
  TfrmFatTrocaCliente = class(TfrmPai)
    pnlFundo: TPanel;
    Label2: TLabel;
    edtCliFat: TEditFocus;
    edtNomCliFat: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure edtCliFatKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryCliFat: TUniQuery;
    objLiberacao : TLiberacao;

    procedure pCarregaNovoCliente;
    function fSaoClientesMesmoEstado(strCliCon, strCliDev: string): Boolean;
  public
    { Public declarations }
    qryFatGor: TUniQuery;
    fatVenda: TFatVenda;
    strCndEdt: String;
    blnResult,
    blnEspeciePermitidaDevolucao: Boolean;
    blnBaixaPedidoDev: Boolean;
    blnValidaClienteAtivo: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas, Data.DB, untTypesSistema;

{$R *.dfm}

procedure TfrmFatTrocaCliente.edtCliFatKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliFat, edtNomCliFat, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCliFat, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatTrocaCliente.FormShow(Sender: TObject);
begin
  inherited;
  qryCliFat := fCriaQuery(Self);
  qryCliFat.SQL.Add('SELECT SQL_NO_CACHE * FROM CADCLI WHERE CLI_CODCLI = :CODCLI');

  if ((fCfgSis('PRECDV', varBoolean)) And (Pos(fatVenda.strOpcDoc, 'DV_') > 0)) And (not FEmptyStr(fatVenda.strCodCliPreCadastro)) then
    edtCliFat.Text := fatVenda.strCodCliPreCadastro
  else
    edtCliFat.Text := fatVenda.strCodCli;

  pCarregaNovoCliente;
  pSetFocus(edtCliFat);
end;

function TfrmFatTrocaCliente.fSaoClientesMesmoEstado(strCliCon,
  strCliDev: string): Boolean;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT CID.CID_ESTADO');
    qryConsulta.SQL.Add('FROM CADCLI CLI');
    qryConsulta.SQL.Add('INNER JOIN CADCID CID');
    qryConsulta.SQL.Add('ON(CLI.CLI_CODCID = CID.CID_CODCID)');
    qryConsulta.SQL.Add('WHERE CLI.CLI_CODCLI = :CLICON OR CLI.CLI_CODCLI = :CLIVEN');
    qryConsulta.SQL.Add('GROUP BY CID.CID_ESTADO');

    qryConsulta.ParamByName('CLICON').AsString := strCliCon;
    qryConsulta.ParamByName('CLIVEN').AsString := strCliDev;

    qryConsulta.Open;

    Result := (not qryConsulta.IsEmpty) and (qryConsulta.RecordCount = 1);
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function TfrmFatTrocaCliente.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCliFat) Then
    Begin
      If (fEmptyStr(edtCliFat.Text)) Then
      Begin
        edtCliFat.Text := fatVenda.strCodCli;
        pCarregaNovoCliente;
      End
      Else
      Begin
        pCarregaNovoCliente;
        If (qryCliFat.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If blnValidaClienteAtivo And (qryCliFat.FieldByName('CLI_STATUS').AsString <> 'A') Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente está com atividade suspensa!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmFatTrocaCliente.pCarregaNovoCliente;
begin
  qryCliFat.Close;
  qryCliFat.ParamByName('CODCLI').AsString := edtCliFat.Text;
  qryCliFat.Open;
  edtNomCliFat.Text := qryCliFat.FieldByName('CLI_NOMCLI').AsString;
end;

procedure TfrmFatTrocaCliente.btnConfirmaDadosClick(Sender: TObject);
  Var
    strMsgSen: String;
    blnDevCon : Boolean;
    strNomCfg: String;

  function fPessoaJuridicaComIES(edtCliFat: String): Boolean;
  Var
    qryCli: TUniQuery;
  begin
    qryCli := fCriaQuery;
    Try
    With qryCli, SQL Do
      Begin
        Add('SELECT');
        Add('  IFNULL(CLI_CGCCPF, 2) AS CLI_CGCCPF,');
        Add('  CLI_I_E_S_');
        Add('FROM');
        Add('  CADCLI');
        Add('WHERE');
        Add('  CLI_CODCLI = :CODCLI');
        ParamByName('CODCLI').AsString := edtCliFat;
        Open;

        Result := (FieldByName('CLI_CGCCPF').AsInteger = 1) And (Not fEmptyStr(FieldByName('CLI_I_E_S_').AsString));
      End;
    Finally
      FreeAndNil(qryCli);
    End;
  end;

  function fPessoaJuridicaSemIES(edtCliFat: String): Boolean;
  Var
    qryCli: TUniQuery;
  begin
    qryCli := fCriaQuery;
    Try
    With qryCli, SQL Do
      Begin
        Add('SELECT');
        Add('  IFNULL(CLI_CGCCPF, 2) AS CLI_CGCCPF,');
        Add('  CLI_I_E_S_');
        Add('FROM');
        Add('  CADCLI');
        Add('WHERE');
        Add('  CLI_CODCLI = :CODCLI');
        ParamByName('CODCLI').AsString := edtCliFat;
        Open;

        Result := (FieldByName('CLI_CGCCPF').AsInteger = 1) And (fEmptyStr(FieldByName('CLI_I_E_S_').AsString));
      End;
    Finally
      FreeAndNil(qryCli);
    End;
  end;

begin
  If Not fVerificaCampos Then
    Exit;

  if blnBaixaPedidoDev then
    strNomCfg := 'TRCLD2'
  else
    strNomCfg := 'TRCLDV';

  If (Pos(fatVenda.strOpcDoc, 'DV_PR_DD_') > 0) And
     (cdsVenda.RecordCount > 0) And
     (blnEspeciePermitidaDevolucao) And
     (fPessoaJuridicaComIES(edtCliFat.Text)) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Não é permitido emitir devolução para pessoa jurídica com inscrição estadual cadastrada.');

    objLiberacao.strDirAce := 'DEVPJ';
    objLiberacao.strSenLib := fCfgSis('SEDVPJ');
    objLiberacao.strMsgSen := 'Devolução Para Pessoa Jurídica';
    objLiberacao.strCodOpe := fatVenda.strCodVen;
    objLiberacao.strCodDig := fatVenda.strCodDig;

    If Not fatVenda.fFatMensagemLiberacao(objLiberacao) Then
    Begin
      Exit;
    End;
  End;

   If (fatVenda.strOpcDoc = 'DV') And
     (cdsVenda.RecordCount > 0) And
     (blnEspeciePermitidaDevolucao) And
     (not fSaoClientesMesmoEstado(fatVenda.strCodCli, edtCliFat.Text)) Then
  Begin
    fMensagem('ATENÇÃO', 'Cliente selecionado deve ser do mesmo estado do cliente da nota! ', ['&Ok']);
    Exit;
  End;

  If (Not fVerificaAcessoSistema('DVPJSI')) Then
  Begin
    If (Pos(fatVenda.strOpcDoc, 'DV_PR_DD_') > 0) And
       (cdsVenda.RecordCount > 0) And
       (blnEspeciePermitidaDevolucao) And
       (fPessoaJuridicaSemIES(edtCliFat.Text)) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Não é permitido emitir devolução para pessoa jurídica sem inscrição estadual cadastrada.');

      objLiberacao.strDirAce := 'DVPJSI';
      objLiberacao.strSenLib := fCfgSis('DVPJSI');
      objLiberacao.strMsgSen := 'Devolução Para Pessoa Jurídica';
      objLiberacao.strCodOpe := fatVenda.strCodVen;
      objLiberacao.strCodDig := fatVenda.strCodDig;

      If Not fatVenda.fFatMensagemLiberacao(objLiberacao) Then
      Begin
        Exit;
      End;
    End;
  End;

  blnDevCon := fCfgSis('DEVCON', varBoolean);
  {*****************************************}
  {* DEVOLUÇÃO NÃO PERMITIDA PARA CLICON   *}
  {**************************************AF*}
  If (fClienteConsumidor(fRetNomCliente(edtCliFat.Text), False, True)) And
     (Pos(fatVenda.strOpcDoc, 'DV_PR_DD_') > 0) And
     ((Not blnDevCon)Or ((Not fatVenda.fEhDevolucaoAVista(strCndEdt)) And (fCfgSis('CNDVEN') ='I'))) Then
  Begin
    If (Not blnDevCon) Then
      fMensagem('', 'Devolução não permitida! Para efetuar este processo, '+
                    'habilite a configuração "CFG_DEVCON" - Permitir devolução para cliente consumidor '+
                    'sem trocar o cliente?!', ['&Ok'])
    Else
      fMensagem('', 'Devolução a prazo não permitida para cliente consumidor! ', ['&Ok']);
    Exit;
  End

  Else If fClienteConsumidor(fRetNomCliente(edtCliFat.Text), True, True) And
          (Pos(fatVenda.strOpcDoc, 'DV_PR_DD_') > 0) Then
  Begin

    If Not fatVenda.fDigDadosConsumidor(qryFatGor) Then
    Begin
      fMensagem('', 'Os dados devem ser preenchidos corretamente!', ['&Ok']);
      Exit;
    End;

  End
  Else If (fCfgSis(strNomCfg, VarBoolean)) And (Pos(fatVenda.strOpcDoc, 'DV_PR_DD_') > 0) And
          (Not fClienteConsumidor(fRetNomCliente(fatVenda.strCodCli), True, True)) And
          (fatVenda.strCodCli <> edtCliFat.Text) Then
  Begin
    strMsgSen := 'Permitir trocar o cliente na devolução para clientes cadastrados?';
    objLiberacao.Clear;

    objLiberacao.objMsgLibera.pAddTexto(strMsgSen);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente Atual', fRetNomCliente(fatVenda.strCodCli), 13);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente Novo' , fRetNomCliente(edtCliFat.Text)    , 13);

    objLiberacao.strDirAce := 'TRCLDV';
    objLiberacao.strMsgSen := strMsgSen;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    If Not objLiberacao.fLibera Then
    Begin
      Exit;
    End;
  End
  Else If (fCfgSis('TRCCDV', VarBoolean)) And (Pos(fatVenda.strOpcDoc, 'DV_PR_DD_') > 0) And
          (fClienteConsumidor(fRetNomCliente(fatVenda.strCodCli), True, True)) And
          (fatVenda.strCodCli <> edtCliFat.Text) Then
  Begin
    strMsgSen := 'Permitir trocar o cliente consumidor na devolução?';
    objLiberacao.Clear;

    objLiberacao.objMsgLibera.pAddTexto(strMsgSen);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente Atual', fRetNomCliente(fatVenda.strCodCli), 13);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente Novo' , fRetNomCliente(edtCliFat.Text)    , 13);

    objLiberacao.strDirAce := 'TRCCDV';
    objLiberacao.strMsgSen := strMsgSen;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    If Not objLiberacao.fLibera Then
    Begin
      Exit;
    End;
  End;

  blnResult := True;
  Close;

  inherited;
end;

procedure TfrmFatTrocaCliente.FormCreate(Sender: TObject);
begin
  inherited;
  blnBaixaPedidoDev := False;
  blnResult := False;
  blnValidaClienteAtivo := False;
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmFatTrocaCliente.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;
end;

end.
