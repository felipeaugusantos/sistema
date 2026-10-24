unit untGarantiaColetalibtypes;

interface

uses
  Uni;

type
  TDuplicadasCreditoCancelarRecord = record
    strNumDup: String;
    strEspDoc: String;
  end;
  TDuplicadasCreditoCancelar = array of TDuplicadasCreditoCancelarRecord;

type
  TProcAnonimoQuery = reference to procedure(var Qry: TUniQuery);

type
 {$SCOPEDENUMS ON}
  TTipoGarantia = (Nenhum, AguardarRetornoFornecedor, CreditoCliente, ReposicaoProduto);
 {$SCOPEDENUMS OFF}
  TSetTipoGarantia = Set of TTipoGarantia;

 {$SCOPEDENUMS ON}
  TValidacaoRetorno = (Valido, RetornoParcial, NaoInformado);
 {$SCOPEDENUMS OFF}
  TSetValidacaoRetorno = Set of TValidacaoRetorno;

Const
  //TVALIDOS = [TTipoGArantia.Nenhum..TTipoGarantia.ReposicaoProduto]
  TEMITEMSELECIONADO = [TValidacaoRetorno.Valido, TValidacaoRetorno.RetornoParcial];
  NAOPERMITIRGARANTIA = [TValidacaoRetorno.RetornoParcial, TValidacaoRetorno.NaoInformado];

Type
 TOpcoesGArantiaHelper = record helper for TTipoGarantia
    function GetEnumName: String;
    function GetIndexAsString: String;
    function GetFromString(s: String): TTipoGarantia;
    procedure SetValueAsString(strValue: String);
 end;


implementation

uses
  System.SysUtils,
  System.StrUtils;

{ TOpcoesGArantiaHelper }

function TOpcoesGarantiaHelper.GetEnumName: String;
begin
  case self of
    TTipoGarantia.AguardarRetornoFornecedor : Result := 'Ret. Fornec';
    TTipoGarantia.CreditoCliente : Result := 'Crédito';
    TTipoGarantia.ReposicaoProduto: Result := 'Reposição';
    else
      Result := '';
  end;
end;

function TOpcoesGArantiaHelper.GetFromString(s: String): TTipoGarantia;
begin
  Case IndexStr(s,['0','1','2','3']) of
    0..3: Result := TTipoGarantia(Ord(StrToInt(s)));
    else
      Result := TTipoGarantia.Nenhum;
  End;
end;

function TOpcoesGArantiaHelper.GetIndexAsString: String;
begin
  case self of
    TTipoGarantia.nenhum..TTipoGarantia.ReposicaoProduto: Result := IntToStr(Ord(Self));
    else
      Result := '0';
  end;

end;

procedure TOpcoesGArantiaHelper.SetValueAsString(strValue: String);
begin
  Self := Self.GetFromString(strValue);
end;

end.
