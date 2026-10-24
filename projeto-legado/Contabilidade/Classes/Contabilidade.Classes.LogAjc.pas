unit Contabilidade.Classes.LogAjc;

interface

uses
  System.SysUtils, System.Generics.Collections, Uni,
  Contabilidade.Model.TDadosImportacaoContabil;

const
  CTamMaxIncDoc = 128;
  // Largura de LOG_VALANT / LOG_VALATU na LOGAJC. TUniQueryAuditoria.fNormalizarValor
  // recorta o snapshot por esta mesma constante: se os dois limites divergirem, uma
  // alteracao alem do menor deles ou e gravada com VALANT igual a VALATU, ou sequer
  // chega a ser detectada como diferenca.
  CTamMaxValor  = 512;

type
  TLogAjc = class
  private
    class function fLimitarTextoValor(const AValor: String): String; static;
    class function fNovoGuid36: String; static;
    class procedure pPrepararInsert(const AQuery: TUniQuery); static;

    class procedure pAtribuirParametrosInsert(
      const AQuery: TUniQuery;
      const ACodeEmp: String;
      const ACodOpe: String;
      const ADtaAlt: TDate;
      const AHraAlt: TTime;
      const ATabela: String;
      const AIncdoc: String;
      const ATipaju: String;
      const AColuna: String;
      const AValAnt: String;
      const AValAtu: String;
      const ANomFrm: String;
      const ASeqAju: String
    ); static;

  public
    class function fGerarSeqAju: String; static;

    class procedure pGravarLote(AItens: TObjectList<TLogAjcItem>; AConexao: TUniConnection = nil); static;

    class procedure pGravar(
      const ACodEmp: string;
      const ACodOpe: string;
      const ADtaAlt: TDate;
      const AHraAlt: TTime;
      const ATabela: String;
      const AIncdoc: String;
      const ATipaju: String;
      const AColuna: String;
      const AValAnt: String;
      const AValAtu: String;
      const ANomFrm: String;
      const ASeqAju: String;
      const AConexao: TUniConnection = nil
    ); static;
  end;

implementation

uses
  System.DateUtils,
  System.Classes,
  untFuncoesSimples,
  untTypesSistema,
  Contabilidade.Funcoes;

class function TLogAjc.fLimitarTextoValor(const AValor: String): String;
begin
  Result := Copy(AValor, 1, CTamMaxValor);
end;

class function TLogAjc.fNovoGuid36: String;
var
  Lguid: TGUID;
begin
  CreateGUID(Lguid);
  Result := Copy(GuidToString(Lguid), 2, 36);
end;

class function TLogAjc.fGerarSeqAju: String;
begin
  Result := fNovoGuid36;
end;

class procedure TLogAjc.pPrepararInsert(const AQuery: TUniQuery);
begin
  AQuery.SQL.Text := fGetSQLInsertLogAjc;
  AQuery.Prepare;
end;

class procedure TLogAjc.pAtribuirParametrosInsert(
  const AQuery: TUniQuery;
  const ACodeEmp: String;
  const ACodOpe: String;
  const ADtaAlt: TDate;
  const AHraAlt: TTime;
  const ATabela: String;
  const AIncdoc: String;
  const ATipaju: String;
  const AColuna: String;
  const AValAnt: String;
  const AValAtu: String;
  const ANomFrm: String;
  const ASeqAju: String
);
begin
  AQuery.ParamByName('CODEMP').AsString := Copy(ACodeEmp, 1, 3);
  AQuery.ParamByName('DTAALT').AsDate := ADtaAlt;
  AQuery.ParamByName('HRAALT').AsTime := AHraAlt;
  AQuery.ParamByName('CODOPE').AsString := Copy(ACodOpe, 1, 3);
  AQuery.ParamByName('TABELA').AsString := Copy(ATabela, 1, 10);
  AQuery.ParamByName('INCDOC').AsString := Copy(AIncdoc, 1, CTamMaxIncDoc);
  AQuery.ParamByName('TIPAJU').AsString := Copy(ATipaju, 1, 3);
  AQuery.ParamByName('COLUNA').AsString := Copy(AColuna, 1, 30);

  if AValAnt = '' then
    AQuery.ParamByName('VALANT').Clear
  else
    AQuery.ParamByName('VALANT').AsString := fLimitarTextoValor(AValAnt);

  if AValAtu = '' then
    AQuery.ParamByName('VALATU').Clear
  else
    AQuery.ParamByName('VALATU').AsString := fLimitarTextoValor(AValAtu);

  if ANomFrm = '' then
    AQuery.ParamByName('NOMFRM').Clear
  else
    AQuery.ParamByName('NOMFRM').AsString := Copy(ANomFrm, 1, 60);

  if ASeqAju = '' then
    AQuery.ParamByName('SEQAJU').Clear
  else
    AQuery.ParamByName('SEQAJU').AsString := Copy(ASeqAju, 1, 36);
end;

class procedure TLogAjc.pGravar(
  const ACodEmp: string;
  const ACodOpe: string;
  const ADtaAlt: TDate;
  const AHraAlt: TTime;
  const ATabela: String;
  const AIncdoc: String;
  const ATipaju: String;
  const AColuna: String;
  const AValAnt: String;
  const AValAtu: String;
  const ANomFrm: String;
  const ASeqAju: String;
  const AConexao: TUniConnection = nil
);
var
  Litem: TLogAjcItem;
  Llst: TObjectList<TLogAjcItem>;
begin
  Llst := TObjectList<TLogAjcItem>.Create();
  try
    Litem := TLogAjcItem.Create;
    Litem.CodEmp := ACodEmp;
    Litem.CodOpe := ACodOpe;
    Litem.DtaAlt := ADtaAlt;
    Litem.HraAlt := AHraAlt;
    Litem.Tabela := ATabela;
    Litem.Incdoc := AIncdoc;
    Litem.Tipaju := ATipaju;
    Litem.Coluna := AColuna;
    Litem.ValAnt := AValAnt;
    Litem.ValAtu := AValAtu;
    Litem.NomFrm := ANomFrm;
    Litem.SeqAju := ASeqAju;
    Llst.Add(LItem);
    pGravarLote(Llst, AConexao);
  finally
    FreeAndNil(Llst);
  end;
end;

class procedure TLogAjc.pGravarLote(AItens: TObjectList<TLogAjcItem>; AConexao: TUniConnection = nil);
var
  LqryLogAjc: TUniQuery;
  LintItem: Integer;
  LseqAju: String;
  LItem: TLogAjcItem;
begin
  if AItens.Count = 0 then
    Exit;

  LqryLogAjc := fCriaQuery(nil, AConexao);
  try
    pPrepararInsert(LqryLogAjc);

    LintItem := 0;
    for LItem in AItens do
    begin
      LseqAju := Trim(AItens[LintItem].SeqAju);
      if LseqAju = '' then
        LseqAju := fGerarSeqAju;

      pAtribuirParametrosInsert(
        LqryLogAjc,
        AItens[LintItem].CodEmp,
        AItens[LintItem].CodOpe,
        AItens[LintItem].DtaAlt,
        AItens[LintItem].HraAlt,
        AItens[LintItem].Tabela,
        AItens[LintItem].Incdoc,
        AItens[LintItem].Tipaju,
        AItens[LintItem].Coluna,
        AItens[LintItem].ValAnt,
        AItens[LintItem].ValAtu,
        AItens[LintItem].NomFrm,
        LseqAju
      );
      LqryLogAjc.ExecSQL;

      Inc(LintItem);
    end;
  finally
    FreeAndNil(LqryLogAjc);
  end;
end;

end.
