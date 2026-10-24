unit TestUntCategoriaCadLead;

interface

uses
  TestFramework, Windows, untCategoriaCadLead, Forms, Dialogs, Controls, Classes, SysUtils,
  Variants, Graphics, Messages;

type

  TestTCategoriaCadLead = class(TTestCase)
  strict private
    FCategoriaCadLead: TCategoriaCadLead;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestpValidaExisteCategoriaSim;
    procedure TestpValidaExisteCategoriaNao;
    procedure TestpValidaCategoriaEhLeadSim;
    procedure TestpValidaCategoriaEhLeadNao;
    procedure TestpValidaExisteCategoriaNaoCodigoDescricaoBranco;
    procedure TestfRetornaSQLCategoria;
    procedure TestfExibeCategoriaNaTelaLead;
    procedure TestfExibeCategoriaNaTelaCadastro;
    procedure TestfRetornaSQLFiltroCategoriaLead;
  end;

implementation

procedure TestTCategoriaCadLead.SetUp;
begin
  FCategoriaCadLead := TCategoriaCadLead.Create;
end;

procedure TestTCategoriaCadLead.TearDown;
begin
  FCategoriaCadLead.Free;
  FCategoriaCadLead := nil;
end;

procedure TestTCategoriaCadLead.TestpValidaExisteCategoriaNao;
  var
    strMenssagem: String;
begin
  strMenssagem:= '';
  Try
    FCategoriaCadLead.strCodigoCategoria:= '000001';
    FCategoriaCadLead.strDescricao      := '';
    FCategoriaCadLead.blnUtiCat         := True;
    FCategoriaCadLead.pValidaExisteCategoria;
  Except
    On E : Exception Do
    Begin
      strMenssagem:= E.Message;
    End;
  End;
  CheckEqualsString(strMenssagem, 'Categoria informada não existe!');
end;

procedure TestTCategoriaCadLead.TestpValidaExisteCategoriaSim;
  var
    strMenssagem: String;
begin
  strMenssagem:= '';
  Try
    FCategoriaCadLead.strCodigoCategoria:= '000001';
    FCategoriaCadLead.strDescricao      := 'Especial';
    FCategoriaCadLead.blnUtiCat         := True;
    FCategoriaCadLead.pValidaExisteCategoria;
  Except
    On E : Exception Do
    Begin
      strMenssagem:= E.Message;
    End;
  End;
  CheckEqualsString(strMenssagem, '');
end;

procedure TestTCategoriaCadLead.TestpValidaExisteCategoriaNaoCodigoDescricaoBranco;
  var
    strMenssagem: String;
begin
  strMenssagem:= '';
  Try
    FCategoriaCadLead.strCodigoCategoria:= '';
    FCategoriaCadLead.strDescricao      := '';
    FCategoriaCadLead.blnUtiCat         := True;
    FCategoriaCadLead.pValidaExisteCategoria;
  Except
    On E : Exception Do
    Begin
      strMenssagem:= E.Message;
    End;
  End;
  CheckEqualsString(strMenssagem, '');
end;

procedure TestTCategoriaCadLead.TestpValidaCategoriaEhLeadNao;
  var
    strMenssagem: String;
begin
  strMenssagem:= '';
  Try
    FCategoriaCadLead.strCategoriaLead  := 'N';
    FCategoriaCadLead.strCodigoCategoria:= '000001';
    FCategoriaCadLead.blnUtiCat         := True;
    FCategoriaCadLead.pValidaCategoriaEhLead;
  Except
    On E : Exception Do
    Begin
      strMenssagem:= E.Message;
    End;
  End;
  CheckEqualsString(strMenssagem, 'Categoria não definida como Lead!');
end;

procedure TestTCategoriaCadLead.TestpValidaCategoriaEhLeadSim;
  var
    strMenssagem: String;
begin
  strMenssagem:= '';
  Try
    FCategoriaCadLead.strCategoriaLead  := 'S';
    FCategoriaCadLead.strCodigoCategoria:= '000001';
    FCategoriaCadLead.blnUtiCat         := True;
    FCategoriaCadLead.pValidaCategoriaEhLead;
  Except
    On E : Exception Do
    Begin
      strMenssagem:= E.Message;
    End;
  End;
  CheckEqualsString(strMenssagem, '');
end;

procedure TestTCategoriaCadLead.TestfRetornaSQLCategoria;
var
  strSQL,
  ReturnValue: string;
begin
  FCategoriaCadLead.strCodigoCategoria:= '000001';

  strSQL:= ' SELECT * FROM CATEGO '+
           ' WHERE CAT_CODIGO = '+QuotedStr(FCategoriaCadLead.strCodigoCategoria)+' ';

  FCategoriaCadLead.strSQLCategoria   := strSQL;

  ReturnValue := FCategoriaCadLead.fRetornaSQLCategoria;

  CheckEqualsString(strSQL, ReturnValue);
end;

procedure TestTCategoriaCadLead.TestfExibeCategoriaNaTelaLead;
var
  ReturnValue: Boolean;
begin
  FCategoriaCadLead.blnUtiCat:= True;
  ReturnValue := FCategoriaCadLead.fExibeCategoriaNaTelaLead;
  CheckTrue(ReturnValue);
end;

procedure TestTCategoriaCadLead.TestfExibeCategoriaNaTelaCadastro;
var
  ReturnValue: Boolean;
begin
  FCategoriaCadLead.blnULeads:= True;
  ReturnValue := FCategoriaCadLead.fExibeCategoriaNaTelaCadastro;
  CheckTrue(ReturnValue);
end;

procedure TestTCategoriaCadLead.TestfRetornaSQLFiltroCategoriaLead;
var
  ReturnValue: string;
begin
  FCategoriaCadLead.blnUtiCat          := True;
  FCategoriaCadLead.blnFiltraApenasLead:= True;
  ReturnValue := FCategoriaCadLead.fRetornaSQLFiltroCategoriaLead;
  CheckEqualsString(' AND CAT_LEDPER = "S" ', ReturnValue);
end;

initialization
  RegisterTest(TestTCategoriaCadLead.Suite);
end.

