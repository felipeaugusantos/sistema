unit untBalancoEstoqueManutencao;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  untFuncoesGenerica,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}

Math, SysUtils, Uni;

type

  TGerenciaBalancoEstoqueManutencao = class
  private
    function fGetIdOperacao: String;
  protected
    qryTemporaria: {$IFDEF LINUX}IQuery; {$ELSE}TUniquery;{$ENDIF}
    FIDOperacao: string;
    procedure pAlimentaItens_BEACCS;
    procedure pAlimentaLotes_BEACCS; 
    procedure pAlimentaBase_ESTMAN; 
    procedure pAlimentaLotes_ESTMAN; 
    procedure pAlimentaItens_ESTMAN; 


    procedure pDeletaRegistros;
    function fSQLBaseEstMan: String;

  public
    strTabela_Lote_ESTMAN: String;
    strTabela_Itens_ESTMAN: String;
    strTabela_Lote_BEACCS: String;
    strTabela_Itens_BEACCS: String;
    strTabela_BASE_ESTMAN: String;

    class function pIniciaProcesso : TGerenciaBalancoEstoqueManutencao;
    class function fhabilitadoBEACCS: Boolean;
    class function fUtilizaRecurso: Boolean;
    class function fGetSaldoSeparadoConferido(ACodIte, ACodEmp: String): Double;
    destructor Destroy; override;
    property IDOperacao: String read fGetIdOperacao;

  End;
implementation

{ TGerenciaBalancoEstoqueManutencao }

class function TGerenciaBalancoEstoqueManutencao.pIniciaProcesso:TGerenciaBalancoEstoqueManutencao;
var Id: integer;
begin
  Id := Random(9);
  Result := TGerenciaBalancoEstoqueManutencao.Create;
  Result.FIDOperacao := FormatDateTime('DDMMYYYYNNSSZZZZ', Now) + Id.ToString;

  Result.strTabela_Lote_ESTMAN := '';
  Result.strTabela_Itens_ESTMAN := '';
  Result.strTabela_Lote_BEACCS := '';
  Result.strTabela_Itens_BEACCS := '';
  Result.strTabela_BASE_ESTMAN := '';

  If (fCfgSis('ESTMAN', varInteger) = 2) Then
    Result.strTabela_BASE_ESTMAN := 'ITENS_BASE_MANUTENCAO_ESTMAN';


  If (fCfgSis('ESTMAN', varInteger) = 2) Then
  begin
    Result.strTabela_Lote_ESTMAN := 'ITENS_LOT_MANUTENCAO_ESTMAN';
    Result.strTabela_Itens_ESTMAN := 'ITENS_MANUTENCAO_ESTMAN';
  End;

  If (fCfgSis('BEACCS', varInteger) = 2) Then
  begin
    Result.strTabela_Lote_BEACCS := 'ITENS_LOT_MANUTENCAO_BEACCS';
    Result.strTabela_Itens_BEACCS := 'ITENS_MANUTENCAO_BEACCS';
  End;

  Result.qryTemporaria := fCriaQuery;
  Try
    If (fCfgSis('ESTMAN', varInteger) = 2)  Then
      Result.pAlimentaBase_ESTMAN;

    If (fCfgSis('ESTMAN', varInteger) = 2) Then
    begin
      Result.pAlimentaLotes_ESTMAN;
      Result.pAlimentaItens_ESTMAN;
    End;

    If Result.fhabilitadoBEACCS Then
    begin
      Result.pAlimentaLotes_BEACCS;
      Result.pAlimentaItens_BEACCS;
    End;

  Finally
    {}
  End;
end;

destructor TGerenciaBalancoEstoqueManutencao.Destroy;
begin
  pDeletaRegistros;
  FreeAndNil(qryTemporaria);

  inherited;
end;

function TGerenciaBalancoEstoqueManutencao.fGetIdOperacao: String;
begin
  Result := FIDOperacao;
end;

