unit untTicketEstacionamento;

interface

uses
  untFuncFat, untTckEstController, untLiberacao, System.SysUtils, Controls;

type
  TTicketEstacionamento = class
  private
    objTckEstController: TTckEstController;
    objFatVenda: TFatVenda;
    fltVlrVenda: Double;
    strCodOpeLib: String;
    objLiberacao: TLiberacao;
    procedure pLiberaTicket(strCodTicket: String);
    function fNumeroTicket: String;
    function fLiberarTicketComVendaAbaixoDoValorMinimo: Boolean;
    function fLiberarTicket: Boolean;
    function fVendaDentroDoValorMinimo: Boolean;
    function fValorMinimoParaLiberacao: Double;
    function fUsaTicket: Boolean;
    function fPossuiTicketParaLiberacao: Boolean;
    function fDesejaLiberarTicketComValorFaltante: Boolean;
  public
    constructor Create(Const objFatVenda: TFatVenda; Const fltVlrVenda: Double = 0);
    destructor Destroy; override;
    procedure pValidar;
  end;

implementation

uses
  untFuncoesSimples, untDigTicketEstacionamento;

{ TTicketEstacionamento }

constructor TTicketEstacionamento.Create(Const objFatVenda: TFatVenda;
  Const fltVlrVenda: Double = 0);
begin
  Self.objFatVenda := objFatVenda;
  Self.fltVlrVenda := IIF(fltVlrVenda > 0, fltVlrVenda, objFatVenda.fltTotGer);
  objLiberacao := TLiberacao.Create;
  objTckEstController := TTckEstController.Create;
end;

destructor TTicketEstacionamento.Destroy;
begin
  FreeAndNil(objLiberacao);
  FreeAndNil(objTckEstController);
end;

function TTicketEstacionamento.fLiberarTicket: Boolean;
  Var
    blnSolicitouLiberacao: Boolean;
begin
  Result := False;

  If (Not fUsaTicket) Then
    Exit;

  If (Not fPossuiTicketParaLiberacao) Then
    Exit;

  If (Not fVendaDentroDoValorMinimo) Then
  Begin
    blnSolicitouLiberacao := fDesejaLiberarTicketComValorFaltante;

    If (Not blnSolicitouLiberacao) Then
      Exit;

    If ((blnSolicitouLiberacao) And (Not fLiberarTicketComVendaAbaixoDoValorMinimo)) Then
      Exit;
  End;

  Result := True;
end;

function TTicketEstacionamento.fLiberarTicketComVendaAbaixoDoValorMinimo: Boolean;
  Var
    strNomCli: String;
begin
  Result := True;

  If (Not fVerificaAcessoSistema('TCKESTCTX', strLoginUsuarioLogado)) Then
  Begin
    objLiberacao.objMsgRemota.strDirAce := 'TCKESTCTX';
    objLiberacao.objMsgRemota.pAddTexto('Liberar ticket de estacionamento CTX '+
                                        'com valor de venda abaixo do valor mínimo');

    objLiberacao.objMsgLibera.pAddTexto('Operador sem permissão para liberar '+
                                        'ticket de estacionamento (CTX)');

    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTexto('Documento: ' + objFatVenda.strNumDoc +
                                        ' - ' + objFatVenda.strEspDoc);

    objLiberacao.objMsgLibera.pAddTexto('Valor configurado: R$'+
                                        FormatFloat('#,##0.00', fValorMinimoParaLiberacao));
    objLiberacao.objMsgLibera.pAddTexto('Valor da venda: R$' +
                                        FormatFloat('#,##0.00', fltVlrVenda));
    objLiberacao.objMsgLibera.pAddQuebra;

    objLiberacao.strDirAce := 'TCKESTCTX';
    objLiberacao.strSenLib := fCfgSis('SENLBD');
    objLiberacao.strMsgSen := 'Liberar ticket de estacionamento (CTX)';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    strNomCli := fRetNomCliente(objFatVenda.strCodCli);
    objLiberacao.strCliente := objFatVenda.strCodCli + ' - ' + strNomCli;

    objLiberacao.pInformaNumDocEspDocCodEmp(objFatVenda.strNumDoc,
                                            objFatVenda.strEspDoc,
                                            objFatVenda.strEmpOri);
    Result := objLiberacao.fLibera;
    strCodOpeLib := objLiberacao.strOperador;
  End;
end;

function TTicketEstacionamento.fPossuiTicketParaLiberacao: Boolean;
begin
  Result := (fMensagem('', 'Cliente possui ticket de estacionamento para '+
                           'liberação?',['&Sim', '&Não'], 2) = 1);
end;

function TTicketEstacionamento.fDesejaLiberarTicketComValorFaltante: Boolean;
  Var
    strMensagem: String;
    fltDiferenca: Double;
begin
  fltDiferenca := fValorMinimoParaLiberacao - fltVlrVenda;

  strMensagem := 'Valor mínimo de venda para liberação do ticket de'+#13+
    'estacionamento não foi atingido.'+#13+
    'Valor faltante para liberação: R$'+FormatFloat('#,##0.00', fltDiferenca)+#13+
    'Deseja liberar?';

  Result := (fMensagem('', strMensagem, ['&Sim', '&Não'], 2) = 1);
end;

function TTicketEstacionamento.fUsaTicket: Boolean;
begin
  Result := fCfgSis('USACTX', varBoolean);
end;

function TTicketEstacionamento.fValorMinimoParaLiberacao: Double;
begin
  Result := fCfgSis('VLRCTX');
end;

function TTicketEstacionamento.fVendaDentroDoValorMinimo: Boolean;
begin
  Result := fFormataFloat(fltVlrVenda, 2) >= fFormataFloat(fValorMinimoParaLiberacao, 2);
end;

procedure TTicketEstacionamento.pLiberaTicket(strCodTicket: String);
  Var
    strMensagemRetorno: String;
    blnTicketLiberado: Boolean;
begin
  blnTicketLiberado := objTckEstController.fLiberarTicket(strCodTicket,
    objFatVenda.strCodCli, strMensagemRetorno, strCodOpeLib);

  If (Not blnTicketLiberado) Then
  Begin
    fMensagem('', 'Não foi possível liberar o ticket ' + strCodTicket + #13 +
      'Motivo: ' + strMensagemRetorno, ['&Ok']);
  End
  Else
    fMensagem('', 'Ticket ' + strCodTicket + ' liberado com sucesso.', ['&Ok']);
end;

function TTicketEstacionamento.fNumeroTicket: String;
  Var
    frmDigTicketEstacionamento: TfrmDigTicketEstacionamento;
begin
  pCriarFormularios(TfrmDigTicketEstacionamento, frmDigTicketEstacionamento);

  Try
    If (frmDigTicketEstacionamento.ShowModal = mrOk) Then
      Result := frmDigTicketEstacionamento.edtCodTicket.Text;
  Finally
    pFreeAndNil(frmDigTicketEstacionamento);
  End;
end;

procedure TTicketEstacionamento.pValidar;
  Var
    strTicket: String;
begin
  If (Not fLiberarTicket) Then
    Exit;

  strTicket := fNumeroTicket;

  If (fEmptyStr(strTicket)) Then
    Exit;

  pLiberaTicket(strTicket);
end;

end.
