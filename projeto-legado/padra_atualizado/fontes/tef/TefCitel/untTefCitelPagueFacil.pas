unit untTefCitelPagueFacil;

interface

uses
  SysUtils, untTefCitelUtil, untInterfaceTefCitel, Classes, Forms, Windows;

Type

  ITefCitelPagueFacil = Interface(IInterface)
    function fRecebePagueFacil(fltValor: Double;
                               var intQtdPar, intOperacao : Integer;
                               strNumDoc, strCodOpe : String;
                               var strModalidade : String;
                               AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra): IRetornoTEFCitel;
  End;

  TTefCitelPagueFacil = class(TInterfacedObject, ITefCitelPagueFacil)
    private
      strTipoCartao: string;
      intParcelas: Integer;
    public
      constructor Create(strTipoCartao: string = ''; intParcelas: Integer = 1);
      destructor Destroy; override;

      function fRecebePagueFacil(fltValor: Double;
                                 var intQtdPar, intOperacao : Integer;
                                 strNumDoc, strCodOpe : String;
                                 var strModalidade : String;
                                 AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra): IRetornoTEFCitel;
  End;

  function fCriarTefCitelPagueFacil(strTipoCartao: string = ''; intParcelas: Integer = 1): ITefCitelPagueFacil;

implementation

function fCriarTefCitelPagueFacil(strTipoCartao: string; intParcelas: Integer): ITefCitelPagueFacil;
begin
  Result := TTefCitelPagueFacil.Create(strTipoCartao, intParcelas);
end;

{ TTefCitelRecebimento }

constructor TTefCitelPagueFacil.Create(strTipoCartao: string; intParcelas: Integer);
begin
  Self.strTipoCartao := strTipoCartao;
  Self.intParcelas := intParcelas;
end;

destructor TTefCitelPagueFacil.Destroy;
begin

  inherited;
end;

function TTefCitelPagueFacil.fRecebePagueFacil(fltValor: Double;
                                               var intQtdPar, intOperacao : Integer;
                                               strNumDoc, strCodOpe : String;
                                               var strModalidade : String;
                                               AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra) : IRetornoTEFCitel;
begin
  intQtdPar := Self.intParcelas;
  Result := fPassaCartaoPagueFacil(Self.strTipoCartao,
                                   intQtdPar,
                                   intOperacao,
                                   fltValor,
                                   strNumDoc,
                                   strCodOpe,
                                   strModalidade,
                                   AobjDadosAdicionaisTefTra);
end;

end.
