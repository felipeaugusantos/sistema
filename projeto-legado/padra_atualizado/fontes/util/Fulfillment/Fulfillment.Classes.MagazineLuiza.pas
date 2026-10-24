unit Fulfillment.Classes.MagazineLuiza;

interface

uses
  Classes, System.SysUtils;

type
  Regras   = (resDevolucaoSimbolicaDeMercadoriaNaoRecebida);
  Operador = (opeEquals, opeContains);

  RegrasHelper = record helper for Regras
  private
    function Operacao : Operador;
  public
    function InfoTAG : String;
  end;

  MagazineLuiza = Class
  public
    class function GeraTL(ASigHub, AInfoTag : String) : Boolean;
  end;

implementation

{ RegrasHelper }

function RegrasHelper.InfoTAG: String;
begin

  Case Self Of
    resDevolucaoSimbolicaDeMercadoriaNaoRecebida : Result := 'DEVOLUCAO SIMBOLICA DE MERCADORIA NAO RECEBIDA';
    Else
      Result := EmptyStr;
  End;

end;

function RegrasHelper.Operacao: Operador;
begin

  Case Self Of
    resDevolucaoSimbolicaDeMercadoriaNaoRecebida : Result := opeEquals;
    Else
      Result := opeContains;
  End;

end;

{ MagazineLuiza }

class function MagazineLuiza.GeraTL(ASigHub, AInfoTag: String): Boolean;
  var
    LRegras : Regras;
begin

  Result := False;

  If Not ASigHub.Equals('MGL') Then
    Exit;

  for LRegras := Low(Regras) to High(Regras) do
  begin

    If LRegras.Operacao = opeEquals Then
      If LRegras.InfoTAG.Equals(AInfoTag) Then
        Exit(True);

    If LRegras.Operacao = opeContains Then
      If AInfoTag.Contains(LRegras.InfoTAG) Then
        Exit(True);

  end;

end;

end.

