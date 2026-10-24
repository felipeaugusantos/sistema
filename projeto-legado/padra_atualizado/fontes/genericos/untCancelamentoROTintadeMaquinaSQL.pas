unit untCancelamentoROTintadeMaquinaSQL;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls;

type
  TCancelamentoROTintadeMaquinaSQL = class (TComponent)
  private

  protected
    function fSQLDocumentoROExiste: String;
    function fSQLDocumentoRO: String;
    function fSQLDocumentoML_DET: String;
    function fSQLDocumentoML_GER(strEspDoc: String): String;
    function fSQLDeletaML_GER(strEspDoc: String): String;
    function fSQLDeletaML_DET(strEspDoc: String): String;
    function fSQLUpdateBAIXAD_DET(strEspDoc: String): String;
    function fSQLUpdateBAIXAD_FDO(strEspDoc: String): String;
    function fSQLDocumentoTINDET_BAIXAD(strEspDoc: String): String;
    function fSQLDocumentoFATDOR: String;
    function fSQLDocumentoRO_GER: String;
    function fSQLDocumentoRO_DET: String;

    function fSQLDeletaRO_GER: String;
    function fSQLDeletaRO_DET: String;

    function fSQLDocumentoTE: String;

    procedure pRetornaSelect(var qryGen: TUniQuery; const strSQL: String;
      const arrParametros: array of string; const arrValores: array of Variant);

    procedure pExecutaSQL(const strSQL: String;
      const arrParametros: array of string; const arrValores: array of Variant);
  public
    Constructor Create(Owner: TComponent); Reintroduce;

    Destructor Destroy; Reintroduce;
  end;

implementation

uses untFuncoesSimples;

{ TCancelamentoROTintadeMaquinaSQL }

constructor TCancelamentoROTintadeMaquinaSQL.Create(Owner: TComponent);
begin
  Inherited Create(Owner);
end;

destructor TCancelamentoROTintadeMaquinaSQL.Destroy;
begin

  inherited Destroy;
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDocumentoROExiste: String;
begin
  Result := '';
  Result := Result + '  SELECT TRUE ';
  Result := Result + '    FROM MOVGER ';
  Result := Result + '   WHERE GER_NUMDOC = :NUMDOC ';
  Result := Result + '     AND GER_ESPDOC = :ESPDOC ';
  Result := Result + '     AND GER_CODEMP = :CODEMP ';
  Result := Result + '     AND GER_CODCLI = :CODCLI ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDocumentoRO_DET: String;
begin
  Result := '';
  Result := Result + '  SELECT * ';
  Result := Result + '    FROM MOVDET ';
  Result := Result + '   WHERE DET_NUMDOC = :NUMDOC ';
  Result := Result + '     AND DET_ESPDOC = :ESPDOC ';
  Result := Result + '     AND DET_CODEMP = :CODEMP ';
  Result := Result + '     AND DET_CODCLI = :CODCLI ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDocumentoRO_GER: String;
begin
  Result := '';
  Result := Result + '  SELECT * ';
  Result := Result + '    FROM MOVGER ';
  Result := Result + '   WHERE GER_NUMDOC = :NUMDOC ';
  Result := Result + '     AND GER_ESPDOC = :ESPDOC ';
  Result := Result + '     AND GER_CODEMP = :CODEMP ';
  Result := Result + '     AND GER_CODCLI = :CODCLI ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDocumentoTE: String;
begin
  Result := '';
  Result := Result + ' SELECT GER_CODEMP, GER_NUMDOC, GER_ESPDOC, GER_CODCLI, ';
  Result := Result + '        DET_CODACA, DET_EMPACA, PCG_BAIXAD              ';
  Result := Result + '   FROM MOVGER G                                        ';
  Result := Result + '  INNER JOIN MOVDET ON DET_SEQGER = G.AUTOINCREM        ';
  Result := Result + '  INNER JOIN (SELECT                                    ';
  Result := Result + '                   PCG_CODFOR,                          ';
  Result := Result + '                   PCG_NUMPED,                          ';
  Result := Result + '                   PCG_CODEMP,                          ';
  Result := Result + '                   PCG_EMPDES,                          ';
  Result := Result + '                   PCG_DTALIB,                          ';
  Result := Result + '                   SUBSTRING(PCG_DOCORI,1,6) AS ORI_NUMDOC, ';
  Result := Result + '                   SUBSTRING(PCG_DOCORI,7,2) AS ORI_ESPDOC, ';
  Result := Result + '                   SUBSTRING(PCG_DOCORI,9,3) AS ORI_CODEMP, ';
  Result := Result + '   		             PCG_ESPDOC, ';
  Result := Result + '    		           PCG_NUMCTN, ';
  Result := Result + '    		           PCG_BAIXAD  ';
  Result := Result + '                 FROM          ';
  Result := Result + '                   PCMGER      ';
  Result := Result + '                 WHERE         ';
  Result := Result + '                   IFNULL(PCG_DOCORI, "") <> "") AS TMP ON ORI_NUMDOC = GER_NUMDOC AND ';
  Result := Result + '                                                           ORI_ESPDOC = GER_ESPDOC AND ';
  Result := Result + '                                                           ORI_CODEMP = GER_CODEMP     ';
  Result := Result + '    	WHERE ';
  Result := Result + '    		DET_CODCLI = :CODCLI AND ';
  Result := Result + '    		DET_ESPDOC = "TE"    AND ';
  Result := Result + '    		DET_CODACA = :CODACA AND ';
  Result := Result + '    		DET_EMPACA = :EMPACA     ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDocumentoTINDET_BAIXAD(
  strEspDoc: String): String;