class function TGerenciaBalancoEstoqueManutencao.fGetSaldoSeparadoConferido(ACodIte, ACodEmp: String): Double;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT FGO_CODEMP,');
    qryConsulta.SQL.Add('       FDO_CODITE,');
    qryConsulta.SQL.Add('       SUM( QTD_ITEM ) AS LOT_BEACCS');

    qryConsulta.SQL.Add('  FROM (SELECT FDO_NUMLOT, FGO_CODEMP, FDO_CODITE, IFNULL(FDO_QTDEXP, 0) AS QTD_ITEM');
    qryConsulta.SQL.Add('          FROM FATGOR A');
    qryConsulta.SQL.Add('          LEFT JOIN EXTGOR B ON A.AUTOINCREM = B.FGO_SEQFGO');
    qryConsulta.SQL.Add('         INNER JOIN FATDOR ON FDO_SEQGER = A.AUTOINCREM');
    qryConsulta.SQL.Add('         INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM');
    qryConsulta.SQL.Add('         WHERE TRUE');
    qryConsulta.SQL.Add('           AND A.FGO_ESPDOC = "PD"');
    qryConsulta.SQL.Add('           AND A.FGO_JAFATU = 0');
    qryConsulta.SQL.Add('           AND B.FGO_DOCEND IS NULL');
    qryConsulta.SQL.Add('           AND A.FGO_VLRCON > 0');
    qryConsulta.SQL.Add('           AND A.FGO_LIBERA > 0');
    qryConsulta.SQL.Add('           AND A.FGO_LIBCOM > 0');
    qryConsulta.SQL.Add('           AND FDO_QTDEXP > 0 ');
    qryConsulta.SQL.Add('           AND FDO_CODITE = "' + ACodIte + '" ');
    qryConsulta.SQL.Add('           AND FDO_QTDEXP > 0 ');
    qryConsulta.SQL.Add('           AND IFNULL(B.FGO_EMP_CD, A.FGO_CODEMP) = "' + ACodEmp + '"');
    qryConsulta.SQL.Add('           AND B.FGO_DTLBEX IS NOT NULL) AS T');

    qryConsulta.Open;

    Result :=  qryConsulta.FieldByName('LOT_BEACCS').AsFloat;
  Finally
    FreeAndnil(qryConsulta);
  End;
end;

class function TGerenciaBalancoEstoqueManutencao.fhabilitadoBEACCS: Boolean;
begin
  Result := (fCfgSis('BEACCS') = '2') and (fCfgSis('TIPEXP') = '4')
end;

class function TGerenciaBalancoEstoqueManutencao.fUtilizaRecurso: Boolean;
begin
  Result := (((fCfgSis('BEACCS') = '2') and (fCfgSis('TIPEXP') = '4')) Or (fCfgSis('ESTMAN') = '2'));

end;

procedure TGerenciaBalancoEstoqueManutencao.pAlimentaBase_ESTMAN;
begin
  qryTemporaria.SQl.Clear;
  qryTemporaria.SQL.Add('INSERT INTO '+ strTabela_BASE_ESTMAN+'(');
  qryTemporaria.SQL.Add('ID_OPERACAO,');
  qryTemporaria.SQL.Add('FDO_NUMLOT,');
  qryTemporaria.SQL.Add('FGO_EMPEXP,');
  qryTemporaria.SQL.Add('FASE,');
  qryTemporaria.SQL.Add('SITUACAO,');
  qryTemporaria.SQL.Add('COMPLEMENTO,');
  qryTemporaria.SQL.Add('FDO_CODITE,');
  qryTemporaria.SQL.Add('QTD_ITEM,');
  qryTemporaria.SQL.Add('FDOINC) ');
  qryTemporaria.SQL.Add(fSQLBaseEstMan);
  qryTemporaria.SQL.Add(';');
  qryTemporaria.ExecSQL;
end;

procedure TGerenciaBalancoEstoqueManutencao.pAlimentaItens_BEACCS;
begin
  qryTemporaria.SQL.Clear;
  qryTemporaria.SQL.Add('INSERT INTO '+strTabela_Itens_BEACCS + '(');
  qryTemporaria.SQL.Add('ID_OPERACAO,');
  qryTemporaria.SQL.Add('FGO_CODEMP,');
  qryTemporaria.SQL.Add('FDO_CODITE,');
  qryTemporaria.SQL.Add('ITE_BEACCS)');
  qryTemporaria.SQL.Add('SELECT "'+FIDOperacao+'", FGO_CODEMP,');
  qryTemporaria.SQL.Add('       FDO_CODITE,');
  qryTemporaria.SQL.Add('       SUM( LOT_BEACCS) AS ITE_BEACCS');
  qryTemporaria.SQL.Add(' FROM  ' + strTabela_Lote_BEACCS);
  qryTemporaria.SQL.Add(' WHERE ID_OPERACAO = "'+FIDOperacao+'"');
  qryTemporaria.SQL.Add('GROUP BY FGO_CODEMP, FDO_CODITE');
  qryTemporaria.SQL.Add('ORDER BY FGO_CODEMP, FDO_CODITE;');
  qryTemporaria.ExecSQL;
end;


