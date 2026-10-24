unit DominioSistemas.Core.Exception;

interface

uses
  System.Classes, System.SysUtils ;

type
  ExceptionDominio = class(Exception);
  ExceptionDominioTokenInvalido = class(ExceptionDominio);
  ExceptionDominioCredencialInvalida = class(ExceptionDominio);
  ExceptionDominioCredencial = class(ExceptionDominio);
  ExceptionDominioUrlInvalida = class(ExceptionDominio);
  ExceptionDominioCredencialNaoAutorizada = class(ExceptionDominio);
  ExceptionDominioTransacaoNaoEncontrada = class(ExceptionDominio);
  ExceptionSelectNaoEncontrado = class(ExceptionDominio);
  ExceptionXmlNaoEncontrado = class(ExceptionDominio);
  ExceptionDocumentoSemChaveAcesso = class(ExceptionDominio);

implementation

end.