begin
  Result := '';
  Result := Result + ' SELECT * ';
  Result := Result + '   FROM TINDET               ';
  Result := Result + '  WHERE DET_NUMDOC = :NUMDOC ';
  Result := Result + '    AND DET_ESPDOC = :ESPDOC ';
  Result := Result + '    AND DET_CODEMP = :CODEMP ';
  Result := Result + '    AND DET_CODACA = :CODACA ';
  Result := Result + '    AND DET_EMPACA = :EMPACA ';
  Result := Result + '    AND DET_BAIXAD <> ''N''  ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLUpdateBAIXAD_DET(
  strEspDoc: String): String;
begin
  Result := '';
  Result := Result + 'UPDATE TINDET               ';
  Result := Result + '   SET DET_OPEBAI = NULL,   ';
  Result := Result + '       DET_DTABAI = NULL,   ';
  Result := Result + '       DET_HORBAI = NULL,   ';
  Result := Result + '       DET_BAIXAD = "N"     ';
  Result := Result + ' WHERE DET_NUMDOC = :NUMDOC ';
  Result := Result + '   AND DET_ESPDOC = :ESPDOC ';
  Result := Result + '   AND DET_CODEMP = :CODEMP ';
  Result := Result + '   AND DET_CODACA = :CODACA ';
  Result := Result + '   AND DET_EMPACA = :EMPACA ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLUpdateBAIXAD_FDO(
  strEspDoc: String): String;
begin
  Result := '';
  Result := Result + 'UPDATE TINDOR ';
  Result := Result + '   SET FDO_OPEBAI = NULL,   ';
  Result := Result + '       FDO_DTABAI = NULL,   ';
  Result := Result + '       FDO_HORBAI = NULL,   ';
  Result := Result + '       FDO_BAIXAD = "N"     ';
  Result := Result + ' WHERE FDO_NUMDOC = :NUMDOC ';
  Result := Result + '   AND FDO_ESPDOC = :ESPDOC ';
  Result := Result + '   AND FDO_CODEMP = :CODEMP ';
  Result := Result + '   AND FDO_CODACA = :CODACA ';
  Result := Result + '   AND FDO_EMPACA = :EMPACA ';
end;

procedure TCancelamentoROTintadeMaquinaSQL.pExecutaSQL(const strSQL: String;
  const arrParametros: array of string; const arrValores: array of Variant);
var
  qryGen: TUniQuery;
  intParametros: Integer;
begin
  Try
    qryGen := fCriaQuery;

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.Params.Clear;
    qryGen.SQL.Text := strSQL;

    For intParametros := Low(arrParametros) To High(arrParametros) Do
    Begin
      qryGen.ParamByName(arrParametros[intParametros]).Value := arrValores[intParametros];
    End;

    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TCancelamentoROTintadeMaquinaSQL.pRetornaSelect(var qryGen: TUniQuery;
  const strSQL: String; const arrParametros: array of string;
  const arrValores: array of Variant);
var
  intParametros: Integer;
begin
  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.Params.Clear;
  qryGen.SQL.Text := strSQL;

  For intParametros := Low(arrParametros) To High(arrParametros) Do
  Begin
    qryGen.ParamByName(arrParametros[intParametros]).Value := arrValores[intParametros];
  End;

  qryGen.Open;
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDeletaML_DET(
  strEspDoc: String): String;
begin
  Result := '';
  Result := Result + 'DELETE FROM ';
  Result := Result + 'MOVDET      ';
  Result := Result + ' WHERE      ';
  Result := Result + '   DET_JAFATU = 1 AND ';
  Result := Result + '   DET_NUMDOC = :NUMDOC AND ';
  Result := Result + '   DET_ESPDOC = :ESPDOC AND ';
  Result := Result + '   DET_CODEMP = :CODEMP AND ';
  Result := Result + '   DET_CODACA = :CODACA AND ';
  Result := Result + '   DET_EMPACA = :EMPACA     ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDeletaML_GER(
  strEspDoc: String): String;
