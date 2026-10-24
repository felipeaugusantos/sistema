unit Reforma.Aliquotas.Fonte;

// A fonte fica atras de interface para trocar a aliquota global de IMPTRI pela
// procedure por item (pRefTrib_CalculaAliquotasEfetivasItens) sem mexer no calculo.

interface

uses
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Host;

type
  IFonteAliquotas = interface
    ['{9BFDBC54-9582-44D2-A4F8-FB109BF41223}']
    function Obter: TAliquotasReforma;
  end;

  // Mesma fonte da calculadora: primeira linha de IMPTRI, aliquota global.
  TFonteAliquotasImptri = class(TInterfacedObject, IFonteAliquotas)
  strict private
    FHost: IReformaHost;
    FTabelaPreparada: Boolean;
    function LerCampo(const Consulta: IReformaConsulta; const Nome: string): Double;
    procedure PrepararTabela;
  public
    constructor Create(const Host: IReformaHost);
    function Obter: TAliquotasReforma;
  end;

implementation

uses
  System.SysUtils,
  System.Variants,
  Reforma.Repositorio.Estrutura;

const
  TABELA_ALIQUOTAS = 'IMPTRI';

constructor TFonteAliquotasImptri.Create(const Host: IReformaHost);
begin
  inherited Create;
  FHost := Host;
end;

function TFonteAliquotasImptri.LerCampo(const Consulta: IReformaConsulta; const Nome: string): Double;
var
  Valor: Variant;
begin
  Valor := Consulta.ValorCampo(Nome);
  if VarIsNull(Valor) or VarIsEmpty(Valor) then
    Result := 0
  else
    Result := VarAsType(Valor, varDouble);
end;

// Banco sem IMPTRI (ou sem a linha de referencia): a estrutura central cria a tabela e grava a aliquota de referencia,
// uma vez por tela, pela porta de gravacao do host (LOGREP). So fora da gravacao do produto: no MySQL o DDL confirma a
// transacao aberta; com o cadastro gravando o ajuste fica adiado para a proxima leitura. Sem permissao de CREATE nao
// repete a cada leitura e as aliquotas ficam zeradas.
procedure TFonteAliquotasImptri.PrepararTabela;
var
  Estrutura: TEstruturaBanco;
  Mensagem: string;
begin
  if FTabelaPreparada or not Assigned(FHost.Gravacao) then
    Exit;

  Estrutura := TEstruturaBanco.Create(fBancoDoHost(FHost));
  try
    Estrutura.PrepararTabelas([TABELA_ALIQUOTAS], Mensagem);
    FTabelaPreparada := not Estrutura.Adiado;
  finally
    Estrutura.Free;
  end;
end;

function TFonteAliquotasImptri.Obter: TAliquotasReforma;
var
  Consulta: IReformaConsulta;
begin
  FillChar(Result, SizeOf(Result), 0);

  // Tabela ausente ou vazia zera as aliquotas e a tela segue (RN07). Qualquer falha
  // do banco aqui nao pode derrubar o cadastro de produtos, entao nao ha filtro de classe.
  try
    PrepararTabela;

    Consulta := FHost.AbrirConsulta('SELECT * FROM ' + TABELA_ALIQUOTAS + ' LIMIT 1');
    Consulta.Abrir;
    if Consulta.Vazia then
      Exit;

    Result.Cbs := LerCampo(Consulta, 'CBS');
    Result.Ibs := LerCampo(Consulta, 'IBS');
    Result.ImpostoSeletivo := LerCampo(Consulta, 'IS');
  except
    FillChar(Result, SizeOf(Result), 0);
  end;
end;

end.