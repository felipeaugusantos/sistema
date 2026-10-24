unit untValidadorDaRegraValorEmissaoNFCePorEstado;

interface

Uses
  untFuncoesSimples, Uni, System.SysUtils;

Type
  TValidadorDaRegraValorEmissaoNFCePorEstado = Class
    Private
      Class function fClienteIdentificado(ACliCgc: String): Boolean;
      Class function fVerificarValorMaximoPermitido(Const ATotalDocumento : Double; Const fltValorMaxPermitido: Double): Boolean;

      Class function fEntrarNaRegraValorEmissaoNFCePorEstado(Const ATipoFaturamento : String) : Boolean;

      Class function fRetornarMensagemValorEmissaoNFCePorEstado(const ADestinatarioIdentificado : Boolean;
        const AEstado : String; const AValorDocumento : Double;
        const AValorMaxPermitido : Double ) : String;

    Public
      Class function fRetornarValidacaoDaRegraValorEmissaoNFCePorEstado(Const AEstado : String; Const ACliCgc : String;
        Const ATipoFaturamento : String; Const ATotalDocumento : Double ): String;

      Class function fRetornarSQLValoresMaxEmissaoNFCe : String;
  End;

implementation

{ TValidadorDaRegraValorEmissaoNFCePorEstado }

class function TValidadorDaRegraValorEmissaoNFCePorEstado.fClienteIdentificado(
  ACliCgc: String): Boolean;
begin
  Result := False;

  If fEmptyStr(ACliCgc) Then
    Exit;
    
  Result := fValidaCnpjCpf(ACliCgc);
end;

class function TValidadorDaRegraValorEmissaoNFCePorEstado.fEntrarNaRegraValorEmissaoNFCePorEstado(Const ATipoFaturamento : String): Boolean;
begin
  Result  := false;

  If Pos(ATipoFaturamento,'NFCe') <= 0 Then
    Exit;

  If Not (fCfgSis('VLMXUF', varBoolean)) Then
    Exit;

  Result  := true;
end;


class function TValidadorDaRegraValorEmissaoNFCePorEstado.fRetornarMensagemValorEmissaoNFCePorEstado(
  const ADestinatarioIdentificado: Boolean; const AEstado: String;
  const AValorDocumento, AValorMaxPermitido: Double): String;
begin
  Result :=
    ' O valor total permitido para emissão de Nfc-e com destinatário identificado no estado "'+AEstado+'" é de ('+FormatFloat('#,##0.00', AValorMaxPermitido)+').'+#13+
    ' É preciso alterar a espécie de fechamento para que o Sefaz não rejeite o documento (CFG_NFCEUF)".';

  if ADestinatarioIdentificado then
    Exit;

  Result :=
    'O valor total da Nfc-e (R$ '+FormatFloat('#,##0.00',AValorDocumento)+') ultrapassa o valor configurado para o estado "'+AEstado+'" e destinatário não '+#13+
    'identificado (R$ '+FormatFloat('#,##0.00',AValorMaxPermitido)+').'+#13+
    'Informe CORRETAMENTE o CPF/CNPJ do cliente para que o cupom eletrônico não seja rejeitado pelo Sefaz (CFG_NFCEUF)".';
end;

class function TValidadorDaRegraValorEmissaoNFCePorEstado.fRetornarSQLValoresMaxEmissaoNFCe: String;
begin
  Result :=
    ' SELECT '+
    '    NFC_ESTADO, '+
    '    NFC_DESCRI, '+
    '    NFC_DESTID, '+
    '    NFC_DESSEM  '+
    '  FROM '+
    '    NFCEUF ' ;
end;

class function TValidadorDaRegraValorEmissaoNFCePorEstado.fRetornarValidacaoDaRegraValorEmissaoNFCePorEstado(Const AEstado : String;
  Const ACliCgc : String; Const ATipoFaturamento : String;
  Const ATotalDocumento : Double ): String;
Var
  LqryAux : TUniQuery;
  LfltValorMaxPermitido : Double;

begin
   Result := '';

  If Not fEntrarNaRegraValorEmissaoNFCePorEstado(ATipoFaturamento) Then
    Exit;

  Try
    LqryAux := fCriaQuery;
    LqryAux.SQL.Text :=
      fRetornarSQLValoresMaxEmissaoNFCe +
        ' WHERE NFC_ESTADO = :ESTADO  ';

    LqryAux.ParamByName('ESTADO').AsString := AEstado;
    LqryAux.Open;


    LfltValorMaxPermitido :=
      IIF(fClienteIdentificado(ACliCgc),
        LqryAux.FieldByName('NFC_DESTID').AsFloat,
          LqryAux.FieldByName('NFC_DESSEM').AsFloat);


    if fVerificarValorMaximoPermitido(fFormataFloat(ATotalDocumento,2), fFormataFloat(LfltValorMaxPermitido,2)) then
    begin
      Result :=
         fRetornarMensagemValorEmissaoNFCePorEstado
           (fClienteIdentificado(ACliCgc),
             AEstado,
               ATotalDocumento,
                 LfltValorMaxPermitido);
    end;

  finally
    pFreeAndNil(LqryAux);
  end;
end;

class function TValidadorDaRegraValorEmissaoNFCePorEstado.fVerificarValorMaximoPermitido(
  Const ATotalDocumento : Double;
  Const fltValorMaxPermitido: Double): Boolean;
begin
  Result := (fFormataFloat(ATotalDocumento, 2) >  fFormataFloat(fltValorMaxPermitido, 2));
end;

end.
