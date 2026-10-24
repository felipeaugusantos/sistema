unit ImportacaoDados.Model.ModeloFactory;

interface

uses
  Classes, SysUtils,
  ImportacaoDados.Interfaces,
  ImportacaoDados.Model.ModeloArquivo,
  ImportacaoDados.Model.CadastroProspecto,
  ImportacaoDados.Model.ItemFatVenda,
  ImportacaoDados.Model.CadLocEqu;

Type

  TModelo = Class
    Class function New(Const aTipo: TTipoImportacaoArquivo): IModeloArquivoImportacao;
    Class function fSelecionarModelo(Const aTipo: TTipoImportacaoArquivo): IModeloArquivoImportacao;
  End;

implementation

uses
  Uni, untFuncoesSimples;

{ TModelo }

class function TModelo.New(const aTipo: TTipoImportacaoArquivo): IModeloArquivoImportacao;
begin
  case aTipo of
    tpCadastroProspecto : Result := TModeloImportacaoProspecto.Create;
    tpItensFatVenda     : Result := TModeloImportacaoItemFatVenda.Create;
    tpCadLocEqu         : Result := TModeloImportacaoEquipamentoLocacao.Create
    Else
      Result := TModeloArquivoImportacao.Create;
  end;
end;

class function TModelo.fSelecionarModelo(Const aTipo: TTipoImportacaoArquivo): IModeloArquivoImportacao;
var
  aModeloAtual: IModeloArquivoImportacao;
  qry: TUniQuery;
begin
  aModeloAtual := TModelo.New(aTipo);

  qry := fCriaQuery(nil);
  Try
    qry.DisableControls;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT AUTOINCREM, ' +
                '       MDL_CODARQ, ' +
                '       MDL_DESARQ, ' +
                '       MDL_TIPARQ  ' +
                'FROM MDLARQ ' +
                'WHERE MDL_MDLATU = "S" ' +
                '  AND MDL_TIPARQ = :MDL_TIPARQ');

    qry.ParamByName('MDL_TIPARQ').AsString := strTipoImportacaoArquivo[aTipo];
    qry.Open;
    If Not(qry.IsEmpty) Then
    Begin
      aModeloAtual.Codigo     := qry.FieldByName('MDL_CODARQ').AsString;
      aModeloAtual.Descricao  := qry.FieldByName('MDL_DESARQ').AsString;
      aModeloAtual.AutoIncrem := qry.FieldByName('AUTOINCREM').AsString;
      aModeloAtual.Tipo := aTipo;
    End;

  Finally
    Result := aModeloAtual;
    FreeAndNil(qry);
  End;
end;

end.
