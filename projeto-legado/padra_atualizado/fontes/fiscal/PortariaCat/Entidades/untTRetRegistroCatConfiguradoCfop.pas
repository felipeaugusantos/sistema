unit untTRetRegistroCatConfiguradoCfop;

interface

uses untTDadosAberturaExportacaoCat42,
     untTRetRegistroCatDevolucaoVenda,
     untTRetRegistroCatTransferencia,
     System.Generics.Collections,
     untTItemNotaUtilizadoCat,
     untTItemNotaFiscal,
     untIRetRegistroCat,
     untTEnquadramento,
     untTRegistroCat,
     untTNotaFiscal,
     SysUtils,
     StrUtils,
     Classes,
     Uni;

type
  TRetRegistroCatConfiguradoCfop = class(TInterfacedObject, IRetRegistroCat)
  private
    FListaEnquadramentosConfigurado: TObjectList<TEnquadramento>;

    function fRetCfopEnquadramento(strEnquadramento: string): string;
    function fRetCstEnquadramento(strEnquadramento: string): string;

    procedure pCarregarEnquadramentosConfigurados;
  public
    function fCarregaRegistrosCat(notas: TObjectList<TNotaFiscal>;
                                  abertura: TDadosAberturaExportacaoCat42;
                                  stlEnquadramento: TStringList): TObjectList<TRegistroCat>;
    constructor create;
    Destructor Destroy; override;
  end;

implementation

uses untFuncoes,
     untTipo;

constructor TRetRegistroCatConfiguradoCfop.Create;
begin
  inherited Create;

  FListaEnquadramentosConfigurado := TObjectList<TEnquadramento>.Create;
  pCarregarEnquadramentosConfigurados;
end;

destructor TRetRegistroCatConfiguradoCfop.Destroy;
begin
  FListaEnquadramentosConfigurado.Free;
  inherited destroy;
end;

procedure TRetRegistroCatConfiguradoCfop.pCarregarEnquadramentosConfigurados;
  var
    enquadramento: TEnquadramento;
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT ' +
                  '  LEFT(ENQ_DESENQ, 1) AS CODIGO, ' +
                  '  ENQ_CLAFIS, ' +
                  '  ENQ_CODFIS ' +
                  'FROM ' +
                  '  CADENQ' +
                  '  LEFT JOIN DESENQ' +
                  '    ON DESENQ.AUTOINCREM = ENQ_CODENQ ';
      Open;

      First;
      while not Eof do
      begin
        enquadramento := TEnquadramento.Create;
        enquadramento.strEnquadramento := FieldByName('CODIGO').AsString;
        enquadramento.strCfops := FieldByName('ENQ_CLAFIS').AsString;
        enquadramento.strCsts := FieldByName('ENQ_CODFIS').AsString;
        FListaEnquadramentosConfigurado.Add(enquadramento);

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

function TRetRegistroCatConfiguradoCfop.fRetCfopEnquadramento(strEnquadramento: string): string;
  var
    enquad: TEnquadramento;
begin
  Result := '';

  for enquad in FListaEnquadramentosConfigurado do
  begin
    if strEnquadramento = enquad.strEnquadramento then
    begin
      Result := enquad.strCfops;
      Exit;
    end;
  end;
end;

function TRetRegistroCatConfiguradoCfop.fRetCstEnquadramento(strEnquadramento: string): string;
  var
    enquad: TEnquadramento;
begin
  Result := '';

  for enquad in FListaEnquadramentosConfigurado do
  begin
    if strEnquadramento = enquad.strEnquadramento then
    begin
      Result := enquad.strCsts;
      Exit;
    end;
  end;
end;

function TRetRegistroCatConfiguradoCfop.fCarregaRegistrosCat(notas: TObjectList<TNotaFiscal>; abertura: TDadosAberturaExportacaoCat42;
  stlEnquadramento: TStringList): TObjectList<TRegistroCat>;
  var
    registro, registroDevolucao, registroTransferencia: TRegistroCat;
    objTransferencia: TRetRegistroCatTransferencia;
    objDevolucao: TRetRegistroCatDevolucaoVenda;
    item: TItemNotaFiscal;
    nota: TNotaFiscal;
