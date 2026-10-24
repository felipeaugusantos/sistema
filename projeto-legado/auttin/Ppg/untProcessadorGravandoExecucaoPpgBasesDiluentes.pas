unit untProcessadorGravandoExecucaoPpgBasesDiluentes;

interface

uses
  untAbstractProcessadorGravandoExecucaoPpgBasesDiluentes, Uni, DB, Classes,
  Variants, SysUtils;

type
  TProcessadorGravandoExecucaoPpgBasesDiluentes = class(TAbstractProcessadorGravandoExecucaoPpgBasesDiluentes)
  public
    function GetDataSetOrigem: TDataSet; override;
    function GetSqlDestino: string; override;
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
  end;

implementation
uses untFuncoesSimples;
{ TProcessadorGravandoExecucaoNexaBasesDiluentes }

function TProcessadorGravandoExecucaoPpgBasesDiluentes.GetDataSetOrigem: TDataSet;
//var
//  qryGen: TUniQuery;
begin
  Result := nil;
  Try
    Try
      Result := fCriarQuery(' SELECT DISTINCT                                            ' +
                            '   PPG_TIPO__ AS BAS_TIPO__                                 ' +
                            '   , DIL_CODDIL AS BAS_CODBAS                               ' +
                            '   , DIL_PESESP AS BAS_PESESP                               ' +
                            ' FROM                                                       ' +
                            '   PPG_CADDIL D                                             ' +
                            '   , PPG_CADPPG T                                           ' +
                            ' WHERE T.PPG_TIPO__ LIKE CONCAT(''%'', D.DIL_LINHA_, ''%'') ');
{      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT                                            ' +
        '   PPG_TIPO__ AS BAS_TIPO__                                 ' +
        '   , DIL_CODDIL AS BAS_CODBAS                               ' +
        '   , DIL_PESESP AS BAS_PESESP                               ' +
        ' FROM                                                       ' +
        '   PPG_CADDIL D                                             ' +
        '   , PPG_CADPPG T                                           ' +
        ' WHERE T.PPG_TIPO__ LIKE CONCAT(''%'', D.DIL_LINHA_, ''%'') ';
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

function TProcessadorGravandoExecucaoPpgBasesDiluentes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM PPG_CADBAS';
end;

procedure TProcessadorGravandoExecucaoPpgBasesDiluentes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'PPG_CADBAS';
end;

procedure TProcessadorGravandoExecucaoPpgBasesDiluentes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('BAS_CODBAS').AsString := qryOrigem.FieldByName('BAS_CODBAS').AsString;
  qryDestino.FieldByName('BAS_DESBAS').AsString := 'DILUENTE ' + qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryDestino.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PPG_CADBAS', VS_strCodEmp);
  qryDestino.FieldByName('BAS_PESESP').AsString := qryOrigem.FieldByName('BAS_PESESP').AsString;
  qryDestino.FieldByName('BAS_TIPO__').AsString := qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryDestino.Post;
end;

end.