procedure TGerenciaBalancoEstoqueManutencao.pAlimentaLotes_BEACCS;
begin
  qryTemporaria.SQL.Clear;

  qryTemporaria.SQL.Add('INSERT INTO ' + strTabela_Lote_BEACCS + '(');
  qryTemporaria.SQL.Add('       ID_OPERACAO,');
  qryTemporaria.SQL.Add('       FDO_NUMLOT,');
  qryTemporaria.SQL.Add('       FGO_CODEMP,');
  qryTemporaria.SQL.Add('       FDO_CODITE,');
  qryTemporaria.SQL.Add('       LOT_BEACCS)');


  qryTemporaria.SQL.Add('SELECT "'+FIDOperacao+'", FDO_NUMLOT,');
  qryTemporaria.SQL.Add('       FGO_CODEMP,');
  qryTemporaria.SQL.Add('       FDO_CODITE,');
  qryTemporaria.SQL.Add('       SUM( QTD_ITEM ) AS LOT_BEACCS');

  qryTemporaria.SQL.Add('  FROM (SELECT FDO_NUMLOT, FGO_CODEMP, FDO_CODITE, IFNULL(FDO_QTDEXP, 0) AS QTD_ITEM');
  qryTemporaria.SQL.Add('          FROM FATGOR A');
  qryTemporaria.SQL.Add('          LEFT JOIN EXTGOR B ON A.AUTOINCREM = B.FGO_SEQFGO');
  qryTemporaria.SQL.Add('         INNER JOIN FATDOR ON FDO_SEQGER = A.AUTOINCREM');
  qryTemporaria.SQL.Add('         INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM');



  qryTemporaria.SQL.Add('         WHERE TRUE');
  qryTemporaria.SQL.Add('           AND A.FGO_ESPDOC = "PD"');
  qryTemporaria.SQL.Add('           AND A.FGO_JAFATU = 0');
  qryTemporaria.SQL.Add('           AND B.FGO_DOCEND IS NULL');
  qryTemporaria.SQL.Add('           AND A.FGO_VLRCON > 0');
  qryTemporaria.SQL.Add('           AND A.FGO_LIBERA > 0');
  qryTemporaria.SQL.Add('           AND A.FGO_LIBCOM > 0');
  qryTemporaria.SQL.Add('           AND FDO_QTDEXP > 0 ');
  qryTemporaria.SQL.Add('           AND IFNULL(B.FGO_EMP_CD, A.FGO_CODEMP) = "' + VS_StrCodEmp + '"');
  If (fCfgSis('ESTMAN', varInteger) = 2) And fhabilitadoBEACCS Then
  begin
    qryTemporaria.SQL.Add('           AND (SELECT COUNT(1) FROM '+ strTabela_BASE_ESTMAN);
    qryTemporaria.SQL.Add('                 WHERE FDOINC = FATDOR.AUTOINCREM AND ID_OPERACAO = "' + FIDOperacao + '") = 0 ');
  End;
  qryTemporaria.SQL.Add('           AND B.FGO_DTLBEX IS NOT NULL) AS T');
  qryTemporaria.SQL.Add('GROUP BY FDO_NUMLOT, FGO_CODEMP, FDO_CODITE');
  qryTemporaria.SQL.Add('ORDER BY FGO_CODEMP, FDO_CODITE;');
  qryTemporaria.ExecSQL;
end;

procedure TGerenciaBalancoEstoqueManutencao.pAlimentaLotes_ESTMAN;
begin
  qryTemporaria.SQL.Clear;
  qryTemporaria.SQL.Add('INSERT INTO '+strTabela_Lote_ESTMAN+' (ID_OPERACAO,');
  qryTemporaria.SQL.Add('                                         FDO_NUMLOT,');
  qryTemporaria.SQL.Add('                                         FGO_EMPEXP,');
  qryTemporaria.SQL.Add('                                         FDO_CODITE,');
  qryTemporaria.SQL.Add('                                         LOT_SALMAN)');
  qryTemporaria.SQL.Add('SELECT ID_OPERACAO,');
  qryTemporaria.SQL.Add('       FDO_NUMLOT,');
  qryTemporaria.SQL.Add('       FGO_EMPEXP,');
  qryTemporaria.SQL.Add('       FDO_CODITE,');
  qryTemporaria.SQL.Add('       SUM( QTD_ITEM ) AS LOT_SALMAN');
  qryTemporaria.SQL.Add('  FROM ' + strTabela_BASE_ESTMAN + ' WHERE ID_OPERACAO = "'+FIDOperacao+'"');
  qryTemporaria.SQL.Add('GROUP BY FDO_NUMLOT, FGO_EMPEXP, FDO_CODITE');
  qryTemporaria.SQL.Add('ORDER BY FGO_EMPEXP, FDO_CODITE;');
  qryTemporaria.ExecSQL;
end;

