{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadora da tinta FarbenAutomotiva *}
{***********************************************************************AC*}
unit untGravandoExecucaoFarbenAutomotivaMontadora;

interface

uses
  untAbstractGravandoExecucaoFarbenAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, Uni, InterBaseUniProvider,UniDataSetProvider;

type
  TGravandoExecucaoFarbenAutomotivaMontadora = class(TAbstractGravandoExecucaoFarbenAutomotiva)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoFarbenAutomotivaMontadora }

procedure TGravandoExecucaoFarbenAutomotivaMontadora.Executar(const gravando: IGravando);
Var
  qryArquivo : TUniQuery;
  qryTotalReg: TUniQuery;
  qryDestino : IDataSet;
  intTotReg  : Integer;
  strDll     : String;
  Provider   : TInterbaseUniProvider;

begin
  Try
    Try

      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not FileExists(GetPath)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de Montadora não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Realizando conexão com banco de dados Firebird...';


      Try

        Provider := TInterbaseUniProvider.Create(Nil);

        qryArquivo := TUniQuery.Create(Nil);
        qryArquivo.Connection := fConnectionFdb;

        qryArquivo.SQL.Clear;
        qryArquivo.Close;
        qryArquivo.SQL.Text := 'SELECT * '+
                               '  FROM ARQMON ';
        qryArquivo.Open;
      Except
        on e : Exception do
        Begin
          strDll := e.message;

          strDll := copy(StrDll, pos(',', StrDll)+1,length(StrDll));
          strDll := copy(StrDll, pos(':', StrDll)+1,length(StrDll));

          strDll := UpperCase(StrDll);

          If (Pos(Copy(strDll, (Length(strDll) - 3) , Length(strDll)),'.DLL') > 0) Then
            gravando.Texto := 'Não foi possível realizar a integração com o banco de dados, pois o arquivo '+ strDll +' não foi encontrado.'
          else
            gravando.Texto := 'Erro ao tentar conexão com o banco de dados!';
        End
      End;

      gravando.Texto := 'Conexão com Firebird realizada com sucesso.';

      Try
        qryTotalReg := TUniQuery.Create(Nil);
        qryTotalReg.Connection := fConnectionFdb;

        qryTotalReg.SQL.Clear;
        qryTotalReg.Close;
        qryTotalReg.SQL.Text := 'SELECT COUNT(*) AS TOTAL '+
                               '  FROM ARQMON ';
        qryTotalReg.Open;

        intTotReg := qryTotalReg.FieldByName('TOTAL').AsInteger;
      Finally
        FreeAndNil(qryTotalReg);
      End;

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := 'SELECT * '+
                        '  FROM FAR_CADMON;';
      qryDestino.Open;


      qryArquivo.First;

      gravando.Texto := 'Iniciando a geração do cadastro de Montadora.. .';

      While Not qryArquivo.Eof do
      Begin
        qryDestino.Insert;
        qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FAR_CADMON', TAutcomTintaFactory.Get.GetCodEmp);
        qryDestino.FieldByName('FAR_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryDestino.FieldByName('FAR_CODMON').AsString  := qryArquivo.FieldByName('CODMONT').AsString;
        qryDestino.FieldByName('FAR_DESMON').AsString  := qryArquivo.FieldByName('MONTADORA').AsString;
        qryDestino.Post;

        gravando.RegistrarProgresso(0, qryArquivo.RecNo, intTotReg);

        qryArquivo.Next;
      end;

    Except
      on e : Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    If Assigned(qryArquivo) Then
      FreeAndNil(qryArquivo);

    if Assigned(Provider) Then
      FreeAndNil(Provider);
  End;

end;

function TGravandoExecucaoFarbenAutomotivaMontadora.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadora';
end;

end.
