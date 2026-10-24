unit untProcessadorGravandoExecucaoNexaBasesDiluentes;

interface

uses
  untAbstractProcessadorGravandoExecucaoPpgBasesDiluentes, Uni, DB, Classes,
  Variants, SysUtils;

type
  TProcessadorGravandoExecucaoNexaBasesDiluentes = class(TAbstractProcessadorGravandoExecucaoPpgBasesDiluentes)
  public
    function GetDataSetOrigem: TDataSet; override;
    function GetSqlDestino: string; override;
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
  end;

implementation
uses untFuncoesSimples;
{ TProcessadorGravandoExecucaoNexaBasesDiluentes }

function TProcessadorGravandoExecucaoNexaBasesDiluentes.GetDataSetOrigem: TDataSet;
//var
//  qryGen: TUniQuery;
begin
  Result := nil;
  Try
    Try
      Result := fCriarQuery(' SELECT DISTINCT                                            ' +
                           '   NEX_TIPO__ AS BAS_TIPO__                                 ' +
                           '   , DIL_CODDIL AS BAS_CODBAS                               ' +
                           '   , DIL_PESESP AS BAS_PESESP                               ' +
                           ' FROM                                                       ' +
                           '   PPG_CADDIL D                                             ' +
                           '   , NEX_CADNEX T                                           ' +
                           ' WHERE T.NEX_TIPO__ LIKE CONCAT(''%'', D.DIL_LINHA_, ''%'') ');
{      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT                                            ' +
        '   NEX_TIPO__ AS BAS_TIPO__                                 ' +
        '   , DIL_CODDIL AS BAS_CODBAS                               ' +
        '   , DIL_PESESP AS BAS_PESESP                               ' +
        ' FROM                                                       ' +
        '   PPG_CADDIL D                                             ' +
        '   , NEX_CADNEX T                                           ' +
        ' WHERE T.NEX_TIPO__ LIKE CONCAT(''%'', D.DIL_LINHA_, ''%'') ';
      Result := qryGen;}
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
//    FreeAndNil(qryGen);
  End;
end;

function TProcessadorGravandoExecucaoNexaBasesDiluentes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM NEX_CADBAS';
end;

procedure TProcessadorGravandoExecucaoNexaBasesDiluentes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'NEX_CADBAS';
end;

procedure TProcessadorGravandoExecucaoNexaBasesDiluentes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('BAS_CODBAS').AsString := qryOrigem.FieldByName('BAS_CODBAS').AsString;
  qryDestino.FieldByName('BAS_DESBAS').AsString := 'DILUENTE ' + qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryDestino.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('NEX_CADBAS', VS_strCodEmp);
  qryDestino.FieldByName('BAS_PESESP').AsString := qryOrigem.FieldByName('BAS_PESESP').AsString;
  qryDestino.FieldByName('BAS_TIPO__').AsString := qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryDestino.Post;
end;

end.
