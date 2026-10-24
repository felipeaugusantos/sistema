{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta QualyVinil *}
{**********************************************************************PH*}
unit untGravandoExecucaoQualyVinilCores;

interface

uses
  untAbstractGravandoExecucaoQualyVinil, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,System.Variants;

type
  TGravandoExecucaoQualyVinilCores = class(TAbstractGravandoExecucaoQualyVinil)
  Private
    function fRetUnidade(strIdEmb: String): String;
    function fRetQuantidade(fltQuantidade: Double; fltVolumePadrao, fltVolumeBase: Double; intRegistros: Integer; strUnidade: String): Double;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

{ TGravandoExecucaoQualyVinilCores }

procedure TGravandoExecucaoQualyVinilCores.Executar(const gravando: IGravando);
Var
  qryMakCores: TUniQuery;
  qryLocCorantes: TUniQuery;
  qryMakEmbalagem: TUniQuery;
  qryLocBases: TUniQuery;
  qryCadQua: IDataSet;
  strSQL: String;
  intForm: Integer;
  strMd5: String;
begin
  Gravando.Texto := 'Verificando Path...';

  If Not fValidaPath Then
  Begin
    Gravando.Texto := 'Os arquivos de geração não foram encontrado! Rever configurações.';
    Exit;
  End;

  Gravando.Texto := 'Carregando Dados...';

  strSQL := '';
  strSQL := strSQL + '  SELECT                        ';
  strSQL := strSQL + '    B.CODIGO AS BASE,           ';
  strSQL := strSQL + '    C.NOME_COR AS NOMCOR,       ';
  strSQL := strSQL + '    L.DESCR AS PRODUTO,         ';
  strSQL := strSQL + '    F.COR_ID AS DESCRICAO,      ';
  strSQL := strSQL + '    CO.ID_CORANTE AS CORANTE,   ';
  strSQL := strSQL + '    CO.COR_ID AS IDCOR,         ';
  strSQL := strSQL + '    CO.ML AS QUANTIDADE,        ';
  strSQL := strSQL + '    F.ID_EMB AS EMBALAGEM,      ';
  strSQL := strSQL + '    F.ID_BASE AS IDBASE,        ';
  strSQL := strSQL + '    CA.DESCRICAO AS COLECAO,    ';
  strSQL := strSQL + '    E.NOMINAL AS VOLUME_EMB     ';
  strSQL := strSQL + '  FROM                          ';
  strSQL := strSQL + '    FORMULA F                  ';
  strSQL := strSQL + '  INNER JOIN BASES B ON         ';
  strSQL := strSQL + '    F.ID_BASE = B.ID_BASE       ';
  strSQL := strSQL + '  INNER JOIN PADRAOCOR C ON     ';
  strSQL := strSQL + '    F.COR_ID = C.COR_ID         ';
  strSQL := strSQL + '  INNER JOIN LINHA L ON         ';
  strSQL := strSQL + '    F.ID_LINHA = L.ID_LINHA     ';
  strSQL := strSQL + '  INNER JOIN COMPOSICAO CO ON   ';
  strSQL := strSQL + '    F.ID_LINHA = CO.ID_LINHA AND    ';
  strSQL := strSQL + '    F.COR_ID = CO.COR_ID        ';
  strSQL := strSQL + '  INNER JOIN COLECAO CA ON      ';
  strSQL := strSQL + '    F.COLECAO = CA.ID           ';
  strSQL := strSQL + '  INNER JOIN EMBALAGENS E ON    ';
  strSQL := strSQL + '    F.ID_EMB = E.ID_EMB         ';

  qryMakCores := TUniQuery.Create(Nil);
  qryMakCores.Connection := fConexaoQualyVinilMaker;
  qryMakCores.Close;
  qryMakCores.SQL.Clear;
  qryMakCores.SQL.Add(strSQL);
  qryMakCores.Open;

  intForm := 0;

  strSQL := '';
  strSQL := strSQL + '  SELECT                  ';
  strSQL := strSQL + '    CODIGO AS CODCOL,     ';
  strSQL := strSQL + '    ID_CORANTE AS ID      ';
  strSQL := strSQL + '  FROM                    ';
  strSQL := strSQL + '    CORANTES              ';

  qryLocCorantes := TUniQuery.Create(Nil);
  qryLocCorantes.Connection := fConexaoQualyVinilLocal;
  qryLocCorantes.Close;
  qryLocCorantes.SQL.Clear;
  qryLocCorantes.SQL.Add(strSQL);
  qryLocCorantes.Open;

  strSQL := '';
  strSQL := strSQL + '  SELECT          ';
  strSQL := strSQL + '    *             ';
  strSQL := strSQL + '  FROM            ';
  strSQL := strSQL + '    EMBALAGENS    ';

  qryMakEmbalagem := TUniQuery.Create(Nil);
  qryMakEmbalagem.Connection := fConexaoQualyVinilMaker;
  qryMakEmbalagem.Close;
  qryMakEmbalagem.SQL.Clear;
  qryMakEmbalagem.SQL.Add(strSQL);
  qryMakEmbalagem.Open;

  qryMakCores.First;
  qryLocCorantes.First;
  qryMakEmbalagem.First;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('QUA_CADQUA');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  qryCadQua := TAutcomTintaFactory.Get.fGetDataSet;
  Gravando.Texto := 'Deletando Cadastro de Cores...';
  qryCadQua.Close;
  qryCadQua.SQL := '  DELETE FROM QUA_CADQUA';
  qryCadQua.ExecSQL;
  Gravando.Texto := 'Cadastro de Cores deletado...';


  Gravando.Texto := 'Processando Cadastro de Cores...';
  Gravando.RegistrarProgresso(0, 0, 0);

  qryLocBases := TUniQuery.Create(Nil);
  qryLocBases.Connection := fConexaoQualyVinilLocal;

  While Not qryMakCores.Eof Do
  Begin
    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    *                 ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    PRECO_PRODBASE    ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    ID_BASE = :BASE   ';

    qryLocBases.Close;
    qryLocBases.SQL.Clear;
    qryLocBases.SQL.Add(strSQL);
    qryLocBases.ParamByName('BASE').AsString := qryMakCores.FieldByName('IDBASE').AsString;
    qryLocBases.Open;


    While Not qryLocBases.Eof Do
    Begin

      strMd5 := '';
      strMd5 := strMd5 + qryMakCores.FieldByName('BASE').AsString;
      strMd5 := strMd5 + qryMakCores.FieldByName('PRODUTO').AsString;
      strMd5 := strMd5 + qryMakCores.FieldByName('DESCRICAO').AsString;
      strMd5 := strMd5 + qryMakCores.FieldByName('NOMCOR').AsString;
      strMd5 := strMd5 + fRetUnidade(qryLocBases.FieldByName('ID_EMB').AsString);
      strMd5 := GetMD5(strMd5);

      qryCadQua.Close;
      qryCadQua.SQL := '  SELECT * FROM QUA_CADQUA WHERE QUA_MD5KEY = :MD5KEY   ';
      qryCadQua.ParamByName('MD5KEY').AsString := strMd5;
      qryCadQua.Open;

      qryLocCorantes.Locate('ID_CORANTE', VarArrayOf([qryMakCores.FieldByName('CORANTE').AsString]), []);
      qryMakEmbalagem.Locate('ID_EMB', VarArrayOf([qryLocBases.FieldByName('ID_EMB').AsString]), []);

      If qryCadQua.IsEmpty Then
      Begin
        intForm := 1;

        qryCadQua.Insert;
        qryCadQua.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('QUA_CADQUA', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadQua.FieldByName('QUA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadQua.FieldByName('QUA_CODITE').AsString := '';
        qryCadQua.FieldByName('QUA_CODBAS').AsString := qryMakCores.FieldByName('BASE').AsString;
        qryCadQua.FieldByName('QUA_PRODUT').AsString := qryMakCores.FieldByName('PRODUTO').AsString;
        qryCadQua.FieldByName('QUA_NOMCOR').AsString := qryMakCores.FieldByName('NOMCOR').AsString;
        qryCadQua.FieldByName('QUA_DESCRI').AsString := qryMakCores.FieldByName('DESCRICAO').AsString;
        qryCadQua.FieldByName('QUA_CODUNI').AsString := fRetUnidade(qryLocBases.FieldByName('ID_EMB').AsString);
        qryCadQua.FieldByName('QUA_MD5KEY').AsString := strMd5;
        qryCadQua.FieldByName('QUA_COLECA').AsString := qryMakCores.FieldByName('COLECAO').AsString;
        qryCadQua.FieldByName('QUA_ATIVAD').AsString := 'S';
        qryCadQua.FieldByName('QUA_FORM01').AsString := qryLocCorantes.FieldByName('CODCOL').AsString;
        qryCadQua.FieldByName('QUA_QTDB01').AsFloat := fRetQuantidade(qryMakCores.FieldByName('QUANTIDADE').AsFloat,
                                                                      qryMakCores.FieldByName('VOLUME_EMB').AsFloat,
                                                                      qryMakEmbalagem.FieldByName('NOMINAL').AsFloat,
                                                                      qryLocBases.RecordCount,
                                                                      fRetUnidade(qryLocBases.FieldByName('ID_EMB').AsString));
        qryCadQua.Post;
      End
      Else
      Begin
        qryCadQua.Edit;
        qryCadQua.FieldByName('QUA_FORM' + TStrUtils.fStrZero(intForm, 2)).AsString := qryLocCorantes.FieldByName('CODCOL').AsString;
        qryCadQua.FieldByName('QUA_QTDB' + TStrUtils.fStrZero(intForm, 2)).AsFloat  := fRetQuantidade(qryMakCores.FieldByName('QUANTIDADE').AsFloat,
                                                                                                      qryMakCores.FieldByName('VOLUME_EMB').AsFloat,
                                                                                                      qryMakEmbalagem.FieldByName('NOMINAL').AsFloat,
                                                                                                      qryLocBases.RecordCount,
                                                                                                      fRetUnidade(qryLocBases.FieldByName('ID_EMB').AsString));
        qryCadQua.Post;
      End;
      qryLocBases.Next;
    End;

    Inc(intForm);
    Gravando.RegistrarProgresso(0, qryMakCores.RecNo, qryMakCores.RecordCount);
    qryMakCores.Next;
  End;

  FreeAndNil(qryMakCores);
  FreeAndNil(qryLocCorantes);
  FreeAndNil(qryMakEmbalagem);
  FreeAndNil(qryLocBases);
end;

function TGravandoExecucaoQualyVinilCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoQualyVinilCores.fRetQuantidade(fltQuantidade,
  fltVolumePadrao, fltVolumeBase: Double; intRegistros: Integer; strUnidade: String): Double;
begin
  If strUnidade = 'QT' Then
    Result := fltQuantidade / (fltVolumePadrao / fltVolumeBase)
  Else
    Result := fltQuantidade * (fltVolumeBase / fltVolumePadrao);
end;

function TGravandoExecucaoQualyVinilCores.fRetUnidade(strIdEmb: String): String;
begin
  Result := '';

  If strIdEmb = '1' Then
    Result := 'QT'
  Else If Pos(strIdEmb, '2_4_7') > 0 Then
    Result := 'GL'
  Else If Pos(strIdEmb, '3_5_6') > 0 Then
    Result := 'LA';
end;

end.
