{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta FarbenAutomotiva *}
{***********************************************************************AC*}
unit untGravandoExecucaoFarbenAutomotivaBases;

interface

uses
  untAbstractGravandoExecucaoFarbenAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, Uni, InterBaseUniProvider,UniDataSetProvider;

type
  TGravandoExecucaoFarbenAutomotivaBases = class(TAbstractGravandoExecucaoFarbenAutomotiva)
  Private
    function fQtdEmbalagemMl(strEmbalagem: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoFarbenAutomotivaBases }

procedure TGravandoExecucaoFarbenAutomotivaBases.Executar(const gravando: IGravando);
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
        gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
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
                               '  FROM ARQPRO '+
                               ' WHERE ORIGEM = ''MP''';
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
                               '  FROM ARQPRO '+
                               ' WHERE ORIGEM = ''MP''';
        qryTotalReg.Open;

        intTotReg := qryTotalReg.FieldByName('TOTAL').AsInteger;
      Finally
        FreeAndNil(qryTotalReg);
      End;

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := 'SELECT * '+
                        '  FROM FAR_CADBAS;';
      qryDestino.Open;


      qryArquivo.First;

      gravando.Texto := 'Iniciando a geração do cadastro de bases.. .';

      While Not qryArquivo.Eof do
      Begin
        qryDestino.Insert;
        qryDestino.FieldByName('BAS_CODBAS').AsString := Trim(qryArquivo.FieldByName('CODIGO').AsString);
        qryDestino.FieldByName('BAS_DESCRI').AsString := qryArquivo.FieldByName('DESCRICAO').AsString;
        qryDestino.FieldByName('BAS_DENSID').AsFloat  := qryArquivo.FieldByName('DENSIDADE').AsFloat;
        qryDestino.FieldByName('BAS_EMBALA').AsFloat  := 3600;
        qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;;
        qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FAR_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
        qryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryDestino.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
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

function TGravandoExecucaoFarbenAutomotivaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoFarbenAutomotivaBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

end.