begin
  Result := '';
  Result := Result + 'DELETE FROM ';
  Result := Result + 'MOVGER ';
  Result := Result + ' WHERE ';
  Result := Result + '   GER_JAFATU = 1 AND       ';
  Result := Result + '   GER_NUMDOC = :NUMDOC AND ';
  Result := Result + '   GER_ESPDOC = :ESPDOC AND ';
  Result := Result + '   GER_CODEMP = :CODEMP     ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDeletaRO_DET: String;
begin
  Result := '';
  Result := Result + 'DELETE FROM ';
  Result := Result + 'MOVDET ';
  Result := Result + ' WHERE ';
  Result := Result + '   DET_NUMDOC = :NUMDOC AND ';
  Result := Result + '   DET_ESPDOC = :ESPDOC AND ';
  Result := Result + '   DET_CODEMP = :CODEMP AND ';
  Result := Result + '   DET_CODACA = :CODACA AND ';
  Result := Result + '   DET_EMPACA = :EMPACA     ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDeletaRO_GER: String;
begin
  Result := '';
  Result := Result + 'DELETE FROM ';
  Result := Result + 'MOVGER ';
  Result := Result + ' WHERE ';
  Result := Result + '   GER_NUMDOC = :NUMDOC AND ';
  Result := Result + '   GER_ESPDOC = :ESPDOC AND ';
  Result := Result + '   GER_CODEMP = :CODEMP AND ';
  Result := Result + '   GER_CODCLI = :CODCLI     ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDocumentoFATDOR: String;
begin
  Result := '';
  Result := Result + 'SELECT *  ';
  Result := Result + '  FROM FATDOR ';
  Result := Result + ' WHERE FDO_NUMDOC = :NUMDOC ';
  Result := Result + '   AND FDO_ESPDOC = :ESPDOC ';
  Result := Result + '   AND FDO_CODEMP = :CODEMP ';
  Result := Result + '   AND FDO_CODACA = :CODACA ';
  Result := Result + '   AND FDO_EMPACA = :EMPACA ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDocumentoML_DET: String;
begin
  Result := '';
  Result := Result + 'SELECT   ';
  Result := Result + '  *      ';
  Result := Result + 'FROM     ';
  Result := Result + '  MOVDET ';
  Result := Result + 'WHERE    ';
  Result := Result + '  DET_JAFATU = 1 AND ';
  Result := Result + '  DET_NUMFAT = :NUMFAT AND ';
  Result := Result + '  DET_TIPFAT = :TIPFAT AND ';
  Result := Result + '  DET_EMPFAT = :EMPFAT AND ';
  Result := Result + '  DET_CODACA = :CODACA AND ';
  Result := Result + '  DET_EMPACA = :EMPACA AND ';
  Result := Result + '  DET_ESPDOC IN ("ML") ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDocumentoML_GER(
  strEspDoc: String): String;
begin
  Result := '';
  Result := Result + 'SELECT * ';
  Result := Result + '  FROM   ';
  Result := Result + ' MOVGER  ';
  Result := Result + ' WHERE   ';
  Result := Result + '   GER_JAFATU = 1       AND ';
  Result := Result + '   GER_NUMDOC = :NUMDOC AND ';
  Result := Result + '   GER_ESPDOC = :ESPDOC AND ';
  Result := Result + '   GER_CODEMP = :CODEMP     ';
end;

function TCancelamentoROTintadeMaquinaSQL.fSQLDocumentoRO: String;
begin
  Result := '';
  Result := Result + '  SELECT  ';
  Result := Result + '         DET_NUMDOC,   ';
  Result := Result + '         DET_ESPDOC,   ';
  Result := Result + '         DET_CODEMP,   ';
  Result := Result + '         DET_CODCLI,   ';
  Result := Result + '         DET_NUMFAT,   ';
  Result := Result + '         DET_TIPFAT,   ';
  Result := Result + '         DET_EMPFAT,   ';
  Result := Result + '         DET_CODACA,   ';
  Result := Result + '         DET_EMPACA,   ';
  Result := Result + '         DET_QTDITE,   ';
  Result := Result + '         DET_CODITE    ';
  Result := Result + '    FROM MOVDET        ';
  Result := Result + '   WHERE DET_NUMDOC = :NUMDOC ';
  Result := Result + '     AND DET_ESPDOC = :ESPDOC ';
  Result := Result + '     AND DET_CODEMP = :CODEMP ';
  Result := Result + '     AND DET_CODCLI = :CODCLI ';
end;

end.
