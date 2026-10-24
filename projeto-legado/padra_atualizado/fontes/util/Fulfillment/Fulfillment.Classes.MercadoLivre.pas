unit Fulfillment.Classes.MercadoLivre;

interface

uses
  Classes, System.SysUtils;

type
  Regras   = (resRemoved, resDevolutionPlaces, resInboundReturn, resInboundNegativeDifference);
  Operador = (opeEquals, opeContains);

  RegrasHelper = record helper for Regras
  private
    function Operacao : Operador;
  public
    function InfoTAG : String;
  end;

  MercadoLivre = Class
  public
    class function GeraTL(ASigHub, AInfoTag : String) : Boolean;
    class function IsRemoved(ASigHub, AInfoTag : String) : Boolean;
    class function IsDevolutionPlaces(ASigHub, AInfoTag : String) : Boolean;
    class function IsInboundNegative(ASigHub, AInfoTag : String) : Boolean;
  end;

implementation

{ RegrasHelper }

function RegrasHelper.InfoTAG: String;
begin

  Case Self Of
    resRemoved                   : Result := 'REMOVED';
    resDevolutionPlaces          : Result := 'DEVOLUTION_PLACES';
    resInboundReturn             : Result := 'INBOUND_RETURN';
    resInboundNegativeDifference : Result := 'INBOUND_NEGATIVE_DIFFERENCE';
    Else
      Result := EmptyStr;
  End;

end;

function RegrasHelper.Operacao: Operador;
begin

  Case Self Of
    resInboundReturn,
    resInboundNegativeDifference : Result := opeContains;
    Else
      Result := opeEquals;
  End;

end;

{ MercadoLivre }

class function MercadoLivre.GeraTL(ASigHub, AInfoTag: String): Boolean;
  var
    LRegras : Regras;
begin

  Result := False;

  If Not ASigHub.Equals('MLB') Then
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

class function MercadoLivre.IsDevolutionPlaces(ASigHub, AInfoTag: String): Boolean;
begin

  Result := False;

  If Not ASigHub.Equals('MLB') Then
    Exit;

  If resDevolutionPlaces.Operacao = opeEquals Then
    If resDevolutionPlaces.InfoTAG.Equals(AInfoTag) Then
      Exit(True);

  If resDevolutionPlaces.Operacao = opeContains Then
    If AInfoTag.Contains(resDevolutionPlaces.InfoTAG) Then
      Exit(True);

end;

class function MercadoLivre.IsInboundNegative(ASigHub, AInfoTag: String): Boolean;
begin

  Result := False;

  If Not ASigHub.Equals('MLB') Then
    Exit;

  If resInboundNegativeDifference.Operacao = opeEquals Then
    If resInboundNegativeDifference.InfoTAG.Equals(AInfoTag) Then
      Exit(True);

  If resInboundNegativeDifference.Operacao = opeContains Then
    If AInfoTag.Contains(resInboundNegativeDifference.InfoTAG) Then
      Exit(True);

end;

class function MercadoLivre.IsRemoved(ASigHub, AInfoTag: String): Boolean;
begin

  Result := False;

  If Not ASigHub.Equals('MLB') Then
    Exit;

  If resRemoved.Operacao = opeEquals Then
    If resRemoved.InfoTAG.Equals(AInfoTag) Then
      Exit(True);

  If resRemoved.Operacao = opeContains Then
    If AInfoTag.Contains(resRemoved.InfoTAG) Then
      Exit(True);

  Result := True;

end;

end.
