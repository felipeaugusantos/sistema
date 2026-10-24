unit Faturamento.Auditoria.EmbalagemFechada;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  UniClientDataSet,
{$ENDIF}
  System.SysUtils, Data.DB, System.Math,
  Faturamento.Auditoria.Interfaces.EmbalagemFechada,
  System.Variants, Core.Funcoes;

type
  TAuditoriaEmbFechada = class(TInterfacedObject, IAuditoriaEmbFechada)
  private
    FCdsAuditoriaEmbFec: TUniClientDataSet;

    function CriarClientAuditoriaEmbFechada: TUniClientDataSet;

  public
    function LocalizouItemAuditoriaEmbFechada(const ACodigoDaEmpresa, ACodigoItem, ATabelaPreco,
      ACodigoDeBarra: String; const AQuantidadeItem: Double): Boolean;

    procedure GravarClientDataSetItemAuditoriaEmbFechada(const ACodigoDaEmpresa, ACodigoItem,
      ATabelaPreco, ACodigoDeBarra: String; const AQuantidadeItem,
      APercDesEmbFec: Double);

    function RetornarValorPercentualDescontoEmbalagemFechada(
      Const ACodigoDaEmpresa, ACodigoDoItem, ATabelaDePreco, CodigoDeBarras : String ; Const AQuantidadeDoItem : Double) : Double;

    constructor Create;
    destructor Destroy; override;

    class function New(): IAuditoriaEmbFechada;
  end;

implementation

{ TAuditoriaEmbFechada }

procedure TAuditoriaEmbFechada.GravarClientDataSetItemAuditoriaEmbFechada(const ACodigoDaEmpresa, ACodigoItem,
  ATabelaPreco, ACodigoDeBarra: String; const AQuantidadeItem,
  APercDesEmbFec: Double);
begin
  If Not LocalizouItemAuditoriaEmbFechada(ACodigoDaEmpresa, ACodigoItem, ATabelaPreco, ACodigoDeBarra, AQuantidadeItem)Then
  begin
    FCdsAuditoriaEmbFec.Append;
    FCdsAuditoriaEmbFec.FieldByName('ITE_EMBFEC_QTDEMB').AsFloat  := AQuantidadeItem;
    FCdsAuditoriaEmbFec.FieldByName('ITE_EMBFEC_TABPRE').AsString := ATabelaPreco;
    FCdsAuditoriaEmbFec.FieldByName('ITE_EMBFEC_CODBAR').AsString := ACodigoDeBarra;
    FCdsAuditoriaEmbFec.FieldByName('ITE_EMBFEC_CODEMP').AsString := ACodigoDaEmpresa;
    FCdsAuditoriaEmbFec.FieldByName('ITE_EMBFEC_CODITE').AsString := ACodigoItem;
    FCdsAuditoriaEmbFec.FieldByName('ITE_EMBFEC_PERDES').AsFloat  := APercDesEmbFec;
    FCdsAuditoriaEmbFec.Post;
 end;
end;


function TAuditoriaEmbFechada.LocalizouItemAuditoriaEmbFechada(Const ACodigoDaEmpresa, ACodigoItem,
  ATabelaPreco, ACodigoDeBarra : String;
  Const AQuantidadeItem : Double): Boolean;
begin
  Result := False;

  If FCdsAuditoriaEmbFec.
        Locate('ITE_EMBFEC_CODEMP;ITE_EMBFEC_CODITE;ITE_EMBFEC_QTDEMB;ITE_EMBFEC_TABPRE;ITE_EMBFEC_CODBAR',
          VarArrayOf(
            [ACodigoDaEmpresa,
             ACodigoItem,
             AQuantidadeItem,
             ATabelaPreco,
             ACodigoDeBarra]), []) Then
  begin
    Result := True;
  end;
end;


function TAuditoriaEmbFechada.RetornarValorPercentualDescontoEmbalagemFechada(
  Const ACodigoDaEmpresa, ACodigoDoItem, ATabelaDePreco, CodigoDeBarras : String; Const AQuantidadeDoItem : Double) : Double;
begin
  Result := 0;

  Try
    If LocalizouItemAuditoriaEmbFechada(
         ACodigoDaEmpresa,
         ACodigoDoItem,
         ATabelaDePreco,
         CodigoDeBarras,
         AQuantidadeDoItem) Then
    begin
      result :=
        FCdsAuditoriaEmbFec.FieldByName('ITE_EMBFEC_PERDES').AsFloat;
    end;

  Except
    Result := 0;
  end;

end;


constructor TAuditoriaEmbFechada.Create;
begin
  inherited Create;
  FCdsAuditoriaEmbFec := CriarClientAuditoriaEmbFechada;
end;

function TAuditoriaEmbFechada.CriarClientAuditoriaEmbFechada: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_EMBFEC_CODEMP', ftString, 3);
  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_EMBFEC_CODBAR', ftString);
  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_EMBFEC_CODITE', ftString, 5);
  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_EMBFEC_QTDEMB', ftFloat);
  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_EMBFEC_TABPRE', ftString, 1);
  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_EMBFEC_PERDES', ftFloat);

  Result.CreateDataSet;

  Result.LogChanges := False;
end;

destructor TAuditoriaEmbFechada.Destroy;
begin
  FreeAndNil(FCdsAuditoriaEmbFec);
  inherited;
end;


class function TAuditoriaEmbFechada.New: IAuditoriaEmbFechada;
begin
  Result := Self.Create;
end;

end.


