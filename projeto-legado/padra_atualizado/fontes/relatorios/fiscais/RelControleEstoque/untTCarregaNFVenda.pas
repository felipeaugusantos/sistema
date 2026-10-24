unit untTCarregaNFVenda;

interface

uses Generics.Collections,
     untTAbstractCarregaNF,
     untTItemNotaFiscal,
     SysUtils,
     StrUtils,
     Classes;

type
  TCarregaNFVenda = class(TAbstractCarregaNF)
  private
    function fRetSQLVendasPeriodoEmpresa: string;
  public
    function fCarregar(strItemSubstituido: string): TObjectList<TItemNotaFiscal>; override;
  end;

implementation

uses untFuncoesSimples,
     untIFuncoes;

{ TCarregaNFVenda }

function TCarregaNFVenda.fCarregar(strItemSubstituido: string): TObjectList<TItemNotaFiscal>;
  var
    item: TItemNotaFiscal;
begin
  Result := listaItensNota; //objeto encapsulado na superclasse

  with dados do
  begin
    Close;
    SQL.Clear;
    SQL.Text := fRetSQLVendasPeriodoEmpresa;
    ParamByName('DTAINI').AsDateTime := dadosAbertura.dtaDataInicial;
    ParamByName('DTAFIN').AsDateTime := dadosAbertura.dtaDataFinal;
    ParamByName('CODEMP').AsString := dadosAbertura.strCodigoEmpresa;
    ParamByName('ITEM').AsString := strItemSubstituido;
    Open;

    First;
    while not Eof do
    begin
      //cria o objeto, carrega e adiciona na lista
      item := TItemNotaFiscal.Create;
      item.dtaData := FieldByName('DET_DTAENT').AsDateTime;
      item.strNumero := FieldByName('DET_NUMDOC').AsString;
      item.strSerie := FieldByName('DET_SERIE_').AsString;
      item.strCodigoParticipante := FieldByName('DET_SERIE_').AsString;
      item.fltQuantidade := FieldByName('DET_QTDITE').AsFloat;
      item.fltBaseSt := FieldByName('DET_BASRET').AsFloat;
      item.fltValorUnitario := FieldByName('DET_UNITAR').AsFloat;
      item.fltTotalProduto := FieldByName('DET_TOTPRO').AsFloat;
      listaItensNota.Add(item);

      Next;
    end;
  end;
end;

function TCarregaNFVenda.fRetSQLVendasPeriodoEmpresa: string;
begin
  Result := '';

  Result := Result + 'SELECT ';
  Result := Result + '  D.DET_DTAENT, ';
  Result := Result + '  D.DET_NUMDOC, ';
  Result := Result + '  D.DET_SERIE_, ';
  Result := Result + '  D.DET_CODCLI, ';
  Result := Result + '  D.DET_QTDITE, ';
  Result := Result + '  IFNULL(D.DET_BASRET, 0) + IFNULL(T.DET_BAERET, 0) AS DET_BASRET, ';
  Result := Result + '  D.DET_UNITAR, ';
  Result := Result + '  IFNULL(D.DET_TOTITE, 0) - IFNULL(D.DET_DESESP, 0) AS DET_TOTPRO ';

  Result := Result + 'FROM ';
  Result := Result + '  MOVDET D ';

  Result := Result + '  LEFT JOIN MOVTRI T';
  Result := Result + '    ON T.DET_SEQGER = D.AUTOINCREM ';

  Result := Result + 'WHERE D.DET_DTAENT BETWEEN :DTAINI ';
  Result := Result + '  AND :DTAFIN ';
  Result := Result + '  AND D.DET_CODEMP = :CODEMP ';
  Result := Result + '  AND D.DET_CODITE = :ITEM ';
  Result := Result + '  AND D.DET_CLAFIS > 6000 ';

  Result := 'SELECT * FROM (' + Result + ' UNION ALL ' +
             AnsiReplaceText(AnsiReplaceText(Result, 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI') + ') AS TAB ';
end;

end.
