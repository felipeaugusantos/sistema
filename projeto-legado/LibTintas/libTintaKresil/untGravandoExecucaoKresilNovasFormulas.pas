{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Kresil *}
{*******************************************************************************PH*}
unit untGravandoExecucaoKresilNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoKresilNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fGetUnidadesGeracaoCadNfm(strUnidade:String):String;
    function fRetFator(fltConMen, fltConMai: Double): Double;
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

{ TGravandoExecucaoKresilNovasFormulas }

constructor TGravandoExecucaoKresilNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoKresilNovasFormulas.Executar(const gravando: IGravando);
Var
  qryBases, qryNovaF, qryCores: IDataSet;
  fltFator: Double;
  intContador: Integer;
begin
  Try
    Try
      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Iniciando Cadastro de Novas Fórmulas...';

      qryBases := TAutcomTintaFactory.Get.fGetDataSet;
      qryNovaF := TAutcomTintaFactory.Get.fGetDataSet;
      qryCores := TAutcomTintaFactory.Get.fGetDataSet;

      qryNovaF.Close;
      qryCores.Close;

      Gravando.Texto := 'Deletando Novas Fórmulas da tabela KRE_CADKRE...';
      qryNovaF.SQL := '   SELECT * FROM KRE_CADNFM    ';
      qryCores.SQL := '   DELETE FROM KRE_CADKRE      ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryNovaF.SQL := qryNovaF.SQL + '  WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
        qryCores.SQL := qryCores.SQL + '  WHERE KRE_CODIGO = ' + QuotedStr(strCodNfm);
      End
      Else
        qryCores.SQL := qryCores.SQL + '  WHERE KRE_CODIGO LIKE ''%ESP%''       ';

      qryCores.ExecSQL;
      qryCores.SQL := '';
      qryCores.SQL := qryCores.SQL + '  SELECT                ';
      qryCores.SQL := qryCores.SQL + '    *                   ';
      qryCores.SQL := qryCores.SQL + '  FROM                  ';
      qryCores.SQL := qryCores.SQL + '    KRE_CADKRE          ';
      qryCores.SQL := qryCores.SQL + '  WHERE FALSE           ';
      qryCores.Open;
      qryNovaF.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('KRE_CADKRE');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Processando Novas Fórmulas...';
      Gravando.RegistrarProgresso(0, 0, 0);

      While Not qryNovaF.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryBases.Close;
        qryBases.SQL := '';
        qryBases.SQL := qryBases.SQL + '  SELECT                    ';
        qryBases.SQL := qryBases.SQL + '    BAS_CONTEU,             ';
        qryBases.SQL := qryBases.SQL + '    BAS_UNIDAD              ';
        qryBases.SQL := qryBases.SQL + '  FROM                      ';
        qryBases.SQL := qryBases.SQL + '    KRE_CADBAS              ';
        qryBases.SQL := qryBases.SQL + '  INNER JOIN CADITE ON              ';
        qryBases.SQL := qryBases.SQL + '    BAS_CODITE = ITE_CODITE               ';
        qryBases.SQL := qryBases.SQL + '  WHERE                     ';
        qryBases.SQL := qryBases.SQL + '    BAS_BASE__ = :CODBAS  AND       ';
        qryBases.SQL := qryBases.SQL + '    BAS_PRODUT = :PRODUT            ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD = :UNIDAD            ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD <> :UNIDAD           ';

        If TStrUtils.fEmptyStr(strCodNfm) Then
          qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryNovaF.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('CODBAS').AsString := qryNovaF.FieldByName('NFM_BASE__').AsString;
        qryBases.ParamByName('PRODUT').AsString := qryNovaF.FieldByName('NFM_PRODUT').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('UNIDAD').AsString := qryNovaF.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.ParamByName('UNIDAD').AsString := strUnidadeMenor;

        qryBases.Open;
        qryBases.First;

        While Not qryBases.Eof Do
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCores.Insert;
          qryCores.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KRE_CADKRE', TAutcomTintaFactory.Get.GetCodEmp);
          qryCores.FieldByName('KRE_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCores.FieldByName('KRE_CODIGO').AsString := qryNovaF.FieldByName('NFM_CODIGO').AsString;
          qryCores.FieldByName('KRE_NOMCOR').AsString := qryNovaF.FieldByName('NFM_NOMCOR').AsString;
          qryCores.FieldByName('KRE_COLECA').AsString := qryNovaF.FieldByName('NFM_COLECA').AsString;
          qryCores.FieldByName('KRE_BASE__').AsString := qryNovaF.FieldByName('NFM_BASE__').AsString;
          qryCores.FieldByName('KRE_PRODUT').AsString := qryNovaF.FieldByName('NFM_PRODUT').AsString;
          qryCores.FieldByName('KRE_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCores.FieldByName('KRE_ATIVO_').AsString := qryNovaF.FieldByName('NFM_ATIVO_').AsString;
          qryCores.FieldByName('KRE_DTACAD').AsDate   := qryNovaF.FieldByName('NFM_DTACAD').AsDate;
          qryCores.FieldByName('KRE_ACRMOB').AsFloat  := qryNovaF.FieldByName('NFM_ACRMOB').AsFloat;

          fltFator := fRetFator(qryNovaF.FieldByName('NFM_CONTEU').AsFloat, qryBases.FieldByName('BAS_CONTEU').AsFloat);


          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryNovaF.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCores.FieldByName('KRE_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryNovaF.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

            qryCores.FieldByName('KRE_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
              qryNovaF.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator;
          End;

          qryCores.FieldByName('KRE_MD5KEY').AsString := GetMD5(qryCores.FieldByName('KRE_CODIGO').AsString +
                                                                qryCores.FieldByName('KRE_NOMCOR').AsString +
                                                                qryCores.FieldByName('KRE_BASE__').AsString +
                                                                qryCores.FieldByName('KRE_PRODUT').AsString +
                                                                qryCores.FieldByName('KRE_UNIDAD').AsString +
                                                                qryCores.FieldByName('KRE_COLECA').AsString);

          qryCores.Post;
          qryBases.Next;
        End;
        qryNovaF.Next;
        gravando.RegistrarProgresso(0, qryNovaF.RecNo, qryNovaF.RecordCount);
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

function TGravandoExecucaoKresilNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoKresilNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","BD") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "BD" ';
end;

function TGravandoExecucaoKresilNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoKresilNovasFormulas.fRetFator(fltConMen,
  fltConMai: Double): Double;
begin
  Result := fltConMai / fltConMen;
end;

end.
