unit untTRetRegistroCatDevolucaoVenda;

interface

uses untTDadosAberturaExportacaoCat42,
     System.Generics.Collections,
     untTItemNotaUtilizadoCat,
     untTItemNotaFiscal,
     untTEnquadramento,
     untTRegistroCat,
     untTNotaFiscal,
     SysUtils,
     StrUtils,
     Uni;

type
  TRetRegistroCatDevolucaoVenda = class
  private
    FListaEnquadramentosConfigurado: TObjectList<TEnquadramento>;
    FAbertura: TDadosAberturaExportacaoCat42;
    FDados: TObjectList<TRegistroCat>;
    FEnquadramentos: string;

    function fRetCfopEnquadramento(strEnquadramento: string): string;
    function fRetCstEnquadramento(strEnquadramento: string): string;

    function fRetRegistroCatGravado(itemDevolucao: TItemNotaFiscal): TRegistroCat;
    function fRetCodigoEnquadramento(qryAux: TUniQuery): string;
  public
    function fRetRegistro(itemDevolucao: TItemNotaFiscal): TRegistroCat;

    constructor create(listaDadosCat: TObjectList<TRegistroCat>);

    property stlListaEnquadramentosConfigurado: TObjectList<TEnquadramento> read FListaEnquadramentosConfigurado write FListaEnquadramentosConfigurado;
    property abertura: TDadosAberturaExportacaoCat42 read FAbertura write FAbertura;
    property strEnquadramentos: string read FEnquadramentos write FEnquadramentos;
  end;

implementation

uses untFuncoes;

{ TRetRegistroCatDevolucaoVenda }

constructor TRetRegistroCatDevolucaoVenda.create(listaDadosCat: TObjectList<TRegistroCat>);
begin
  inherited create;

  if Assigned(listaDadosCat) then
    FDados := listaDadosCat;
end;

function TRetRegistroCatDevolucaoVenda.fRetCfopEnquadramento(
  strEnquadramento: string): string;
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

function TRetRegistroCatDevolucaoVenda.fRetCodigoEnquadramento(qryAux: TUniQuery): string;
  var
    strPerfilCliente: string;
begin
  Result := '';

  with qryAux do
  begin
    if FAbertura.blnUtilizarConfigCfopCstEnquadramentos  then
    begin
      if (Pos(FieldByName('DET_CLAFIS').AsString, fRetCfopEnquadramento('0')) > 0) then
        Result := '0'
      else if (Pos(FieldByName('DET_CLAFIS').AsString, fRetCfopEnquadramento('1')) > 0) then
        Result := '1'
      else if (Pos(FieldByName('DET_CLAFIS').AsString, fRetCfopEnquadramento('2')) > 0) then
        Result := '2'
      else if (Pos(RightStr(FieldByName('DET_CODFIS').AsString, 2), fRetCstEnquadramento('3')) > 0) and
              (Pos(FieldByName('DET_CLAFIS').AsString, fRetCfopEnquadramento('3')) > 0) then
        Result := '3'
      else if (Pos(RightStr(FieldByName('DET_CODFIS').AsString, 2), fRetCstEnquadramento('4')) > 0) and
              (Pos(FieldByName('DET_CLAFIS').AsString, fRetCfopEnquadramento('4')) > 0) then
        Result := '4'
    end
    else
    begin
      strPerfilCliente := fGetTipoAbfCliente(FieldByName('DET_CODCLI').AsString);

      if (Pos('1', FEnquadramentos) > 0) and
         (Pos(FieldByName('DET_CLAFIS').AsString, VS_strClaDev) = 0) and
         (StrToInt(FieldByName('DET_CLAFIS').AsString) < 6000) and (StrToInt(FieldByName('DET_CLAFIS').AsString) > 5000) and
         ((Pos('NCO', strPerfilCliente) > 0) or (Pos('CCO', strPerfilCliente) > 0) or (Pos('CTA', strPerfilCliente) > 0) or
         (Pos('PRU', strPerfilCliente) > 0) or (Pos('SNA', strPerfilCliente) > 0)) then
        Result := '1'
      else if (Pos('2', FEnquadramentos) > 0) and (FieldByName('DET_CLAFIS').AsString = '5927') then
        Result := '2'
      else if (Pos('3', FEnquadramentos) > 0) and ((Pos(RightStr(FieldByName('DET_CODFIS').AsString, 2), '40_41') > 0) or (StrToInt(FieldByName('DET_CLAFIS').AsString) > 7000)) then
        Result := '3'
      else if (Pos('4', FEnquadramentos) > 0) and ((Pos(RightStr(FieldByName('DET_CODFIS').AsString, 2), '00_10_20_70') > 0) and (StrToInt(FieldByName('DET_CLAFIS').AsString) > 6000)) then
        Result := '4';
    end;
  end;
end;

function TRetRegistroCatDevolucaoVenda.fRetCstEnquadramento(
  strEnquadramento: string): string;
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

function TRetRegistroCatDevolucaoVenda.fRetRegistro(itemDevolucao: TItemNotaFiscal): TRegistroCat;

begin
  Result := fRetRegistroCatGravado(itemDevolucao);
end;

function TRetRegistroCatDevolucaoVenda.fRetRegistroCatGravado(itemDevolucao: TItemNotaFiscal): TRegistroCat;
  var
    qryAux: TUniQuery;
