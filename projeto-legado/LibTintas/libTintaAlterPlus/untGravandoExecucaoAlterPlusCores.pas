{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta AlterPlus *}
{**********************************************************************PH*}
unit untGravandoExecucaoAlterPlusCores;

interface

uses
  untAbstractGravandoExecucaoAlterPlus, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  ADODB, Dialogs, Classes, untFloatUtils;



type
  TGravandoExecucaoAlterPlusCores = class(TAbstractGravandoExecucaoAlterPlus)
  Private
    procedure DeletarMd5KeyDuplicado(Gravando :IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fConverterQuantidade(strValor : String) : double;
    function fRetUnidade(fltEmbalagem : Double ) : String;
    function fRetFatorUnidade(strCodUni : String ) : Integer;
  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoAlterPlusCores }


procedure TGravandoExecucaoAlterPlusCores.DeletarMd5KeyDuplicado(
  Gravando: IGravando);
Var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD, ' +
                '        ALP_MD5KEY       ' +
                '   FROM ALP_CADALP       ' +
                '  GROUP BY ALP_MD5KEY    ' +
                ' HAVING COUNT(*) > 1     ';

  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo arquivos duplicados ALP_CADALP...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE '+
                    '   FROM ALP_CADALP ' +
                    '  WHERE ALP_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('ALP_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
      qryGen.Next;
    End;


  End;
end;

procedure TGravandoExecucaoAlterPlusCores.Executar(const gravando: IGravando);
var
  qryDestino    : IDataSet;
  Conexao       : TADOConnection;
  TblCor        : TADODataSet;
  TblCol        : TADOQuery;
