unit untTRetRegistroCat;

interface

uses untTDadosAberturaExportacaoCat42,
     untTRetRegistroCatDevolucaoVenda,
     untTRetRegistroCatTransferencia,
     System.Generics.Collections,
     untTItemNotaUtilizadoCat,
     untIRetRegistroCat,
     untTRegistroCat,
     untTNotaFiscal,
     SysUtils,
     StrUtils,
     Classes;

type
  TRetRegistroCat = class(TInterfacedObject, IRetRegistroCat)
  private
    function fCarregaEnquadramentosSelecionados(stlEnquadramento: TStringList): string;
  public
    function fCarregaRegistrosCat(notas: TObjectList<TNotaFiscal>;
                                  abertura: TDadosAberturaExportacaoCat42;
                                  stlEnquadramento: TStringList): TObjectList<TRegistroCat>;
  end;

implementation

uses untTItemNotaFiscal, untFuncoes, untTipo;

{ TRetRegistroCat }

function TRetRegistroCat.fCarregaEnquadramentosSelecionados(stlEnquadramento: TStringList): string;
  var
    intContador: integer;
begin
  Result := '';

  for intContador := 0 to stlEnquadramento.Count - 1 do
  begin
    Result := Result + stlEnquadramento[intContador] + '_';
  end;
end;

function TRetRegistroCat.fCarregaRegistrosCat(notas: TObjectList<TNotaFiscal>; abertura: TDadosAberturaExportacaoCat42;
  stlEnquadramento: TStringList): TObjectList<TRegistroCat>;
  var
    registro, registroDevolucao, registroTransferencia: TRegistroCat;
    objTransferencia: TRetRegistroCatTransferencia;
    objDevolucao: TRetRegistroCatDevolucaoVenda;
    strEnquadramentos: string;
    strPerfilCliente: string;
    item: TItemNotaFiscal;
    nota: TNotaFiscal;
