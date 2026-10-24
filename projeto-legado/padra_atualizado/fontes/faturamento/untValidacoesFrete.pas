unit untValidacoesFrete;

interface

uses EditFocus, ComboBoxFocus, untFuncFat;

type
  TInputPassarZeroEmitenteCIF = record
    EditValFre : TEditFocus;
    ComboTipFre : TComboBoxFocus;
    CodigoTransportadora : String;
  End;

  TValidacoesFrete = class
  private
    FFatVenda : TFatVenda;
  public
    function PermitePassarComFreteZeroEmitenteCIF(const AInputPassarZeroEmitenteCIF : TInputPassarZeroEmitenteCIF) : Boolean;
    constructor Create(const AFatVenda : TFatVenda);
  End;

implementation

uses untLiberacao, untFuncoesSimples, untTipoFreteAtc, System.SysUtils;

{ TValidacoesFrete }

constructor TValidacoesFrete.Create(const AFatVenda: TFatVenda);
begin
  FFatVenda := AFatVenda;
end;

function TValidacoesFrete.PermitePassarComFreteZeroEmitenteCIF(const AInputPassarZeroEmitenteCIF : TInputPassarZeroEmitenteCIF) : Boolean;
  Var
    LLiberacao : TLiberacao;
begin
  Result := True;

  If (fCfgSis('OBRCIF', varString) = 'N') Then
    Exit;

  If (Pos(FFatVenda.strOpcDoc, 'PD_OR_VN_') <= 0) Then
    Exit;

  If (AInputPassarZeroEmitenteCIF.EditValFre.ReadOnly) Then
    Exit;

  If (fTipoFrete(AInputPassarZeroEmitenteCIF.ComboTipFre.Text) <> '1') Then
    Exit;

  If (fStrToFloat(AInputPassarZeroEmitenteCIF.EditValFre.Text) <> 0) Then
    Exit;

  LLiberacao := TLiberacao.Create;
  try
    LLiberacao.objMsgLibera.pAddTexto('Tipo de frete EMITENTE CIF sem frete informado.');
    LLiberacao.objMsgLibera.pAddTexto('---------------------------------------------------');
    LLiberacao.objMsgLibera.pAddTexto('Cliente: ' + FFatVenda.strCodCli + '-' + FFatVenda.strCliNom);
    LLiberacao.objMsgLibera.pAddTexto('Vendedor: ' + FFatVenda.strCodVen + '-' + FFatVenda.strNomVen);
    LLiberacao.objMsgLibera.pAddTexto('Transportadora: ' + AInputPassarZeroEmitenteCIF.CodigoTransportadora + '-' + fRetNomTransportadora(AInputPassarZeroEmitenteCIF.CodigoTransportadora));
    LLiberacao.objMsgLibera.pAddTexto('Tipo de Frete: EMITENTE CIF');
    LLiberacao.objMsgLibera.pAddTexto('Valor do Frete: 0.00');
    LLiberacao.objMsgLibera.pAddTexto('---------------------------------------------------');
    LLiberacao.strDirAce := 'OBRCIF';
    LLiberacao.strMsgSen := 'Tipo de frete Emitente CIF sem frete informado.';
    LLiberacao.strCodOpe := FFatVenda.strCodVen;
    LLiberacao.strCodDig := FFatVenda.strCodDig;
    LLiberacao.strCliente := FFatVenda.strCodCli + '-' + FFatVenda.strCliNom;
    LLiberacao.blnUsarSenhaFixa := False;
    LLiberacao.blnSempreVariavelUsuario := True;
    Result := FFatVenda.fFatMensagemLiberacao(LLiberacao);
  finally
    FreeAndNil(LLiberacao);
  end;
end;

end.
