unit untAlteracaoItensRomaneio;

interface

uses classes, sysutils, strutils, untZClient, uni, untCdsItensLocalSeparacao;

Type
    TAlteracaoItensRomaneio = class
    private

      FNumeroRomaneio : String;
      cdsRomDetXOld   : TZClient;
      cdsRomDetXNew   : TZClient;
      cdsDadosItem    : TUniQuery;

      function fGetSQLRomDet : String;

    public

      constructor Create(strNumeroRomaneio : String);
      function fAbreRomDetXOld : boolean;
      function fGetItensAlterados( blnConsiderarExcluidos : boolean = True ) : TCdsItensLocalSeparacao;
      destructor Destroy; override;

    end;

implementation

uses untFuncoesSimples, untFuncFatImp, untTypesSistema, untFuncFatTypes;


{ TAlteracaoItensRomaneio }

constructor TAlteracaoItensRomaneio.Create(strNumeroRomaneio : String);
begin
  FNumeroRomaneio := strNumeroRomaneio;
  cdsRomDetXOld := TZClient.Create(nil, fGetSQLRomDet);
  cdsRomDetXNew := TZClient.Create(nil, fGetSQLRomDet);

  cdsDadosItem := fCriaQuery(nil);
  cdsDadosItem.SQL.Add('SELECT                                            ');
  cdsDadosItem.SQL.Add('  CADLSE.AUTOINCREM AS AUTOINCREM_LOCAL_SEPARACAO ');
  cdsDadosItem.SQL.Add('FROM                                              ');
  cdsDadosItem.SQL.Add('  ITEGER                                          ');

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
  begin
    cdsDadosItem.SQL.Add(' LEFT JOIN CADLOC ON LOC_CODLOC = ITE_LOCFIS AND LOC_CODEMP = ITE_CODEMP  ');
    cdsDadosItem.SQL.Add(' LEFT JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE ');
  end
  else
    cdsDadosItem.SQL.Add('  LEFT JOIN CADLSE ON LSE_CODIGO = ITE_CODLSE     ');

  cdsDadosItem.SQL.Add('WHERE ITE_CODITE = :CODIGO_ITEM                   ');
  cdsDadosItem.SQL.Add('  AND ITE_CODEMP = :CODIGO_EMPRESA                ');
end;

destructor TAlteracaoItensRomaneio.Destroy;
begin
  FreeAndNil(cdsRomDetXOld);
  FreeAndNil(cdsRomDetXNew);
  FreeAndNil(cdsDadosItem);

  inherited;
end;

function TAlteracaoItensRomaneio.fGetItensAlterados( blnConsiderarExcluidos : boolean = True ): TCdsItensLocalSeparacao;
  procedure pAddItem(strCodigoItem : String);
  begin
    if not Result.Locate('CODIGO_ITEM', strCodigoItem, []) then
    begin

      cdsDadosItem.Close;
      cdsDadosItem.ParamByName('CODIGO_ITEM').AsString    := strCodigoItem;
      cdsDadosItem.ParamByName('CODIGO_EMPRESA').AsString := VS_strCodEmp;
      cdsDadosItem.Open;

      Result.Append;
      Result.FieldByName('CODIGO_ITEM').AsString := strCodigoItem;
      if not fEmptyStr(cdsDadosItem.FieldByName('AUTOINCREM_LOCAL_SEPARACAO').AsString) then
        Result.FieldByName('AUTOINCREM_LOCAL_SEPARACAO').AsString := cdsDadosItem.FieldByName('AUTOINCREM_LOCAL_SEPARACAO').AsString;
      Result.Post;

    end;
  end;

begin
  Result := TCdsItensLocalSeparacao.Create(nil);
  try
    cdsRomDetXNew.Close;
    cdsRomDetXNew.qryQuery.Close;

    if not cdsRomDetXNew.fAbreClient(True, 'TAlteracaoItensRomaneio.fGetItensAlterados') then
      raise Exception.Create('Erro ao verificar itens alterados');

    cdsRomDetXNew.First;
    while not cdsRomDetXNew.Eof do
    begin
      if cdsRomDetXOld.Locate('CODIGO_ITEM', cdsRomDetXNew.FieldByName('CODIGO_ITEM').AsString, []) then
      begin
        if cdsRomDetXNew.FieldByName('QUANTIDADE_ITEM').AsFloat <> cdsRomDetXOld.FieldByName('QUANTIDADE_ITEM').AsFloat then
          pAddItem(cdsRomDetXNew.FieldByName('CODIGO_ITEM').AsString);
      end
      else
        pAddItem(cdsRomDetXNew.FieldByName('CODIGO_ITEM').AsString);

      cdsRomDetXNew.Next;
    end;

    if blnConsiderarExcluidos then
    begin
      cdsRomDetXOld.First;
      while not cdsRomDetXOld.Eof do
      begin
        if not cdsRomDetXNew.Locate('CODIGO_ITEM', cdsRomDetXOld.FieldByName('CODIGO_ITEM').AsString, []) then
          pAddItem(cdsRomDetXOld.FieldByName('CODIGO_ITEM').AsString);

        cdsRomDetXOld.Next;
      end;

    end;

  except

    On E:Exception do
    begin
      FreeAndNil(Result);
      raise Exception.Create(E.Message);
    end;

  end;

end;

function TAlteracaoItensRomaneio.fGetSQLRomDet: String;
begin
  Result :=          ' SELECT                                            ';
  Result := Result + '   DET_CODITE      AS CODIGO_ITEM,                 ';
  Result := Result + '   SUM(DET_QTDITE) AS QUANTIDADE_ITEM              ';
  Result := Result + ' FROM                                              ';
  Result := Result + '   ROMDETX                                         ';
  Result := Result + ' WHERE DET_NUMROM = ' + QuotedStr(FNumeroRomaneio)  ;
  Result := Result + '   AND DET_EMPROM = ' + QuotedStr(VS_strCodEmp)     ;
  Result := Result + ' GROUP BY                                          ';
  Result := Result + '   DET_CODITE                                      ';
end;

function TAlteracaoItensRomaneio.fAbreRomDetXOld : boolean;
begin

  cdsRomDetXOld.Close;
  cdsRomDetXOld.qryQuery.Close;

  Result := cdsRomDetXOld.fAbreClient(True, 'TAlteracaoItensRomaneio.pAbreRomDetXOld');

end;

end.
