{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta MazaAutomotiva *}
{***********************************************************************AC*}
unit untGravandoExecucaoMazaAutomotivaCores;

interface

uses
  untAbstractGravandoExecucaoMazaAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni;
type
  TGravandoExecucaoMazaAutomotivaCores = class(TAbstractGravandoExecucaoMazaAutomotiva)
  Private
    function fRetornaDtaFor(strDta: String): String;
    procedure CalculaPesForPesCor(const gravando: IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

{ TGravandoExecucaoMazaAutomotivaCores }

procedure TGravandoExecucaoMazaAutomotivaCores.CalculaPesForPesCor(const gravando: IGravando);
Var
  qryCadCor: IDataSet;
  qryCadBas: IDataSet;
  intContador: Integer;
  fltPesoFor,
  fltPesoCor: Double;
  fltPesoCorBase: Double;
begin
  qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadCor.SQL := '  SELECT * FROM MZA_CADMZA    ';
  qryCadCor.Open;

  qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadBas.SQL := '  SELECT * FROM MZA_CADBAS  ';
  qryCadBas.Open;


  While Not qryCadCor.Eof Do
  Begin
    fltPesoFor := 0;
    fltPesoCor := 0;

    qryCadCor.Edit;

    For intContador := 1 To 20 Do
    Begin
      If TStrUtils.fEmptyStr(qryCadCor.FieldByName('MZA_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Break;

      fltPesoFor := fltPesoFor + qryCadCor.FieldByName('MZA_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    End;

    qryCadCor.FieldByName('MZA_PESFOR').AsFloat := fltPesoFor;

    For intContador := 1 To 20 Do
    Begin
      If TStrUtils.fEmptyStr(qryCadCor.FieldByName('MZA_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Break;

      If Not qryCadBas.Locate('BAS_CODBAS', qryCadCor.FieldByName('MZA_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString, []) Then
        Break;

      fltPesoCorBase := (qryCadCor.FieldByName('MZA_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat / fltPesoFor) * qryCadBas.FieldByName('BAS_PESESP').AsFloat;
      fltPesoCor := fltPesoCor + fltPesoCorBase;
    End;

    qryCadCor.FieldByName('MZA_PESCOR').AsFloat := fltPesoCor;
    qryCadCor.Post;

    qryCadCor.Next;
    Gravando.RegistrarProgresso(0, qryCadCor.RecNo, qryCadCor.RecordCount);
  End;
end;

procedure TGravandoExecucaoMazaAutomotivaCores.Executar(const gravando: IGravando);
var
  qryCadCor: IDataSet;
  qryCores: TUniQuery;
  strSQL: String;
  strMd5: String;
  intQuantidade: Integer;
begin
  If (Gravando.Status <> sgGravando) Then
    Exit;

  intQuantidade := 1;

  strSQL := '';
  strSQL := strSQL + '  SELECT          ';
  strSQL := strSQL + '    fc.id_formula AS IDFORMULA,     ';
  strSQL := strSQL + '    fc.id_componente AS IDBASE,     ';
  strSQL := strSQL + '    fc.ordem AS ORDEM,              ';
  strSQL := strSQL + '    fc.gramas AS QUANTIDADE,        ';
  strSQL := strSQL + '    co.codigo AS CODBASE,           ';
  strSQL := strSQL + '    FORM.codigo_oem AS CODOEM,      ';
  strSQL := strSQL + '    var.descricao_pt AS VARIAN,     ';
  strSQL := strSQL + '    FORM.descricao_cor AS DESCOR,   ';
  strSQL := strSQL + '    FORM.codigo_cor AS CODCOR,      ';
  strSQL := strSQL + '    FORM.data_atualizada AS DTAATU, ';
  strSQL := strSQL + '    FORM.ano_inicio AS ANOCOR,      ';
  strSQL := strSQL + '    fpc.tag_codigo AS CODMON,       ';
  strSQL := strSQL + '    PRO.descricao_pt AS DESLIN,     ';
  strSQL := strSQL + '    PRO.codigo_produto AS SIGLIN    ';
  strSQL := strSQL + '  FROM formula_composicao AS fc           ';
  strSQL := strSQL + '  INNER JOIN componente AS co ON          ';
  strSQL := strSQL + '    co.id = fc.id_componente        ';
  strSQL := strSQL + '  INNER JOIN formula AS FORM ON           ';
  strSQL := strSQL + '    FORM.id = fc.id_formula         ';
  strSQL := strSQL + '  INNER JOIN produto AS PRO ON            ';
  strSQL := strSQL + '    PRO.id = FORM.id_produto        ';
  strSQL := strSQL + '  INNER JOIN fabricante_padraocor AS fpc ON       ';
  strSQL := strSQL + '    fpc.id = FORM.id_fabricante_padraocor   ';
  strSQL := strSQL + '  INNER JOIN variante AS var ON     ';
  strSQL := strSQL + '    var.id = FORM.id_variante             ';
  strSQL := strSQL + '  WHERE PRO.tipo = ''AUTOMOTIVA''         ';
  strSQL := strSQL + '  ORDER BY fc.id_formula, fc.ordem;       ';

  Gravando.Texto := 'Carregando dados do Cadastro de Cores...';
  qryCores := TUniQuery.Create(Nil);
  qryCores.Connection := fConexaoPostgreSQL;
  qryCores.Close;
  qryCores.SQL.Clear;
  qryCores.SQL.Add(strSQL);
  qryCores.Open;
  qryCores.First;

  If qryCores.IsEmpty Then
  Begin
    Gravando.Texto := 'O cadastro de cores está vazio. Verificar!';
    Exit;
  End;

  Gravando.Texto := 'Deletando Cadastro de Cores...';
  qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadCor.SQL := '  DELETE FROM MZA_CADMZA   ';
  qryCadCor.ExecSQL;
  qryCadCor.SQL.Empty;
  Gravando.Texto := 'Cadastro de Cores deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('MZA_CADMZA');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Cores...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    While Not qryCores.Eof Do
    Begin
      strMd5 := '';
      strMd5 := strMd5 + qryCores.FieldByName('CODCOR').AsString;
      strMd5 := strMd5 + qryCores.FieldByName('VARIAN').AsString;
      strMd5 := strMd5 + qryCores.FieldByName('DESCOR').AsString;
      strMd5 := strMd5 + qryCores.FieldByName('ANOCOR').AsString;
      strMd5 := strMd5 + fRetornaDtaFor(qryCores.FieldByName('DTAATU').AsString);
      strMd5 := strMd5 + qryCores.FieldByName('SIGLIN').AsString;
      strMd5 := strMd5 + qryCores.FieldByName('CODMON').AsString;
      strMd5 := strMd5 + '';
      strMd5 := strMd5 + qryCores.FieldByName('CODOEM').AsString;
      strMd5 := GetMD5(strMd5);

      qryCadCor.Close;
      qryCadCor.SQL := '  SELECT * FROM MZA_CADMZA WHERE MZA_MD5KEY = :MD5KEY ';
      qryCadCor.ParamByName('MD5KEY').AsString := strMd5;
      qryCadCor.Open;

      If qryCadCor.IsEmpty Then
      Begin
        intQuantidade := 1;

        qryCadCor.Insert;
        qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MZA_CADMZA', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadCor.FieldByName('MZA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadCor.FieldByName('MZA_CODIGO').AsString := qryCores.FieldByName('CODCOR').AsString;
        qryCadCor.FieldByName('MZA_VARIAC').AsString := qryCores.FieldByName('VARIAN').AsString;
        qryCadCor.FieldByName('MZA_DESCRI').AsString := qryCores.FieldByName('DESCOR').AsString;
        qryCadCor.FieldByName('MZA_ANOCOR').AsString := qryCores.FieldByName('ANOCOR').AsString;
        qryCadCor.FieldByName('MZA_CODMON').AsString := qryCores.FieldByName('CODMON').AsString;
        qryCadCor.FieldByName('MZA_LINHA_').AsString := qryCores.FieldByName('SIGLIN').AsString;
        qryCadCor.FieldByName('MZA_DTAFOR').AsString := fRetornaDtaFor(qryCores.FieldByName('DTAATU').AsString);
        qryCadCor.FieldByName('MZA_UNIVER').AsString := qryCores.FieldByName('CODOEM').AsString;
        qryCadCor.FieldByName('MZA_CODNFM').AsString := '';
        qryCadCor.FieldByName('MZA_BAIQDI').AsString := 'N';
        qryCadCor.FieldByName('MZA_ATIVAD').AsString := 'S';
        qryCadCor.FieldByName('MZA_MD5KEY').AsString := strMd5;
        qryCadCor.FieldByName('MZA_FORM01').AsString := qryCores.FieldByName('CODBASE').AsString;
        qryCadCor.FieldByName('MZA_QTDC01').AsFloat := qryCores.FieldByName('QUANTIDADE').AsFloat;
        qryCadCor.Post;
      End
      Else
      Begin
        Inc(intQuantidade, 1);

        qryCadCor.Edit;
        qryCadCor.FieldByName('MZA_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := qryCores.FieldByName('CODBASE').AsString;
        qryCadCor.FieldByName('MZA_QTDC' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat := qryCores.FieldByName('QUANTIDADE').AsFloat;
        qryCadCor.Post;
      End;

      qryCores.Next;
      Gravando.RegistrarProgresso(0, qryCores.RecNo, qryCores.RecordCount);
    End;

    Gravando.Texto := 'Processando Pesos Cor/Formula...';
    CalculaPesForPesCor(Gravando);
  Finally
    FreeAndNil(qryCores);
  End;
End;

function TGravandoExecucaoMazaAutomotivaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoMazaAutomotivaCores.fRetornaDtaFor(
  strDta: String): String;
Var
  strDtaAtual: String;
  strDtaNova : String;
begin
  strDtaAtual := Copy(strDta, 1, 10);
  strDtaNova :=  Copy(strDtaAtual, 7, 4) + Copy(strDtaAtual, 4, 2) + Copy(strDtaAtual, 1, 2);

  Result := strDtaNova;
end;


end.
