unit Contabilidade.Funcoes.ImpostoRenda;

interface

uses
  Contabilidade.Interfaces ;

function fRetornaFormaTributacao(const AstrCodEmp, AstrExercicio: string):TFormaTributacao ;
function fValidaParametrizacaoEmpresaLucroPresumido(const AstrCodEmp,
                                                          AstrExercicio: string;
                                                    var AstrMensagem: String): Boolean ;

implementation

uses
  untFuncoesSimples, Variants ;

function fRetornaFormaTributacao(const AstrCodEmp, AstrExercicio: string):TFormaTributacao ;
var
  LstrRetorno: string ;
begin
  Result := ftNada ;
  LstrRetorno := vartostr(fCampoTabela('TRI_FORMTR', 'EPREGT', ['TRI_CODEMP', 'TRI_ANOEXE'], [AstrCodEmp, AstrExercicio])) ;
  if LstrRetorno = '1' then
  begin
    Result := ftLucroPresumido ;
  end
  else if LstrRetorno = '2' then
  begin
    Result := ftLucroRealTrimestral ;
  end
  else if LstrRetorno = '3' then
  begin
    Result := ftLucroRealEstimativaMensal ;
  end;
end;

function fValidaParametrizacaoEmpresaLucroPresumido(const AstrCodEmp,
                                                          AstrExercicio: string;
                                                    var AstrMensagem: String): Boolean ;
var
  LformaTributacao: TFormaTributacao ;
begin
  Result := False ;
  LformaTributacao := fRetornaFormaTributacao(AstrCodEmp, AstrExercicio) ;
  if LformaTributacao = ftNada then
  begin
    AstrMensagem := 'Exercício Não Cadastrado. ' + #13 +
                    'Deverá ser efetuado o Cadastro na Aba "Contabilidade" presente no "Cadastro de Empresas"!' ;
    exit ;
  end ;

  if LformaTributacao <> ftLucroPresumido then
  begin
    AstrMensagem := 'A Forma de Tributação para esse Exercício, não corresponde a Forma de Tributação = Lucro Presumido.'+#13+#10+
                    'Verificar essa condição na Aba "Contabilidade" presente no "Cadastro de Empresas"' ;
    Exit ;
  end ;
  Result := True ;
end ;


end.
