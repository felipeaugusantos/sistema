unit untCdsItensLocalSeparacao;

interface

uses
  UniClientDataSet, Classes, SysUtils, Data.Db, untFuncoesSimples,
  System.Variants;

  type
    TCdsItensLocalSeparacao = class(TUniClientDataSet)
    public
      constructor Create(AOwner: TComponent); override;
  end;


implementation

{ TCdsItensLocalSeparacao }

constructor TCdsItensLocalSeparacao.Create(AOwner: TComponent);
begin
  inherited;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_ITEM';                DataType := ftString; Size := 07; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'AUTOINCREM_LOCAL_SEPARACAO'; DataType := ftString; Size := 20; Required := False; End;

  CreateDataSet;
  Open;

end;

end.
