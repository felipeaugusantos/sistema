unit untBtnRestaurarPrecoEvento;

interface

uses untAutcomTintaFactory, untIAutcomTintaWrapper, SysUtils, untIDataSet,
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untAbstractCadastro,
  Dialogs;

type
  TBtnRestaurarPrecoEvento = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    dbeItemBase: string;
    dbePrecoCusto: string;
    dbeMargem: string;
    dbePrecoVenda: string;
  published
    constructor Create(const cadastro: TAbstractCadastro; const dbeItemBase: string;
      const dbePrecoCusto: string; const dbeMargem: string; const dbePrecoVenda: string); reintroduce;
  published
    procedure OnClick(Sender: Pointer);
  end;

implementation

constructor TBtnRestaurarPrecoEvento.Create(const cadastro: TAbstractCadastro; const dbeItemBase: string;
  const dbePrecoCusto: string; const dbeMargem: string; const dbePrecoVenda: string);
begin
  inherited Create('OnClick', cadastro);
  Self.dbeItemBase := dbeItemBase;
  Self.dbePrecoCusto := dbePrecoCusto;
  Self.dbeMargem := dbeMargem;
  Self.dbePrecoVenda := dbePrecoVenda;
end;

procedure TBtnRestaurarPrecoEvento.OnClick(Sender: Pointer);
var
  qryDados: IDataSet;
begin
  Try
    Try
      qryDados := TAutcomTintaFactory.Get.fGetDataSet;
      qryDados.SQL :=
        ' SELECT                     ' +
        '   ITE_PRECUS               ' +
        '   , ITE_MARBR1             ' +
        '   , ITE_PREVE1             ' +
        ' FROM                       ' +
        '   ITEGER                   ' +
        ' WHERE ITE_CODITE = :CODITE ' +
        '   AND ITE_CODEMP = :CODEMP ';
      qryDados.ParamByName('CODITE').AsString := GetControle(dbeItemBase)['Text'].Value;
      qryDados.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryDados.Open;

      GetFieldByControle(dbePrecoCusto).AsFloat := qryDados.FieldByName('ITE_PRECUS').AsFloat;
      GetFieldByControle(dbeMargem).AsFloat := qryDados.FieldByName('ITE_MARBR1').AsFloat;
      GetFieldByControle(dbePrecoVenda).AsFloat := qryDados.FieldByName('ITE_PREVE1').AsFloat;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;

end;
end.
