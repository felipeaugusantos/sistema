{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta suvinil *}
{**********************************************************************PH*}
unit untGravandoExecucaoSuvinilBases;

interface

uses
  untAbstractGravandoExecucaoSuvinil, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando;

type
  TGravandoExecucaoSuvinilBases = class(TAbstractGravandoExecucaoSuvinil)
  Private
    procedure pRemoveAcento();
  public
    function IsNotRegistroExiste(qryDestino: IDataSet; qryBases: TADODataSet; qryEmbalagens: TADODataSet; qryProBases: TADODataSet;
      qryProdutos: TADODataSet): Boolean;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fHabilitaOpcao(): Boolean; Override;
  end;

implementation

{ TGravandoExecucaoSuvinilBases }

procedure TGravandoExecucaoSuvinilBases.Executar(const gravando: IGravando);
var
  qryDestino: IDataSet;
begin
  Try
    Try
      CriarObjetos;

      gravando.Texto := 'Carregando dados...';
      
      CarregarDadosBases;
      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := 'SELECT * FROM SUV_CADBAS';
      qryDestino.Open;

      qryProdutos.DataSource := dsProdutosBasesEmbalagens;
      qryProdutos.MasterFields := 'COD_PRODUTO';

      qryEmbalagens.DataSource := dsProdutosBasesEmbalagens;
      qryEmbalagens.MasterFields := 'COD_EMBALAGEM';

      qryBases.DataSource := dsProdutosBasesEmbalagens;
      qryBases.MasterFields := 'COD_BASE';

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SUV_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryProdutosBasesEmbalagens.First;
      while (not qryProdutosBasesEmbalagens.Eof) and (gravando.Status = sgGravando) do
      begin
        Try
          Try
            If IsNotRegistroExiste(qryDestino, qryBases, qryEmbalagens, qryProdutosBasesEmbalagens, qryProdutos) Then
            begin
              qryDestino.Insert;
              qryDestino.FieldByName('SUV_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SUV_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
              qryDestino.FieldByName('SUV_CODFML').AsString := qryProdutosBasesEmbalagens.FieldByName('COD_PRODUTO').AsString;
              qryDestino.FieldByName('SUV_CODBAS').AsString := qryBases.FieldByName('DES_BASE').AsString;
              qryDestino.FieldByName('SUV_DESCRI').AsString := AnsiUpperCase(qryProdutos.FieldByName('DES_PRODUTO').AsString);
              qryDestino.FieldByName('SUV_CODUNI').AsString := GetUnidade(qryEmbalagens.FieldByName('VOLUME').AsFloat);
              qryDestino.Post;
            end;

          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          gravando.RegistrarProgresso(0, qryProdutosBasesEmbalagens.RecNo, qryProdutosBasesEmbalagens.RecordCount);
          qryProdutosBasesEmbalagens.Next;
        End;
      end;

      Gravando.Texto := 'Removendo acentos...';
      pRemoveAcento;




    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
     DestruirObjetos;
  End;
end;

function TGravandoExecucaoSuvinilBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoSuvinilBases.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoSuvinilBases.IsNotRegistroExiste(qryDestino: IDataSet;
  qryBases, qryEmbalagens, qryProBases, qryProdutos: TADODataSet): Boolean;
begin
  Result := (Not qryDestino.Locate('SUV_CODFML;SUV_CODBAS;SUV_CODUNI',
    VarArrayOf([qryProBases.FieldByName('COD_PRODUTO').AsString, qryBases.FieldByName('DES_BASE').AsString,
      GetUnidade(qryEmbalagens.FieldByName('VOLUME').AsFloat)]), [])) And (Pos(qryBases.FieldByName('SITUACAO').AsString, 'A_a_') > 0) And
      (Pos(qryEmbalagens.FieldByName('SITUACAO').AsString, 'A_a_') > 0) And (Pos(qryProBases.FieldByName('SITUACAO').AsString, 'A_a_') > 0) And
      (Pos(qryProdutos.FieldByName('SITUACAO').AsString, 'A_a_') > 0);
end;

procedure TGravandoExecucaoSuvinilBases.pRemoveAcento;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '  UPDATE           ' +
                '   SUV_CADBAS      ' +
                '  SET              ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Á'', ''A''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Â'', ''A''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ã'', ''A''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ç'', ''C''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''É'', ''E''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ê'', ''E''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Í'', ''I''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ñ'', ''N''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ó'', ''O''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ô'', ''O''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Õ'', ''O''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ú'', ''U''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ü'', ''U''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''á'', ''a''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''â'', ''a''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ã'', ''a''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ç'', ''c''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''é'', ''e''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ê'', ''e''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''í'', ''i''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ñ'', ''n''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ó'', ''o''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ô'', ''o''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''õ'', ''o''), ' +
                '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ú'', ''u''); ';

  qryGen.ExecSQL;
end;

end.
