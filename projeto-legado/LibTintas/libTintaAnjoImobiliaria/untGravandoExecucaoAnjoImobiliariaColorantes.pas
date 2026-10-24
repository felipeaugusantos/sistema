{*************************************************************************}
{* Classe responsável pela geração do cadastro de Colorantes da tinta AnjoImobiliaria *}
{**********************************************************************PH*}
unit untGravandoExecucaoAnjoImobiliariaColorantes;

interface

uses
  untAbstractGravandoExecucaoAnjoImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  uni, ComObj, DBFUniProvider;

Type
  TGravandoExecucaoAnjoImobiliariaColorantes = class(TAbstractGravandoExecucaoAnjoImobiliaria)
  private

    function fRetPatDBF : String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;const stlTabelas: TStrings): string; override;
  end;

implementation

{ TGravandoExecucaoAnjoImobiliariaColorantes }

uses untStrUtils;


procedure TGravandoExecucaoAnjoImobiliariaColorantes.Executar(const gravando: IGravando);
var
  qryColDbf : TUniQuery;
  DataCol   : TUniConnection;
  qryCadCol : IDataSet;
  strIdCol  : String;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not DirectoryExists(fRetPatDBF)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de Colorantes não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      DataCol := TUniConnection.Create(Nil);
      DataCol.ProviderName := 'DBF';
      DataCol.LoginPrompt  := False;

      DataCol.Database     := fRetPatDBF;

      If (Not DataCol.Connected) Then
        DataCol.Connected := True;

      qryColDbf := TUniQuery.Create(Nil);
      qryColDbf.Connection := DataCol;

      qryColDbf.Close;
      qryColDbf.SQL.Clear;
      qryColDbf.SQL.Add(' SELECT * FROM \CNTS.DBF');
      qryColDbf.Open;

      qryColDbf.First;


      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ANJ_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';


      qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadCol.SQL := 'SELECT * '+
                       '  FROM ANJ_CADCOL '+
                       ' WHERE COL_CODCOL = :CODCOL';
      qryCadCol.ParamByName('CODCOL').AsString := qryColDbf.FieldByName('ID').AsString;
      qryCadCol.Open;

      If qryCadCol.IsEmpty Then
      Begin
        While Not(qryColDbf.Eof) Do
        begin
          strIdCol := Trim(qryColDbf.FieldByName('ID').AsString);

          qryCadCol.Insert;
          qryCadCol.FieldByName('COL_CODCOL').AsString := strIdCol;
          qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ANJ_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCol.FieldByName('COL_DESCRI').AsString := qryColDbf.FieldByName('DESCR').AsString;
          qryCadCol.Post;

          qryColDbf.Next;

          gravando.RegistrarProgresso(0, qryColDbf.RecNo, qryColDbf.RecordCount);
        end;
      End;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoAnjoImobiliariaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoAnjoImobiliariaColorantes.fRetPatDBF: String;
begin
  Result := conf.fGet('PATANJ'); //ANJO1
end;


function TGravandoExecucaoAnjoImobiliariaColorantes.GetSqlDestino: string;
begin
  Result := '';
end;

function TGravandoExecucaoAnjoImobiliariaColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

end.