begin
  //objeto destruido na classe TEstoqueCat42, pois essa função serve para alimentar a lista de registros da classe citada
  Result := TObjectList<TRegistroCat>.Create;

  //carregando a string para validação de qual enquadramento será gerado
  strEnquadramentos := fCarregaEnquadramentosSelecionados(stlEnquadramento);

  for nota in notas do
  begin
    strPerfilCliente := fGetTipoAbfCliente(nota.participante.strCodigo);

    for item in nota.itensNota do
    begin
      if (Pos(nota.strCfop1, VS_strClaDev) = 0) and (StrToInt(item.strCfop) < 6000) and (StrToInt(item.strCfop) > 5000) and
         ((Pos('NCO', strPerfilCliente) > 0) or (Pos('CCO', strPerfilCliente) > 0) or (Pos('CTA', strPerfilCliente) > 0) or
         (Pos('PRU', strPerfilCliente) > 0) or (Pos('SNA', strPerfilCliente) > 0)) then
      begin
        registro := TRegistroCat.Create;

        registro.dtaDataNotaDadosGerais := item.dtaDtaEnt;
        registro.strCodigoProduto := item.strCodIte;
        registro.strEnquadramento := '1';
        registro.intOrdemGeracao := 3;

        registro.itemNota.participante.strCodigo := item.participante.strCodigo;
        registro.itemNota.fltValorContabil := item.fltValorContabil;
        registro.itemNota.strChaveAcesso := item.strChaveAcesso;
        registro.itemNota.fltQuantidade := item.fltQuantidade;
        registro.itemNota.strAutoIncrem := item.strAutoIncrem;
        registro.itemNota.strUnidade := item.strUnidade;
        registro.itemNota.strCodIte := item.strCodIte;
        registro.itemNota.strDesIte := item.strDesIte;
        registro.itemNota.dtaDtaEnt := item.dtaDtaEnt;
        registro.itemNota.strNumDoc := item.strNumDoc;
        registro.itemNota.strSerie := item.strSerie;
        registro.itemNota.strCfop := item.strCfop;

        Result.Add(registro);
      end

      else if (nota.strCfop1 = '5927') then
      begin
        registro := TRegistroCat.Create;

        registro.dtaDataNotaDadosGerais := item.dtaDtaEnt;
        registro.strCodigoProduto := item.strCodIte;
        registro.strEnquadramento := '2';
        registro.intOrdemGeracao := 3;

        registro.itemNota.participante.strCodigo := item.participante.strCodigo;
        registro.itemNota.fltValorContabil := item.fltValorContabil;
        registro.itemNota.strChaveAcesso := item.strChaveAcesso;
        registro.itemNota.fltQuantidade := item.fltQuantidade;
        registro.itemNota.strAutoIncrem := item.strAutoIncrem;
        registro.itemNota.strUnidade := item.strUnidade;
        registro.itemNota.strCodIte := item.strCodIte;
        registro.itemNota.strDesIte := item.strDesIte;
        registro.itemNota.dtaDtaEnt := item.dtaDtaEnt;
        registro.itemNota.strNumDoc := item.strNumDoc;
        registro.itemNota.strSerie := item.strSerie;
        registro.itemNota.strCfop := item.strCfop;

        Result.Add(registro);
      end

      else if ((Pos(RightStr(item.strCstIcm, 2), '40_41') > 0) or (StrToInt(item.strCfop) > 7000)) then
      begin
        registro := TRegistroCat.Create;

        registro.dtaDataNotaDadosGerais := item.dtaDtaEnt;
        registro.strCodigoProduto := item.strCodIte;
        registro.strEnquadramento := '3';
        registro.intOrdemGeracao := 3;

        registro.itemNota.participante.strCodigo := item.participante.strCodigo;
        registro.itemNota.fltValorContabil := item.fltValorContabil;
        registro.itemNota.strChaveAcesso := item.strChaveAcesso;
        registro.itemNota.fltQuantidade := item.fltQuantidade;
        registro.itemNota.strAutoIncrem := item.strAutoIncrem;
        registro.itemNota.strUnidade := item.strUnidade;
        registro.itemNota.strCodIte := item.strCodIte;
        registro.itemNota.strDesIte := item.strDesIte;
        registro.itemNota.dtaDtaEnt := item.dtaDtaEnt;
        registro.itemNota.strNumDoc := item.strNumDoc;
        registro.itemNota.strSerie := item.strSerie;
        registro.itemNota.strCfop := item.strCfop;

        Result.Add(registro);
      end

      else if ((Pos(RightStr(item.strCstIcm, 2), '00_10_20_70') > 0) and (StrToInt(item.strCfop) > 6000)) then
      begin
        registro := TRegistroCat.Create;

        registro.dtaDataNotaDadosGerais := item.dtaDtaEnt;
        registro.strCodigoProduto := item.strCodIte;
        registro.strEnquadramento := '4';
        registro.intOrdemGeracao := 3;

        registro.itemNota.participante.strCodigo := item.participante.strCodigo;
        registro.itemNota.fltValorContabil := item.fltValorContabil;
        registro.itemNota.strChaveAcesso := item.strChaveAcesso;
        registro.itemNota.fltQuantidade := item.fltQuantidade;
        registro.itemNota.strAutoIncrem := item.strAutoIncrem;
        registro.itemNota.strUnidade := item.strUnidade;
        registro.itemNota.strCodIte := item.strCodIte;
        registro.itemNota.strDesIte := item.strDesIte;
        registro.itemNota.dtaDtaEnt := item.dtaDtaEnt;
        registro.itemNota.strNumDoc := item.strNumDoc;
        registro.itemNota.strSerie := item.strSerie;
        registro.itemNota.strCfop := item.strCfop;

        Result.Add(registro);
      end

      else if Pos(nota.strCfop1, VS_strClaDev) > 0 then
      begin
        objDevolucao := TRetRegistroCatDevolucaoVenda.Create(Result);
        try
          objDevolucao.strEnquadramentos := strEnquadramentos;
          objDevolucao.abertura := abertura;
          registroDevolucao := objDevolucao.fRetRegistro(item);

          if Assigned(registroDevolucao) then
            Result.Add(registroDevolucao)
          else
          begin
            registro := TRegistroCat.Create;

            registro.dtaDataNotaDadosGerais := item.dtaDtaEnt;
            registro.strCodigoProduto := item.strCodIte;
            registro.intOrdemGeracao := 3;

            //# ROTINA PARA NÃO GRAVAR VALOR PARA OS CFOPS DESTACADOS
            if (Pos(item.strCfop, '1411') > 0) then
              registro.strEnquadramento := '0'
            else registro.strEnquadramento := '4';

            registro.itemNota.participante.strCodigo := item.participante.strCodigo;
            registro.itemNota.fltValorContabil := item.fltValorContabil;
            registro.itemNota.strChaveAcesso := item.strChaveAcesso;
            registro.itemNota.fltQuantidade := item.fltQuantidade;
            registro.itemNota.strAutoIncrem := item.strAutoIncrem;
            registro.itemNota.strUnidade := item.strUnidade;
            registro.itemNota.strCodIte := item.strCodIte;
            registro.itemNota.strDesIte := item.strDesIte;
            registro.itemNota.dtaDtaEnt := item.dtaDtaEnt;
            registro.itemNota.strNumDoc := item.strNumDoc;
            registro.itemNota.strSerie := item.strSerie;
            registro.itemNota.strCfop := item.strCfop;
            registro.itemNota.strDocDev := item.strDocDev; {para verificar se existe nota fiscal referenciada}

            Result.Add(registro);
          end;
        finally
          objDevolucao.Free;
        end;

      end

      else if Pos(item.strCfop, '1409_2409') > 0 then
      begin
        objTransferencia := TRetRegistroCatTransferencia.Create;
        try
          objTransferencia.abertura := abertura;
          registroTransferencia := objTransferencia.fRetRegistro(item);

          if Assigned(registroTransferencia) then
            Result.Add(registroTransferencia);
        finally
          objTransferencia.Free;
        end;
      end

      else if (StrToInt(nota.strCfop1) < 5000) and
              (Pos(RightStr(item.strCstIcm, 2), '10_60') > 0) then
      begin
        if abertura.strVersaoExecutada = 'v1' then
        begin
          if abertura.blnEnviaNfCredSemSubsti then
          begin
            registro := TRegistroCat.Create;

            registro.dtaDataNotaDadosGerais := item.dtaDtaEnt;
            registro.strCodigoProduto := item.strCodIte;
            registro.strEnquadramento := '';
            registro.intOrdemGeracao := 1;

            registro.itemNota.fltValorRetidoNaoCreditado := item.fltValorRetidoNaoCreditado;
            registro.itemNota.participante.strCodigo := item.participante.strCodigo;
            registro.itemNota.fltValorContabil := item.fltValorContabil;
            registro.itemNota.strChaveAcesso := item.strChaveAcesso;
            registro.itemNota.fltQuantidade := item.fltQuantidade;
            registro.itemNota.strUnidade := item.strUnidade;
            registro.itemNota.strCodIte := item.strCodIte;
            registro.itemNota.strDesIte := item.strDesIte;
            registro.itemNota.dtaDtaEnt := item.dtaDtaEnt;
            registro.itemNota.strNumDoc := item.strNumDoc;
            registro.itemNota.strSerie := item.strSerie;
            registro.itemNota.strCfop := item.strCfop;

            Result.Add(registro);
          end
          else if item.fltValorRetidoNaoCreditado > 0 then
          begin
            registro := TRegistroCat.Create;

            registro.dtaDataNotaDadosGerais := item.dtaDtaEnt;
            registro.strCodigoProduto := item.strCodIte;
            registro.strEnquadramento := '';
            registro.intOrdemGeracao := 1;

            registro.itemNota.fltValorRetidoNaoCreditado := item.fltValorRetidoNaoCreditado;
            registro.itemNota.participante.strCodigo := item.participante.strCodigo;
            registro.itemNota.fltValorContabil := item.fltValorContabil;
            registro.itemNota.strChaveAcesso := item.strChaveAcesso;
            registro.itemNota.fltQuantidade := item.fltQuantidade;
            registro.itemNota.strUnidade := item.strUnidade;
            registro.itemNota.strCodIte := item.strCodIte;
            registro.itemNota.strDesIte := item.strDesIte;
            registro.itemNota.dtaDtaEnt := item.dtaDtaEnt;
            registro.itemNota.strNumDoc := item.strNumDoc;
            registro.itemNota.strSerie := item.strSerie;
            registro.itemNota.strCfop := item.strCfop;

            Result.Add(registro);
          end;
        end
        else
        begin
          if abertura.tipoConferencia = tccSim then
          begin
            if IIF(abertura.strVersaoExecutada = 'v1', abertura.blnEnviaNfCredSemSubsti, true) then
            begin
              registro := TRegistroCat.Create;

              registro.dtaDataNotaDadosGerais := item.dtaDtaEnt;
              registro.strCodigoProduto := item.strCodIte;
              registro.strEnquadramento := '';
              registro.intOrdemGeracao := 1;

              registro.itemNota.fltValorRetidoNaoCreditado := item.fltValorRetidoNaoCreditado;
              registro.itemNota.participante.strCodigo := item.participante.strCodigo;
              registro.itemNota.fltValorContabil := item.fltValorContabil;
              registro.itemNota.strChaveAcesso := item.strChaveAcesso;
              registro.itemNota.fltQuantidade := item.fltQuantidade;
              registro.itemNota.strUnidade := item.strUnidade;
              registro.itemNota.strCodIte := item.strCodIte;
              registro.itemNota.strDesIte := item.strDesIte;
              registro.itemNota.dtaDtaEnt := item.dtaDtaEnt;
              registro.itemNota.strNumDoc := item.strNumDoc;
              registro.itemNota.strSerie := item.strSerie;
              registro.itemNota.strCfop := item.strCfop;

              Result.Add(registro);
            end
            else if item.fltValorRetidoNaoCreditado > 0 then
            begin
              registro := TRegistroCat.Create;

              registro.dtaDataNotaDadosGerais := item.dtaDtaEnt;
              registro.strCodigoProduto := item.strCodIte;
              registro.strEnquadramento := '';
              registro.intOrdemGeracao := 1;

              registro.itemNota.fltValorRetidoNaoCreditado := item.fltValorRetidoNaoCreditado;
              registro.itemNota.participante.strCodigo := item.participante.strCodigo;
              registro.itemNota.fltValorContabil := item.fltValorContabil;
              registro.itemNota.strChaveAcesso := item.strChaveAcesso;
              registro.itemNota.fltQuantidade := item.fltQuantidade;
              registro.itemNota.strUnidade := item.strUnidade;
              registro.itemNota.strCodIte := item.strCodIte;
              registro.itemNota.strDesIte := item.strDesIte;
              registro.itemNota.dtaDtaEnt := item.dtaDtaEnt;
              registro.itemNota.strNumDoc := item.strNumDoc;
              registro.itemNota.strSerie := item.strSerie;
              registro.itemNota.strCfop := item.strCfop;

              Result.Add(registro);
            end;
          end
          else
          begin
            if abertura.tipoConferencia = tccConf then
            begin
              registro := TRegistroCat.Create;

              registro.dtaDataNotaDadosGerais := item.dtaDtaEnt;
              registro.strCodigoProduto := item.strCodIte;
              registro.strEnquadramento := '';
              registro.intOrdemGeracao := 1;

              registro.itemNota.fltValorRetidoNaoCreditado := item.fltValorRetidoNaoCreditado;
              registro.itemNota.participante.strCodigo := item.participante.strCodigo;
              registro.itemNota.fltValorContabil := item.fltValorContabil;
              registro.itemNota.strChaveAcesso := item.strChaveAcesso;
              registro.itemNota.fltQuantidade := item.fltQuantidade;
              registro.itemNota.strUnidade := item.strUnidade;
              registro.itemNota.strCodIte := item.strCodIte;
              registro.itemNota.strDesIte := item.strDesIte;
              registro.itemNota.dtaDtaEnt := item.dtaDtaEnt;
              registro.itemNota.strNumDoc := item.strNumDoc;
              registro.itemNota.strSerie := item.strSerie;
              registro.itemNota.strCfop := item.strCfop;

              Result.Add(registro);
            end;
          end;
        end;
      end;
    end;
  end;
end;

end.
