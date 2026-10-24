unit Produto.TProdutos;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Windows, Messages, Graphics, Controls, Forms, Dialogs,
{$ENDIF}
  SysUtils, Variants, Classes;

Type
  TProdutos = Class
  private
    FComponenteA: String;
    FComponenteB: String;
    FCfgUsaComponente: Boolean;
    FCodigoProduto: String;
    FDescricaoProduto: String;

  public

    property strComponenteA: String read FComponenteA write FComponenteA;
    property strComponenteB: String read FComponenteB write FComponenteB;
    property blnCfgUsaComponente: Boolean read FCfgUsaComponente
      write FCfgUsaComponente;
    property strCodigoProduto: String read FCodigoProduto write FCodigoProduto;
    property strDescricaoProduto: String read FDescricaoProduto
      write FDescricaoProduto;

    constructor Create;

    // procedure pValidaCo

    function fCfgComponente: Boolean;
    function fVerificaComponenteA: Boolean;
    function fVerificaComponenteB: Boolean;

    procedure pValidaCodigoProdutoComponenteB;
    procedure pValidaNomeProdutoComponenteB;
    procedure pValidaCodigoProdutoComponenteDiluente;
    procedure pValidaNomeProdutoComponenteDiluente;

  End;

implementation

{ TProdutos }

constructor TProdutos.Create;
begin
  FComponenteA := '';
  FComponenteB := '';
  FCodigoProduto := '';
  FCfgUsaComponente := False;
end;

function TProdutos.fCfgComponente: Boolean;
begin
  Result := (FCfgUsaComponente = True);
end;

function TProdutos.fVerificaComponenteA: Boolean;
begin
  Result := FComponenteA = 'S';
end;

function TProdutos.fVerificaComponenteB: Boolean;
begin
  Result := FComponenteB = 'S';
end;

procedure TProdutos.pValidaCodigoProdutoComponenteB;
begin
  if (FCfgUsaComponente) then
  Begin
    if (FCodigoProduto = '') then
      Raise Exception.Create('Digite o código do produto!');
  End;
end;

procedure TProdutos.pValidaNomeProdutoComponenteB;
begin
  if (FCfgUsaComponente) then
  Begin
    if (FDescricaoProduto = '') then
      Raise Exception.Create('Código do Produto não encontrado!');
  End;
end;

procedure TProdutos.pValidaCodigoProdutoComponenteDiluente;
begin
  if (FCfgUsaComponente) then
  Begin
    if (FCodigoProduto = '') then
      Raise Exception.Create('Digite o código do produto Diluente!');
  End;
end;

procedure TProdutos.pValidaNomeProdutoComponenteDiluente;
begin
  if (FCfgUsaComponente) then
  Begin
    if (FDescricaoProduto = '') then
      Raise Exception.Create('Código do Produto Diluente não encontrado!');
  End;
end;

end.