begin
  Try
    gravando.Texto := 'Validando Path de Arquivos ...';

    If (Not fValidaPath) Then
    Begin
      gravando.Texto := 'Path para o geração do arquivo de cores não é válido...';
      gravando.Cancelar;
      Exit;
    End;

    gravando.Texto := 'Path validado com sucesso ...';

    gravando.Texto := 'Carregando dados...';

    gravando.Texto := 'Dados carregados com sucesso!';

    gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('ALP_CADALP');
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

      TblCor := TADODataSet.Create(nil);

      TblCor.Connection := Conexao;
      TblCor.CommandText := ' SELECT A.COD_COR_FORMULACAO '+
                            '      , A.COD_REFERENCIA '+
                            '      , A.COD_COR '+
                            '      , B.COD_NM_COR '+
                            '      , B.NM_REF_CORII AS NOMCOR   ' +
                            '      , A.COD_COLECAO '+
                            '      , C.NM_COLECAO '+
                            '      , A.COD_PRODUTO '+
                            '      , D.NM_PRODUTO '+
                            '      , A.COD_BASE '+
                            '      , E.NM_BASE '+
                            '      , A.COD_REFERENCIA '+
                            '      , F.NM_REFERENCIA '+
                            '      , A.COD_EMBALAGEM '+
                            '      , H.NU_EMBALAGEM '+
                            '   FROM TB_COR_FORMULACAO A '+
                            '      , TB_COR B '+
                            '      , TB_COLECAO C '+
                            '      , TB_PRODUTO D '+
                            '      , TB_BASE    E '+
                            '      , TB_REFERENCIA F '+
                            '      , TB_PRODUTO_EMBALAGEM G '+
                            '      , TB_TIPO_EMBALAGEM H '+
                            '  WHERE B.COD_COR            = A.COD_COR '+
                            '    AND C.COD_COLECAO        = A.COD_COLECAO '+
                            '    AND D.COD_PRODUTO        = A.COD_PRODUTO '+
                            '    AND E.COD_BASE           = A.COD_BASE '+
                            '    AND F.COD_REFERENCIA     = A.COD_REFERENCIA '+
                            '    AND G.COD_PRODUTO        = A.COD_PRODUTO '+
                            '    AND H.COD_TIPO_EMBALAGEM = G.COD_EMBALAGEM'+
                            '  ORDER BY A.COD_COR_FORMULACAO'+
                            '         , B.COD_NM_COR'+
                            '         , A.COD_PRODUTO';
      TblCor.Open;



      TblCor.First;

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Cadastro de Cores...';
      qryDestino.SQL := ' DELETE FROM ALP_CADALP  ';
      qryDestino.ExecSQL;
      Gravando.Texto := 'Cadastro de Cores deletado com sucesso...';


      gravando.Texto := 'Carregando os registros do arquivo de cores...';


      TblCol := TADOQuery.Create(Nil);
      TblCol.Connection := Conexao;

      qryDestino.Close;
      qryDestino.SQL := 'SELECT * FROM ALP_CADALP WHERE FALSE';
      qryDestino.Open;


      While not (TblCor.Eof) do
      begin
        qryDestino.Insert;
        qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALP_CADALP', TAutcomTintaFactory.Get.GetCodEmp);
        qryDestino.FieldByName('ALP_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryDestino.FieldByName('ALP_CODIGO').AsString := TblCor.FieldByName('COD_COR_FORMULACAO').AsString;
        qryDestino.FieldByName('ALP_DTACAD').AsDate   := Date;
        qryDestino.FieldByName('ALP_COLECA').AsString := AnsiUpperCase(TblCor.FieldByName('NM_COLECAO').AsString);
        qryDestino.FieldByName('ALP_PRODUT').AsString := AnsiUpperCase(TblCor.FieldByName('NM_PRODUTO').AsString);
        qryDestino.FieldByName('ALP_CODBAS').AsString := AnsiUpperCase(TblCor.FieldByName('COD_BASE').AsString);
        qryDestino.FieldByName('ALP_CODUNI').AsString := fRetUnidade(TblCor.FieldByName('NU_EMBALAGEM').AsFloat);
        qryDestino.FieldByName('ALP_DESCRI').AsString := AnsiUpperCase(TblCor.FieldByName('COD_NM_COR').AsString);
        qryDestino.FieldByName('ALP_REFERE').AsString := AnsiUpperCase(TblCor.FieldByName('NM_REFERENCIA').AsString);
        qryDestino.FieldByName('ALP_NOME__').AsString := AnsiUpperCase(TblCor.FieldByName('NOMCOR').AsString);

        // Colorantes
        TblCol.Close;
        TblCol.SQL.Text   := 'SELECT DISTINCT '+
                             '       NM_CANISTER         AS COLORANTE '+
                             '     , VL_QTDE             AS QUANTIDADE '+
                             '     , COD_COR_FORMULACAO  AS CODIGO '+
                             '     , COD_ORDEM           As ORDEM '+
                             '  FROM TB_COR_DOSAGEM A '+
                             '     , TB_CANISTER    B '+
                             ' WHERE COD_COR_FORMULACAO = :COD_FORMULACAO '+
                              '  AND A.COD_STATUS       <> 2    '+
                              '  AND A.COD_CANISTER     = B.COD_CANISTER '+
                             ' ORDER BY COD_COR_FORMULACAO '+
                             '        , COD_ORDEM ';

        TblCol.Parameters.ParamByName('COD_FORMULACAO').Value := TblCor.FieldByName('COD_COR_FORMULACAO').Value;
        TblCol.Open;

        TblCol.First;

        While not TblCol.Eof Do
        Begin
          qryDestino.FieldByName('ALP_FORM' + TStrUtils.fStrZero(TblCol.RecNo, 2)).AsString := AnsiUpperCase(TblCol.FieldByName('COLORANTE').AsString);

          qryDestino.FieldByName('ALP_QTDC' + TStrUtils.fStrZero(TblCol.RecNo, 2)).AsFloat  :=
            TblCol.FieldByName('QUANTIDADE').AsFloat * fRetFatorUnidade(qryDestino.FieldByName('ALP_CODUNI').AsString) ;

          TblCol.Next;
        End;

        qryDestino.FieldByName('ALP_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('ALP_CODEMP').AsString +
                                                                qryDestino.FieldByName('ALP_CODIGO').AsString +
                                                                qryDestino.FieldByName('ALP_DTACAD').AsString +
                                                                qryDestino.FieldByName('ALP_COLECA').AsString +
                                                                qryDestino.FieldByName('ALP_PRODUT').AsString +
                                                                qryDestino.FieldByName('ALP_CODBAS').AsString +
                                                                qryDestino.FieldByName('ALP_CODUNI').AsString +
                                                                qryDestino.FieldByName('ALP_DESCRI').AsString );
        qryDestino.Post;

        gravando.RegistrarProgresso(0, TblCor.RecNo, TblCor.RecordCount);

        TblCor.Next;
      end;

      DeletarMd5KeyDuplicado(Gravando);

    except
      on e : Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    end;

  finally
    FreeAndNil(Conexao);
    FreeAndNil(TblCor);
    FreeAndNil(TblCol);
  end;

end;


function TGravandoExecucaoAlterPlusCores.fConverterQuantidade(strValor: String): Double;
begin
  Result := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(strValor, '.', ','));
  Result := TFloatUtils.fFormataFloat(Result,4);
end;


function TGravandoExecucaoAlterPlusCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoAlterPlusCores.fRetFatorUnidade(strCodUni: String): Integer;
begin
  If strCodUni = 'LT' Then
    Result := 1
  else if strCodUni = 'GL' Then
    Result := 4
  else
    Result := 20;
end;


function TGravandoExecucaoAlterPlusCores.fRetUnidade(fltEmbalagem: Double): String;
begin
  if fltEmbalagem <= 0.9 then
    Result := 'LT'
  else if (fltEmbalagem <= 5.8) then
    Result := 'GL'
  else
    Result := 'LA';
end;

end.
