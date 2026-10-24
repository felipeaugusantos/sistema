unit untSQLRepositorio;

interface

uses Uni;

Type
  TRepositorio = (repServicos, repFaturamento);

procedure pSQL(qry: TUniQuery; repRepositorio: TRepositorio; strNomeSQL: String; arrParams: Array Of Const; strNomeTabela: String = '');

implementation

uses untSQLServicos, untSQLFaturamento;

procedure pSQL(qry: TUniQuery; repRepositorio: TRepositorio; strNomeSQL: String; arrParams: Array Of Const; strNomeTabela: String = '');
begin
  qry.SQL.Clear;

  Case repRepositorio Of
    repServicos: pSQLServico(qry, strNomeSQL, arrParams, strNomeTabela);
    repFaturamento: pSQLFaturamento(qry, strNomeSQL, arrParams, strNomeTabela);
  End;
end;

end.
