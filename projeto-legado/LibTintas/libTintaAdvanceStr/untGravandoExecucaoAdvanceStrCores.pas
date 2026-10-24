{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta AdvanceStr *}
{**********************************************************************PH*}
unit untGravandoExecucaoAdvanceStrCores;

interface

uses
  untAbstractGravandoExecucaoAdvanceStr, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni, DBFUniProvider;

type
  TGravandoExecucaoAdvanceStrCores = class(TAbstractGravandoExecucaoAdvanceStr)
  Private
    intQuantidade: Integer;
    function fRetUnidade(fltEmbalagem: Double): String;
    function fRetFator(fltUniFixa, fltProUni: Double): Double;
    procedure IsDeletarRegistros();
    function fRetLinha(strLinha: String): String;
  Protected
    function GetSqlDestino(): String; override;
    function fGetPath(intContador: Integer; intDiretorio: Integer): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean; override;
    procedure GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery); override;
    procedure EditarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


{ TGravandoExecucaoAdvanceStrCores }

procedure TGravandoExecucaoAdvanceStrCores.EditarRegistro(
  const qryDestino: IDataSet; qryOrigem: TUniQuery);
Var
  fltFator: Double;
begin
  fltFator := fRetFator(3600, qryOrigem.FieldByName('ADS_QTDEMB').AsFloat);

  qryDestino.Edit;
  qryDestino.FieldByName('ADS_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := qryOrigem.FieldByName('ADS_COLORANTE').AsString;
  qryDestino.FieldByName('ADS_QTDC' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat  := qryOrigem.FieldByName('ADS_QUANTIDADE').AsFloat * fltFator;
  qryDestino.Post;
end;

procedure TGravandoExecucaoAdvanceStrCores.Executar(const gravando: IGravando);
var
  qryCores: TUniQuery;
  qryCadCor: IDataSet;
  strSQL: String;
begin
  Try
    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.Texto := 'Carregando Dados do Cadastro de Cores...';
    qryCores := TUniQuery.Create(Nil);
    qryCores.Connection := fConexaoPostgreSQL;

    strSQL := '  SELECT                                                     ' +
              '    FORM.id AS ADS_CODIGO,                                   ' +
              '    FORM.codigo_cor AS ADS_NOMCOR,                           ' +
              '    PRO.descricao_pt AS ADS_PRODUT,                          ' +
              '    CO.descricao as ADS_CODBAS,                              ' +
              '    COL.codigo as ADS_COLORANTE,                             ' +
              '    FC.gramas as ADS_QUANTIDADE,                             ' +
              '    PRO.tipo AS ADS_LINHA_,                                  ' +
              '    EMB.capacidade_ml AS ADS_QTDEMB,                         ' +
              '    EMB.descricao_pt AS ADS_DESEMB                           ' +
              '  FROM                                                       ' +
              '    formula AS FORM                                          ' +
              '  INNER JOIN produto AS PRO ON                               ' +
              '    PRO.id = FORM.id_produto                                 ' +
              '  INNER JOIN componente AS CO ON                             ' +
              '    CO.id_produto = PRO.id                                   ' +
              '  INNER JOIN formula_composicao AS FC ON                     ' +
              '    FC.id_formula = FORM.id                                  ' +
              '  INNER JOIN componente as COL ON                            ' +
              '    COL.id = fc.id_componente                                ' +
              '  INNER JOIN embalagem AS EMB ON                             ' +
              '    FORM.id_fabricante = EMB.id_fabricante                   ' +
              '  ORDER BY FC.id_formula, EMB.descricao_pt, FC.ordem;        ';

    qryCores.Close;
    qryCores.SQL.Clear;
    qryCores.SQL.Add(strSQL);
    qryCores.Open;

    If qryCores.IsEmpty Then
    Begin
      Gravando.Texto := 'O cadastro de Cores está vazio! Verificar.';
      Exit;
    End;

    Gravando.Texto := 'Deletando Cadastro de Cores...';
    IsDeletarRegistros();
    Gravando.Texto := 'Cadastro de Cores deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('ADS_CADADS');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    Gravando.Texto := 'Abrindo Cadastro de Cores...';
    qryCadCor := GetDataSetDestino();

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.RegistrarProgresso(0, 0, 0);
    qryCores.First;

    Try
      While Not qryCores.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not IsRegistroExistente(qryCadCor, qryCores) Then
          GravarRegistro(qryCadCor, qryCores)
        Else
          EditarRegistro(qryCadCor, qryCores);

        qryCores.Next;
        Inc(intQuantidade);
        Gravando.RegistrarProgresso(0, qryCores.RecNo, qryCores.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryCores) Then
      FreeAndNil(qryCores);
  End;
end;

function TGravandoExecucaoAdvanceStrCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoAdvanceStrCores.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATADS');
end;

function TGravandoExecucaoAdvanceStrCores.fRetFator(fltUniFixa,
  fltProUni: Double): Double;
begin
  Result := fltProUni / fltUniFixa;
end;

function TGravandoExecucaoAdvanceStrCores.fRetLinha(strLinha: String): String;
begin
  Result := '';

  If strLinha = 'FC' Then
    Result := 'LINHA DE FROTAS'
  Else If strLinha = 'MAX' Then
    Result := 'LINHA ADMAX'
  Else If strLinha = 'STR' Then
    Result := 'LINHA INDUSTRIAL';
end;

function TGravandoExecucaoAdvanceStrCores.fRetUnidade(fltEmbalagem: Double): String;
begin
  If fltEmbalagem < 1000 Then
    Result := 'QT'
  Else If fltEmbalagem < 5000 Then
    Result := 'GL'
  Else If fltEmbalagem < 18001 Then
    Result := 'LA'
  Else
    Result := 'BD';
end;

function TGravandoExecucaoAdvanceStrCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM ADS_CADADS';
end;

procedure TGravandoExecucaoAdvanceStrCores.GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery);
Var
  fltFator: Double;
begin
  intQuantidade := 1;
  fltFator := fRetFator(3600, qryOrigem.FieldByName('ADS_QTDEMB').AsFloat);

  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADS_CADADS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('ADS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('ADS_CODIGO').AsString := qryOrigem.FieldByName('ADS_CODIGO').AsString;
  qryDestino.FieldByName('ADS_NOMCOR').AsString := qryOrigem.FieldByName('ADS_NOMCOR').AsString;
  qryDestino.FieldByName('ADS_DESCRI').AsString := qryOrigem.FieldByName('ADS_NOMCOR').AsString;
  qryDestino.FieldByName('ADS_CODBAS').AsString := qryOrigem.FieldByName('ADS_CODBAS').AsString;
  qryDestino.FieldByName('ADS_UNIDAD').AsString := fRetUnidade(qryOrigem.FieldByName('ADS_QTDEMB').AsFloat);
  qryDestino.FieldByName('ADS_PRODUT').AsString := qryOrigem.FieldByName('ADS_PRODUT').AsString;
  qryDestino.FieldByName('ADS_LINHA_').AsString := fRetLinha(qryOrigem.FieldByName('ADS_LINHA_').AsString);
  qryDestino.FieldByName('ADS_FORM01').AsString := qryOrigem.FieldByName('ADS_COLORANTE').AsString;
  qryDestino.FieldByName('ADS_QTDC01').AsFloat  := qryOrigem.FieldByName('ADS_QUANTIDADE').AsFloat * fltFator;
  qryDestino.FieldByName('ADS_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('ADS_CODIGO').AsString +
                                                          qryDestino.FieldByName('ADS_NOMCOR').AsString +
                                                          qryDestino.FieldByName('ADS_CODBAS').AsString +
                                                          qryDestino.FieldByName('ADS_UNIDAD').AsString +
                                                          qryDestino.FieldByName('ADS_PRODUT').AsString +
                                                          qryDestino.FieldByName('ADS_LINHA_').AsString);
  qryDestino.Post;
end;

procedure TGravandoExecucaoAdvanceStrCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM ADS_CADADS        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoAdvanceStrCores.IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := qryDestino.Locate('ADS_CODIGO;ADS_NOMCOR;ADS_CODBAS;ADS_UNIDAD;ADS_PRODUT;ADS_LINHA_', VarArrayOf([
    qryOrigem.FieldByName('ADS_CODIGO').AsString, qryOrigem.FieldByName('ADS_NOMCOR').AsString, qryOrigem.FieldByName('ADS_CODBAS').AsString,
    fRetUnidade(qryOrigem.FieldByName('ADS_QTDEMB').AsFloat), qryOrigem.FieldByName('ADS_PRODUT').AsString, fRetLinha(qryOrigem.FieldByName('ADS_LINHA_').AsString)]), []);
end;

end.