procedure TGerenciaBalancoEstoqueManutencao.pDeletaRegistros;
begin
  qryTemporaria.SQL.Clear;
  If strTabela_Lote_ESTMAN <> '' Then
    qryTemporaria.SQL.Add('DELETE FROM ' + strTabela_Lote_ESTMAN + ' WHERE ID_OPERACAO = "'+FIDOperacao+'";');
  If strTabela_Itens_ESTMAN <> '' Then
    qryTemporaria.SQL.Add('DELETE FROM ' + strTabela_Itens_ESTMAN + ' WHERE ID_OPERACAO = "'+FIDOperacao+'";');
  If strTabela_Lote_BEACCS <> '' Then
    qryTemporaria.SQL.Add('DELETE FROM ' + strTabela_Lote_BEACCS + ' WHERE ID_OPERACAO = "'+FIDOperacao+'";');
  If strTabela_Itens_BEACCS <> '' Then
    qryTemporaria.SQL.Add('DELETE FROM ' + strTabela_Itens_BEACCS + ' WHERE ID_OPERACAO = "'+FIDOperacao+'";');
  If strTabela_BASE_ESTMAN <> '' Then
    qryTemporaria.SQL.Add('DELETE FROM ' + strTabela_BASE_ESTMAN + ' WHERE ID_OPERACAO = "'+FIDOperacao+'";');
  qryTemporaria.ExecSQL;
end;

procedure TGerenciaBalancoEstoqueManutencao.pAlimentaItens_ESTMAN;
begin
  qryTemporaria.SQL.Clear;
  qryTemporaria.SQL.Add('INSERT INTO '+strTabela_Itens_ESTMAN+' (ID_OPERACAO,');
  qryTemporaria.SQL.Add('                                                  FGO_EMPEXP,');
  qryTemporaria.SQL.Add('                                                  FDO_CODITE,');
  qryTemporaria.SQL.Add('                                                  ITE_SALMAN)');
  qryTemporaria.SQL.Add('SELECT "'+FIDOperacao+'", FGO_EMPEXP,');
  qryTemporaria.SQL.Add('       FDO_CODITE,');
  qryTemporaria.SQL.Add('       SUM( LOT_SALMAN ) AS ITE_SALMAN');
  qryTemporaria.SQL.Add(' FROM  ' + strTabela_Lote_ESTMAN + ' WHERE ID_OPERACAO = "' + FIDOperacao +'"');
  qryTemporaria.SQL.Add('GROUP BY FGO_EMPEXP, FDO_CODITE');
  qryTemporaria.SQL.Add('ORDER BY FGO_EMPEXP, FDO_CODITE;');
  qryTemporaria.ExecSQL;
end;


function TGerenciaBalancoEstoqueManutencao.fSQLBaseEstMan: String;
begin
  Result := '';

  Result := Result + 'SELECT "' + FIDOperacao + '", FDO_NUMLOT, ';
  Result := Result + '       E.FGO_EMPEXP, ';
  Result := Result + '       B.EQU_FLXFAS AS FASE, ';
  Result := Result + '       B.EQU_FLXSIT AS SITUACAO, ';
  Result := Result + '       B.EQU_FLXCOM AS COMPLEMENTO, ';
  Result := Result + '       D.FDO_CODITE, ';
  Result := Result + '       D.FDO_QTDITE - IFNULL( D.FDO_QTDBAI, 0 ) AS QTD_ITEM, ';
  Result := Result + '       D.AUTOINCREM AS FDOINC ';
  Result := Result + '  FROM FATGOR A ';
  Result := Result + '  LEFT JOIN FATDOR D ON A.AUTOINCREM = D.FDO_SEQGER ';
  Result := Result + '  LEFT JOIN EQUGER B ON A.FGO_NUMDOC = B.EQU_NUMPED ';
  Result := Result + '                    AND A.FGO_ESPDOC = "PD" ';
  Result := Result + '                    AND A.FGO_CODEMP = B.EQU_EMPPED ';
  Result := Result + '  LEFT JOIN EXTGOR E ON A.AUTOINCREM = E.FGO_SEQFGO ';
  Result := Result + ' WHERE TRUE ';
  Result := Result + '   AND A.FGO_ESPDOC = "PD" ';
  Result := Result + '   AND A.FGO_JAFATU = 0 ';
  Result := Result + '   AND D.FDO_JAFATU = 0 ';
  Result := Result + '   AND B.EQU_NUMOSE IS NOT NULL ';
  Result := Result + '   AND D.FDO_QTDITE - IFNULL( D.FDO_QTDBAI, 0 ) > 0 ';
  Result := Result + 'HAVING TRUE ';
  Result := Result + '   AND FASE IN ( "M", "R" ) ';
  Result := Result + '   AND SITUACAO IN ( "EM", "MF", "AR", "AF" ) ';
  Result := Result + '   AND COMPLEMENTO IN ( "AM", "AA", "AF", "ER" ) ';
  Result := Result + ' ORDER BY A.FGO_DTAENT, A.FGO_CODEMP, A.FGO_ESPDOC, A.FGO_NUMDOC ';

End;

end.
