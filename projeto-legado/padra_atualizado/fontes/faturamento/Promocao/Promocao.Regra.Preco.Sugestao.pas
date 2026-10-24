unit Promocao.Regra.Preco.Sugestao;

interface

uses

{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  cxRadioGroup, untFuncoesSimples,
{$ENDIF}
  System.SysUtils;

type
  TRegraPrecoSugestao = (PrecoDePromocao = 1, PrecoDeTabela = 2);

  TRegraPrecoSugestaoHelper = record helper for TRegraPrecoSugestao
  strict private
    type
      TDado = record
        Descricao: string;
      end;
      TDados = array[PrecoDePromocao..PrecoDeTabela] of TDado;
    const
      Dados: TDados = ((Descricao: 'Preço de Promoção'),
                       (Descricao: 'Preço de Tabela'));
  public
    function Valor: integer;
    function Descricao: string;

    class function getByValor(const pIntValor: integer): TRegraPrecoSugestao; static;
  {$IFNDEF LINUX}
    class function getRegraPrecoSugestaoAtiva(const pStrCodPro, pStrCodEmp: string; strOriF11: string = 'N'; blnEhItemCarregadoJuntoPDouOR: Boolean=False): TRegraPrecoSugestao; static;
  {$ENDIF}
    class function getTrazerValoresSubconsulta: string; static;

    {$IFNDEF LINUX}
    class procedure MontarRegraRadioGroupItems(pObjRadioGroupItems: TcxRadioGroupItems); static;
    {$ENDIF}
  end;

implementation

uses
  Uni;

function TRegraPrecoSugestaoHelper.Valor: integer;
begin
  result := ord(Self);
end;

function TRegraPrecoSugestaoHelper.Descricao: string;
begin
  result := Dados[Self].Descricao;
end;

class function TRegraPrecoSugestaoHelper.getTrazerValoresSubconsulta: string;
var
  enuRegraPreco: TRegraPrecoSugestao;
begin
  Result := '';
  for enuRegraPreco := Low(TRegraPrecoSugestao) to High(TRegraPrecoSugestao) do
    Result := Result +
              '  WHEN ' + enuRegraPreco.Valor.ToString + ' THEN ' + QuotedStr(enuRegraPreco.Descricao) + ' ';
end;

class function TRegraPrecoSugestaoHelper.getByValor(const pIntValor: integer): TRegraPrecoSugestao;
begin
  result := TRegraPrecoSugestao(pIntValor);
end;

{$IFNDEF LINUX}
class function TRegraPrecoSugestaoHelper.getRegraPrecoSugestaoAtiva(const pStrCodPro, pStrCodEmp: string; strOriF11: string = 'N'; blnEhItemCarregadoJuntoPDouOR: Boolean=False): TRegraPrecoSugestao;
var
  strRegraPromocao: string;
  qryRegra: TUniQuery;
begin
  if fCfgSis('PROSUG', varBoolean) then
  begin
    if pStrCodPro.IsEmpty then
      Exit(TRegraPrecoSugestao(0));

    if pStrCodEmp.IsEmpty then
      Exit(TRegraPrecoSugestao(0));

    qryRegra := fCriaQuery;
    Try
      qryRegra.SQL.Text := 'SELECT CADPRO.PRO_PROPRE FROM CADPRO '
                         + ' INNER JOIN PROEMP ON PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM '
                         + ' WHERE CADPRO.PRO_CODPRO = :CODPRO '
                         + '   AND PROEMP.PRO_CODEMP = :CODEMP ';

      qryRegra.ParamByName('CODPRO').AsString := pStrCodPro;
      qryRegra.ParamByName('CODEMP').AsString := pStrCodEmp;
      qryRegra.Open;

      strRegraPromocao := qryRegra.FieldByName('PRO_PROPRE').AsString;
    Finally
      FreeAndNil(qryRegra);
    End;

    result := TRegraPrecoSugestao.getByValor(StrToIntDef(strRegraPromocao, -1));
  end
  else
  begin
    if (strOriF11 = 'S') And (Not blnEhItemCarregadoJuntoPDouOR) then
    begin
      result := TRegraPrecoSugestao.getByValor(fCfgSis('PRMF11'));
    end
    else
    begin
      result := TRegraPrecoSugestao.getByValor(fCfgSis('PROPRE'));
    end;
  end;
end;
{$ENDIF}

{$IFNDEF LINUX}
class procedure TRegraPrecoSugestaoHelper.MontarRegraRadioGroupItems(
  pObjRadioGroupItems: TcxRadioGroupItems);
var
  enuRegraPreco: TRegraPrecoSugestao;
  objRadioGroupItem: TcxRadioGroupItem;
begin
  pObjRadioGroupItems.Clear;
  for enuRegraPreco := Low(TRegraPrecoSugestao) to High(TRegraPrecoSugestao) do
  begin
    objRadioGroupItem := pObjRadioGroupItems.Add;
    objRadioGroupItem.Value := enuRegraPreco.Valor.ToString;
    objRadioGroupItem.Caption := enuRegraPreco.Descricao;
  end;
end;
{$ENDIF}

end.
