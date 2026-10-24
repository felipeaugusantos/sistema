unit untCategoriaCadLead;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
     Forms, Dialogs;

Type
  TCategoriaCadLead = class
    private

      FCodigoCategoria    : String;
      FCategoriaLead      : String;
      FValorPadraoFlagLead: String;
      FSQLCategoria       : String;
      FUleads             : Boolean;
      FUtiCat             : Boolean;
      FFiltraApenasLead   : Boolean;
      FDescricao          : String;


    public
      property strCodigoCategoria     : String  read FCodigoCategoria     write FCodigoCategoria;
      property strCategoriaLead       : String  read FCategoriaLead       write FCategoriaLead;
      property strValorPadraoFlagLead : String  read FValorPadraoFlagLead write FValorPadraoFlagLead;
      property strSQLCategoria        : String  read FSQLCategoria        write FSQLCategoria;
      property blnULeads              : Boolean read FUleads              write FUleads;
      property blnUtiCat              : Boolean read FUtiCat              write FUtiCat;
      property blnFiltraApenasLead    : Boolean read FFiltraApenasLead    write FFiltraApenasLead;
      property strDescricao           : String  read FDescricao           write FDescricao;

      constructor Create;

      procedure pValidaExisteCategoria;
      procedure pValidaCategoriaEhLead;
      function  fRetornaSQLCategoria: String;
      function  fExibeCategoriaNaTelaLead: Boolean;
      function  fExibeCategoriaNaTelaCadastro: Boolean;
      function  fRetornaSQLFiltroCategoriaLead: String;

      Const
        VALOR_PADRAO_FLAG_LEAD = 'N';


  End;

implementation

{ TCategoriaCadLead }

constructor TCategoriaCadLead.Create;
begin
  FCodigoCategoria    := '';
  FCategoriaLead      := '';
  FValorPadraoFlagLead:= '';
  FSQLCategoria       := '';
  FUleads             := False;
  FUtiCat             := False;
  FDescricao          := '';
  FFiltraApenasLead   := False;
end;

procedure TCategoriaCadLead.pValidaCategoriaEhLead;
begin
  if ((FCategoriaLead <> 'S') AND (FCodigoCategoria <> '') AND (FUtiCat)) then
    Raise Exception.Create('Categoria não definida como Lead!');
end;

procedure TCategoriaCadLead.pValidaExisteCategoria;
begin
  if ((FCodigoCategoria <> '') AND (FDescricao = '')) AND (FUtiCat) then
    Raise Exception.Create('Categoria informada não existe!');
end;

function TCategoriaCadLead.fExibeCategoriaNaTelaCadastro: Boolean;
begin
  Result:= FUleads;
end;

function TCategoriaCadLead.fExibeCategoriaNaTelaLead: Boolean;
begin
  Result:= FUtiCat;
end;

function TCategoriaCadLead.fRetornaSQLFiltroCategoriaLead: String;
begin
  Result:= '';
  If (FUtiCat) and (blnFiltraApenasLead) Then
    Result:= ' AND CAT_LEDPER = "S" ';
end;

function TCategoriaCadLead.fRetornaSQLCategoria: String;
begin
  Result:=   ' SELECT * FROM CATEGO '+
             ' WHERE CAT_CODIGO = '+QuotedStr(FCodigoCategoria)+' ';

end;

end.
