unit Contabilidade.Classes.AuditoriaFireDac;

interface

uses FireDAC.Phys.MySQLCli ;

type
  TAuditoriaFireDac = class
  private
    class var FOriginalRealQuery: TPrcmysql_real_query;
  public
    class procedure pRegistraVendor(Sender: TObject) ;
  end ;

implementation

uses
  FireDAC.Phys.MySQLWrapper, strUtils, Contabilidade.Funcoes, FireDAC.Phys.MySQL ;

function fContabilidadeRealQueryIntercept(mysql: PMYSQL; const q: my_pchar; length: my_ulong): Integer; stdcall ;
var
  LstrString: string ;
  LstrSql: string ;
  LstrTabela: string ;
begin
  // chama a função original de execução
  Result := TAuditoriaFireDac.FOriginalRealQuery(mysql, q, length);
  // registra o log caso das tabelas permitidas.
  LstrString := String(q) ;
  LstrTabela := fRetornaNomeTabela(LstrString);
  // não precisa logar a importação de movimento
  if fEhTabelaDeContabilidade(LstrTabela) and (LstrTabela <> 'LANCON') then
  begin
    LstrSql := fTiraEnter(LstrString);
    pGravaLogContabil(LstrSQL, LstrTabela);
  end ;
end;

{ TAuditoriaFireDac }

class procedure TAuditoriaFireDac.pRegistraVendor(Sender: TObject);
var
  LCliLib: TMySQLLib;
begin
  LCliLib := TMySQLLib(TFDPhysMySQLDriverLink(Sender).DriverIntf.CliObj);

  TAuditoriaFireDac.FOriginalRealQuery := LCliLib.mysql_real_query;
  LCliLib.mysql_real_query := fContabilidadeRealQueryIntercept;
end;

end.
