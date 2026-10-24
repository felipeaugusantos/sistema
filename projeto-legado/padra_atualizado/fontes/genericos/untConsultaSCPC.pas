unit untConsultaSCPC;

interface

uses Classes;

Type
  TConsultaSCPC = class(TComponent)
    protected
      function fGetMsgErro: String; virtual; abstract;
      function fGetRelatorio: String; virtual; abstract;
      function fGetQtdProtestos: Integer; virtual; abstract;
      function fGetQtdCheques: Integer; virtual; abstract;
    public
      class function fGetInstance(objOwner: TComponent): TConsultaSCPC;
      function fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean; Overload; virtual; abstract;
      function fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean; strConsulta: String; strTipoConsulta: String): Boolean; Overload; virtual; abstract;
      procedure pSaveToFile(Const strFileName: String); virtual; abstract;
      property strMsqErro: String read fGetMsgErro;
      property strRelatorio: String read fGetRelatorio;
      property intQtdProtestos: Integer read fGetQtdProtestos;
      property intQtdCheques: Integer read fGetQtdCheques;
  end;

implementation

{ TConsultaSCPC }

uses untConsultaSCPCPhdRisk, untConsultaSCPCBoaVista, untConsultaSCPCBoaVistaES,
     untFuncoesSimples, untConsultaSCPCBoaVistaAcerta, untConsultaSCPCBoaVistaEmpresarial,
     untConsultaSCPCBoaVistaEmpresarialPlatinum,untConsultaSCPCBoaVistaEssencial,unTConsultaSCPC_CDLPOA_RS;

class function TConsultaSCPC.fGetInstance(objOwner: TComponent): TConsultaSCPC;
begin
  If fCfgSis('CNSCPC') = 'P' Then
    Result := TConsultaSCPCPhdRisk.Create(objOwner)
  Else If fCfgSis('CNSCPC') = 'B' Then
    Result := TConsultaSCPCBoaVista.Create(objOwner)
  Else If fCfgSis('CNSCPC') = 'E' Then
  Begin
    If (fCfgSis('INTBOV') = 'emp_gold') Then
      Result := TConsultaSCPCBoaVistaEmpresarial.Create(objOwner)
    Else
    If (fCfgSis('INTBOV') = 'emp_platinum') Then
      Result := TConsultaSCPCBoaVistaEmpresarialPlatinum.Create(objOwner)
    Else
    If (fCfgSis('INTBOV') = 'ES') Then
      Result := TConsultaSCPCBoaVistaEssencial.Create(objOwner)
    Else
      Result := Nil;
  End
  Else If (fCfgSis('CNSCPC') = 'A') OR (fCfgSis('CNSCPC') = 'G') Then
    Result := TConsultaSCPCBoaVistaAcerta.Create(objOwner)
  Else If (fCfgSis('CNSCPC') = 'R') Then
    Result := TConsultaSCPC_CDLPOA_RS.Create(objOwner)
  Else
    Result := Nil;
end;

end.
