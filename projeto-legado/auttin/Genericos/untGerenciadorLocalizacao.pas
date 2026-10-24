unit untGerenciadorLocalizacao;

interface

uses
  untILocalizador, untILocalizavel,  Uni, SysUtils, Forms,
  Classes;

type
  TGerenciadorLocalizacao = class(TInterfacedObject)
  private
    localizador: ILocalizador;
    qryGen: TUniQuery;
    stlIndice: TStringList;
    stlDescricao: TStringList;
  public
    constructor Create(localizador: ILocalizador);
    destructor Destroy; override;
  public
    procedure Localizar(localizavel: ILocalizavel);

  end;

implementation

uses untFuncoesSimples;

{ TLocalizador }

constructor TGerenciadorLocalizacao.Create(localizador: ILocalizador);
begin
  inherited Create();
  Self.localizador := localizador;
  Self.qryGen := fCriaQuery();
  Self.stlIndice := TStringList.Create;
  Self.stlDescricao := TStringList.Create;
end;

destructor TGerenciadorLocalizacao.Destroy;
begin
  if Assigned(qryGen) then FreeAndNil(qryGen);
  if Assigned(stlIndice) then FreeAndNil(stlIndice);
  if Assigned(stlDescricao) then FreeAndNil(stlDescricao);
  inherited;
end;

procedure TGerenciadorLocalizacao.Localizar(localizavel: ILocalizavel);
begin
  Try
    Try
      stlIndice.Clear;
      localizador.ConstruirIndices(stlIndice);

      stlDescricao.Clear;
      localizador.ConstruirDescricaoIndices(stlDescricao);

      If pConsultaComp(Screen.ActiveForm, qryGen, localizador.NomeTabela, localizador.Sql, stlIndice, stlDescricao) Then
      begin
        localizavel.OnLocalizado(qryGen);
      end;

    Except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO', E.Message, ['&OK']);
      end;
    End;
  Finally

  End;
end;

end.