begin
  //objeto destruido na classe TEstoqueCat42, pois essa função serve para alimentar a lista de registros da classe citada
  Result := TObjectList<TRegistroCat>.Create;

  {$Region 'leitura das notas fiscais'}
  for nota in notas do
  begin
    {$Region 'leitura dos Itens das notas fiscais'}
    for item in nota.itensNota do
    begin
      {$Region 'Enquadramento 0'}
      //Enquadramento 0
      if (Pos(item.strCfop, fRetCfopEnquadramento('0')) > 0) then
      begin
        registro := TRegistroCat.Create;

        registro.dtaDataNotaDadosGerais := item.dtaDtaEnt;
        registro.strCodigoProduto := item.strCodIte;
        registro.strEnquadramento := '0';
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
      {$EndRegion}

      {$Region 'Enquadramento 1'}
      //Enquadramento 1
      else if (Pos(item.strCfop, fRetCfopEnquadramento('1')) > 0) then
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
      {$EndRegion}

      {$Region 'Enquadramento 2'}
      //Enquadramento 2
      else if (Pos(item.strCfop, fRetCfopEnquadramento('2')) > 0) then
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
      {$EndRegion}

      {$Region 'Enquadramento 3'}
      //Enquadramento 3
      else if (Pos(RightStr(item.strCstIcm, 2), fRetCstEnquadramento('3')) > 0) and
              (Pos(item.strCfop, fRetCfopEnquadramento('3')) > 0) then
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
      {$EndRegion}

      {$Region 'Enquadramento 4'}
      //Enquadramento 4
      else if (Pos(RightStr(item.strCstIcm, 2), fRetCstEnquadramento('4')) > 0) and
              (Pos(item.strCfop, fRetCfopEnquadramento('4')) > 0) then
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
      {$EndRegion}

      {$Region 'Enquadramento 5'}
      //Enquadramento 5 (devoluções)
      else if (Pos(item.strCfop, fRetCfopEnquadramento('5')) > 0) then
      begin
        {CSTs: '00_10_20_70'}
        if (Pos(RightStr(item.strCstIcm, 2), fRetCstEnquadramento('5')) > 0) then
        begin
          {estrutura foi construida desta forma por que futuramente iremos implementar novas regras (Saidas)}
          objDevolucao := TRetRegistroCatDevolucaoVenda.Create(Result);
          try
            objDevolucao.stlListaEnquadramentosConfigurado := FListaEnquadramentosConfigurado;
            objDevolucao.abertura := abertura;
            registroDevolucao := objDevolucao.fRetRegistro(item);

            if Assigned(registroDevolucao) then
              Result.Add(registroDevolucao)

          finally
            objDevolucao.Free;
          end;
        end;
      end
      {$EndRegion}

      {$Region 'Enquadramento 6'}
      //Enquadramento 6 (Entradas)
      else if (Pos(RightStr(item.strCstIcm, 2), fRetCstEnquadramento('6')) > 0) and
              (Pos(item.strCfop, fRetCfopEnquadramento('6')) > 0){or
              (Pos(item.strCfop, '1409_2409') > 0)} then
      begin
        if abertura.tipoConferencia = tccsim  then
        begin
          if Pos(item.strCfop, '1409_2409') > 0 then
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
          else
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

          if IIF(abertura.strVersaoExecutada = 'v1', abertura.blnEnviaNfCredSemSubsti, true) then
          begin
            if Pos(item.strCfop, '1409_2409') > 0 then
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
            else
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
          else if item.fltValorRetidoNaoCreditado > 0 then
          begin
            if Pos(item.strCfop, '1409_2409') > 0 then
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
            else
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
      {$EndRegion}
    end;
    {$EndRegion}
  end;
  {$EndRegion}
end;

end.
