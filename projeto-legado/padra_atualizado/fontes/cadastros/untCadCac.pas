{*********************************************}
{* CLASSE PARA O CADASTRO DE CANAL DE ACESSO *}
{*                                           *}
{* DATA........: 24/02/2011                  *}
{* AUTOR.......: DANIEL PARRON FERNANDES     *}
{*                                           *}
{******************************************DP*}
unit untCadCac;

interface

uses Classes, Uni;

Type TCadCac = Class( TComponent )
  Private
    FCodCac : String;
    FNomCac : String;
    FIdCont : String;


    procedure setCodCac(const Value : String);
    procedure setNomCac(const Value : String);
    procedure setIdcont(const Value : String);


  Public
    qryTabela: TUniQuery;

    Property strCodCac: String Read FCodCac Write setCodCac;
    Property strNomCac: String Read FNomCac Write setNomCac;
    Property strIdCont: String Read FIdCont Write setIdcont;

  Constructor Create(Owner: TComponent); Reintroduce;
End;

implementation

uses SysUtils, untFuncoesSimples;

procedure TCadCac.setCodCac(const Value: String);
Begin
  If Not(fEmptyStr(Value)) Then
    FCodCac := Value
  Else
    Raise Exception.Create('O código do Canal de Acesso deve ser preenchido!');
End;

procedure TCadCac.setIdcont(const Value: String);
begin
  FIdCont := Value;
end;

procedure TCadCac.setNomCac(const Value: String);
Begin
  If Not(fEmptyStr(Value)) Then
    FNomCac := Value
  Else
    Raise Exception.Create('O nome do Canal de Acesso deve ser preenchido!');
End;


constructor TCadCac.Create(Owner: TComponent);
Begin

  Try

    qryTabela := fCriaQuery(Self);

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CADCAC WHERE FALSE');
    qryTabela.Open;

    FCodCac := '';
    FNomCac := '';
    FIdCont := '';

  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto CadCac!' + #13 + E.Message );
  End;

End;

end.
