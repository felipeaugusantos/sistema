{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta AlterPlus *}
{**********************************************************************PH*}
unit untGravandoExecucaoAlterPlusBases;

interface

uses
  untAbstractGravandoExecucaoAlterPlus, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando,ComObj, Dialogs, Classes, untStrUtils;

type
  TGravandoExecucaoAlterPlusBases = class(TAbstractGravandoExecucaoAlterPlus)
  private
    function fRetornaUnidade(fltEmbalagem: Double): String;
    function fVerificaBase(qryDestino: IDataSet; strBase: String): Boolean;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoAlterPlusBases }

procedure TGravandoExecucaoAlterPlusBases.Executar(const gravando: IGravando);
var
  qryDestino : IDataSet;
  Conexao    : TADOConnection;
  Table      : TADODataSet;
  strCodUni  : String;
begin
  Try
    gravando.Texto := 'Validando Path de Arquivos ...';

    If (Not fValidaPath) Then
    Begin
      gravando.Texto := 'Path para o geração do arquivo de Colorantes não é válido...';
      gravando.Cancelar;
      Exit;
    End;

    gravando.Texto := 'Path validado com sucesso ...';

    gravando.Texto := 'Carregando dados...';

    gravando.Texto := 'Dados carregados com sucesso!';

    gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('ALP_CADBAS');
    gravando.Texto := 'PROCOD verificado com sucesso!';

    if gravando.Status <> sgGravando then
      Exit;

    Try
      Conexao                  := TADOConnection.Create(nil);
      Conexao.LoginPrompt      := False;
      Conexao.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;' +
                                  'Data Source=' + GetPath + ';' + 'Persist Security Info=False;' +
                                  'Jet OLEDB:Database Password=flordavida64836082';
      Conexao.Open;

      Table := TADODataSet.Create(nil);
      Table.Connection := Conexao;

      Table.CommandText := ' SELECT A.COD_BASE     '+
                           '      , A.NM_BASE      '+
                           '      , C.COD_PRODUTO  '+
                           '      , C.NM_PRODUTO   '+
                           '      , E.NU_EMBALAGEM '+
                           '   FROM TB_BASE              A '+
                           '      , TB_PRODUTO_BASE      B '+
                           '      , TB_PRODUTO           C '+
                           '      , TB_PRODUTO_EMBALAGEM D '+
                           '      , TB_TIPO_EMBALAGEM    E '+
                           ' WHERE A.COD_BASE            = B.COD_BASE      '+
                           '    AND C.COD_PRODUTO        = B.COD_PRODUTO   '+
                           '    AND D.COD_PRODUTO        = C.COD_PRODUTO   '+
                           '    AND E.COD_TIPO_EMBALAGEM = D.COD_EMBALAGEM ';

      gravando.Texto := 'Carregando os registros do arquivo... !';

      Table.Open;
      Table.First;

      While not (Table.Eof) do
      begin
        strCodUni := fRetornaUnidade(Table.FieldByName('NU_EMBALAGEM').AsFloat);



        qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
        qryDestino.Close;
        qryDestino.SQL := 'SELECT * '+
                          '  FROM ALP_CADBAS '+
                          ' WHERE BAS_CODBAS = :CODBAS '+
                          '   AND BAS_CODUNI = :CODUNI '+
                          '   AND BAS_CODEMP = :CODEMP '+
                          '   AND BAS_DESCRI = :DESCRI '+
                          '   AND BAS_PRODUT = :PRODUT ';

        qryDestino.ParamByName('CODBAS').AsString := Trim(Table.FieldByName('COD_BASE').AsString);
        qryDestino.ParamByName('CODUNI').AsString := strCodUni;
        qryDestino.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryDestino.ParamByName('DESCRI').AsString := AnsiUpperCase(Table.FieldByName('NM_BASE').AsString);
        qryDestino.ParamByName('PRODUT').AsString := AnsiUpperCase(Table.FieldByName('NM_PRODUTO').AsString);

        qryDestino.Open;

        If fVerificaBase(qryDestino, Table.FieldByName('NM_BASE').AsString) Then
        Begin
          qryDestino.Insert;
          qryDestino.FieldByName('BAS_CODBAS').AsString := Trim(Table.FieldByName('COD_BASE').AsString);
          qryDestino.FieldByName('BAS_CODUNI').AsString := strCodUni;
          qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryDestino.FieldByName('BAS_DESCRI').AsString := AnsiUpperCase(Table.FieldByName('NM_BASE').AsString);
          qryDestino.FieldByName('BAS_PRODUT').AsString := AnsiUpperCase(Table.FieldByName('NM_PRODUTO').AsString);
          qryDestino.FieldByName('BAS_EMBALA').AsFloat  := Table.FieldByName('NU_EMBALAGEM').AsFloat;
          qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALP_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryDestino.Post;
        End;

        gravando.RegistrarProgresso(0, Table.RecNo, Table.RecordCount);

        Table.Next;
      end;

    except
      on e : Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    end;

  finally
    FreeAndNil(Conexao);
    FreeAndNil(Table);
  end;

end;

function TGravandoExecucaoAlterPlusBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoAlterPlusBases.fRetornaUnidade(
  fltEmbalagem: Double): String;
begin
  if fltEmbalagem <= 0.9 then
    Result := 'LT'
  else if (fltEmbalagem <= 5.8) then
    Result := 'GL'
  else
    Result := 'LA';
end;

function TGravandoExecucaoAlterPlusBases.fVerificaBase(qryDestino: IDataSet;
  strBase: String): Boolean;
begin
  Result := False;

  If qryDestino.IsEmpty Then
  Begin
    If Not TStrUtils.fEmptyStr(strBase) Then
      Result := True;
  End;
end;

end.
