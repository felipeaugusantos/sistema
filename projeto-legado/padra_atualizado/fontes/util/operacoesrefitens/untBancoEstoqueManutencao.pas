unit untBancoEstoqueManutencao;

interface

uses Math, SysUtils, untFuncoesSimples, Uni;

type

  TGerenciaBancoEstoqueManutencao = class
  protected
    qryTemporaria: TUniquery;
    procedure pCriaTemporariaItens;
    procedure pCriaTemporariaLotes;
    procedure DestroiTemporaria;
  public
    strTabelaTemporaria_Lote: String;
    strTabelaTemporaria_Itens: String;
    class function CriaTemporaria : TGerenciaBancoEstoqueManutencao;
    destructor Destroy; override;

  End;
implementation

{ TGerenciaBancoEstoqueManutencao }

class function TGerenciaBancoEstoqueManutencao.CriaTemporaria:TGerenciaBancoEstoqueManutencao;
var ID: Integer;

begin
  Result := TGerenciaBancoEstoqueManutencao.Create;
  Result.DestroiTemporaria;
  Id := Random(9999);
  Result.strTabelaTemporaria_Lote := 'TMP_ITENS_LOT_MANUTENCAO_' + IntToStr(ID);
  Result.strTabelaTemporaria_Itens := 'TMP_ITENS_MANUTENCAO_' + IntToStr(ID);
  Result.qryTemporaria := fCriaQuery;
  Try
    Result.pCriaTemporariaLotes;
    Result.pCriaTemporariaItens;
  Finally
    FreeAndNil(Result.qryTemporaria);
  End;
end;

procedure TGerenciaBancoEstoqueManutencao.DestroiTemporaria;
begin
  If Not fEmptyStr(strTabelaTemporaria_Lote) Then
    fDropTable(strTabelaTemporaria_Lote);
  strTabelaTemporaria_Lote := '';

  If Not fEmptyStr(strTabelaTemporaria_Itens) Then
    fDropTable(strTabelaTemporaria_Itens);
  strTabelaTemporaria_Itens := '';
end;

destructor TGerenciaBancoEstoqueManutencao.Destroy;
begin
  DestroiTemporaria;

  inherited;
end;

procedure TGerenciaBancoEstoqueManutencao.pCriaTemporariaItens;
begin
  qryTemporaria.SQL.Clear;
  qryTemporaria.SQL.Add('CREATE TEMPORARY TABLE '+strTabelaTemporaria_Itens);
  qryTemporaria.SQL.Add('SELECT FGO_EMPEXP,');
  qryTemporaria.SQL.Add('       FDO_CODITE,');
  qryTemporaria.SQL.Add('       SUM( LOT_SALMAN ) AS ITE_SALMAN');
  qryTemporaria.SQL.Add(' FROM  ' + strTabelaTemporaria_Lote );
  qryTemporaria.SQL.Add('GROUP BY FGO_EMPEXP, FDO_CODITE');
  qryTemporaria.SQL.Add('ORDER BY FGO_EMPEXP, FDO_CODITE;');
  qryTemporaria.SQL.Add('');
  qryTemporaria.SQL.Add('ALTER TABLE '+strTabelaTemporaria_Itens+' ADD INDEX `IDX_ITENS_MANUT` (`FGO_EMPEXP`, `FDO_CODITE` );');
  qryTemporaria.ExecSQL;
end;

procedure TGerenciaBancoEstoqueManutencao.pCriaTemporariaLotes;
begin
  qryTemporaria.SQL.Clear;
  qryTemporaria.SQL.Add('CREATE TEMPORARY TABLE '+ strTabelaTemporaria_Lote);
  qryTemporaria.SQL.Add('SELECT FDO_NUMLOT,');
  qryTemporaria.SQL.Add('       FGO_EMPEXP,');
  qryTemporaria.SQL.Add('       FDO_CODITE,');
  qryTemporaria.SQL.Add('       SUM( QTD_ITEM ) AS LOT_SALMAN');
  qryTemporaria.SQL.Add('  FROM (SELECT  FDO_NUMLOT,');
  qryTemporaria.SQL.Add('                E.FGO_EMPEXP,');
  qryTemporaria.SQL.Add('                B.EQU_FLXFAS AS FASE,');
  qryTemporaria.SQL.Add('                B.EQU_FLXSIT AS SITUACAO,');
  qryTemporaria.SQL.Add('                B.EQU_FLXCOM AS COMPLEMENTO,');
  qryTemporaria.SQL.Add('                D.FDO_CODITE,');
  qryTemporaria.SQL.Add('                D.FDO_QTDITE - IFNULL( D.FDO_QTDBAI, 0 ) AS QTD_ITEM');
  qryTemporaria.SQL.Add('           FROM FATGOR A');
  qryTemporaria.SQL.Add('           LEFT JOIN FATDOR D ON A.AUTOINCREM = D.FDO_SEQGER');
  qryTemporaria.SQL.Add('           LEFT JOIN EQUGER B ON A.FGO_NUMDOC = B.EQU_NUMPED');
  qryTemporaria.SQL.Add('                             AND A.FGO_ESPDOC = "PD"');
  qryTemporaria.SQL.Add('                             AND A.FGO_CODEMP = B.EQU_EMPPED');
  qryTemporaria.SQL.Add('           LEFT JOIN EXTGOR E ON A.AUTOINCREM = E.FGO_SEQFGO');
  qryTemporaria.SQL.Add('          WHERE TRUE');
  qryTemporaria.SQL.Add('            AND A.FGO_ESPDOC = "PD"');
  qryTemporaria.SQL.Add('            AND A.FGO_JAFATU = 0');
  qryTemporaria.SQL.Add('            AND D.FDO_JAFATU = 0');
  qryTemporaria.SQL.Add('            AND B.EQU_NUMOSE IS NOT NULL');
  qryTemporaria.SQL.Add('         HAVING TRUE');
  qryTemporaria.SQL.Add('            AND FASE        IN ( "M", "R" )');
  qryTemporaria.SQL.Add('            AND SITUACAO    IN ( "EM", "MF", "AR", "AF" )');
  qryTemporaria.SQL.Add('            AND COMPLEMENTO IN ( "AM", "AA", "AF", "ER" )');
  qryTemporaria.SQL.Add('          ORDER BY A.FGO_DTAENT, A.FGO_CODEMP, A.FGO_ESPDOC, A.FGO_NUMDOC) AS T');
  qryTemporaria.SQL.Add('GROUP BY FDO_NUMLOT, FGO_EMPEXP, FDO_CODITE');
  qryTemporaria.SQL.Add('ORDER BY FGO_EMPEXP, FDO_CODITE;');
  qryTemporaria.SQL.Add('');
  qryTemporaria.SQL.Add('ALTER TABLE '+ strTabelaTemporaria_Lote + ' ADD INDEX `IDX_ITENS_MANUT_LOT` ( `FDO_NUMLOT`, `FGO_EMPEXP`, `FDO_CODITE` );');
  qryTemporaria.ExecSQL;
end;

end.
