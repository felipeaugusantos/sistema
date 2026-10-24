{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Lukscolor2 *}
{*******************************************************************************PH*}
unit untGravandoExecucaoLukscolor2NovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoLukscolor2NovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fGetUnidadesGeracaoCadNfm(strUnidade:String):String;
    function fFatorUnidade(fltUniOri: Double; fltUniAtu: Double): Double;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoLukscolor2NovasFormulas }

constructor TGravandoExecucaoLukscolor2NovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoLukscolor2NovasFormulas.Executar(const gravando: IGravando);
Var
  qryCadNfm, qryBases, qryCadLkc: IDataSet;
  intContador: Integer;
  fltFator: Double;
begin
  Try
    Try

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando Dados...';

      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadLkc := TAutcomTintaFactory.Get.fGetDataSet;
      qryBases  := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '  SELECT  * FROM LKC_CADNFM       ';
      qryCadLkc.SQL := '  DELETE FROM LKC_CADLKC          ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);
        qryCadLkc.SQL := qryCadLkc.SQL + ' WHERE LKC_CODIGO = ' + QuotedStr(strCodNfm);
      End
      Else
      Begin
        qryCadLkc.SQL := qryCadLkc.SQL + ' WHERE LKC_CODIGO LIKE ''%ESP%''  ';
      End;

      qryCadLkc.ExecSQL;

      qryCadLkc.SQL := '';
      qryCadLkc.SQL := '    SELECT * FROM LKC_CADLKC WHERE FALSE      ';
      qryCadLkc.Open;
      qryCadNfm.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LKC_CADLKC');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      While Not qryCadNfm.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryBases.Close;
        qryBases.SQL := '';
        qryBases.SQL := qryBases.SQL + '  SELECT              ';
        qryBases.SQL := qryBases.SQL + '    *                 ';
        qryBases.SQL := qryBases.SQL + '  FROM                ';
        qryBases.SQL := qryBases.SQL + '    LKC_CADBAS        ';
        qryBases.SQL := qryBases.SQL + '  INNER JOIN CADITE ON        ';
        qryBases.SQL := qryBases.SQL + '    BAS_CODITE = ITE_CODITE         ';
        qryBases.SQL := qryBases.SQL + '  WHERE BAS_CODBAS = :CODBAS              ';
        qryBases.SQL := qryBases.SQL + '    AND BAS_PRODUT = :PRODUT              ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD = :UNIDAD            ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD <> :UNIDAD           ';

        If TStrUtils.fEmptyStr(strCodNfm) Then
          qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('UNIDAD').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.ParamByName('UNIDAD').AsString := strUnidadeMenor;

        qryBases.Open;

        qryBases.First;

        While Not qryBases.Eof Do
        Begin
          qryCadLkc.Insert;
          qryCadLkc.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LKC_CADLKC', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadLkc.FieldByName('LKC_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadLkc.FieldByName('LKC_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
          qryCadLkc.FieldByName('LKC_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadLkc.FieldByName('LKC_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
          qryCadLkc.FieldByName('LKC_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
          qryCadLkc.FieldByName('LKC_ATIVO_').AsString := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
          qryCadLkc.FieldByName('LKC_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
          qryCadLkc.FieldByName('LKC_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadLkc.FieldByName('LKC_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
          qryCadLkc.FieldByName('LKC_CONTEU').AsString := qryBases.FieldByName('BAS_CONTEU').AsString;

          fltFator := fFatorUnidade(qryCadNfm.FieldByName('NFM_CONTEU').AsFloat, qryBases.FieldByName('BAS_CONTEU').AsFloat);

          For IntContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCadLkc.FieldByName('LKC_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

            qryCadLkc.FieldByName('LKC_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator;
          End;

          qryCadLkc.FieldByName('LKC_MD5KEY').AsString := GetMD5(qryCadLkc.FieldByName('LKC_CODIGO').AsString +
                                                                 qryCadLkc.FieldByName('LKC_CODBAS').AsString +
                                                                 qryCadLkc.FieldByName('LKC_NOMCOR').AsString +
                                                                 qryCadLkc.FieldByName('LKC_PRODUT').AsString +
                                                                 qryCadLkc.FieldByName('LKC_UNIDAD').AsString +
                                                                 qryCadLkc.FieldByName('LKC_CONTEU').AsString);
          qryCadLkc.Post;
          qryBases.Next;
        End;
        qryCadNfm.Next;
        Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      End;


    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally

  End;
end;

function TGravandoExecucaoLukscolor2NovasFormulas.fFatorUnidade(fltUniOri,
  fltUniAtu: Double): Double;
begin
  Result := fltUniAtu / fltUniOri;
end;

function TGravandoExecucaoLukscolor2NovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoLukscolor2NovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoLukscolor2NovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.