begin
  Result := nil;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      //DADOS DA VENDA/COMPRA QUE GEROU A DEVOLUÇÃO
      //PRIMEIRO E VERIFICADO A TABELA MOVDET CASO CONTRARIO E VERIFICADO A NOTDET
      //ANDRE MAXIMIANO 25-02-2021
      SQL.Text := 'SELECT ' +
                  '  DET_CLAFIS, ' +
                  '  DET_CODCLI, ' +
                  '  DET_CODFIS ' +
                  'FROM ' +
                  '  MOVDET ' +
                  'WHERE DET_NUMDOC = :NUMDOC ' +
                  '  AND DET_CODEMP = :CODEMP ' +
                  '  AND DET_ESPDOC = :ESPDOC ' +
                  //# '  AND IFNULL(DET_CODCLI, DET_CODFOR) = :CODCLI ' +
                  '  AND DET_CODITE = :CODITE ';

      ParamByName('CODITE').AsString := itemDevolucao.strCodIte;
      ParamByName('NUMDOC').AsString := itemDevolucao.strDocDev;
      ParamByName('CODEMP').AsString := itemDevolucao.strEmpDev;
      ParamByName('ESPDOC').AsString := itemDevolucao.strEspDev;
      //# ParamByName('CODCLI').AsString := itemDevolucao.participante.strCodigo;
      Open;

      if RecordCount > 0 then
      begin
        Result := TRegistroCat.Create;

        Result.dtaDataNotaDadosGerais := itemDevolucao.dtaDtaEnt;
        Result.strCodigoProduto := itemDevolucao.strCodIte;
        Result.strEnquadramento := IIF(fEmptyStr(fRetCodigoEnquadramento(qryAux)), '4', fRetCodigoEnquadramento(qryAux));
        Result.itemNota.participante.strCodigo := itemDevolucao.participante.strCodigo;
        Result.itemNota.fltValorContabil := itemDevolucao.fltValorContabil;
        Result.itemNota.strChaveAcesso := itemDevolucao.strChaveAcesso;
        Result.itemNota.fltQuantidade := itemDevolucao.fltQuantidade;
        Result.itemNota.strUnidade := itemDevolucao.strUnidade;
        Result.itemNota.strCodIte := itemDevolucao.strCodIte;
        Result.itemNota.strDesIte := itemDevolucao.strDesIte;
        Result.itemNota.dtaDtaEnt := itemDevolucao.dtaDtaEnt;
        Result.itemNota.strNumDoc := itemDevolucao.strNumDoc;
        Result.itemNota.strSerie := itemDevolucao.strSerie;
        Result.itemNota.strCfop := itemDevolucao.strCfop;
        Result.itemNota.strDocDev := itemDevolucao.strDocDev;
        Result.intOrdemGeracao := 2;
      end
      else
      begin
        Close;
        SQL.Clear;
        //DADOS DA VENDA/COMPRA QUE GEROU A DEVOLUÇÃO
        //PRIMEIRO E VERIFICADO A TABELA MOVDET CASO CONTRARIO E VERIFICADO A NOTDET
        //ANDRE MAXIMIANO 25-02-2021
        SQL.Text := 'SELECT ' +
                    '  DET_CLAFIS, ' +
                    '  DET_CODCLI, ' +
                    '  DET_CODFIS ' +
                    'FROM ' +
                    '  NOTDET ' +
                    'WHERE DET_NUMDOC = :NUMDOC ' +
                    '  AND DET_CODEMP = :CODEMP ' +
                    '  AND DET_ESPDOC = :ESPDOC ' +
                    //# '  AND IFNULL(DET_CODCLI, DET_CODFOR) = :CODCLI ' +
                    '  AND DET_CODITE = :CODITE ';

        ParamByName('CODITE').AsString := itemDevolucao.strCodIte;
        ParamByName('NUMDOC').AsString := itemDevolucao.strDocDev;
        ParamByName('CODEMP').AsString := itemDevolucao.strEmpDev;
        ParamByName('ESPDOC').AsString := itemDevolucao.strEspDev;
        //# ParamByName('CODCLI').AsString := itemDevolucao.participante.strCodigo;
        Open;

        if RecordCount > 0 then
        begin
          Result := TRegistroCat.Create;

          Result.dtaDataNotaDadosGerais := itemDevolucao.dtaDtaEnt;
          Result.strCodigoProduto := itemDevolucao.strCodIte;
          Result.strEnquadramento := IIF(fEmptyStr(fRetCodigoEnquadramento(qryAux)), '4', fRetCodigoEnquadramento(qryAux));
          Result.itemNota.participante.strCodigo := itemDevolucao.participante.strCodigo;
          Result.itemNota.fltValorContabil := itemDevolucao.fltValorContabil;
          Result.itemNota.strChaveAcesso := itemDevolucao.strChaveAcesso;
          Result.itemNota.fltQuantidade := itemDevolucao.fltQuantidade;
          Result.itemNota.strUnidade := itemDevolucao.strUnidade;
          Result.itemNota.strCodIte := itemDevolucao.strCodIte;
          Result.itemNota.strDesIte := itemDevolucao.strDesIte;
          Result.itemNota.dtaDtaEnt := itemDevolucao.dtaDtaEnt;
          Result.itemNota.strNumDoc := itemDevolucao.strNumDoc;
          Result.itemNota.strSerie := itemDevolucao.strSerie;
          Result.itemNota.strCfop := itemDevolucao.strCfop;
          Result.itemNota.strDocDev := itemDevolucao.strDocDev;
          Result.intOrdemGeracao := 2;
        end;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

end.
