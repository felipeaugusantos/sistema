{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoPpgNexa;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, untIDataSet,
  Math, untIConfTinta, Classes, untStatusGravando, Windows,
  ActiveX;

type
  TAbstractGravandoExecucaoPpgNexa = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    strMarca: string;

    procedure CarregarDados(const gravando: IGravando; var qryOrigem: TDataSet; const strNomeArquivo: string; var qryDestino: IDataSet);
    function fGetNomeArquivo: String;

    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
    function GetDataSetDestino(): IDataSet; virtual;
    function GetSqlDestino(): string; virtual; abstract;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery;
    procedure GetTabelas(const qryOrigem: TADOQuery; const stlTabelas: TStrings);
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; virtual; abstract;

    procedure Animar(const gravando: IGravando);
    class function LimpaTexto(const strTexto: string): string;

    constructor Create(const strIdePro, strConfArq, strMarca: string); virtual;

  public
//    constructor Create;
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

  TProcedureGravandoExecucao = procedure (const gravando: IGravando) of object;
  TGetDataSetOrigem =  function (const strNomeArquivo: string): TDataSet of object;
  TGetDataSetDestino = function(): IDataSet of object;

  TThreadCarregar = class(TThread)
  private
    GetDataSetOrigem : TGetDataSetOrigem;
    GetDataSetDestino: TGetDataSetDestino;
    strNomeArquivo   : string;
    dataSetOrigem    : TDataSet;
    dataSetDestino   : IDataSet;
  protected
    procedure Execute; override;
  public
    constructor Create(const GetDataSetOrigem: TGetDataSetOrigem; const GetDataSetDestino: TGetDataSetDestino; const strNomeArquivo: string); reintroduce;
    destructor Destroy; override;

    property Origem : TDataSet read dataSetOrigem;
    property Destino: IDataSet read dataSetDestino;
  end;

implementation

uses
  untAutcomTintaFactory, untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untADOTxtFactory, untADOFactory;

{ TGravandoExecucaoPpxCores }


procedure TAbstractGravandoExecucaoPpgNexa.Animar(const gravando: IGravando);
begin
  gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoPpgNexa.CarregarDados( const gravando: IGravando; var qryOrigem: TDataSet; const strNomeArquivo: string; var qryDestino: IDataSet);
var
  threadCarregar: TThreadCarregar;
begin
  threadCarregar := nil;
  Try
    Try
      threadCarregar := TThreadCarregar.Create(GetDataSetOrigem, GetDataSetDestino, strNomeArquivo);

      while not threadCarregar.Terminated do
      begin
        if gravando.Status in [sgCancelado, sgFinalizado] then
        begin
          threadCarregar.Terminate;
          TerminateThread(threadCarregar.Handle, 0);
        end
        else
          Animar(gravando);
      end;

      threadCarregar.WaitFor;
      qryOrigem  := threadCarregar.Origem;
      qryDestino := threadCarregar.Destino;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(threadCarregar) then FreeAndNil(threadCarregar);
  End;
end;


constructor TAbstractGravandoExecucaoPpgNexa.Create(const strIdePro, strConfArq,
  strMarca: string);
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('PPX');
  self.strMarca := strMarca;
end;

destructor TAbstractGravandoExecucaoPpgNexa.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoPpgNexa.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
var
  definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, False, '|', dtcsAnsi, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
      TGenericDefinicaoTxtCampo.Create('UFID', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Brand Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Brand Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('OEM Color Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Mixing Scheme Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Mixing Scheme Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Source Type Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Source Type Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Usage Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Usage Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Manufacturer Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Manufacturer Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Model', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Country For Color Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Contry For Color Desc', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Finish Effect Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Finish Effect Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Paint System Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Paint System', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Paint System Short Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Variant Key Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('VariantCode', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Variant Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Specific Weigh (Gravity)', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product Volume', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Initial Year', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Finish Year', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product1 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product1Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct1', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct1', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product2 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product2Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct2', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct2', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product3 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product3Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct3', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct3', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product4 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product4Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct4', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct4', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product5 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product5Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct5', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct5', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product6 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product6Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct6', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct6', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product7 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product7Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct7', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct7', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product8 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product8Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct8', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct8', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product9 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product9Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct9', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct9', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product10 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product10Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct10', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct10', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Product11 Code', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Product11Description', dtctMemo),
      TGenericDefinicaoTxtCampo.Create('Amount of Grams/Prodct11', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('GravityProduct11', dtctDouble)
  ]));
  strNomeArquivo := definicao.NomeArquivo;
  TADOTxtFactory.Registrar(definicao);
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));

end;

function TAbstractGravandoExecucaoPpgNexa.GetDataSetDestino: IDataSet;
begin
  Result     := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

procedure TAbstractGravandoExecucaoPpgNexa.GetTabelas(const qryOrigem: TADOQuery;
  const stlTabelas: TStrings);
var
  conOrigem: TADOConnection;
begin
  conOrigem := nil;
  Try
    Try
      conOrigem := TADOConnection.Create(qryOrigem);
      conOrigem.ConnectionString := qryOrigem.ConnectionString;
      conOrigem.LoginPrompt := False;
      conOrigem.Open();
      conOrigem.GetTableNames(stlTabelas);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(conOrigem) then FreeAndNil(conOrigem);
  End;
end;


class function TAbstractGravandoExecucaoPpgNexa.LimpaTexto(
  const strTexto: string): string;
begin
  Result := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

function TAbstractGravandoExecucaoPpgNexa.GetDataSetOrigem(
  const strNomeArquivo: string): TDataSet;
var
  strArquivo: string;
  stlTabelas: TStringList;
begin
  stlTabelas := nil;
  Result     := nil;
  Try
    Try
      stlTabelas := TStringList.Create;
      strArquivo := strNomeArquivo;
      Result     := GetAdoQuery(strArquivo);
      GetTabelas(TADOQuery(Result), stlTabelas);
      TADOQuery(Result).SQL.Text := GetSqlOrigem(strArquivo, stlTabelas);
      TADOQuery(Result).Open;
    Except
      on E: EAbstractError do
      begin
        raise Exception.CreateFmt('[%s] %s', [Self.ClassName, E.Message]);
      end;

      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlTabelas) then FreeAndNil(stlTabelas);
  End;

end;


function TAbstractGravandoExecucaoPpgNexa.fGetNomeArquivo : String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('PPX').fGet('PATPPX');
end;

function TAbstractGravandoExecucaoPpgNexa.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

{ TThreadCarregar }

constructor TThreadCarregar.Create(const GetDataSetOrigem: TGetDataSetOrigem; const GetDataSetDestino: TGetDataSetDestino; const strNomeArquivo: string);
begin
  inherited Create(False);

  Self.GetDataSetOrigem  := GetDataSetOrigem;
  Self.GetDataSetDestino := GetDataSetDestino;
  Self.strNomeArquivo    := strNomeArquivo;
end;

destructor TThreadCarregar.Destroy;
begin

  inherited;
end;

procedure TThreadCarregar.Execute;
begin
  Try
    CoInitializeEx(nil, COINIT_MULTITHREADED);
    Self.dataSetOrigem  := GetDataSetOrigem(strNomeArquivo);
    Self.dataSetDestino := GetDataSetDestino;
  Finally
    CoUninitialize;
    Terminate;
  End;

end;


end.
