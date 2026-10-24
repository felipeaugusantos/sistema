{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta AdvanceTintoSystem *}
{*******************************************************************************PH*}
unit untGravandoExecucaoAdvanceTintoSystemNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoAdvanceTintoSystemNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fRetQtdBas(strCodEmb: String; strCodPro: String; strCodBas: String): Double;
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

{ TGravandoExecucaoAdvanceTintoSystemNovasFormulas }

constructor TGravandoExecucaoAdvanceTintoSystemNovasFormulas.Create(
  const strCodNfm: string; blnGerarUnidades: Boolean;
  const blnAtualizarUnidade: Boolean; const strUnidadeMenor: String);
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoAdvanceTintoSystemNovasFormulas.Executar(const gravando: IGravando);
Var
  qryBases,
  qryCadNfm,
  qryCadAdt,
  qryCadCol,
  qryCatali: IDataSet;
  intContador:Integer;
  fltQtdMl:Double;
  fltNfmBas: Double;
begin
  Gravando.Texto := '  Carregando dados do Cadastro de Novas Fórmulas...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadNfm.SQL := '    SELECT * FROM ADT_CADNFM    ';

  qryCadAdt := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadAdt.SQL := '    DELETE FROM ADT_CADADT      ';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
  Begin
    qryCadNfm.SQL := qryCadNfm.SQL +  '   WHERE NFM_IDFORM = ' + QuotedStr(strCodNfm);
    qryCadAdt.SQL := qryCadAdt.SQL +  '   WHERE ADT_IDFORM = ' + QuotedStr(strCodNfm);
  End
  Else
  Begin
    qryCadAdt.SQL := qryCadAdt.SQL +  '   WHERE ADT_IDFORM LIKE ''%ESP%''   ';
  End;

  qryCadNfm.Open;
  qryCadAdt.ExecSQL;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('ADT_CADADT');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

  qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadCol.SQL := '    SELECT * FROM ADT_CADCOL    ';
  qryCadCol.Open;

  qryCadAdt.SQL.Empty;
  qryCadAdt.SQL := '    SELECT * FROM ADT_CADADT ';
  qryCadAdt.Open;

  qryCatali := TAutcomTintaFactory.Get.fGetDataSet;
  qryCatali.SQL := '    SELECT * FROM ADT_CADBAS WHERE BAS_DESCRI LIKE ''%PARTE B%''   ';
  qryCatali.Open;

  Try
    Try
      While Not qryCadNfm.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT                              ' +
                        '     *                                 ' +
                        '   FROM                                ' +
                        '     ADT_CADBAS                        ' +
                        '   INNER JOIN CADITE ON                ' +
                        '     ITE_CODITE = BAS_CODITE           ' +
                        '   WHERE                               ' +
                        '     BAS_CODBAS = :BASE__ AND          ' +
                        '     BAS_PRODUT = :PRODUT              ' ;

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '  AND BAS_CODEMB = :EMBA__    ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '  AND BAS_CODEMB <> :EMBA__   ';

        qryBases.ParamByName('BASE__').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('EMBA__').AsString := qryCadNfm.FieldByName('NFM_CODEMB').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.ParamByName('EMBA__').AsString := strUnidadeMenor;


        qryBases.Open;

        fltNfmBas := fRetQtdBas(qryCadNfm.FieldByName('NFM_CODEMB').AsString, qryCadNfm.FieldByName('NFM_PRODUT').AsString,
          qryCadNfm.FieldByName('NFM_CODBAS').AsString);

        While Not qryBases.Eof Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;



          qryCadAdt.Insert;
          qryCadAdt.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADT_CADADT', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadAdt.FieldByName('ADT_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadAdt.FieldByName('ADT_IDFORM').AsString := qryCadNfm.FieldByName('NFM_IDFORM').AsString;
          qryCadAdt.FieldByName('ADT_CODCOR').AsString := qryCadNfm.FieldByName('NFM_CODCOR').AsString;
          qryCadAdt.FieldByName('ADT_CODTEC').AsString := qryCadNfm.FieldByName('NFM_CODTEC').AsString;
          qryCadAdt.FieldByName('ADT_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
          qryCadAdt.FieldByName('ADT_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadAdt.FieldByName('ADT_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
          qryCadAdt.FieldByName('ADT_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
          qryCadAdt.FieldByName('ADT_CODEMB').AsString := qryBases.FieldByName('BAS_CODEMB').AsString;
          qryCadAdt.FieldByName('ADT_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
          qryCadAdt.FieldByName('ADT_MD5KEY').AsString := GetMD5(qryCadAdt.FieldByName('ADT_IDFORM').AsString +
                                                                 qryCadAdt.FieldByName('ADT_CODCOR').AsString +
                                                                 qryCadAdt.FieldByName('ADT_CODTEC').AsString +
                                                                 qryCadAdt.FieldByName('ADT_PRODUT').AsString +
                                                                 qryCadAdt.FieldByName('ADT_CODBAS').AsString +
                                                                 qryCadAdt.FieldByName('ADT_CODEMB').AsString +
                                                                 qryCadAdt.FieldByName('ADT_CODCAT').AsString);

          fltQtdMl := 0;
          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            If Not qryCadCol.Locate('COL_CODCOL', TrimRight(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString), []) Then
              Raise Exception.CreateFmt('O Colorante %s não está cadastrado', [qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString]);

            qryCadAdt.FieldByName('ADT_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString);

            qryCadAdt.FieldByName('ADT_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
              (qryBases.FieldByName('BAS_CONTEU').AsFloat / fltNfmBas) *
                qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat / qryCadCol.FieldByName('COL_PESESP').AsFloat;


            fltQtdMl := fltQtdMl + qryCadAdt.FieldByName('ADT_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
          End;

          qryCadAdt.FieldByName('ADT_QTDBAS').AsFloat := qryBases.FieldByName('BAS_CONTEU').AsFloat;
          qryCadAdt.FieldByName('ADT_QTD_ML').AsFloat := fltQtdMl;

          If Not TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODCAT').AsString) Then
          Begin

            If Not qryCatali.Locate('BAS_CODBAS;BAS_CODEMB', VarArrayOf([TrimRight(qryCadNfm.FieldByName('NFM_CODCAT').AsString), qryCadNfm.FieldByName('NFM_CODEMB').AsString]),
              []) Then
              Raise Exception.CreateFmt('O catalisador %s não está cadastrado', [qryCadNfm.FieldByName('NFM_CODCAT').AsString]);

            qryCadAdt.FieldByName('ADT_CODCAT').AsString :=
              TrimRight(qryCadNfm.FieldByName('NFM_CODCAT').AsString);

            qryCadAdt.FieldByName('ADT_QTDCAT').AsFloat := (qryBases.FieldByName('BAS_CONTEU').AsFloat / fltNfmBas) *
              qryCadNfm.FieldByName('NFM_QTDCAT').AsFloat / qryCatali.FieldByName('BAS_PESESP').AsFloat;



          End;

          qryCadAdt.FieldByName('ADT_QTDFIN').AsFloat :=
            qryCadAdt.FieldByName('ADT_QTDBAS').AsFloat +
            qryCadAdt.FieldByName('ADT_QTD_ML').AsFloat +
            qryCadAdt.FieldByName('ADT_QTDCAT').AsFloat;

          qryCadAdt.Post;
          qryBases.Next;

        End;

        qryCadNfm.Next;
        Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);

      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;

    End;
  Finally
    Gravando.Texto := Format('%s processado com sucesso!', ['Novas Fórmulas']);
  End;


end;

function TGravandoExecucaoAdvanceTintoSystemNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;


function TGravandoExecucaoAdvanceTintoSystemNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoAdvanceTintoSystemNovasFormulas.fRetQtdBas(strCodEmb,
  strCodPro, strCodBas: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                    ' +
                '   BAS_CONTEU              ' +
                ' FROM                      ' +
                '   ADT_CADBAS              ' +
                ' WHERE                     ' +
                '   BAS_CODBAS = :CODBAS AND    ' +
                '   BAS_CODEMB = :CODEMB AND    ' +
                '   BAS_PRODUT = :PRODUT        ';

  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('CODEMB').AsString := strCodEmb;
  qryGen.ParamByName('PRODUT').AsString := strCodPro;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_CONTEU').AsFloat;
end;

end.
