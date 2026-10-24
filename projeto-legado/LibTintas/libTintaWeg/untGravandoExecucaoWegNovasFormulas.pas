{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Weg *}
{*******************************************************************************PH*}
unit untGravandoExecucaoWegNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoWegNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fRetProximoCodSeq(): Integer;
    function fRetQtdEmbalagem(strUnidade:String):Double;
    function fRetFatorUnidade(fltQtdAtual, fltQtdOrigem:Double):Double;
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

{ TGravandoExecucaoWegNovasFormulas }

constructor TGravandoExecucaoWegNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoWegNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm, qryCadWeg: IDataSet;
  qryBases: IDataSet;
  fltQtdOrigem,
  fltQtdAtual,
  fltFatorUnd:Double;
  intContador:Integer;
Begin
  Gravando.Texto := 'Carregando Dados...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadWeg := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadNfm.SQL := '    SELECT * FROM WEG_CADNFM      ';
  qryCadWeg.SQL := '    DELETE FROM WEG_CADWEG      ';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
  Begin
    qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODPRO = ' + QuotedStr(strCodNfm);
    qryCadWeg.SQL := qryCadWeg.SQL + '  WHERE WEG_CODIGO = ' + QuotedStr(strCodNfm);
  End
  Else
  Begin
    qryCadWeg.SQL := qryCadWeg.SQL + '    WHERE WEG_CODIGO LIKE ''%ESP%''   ';
  End;

  qryCadNfm.Open;
  qryCadWeg.ExecSQL;
  qryCadWeg.SQL.Empty;
  qryCadWeg.SQL := '    SELECT * FROM WEG_CADWEG  WHERE FALSE ;    ';
  qryCadWeg.Open;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('WEG_CADWEG');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Processando Nóvas Formulas...';

  Try
    Try
      While Not qryCadNfm.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT * FROM WEG_CADBAS        ' +
                        '   INNER JOIN CADITE ON            ' +
                        '     ITE_CODITE = BAS_CODITE       ' +
                        '   WHERE                           ' +
                        '     BAS_BASE__ = :CODBAS          ' +
                        '   AND BAS_PROKEY = :PROKEY        ' +
                        '   AND BAS_SUBKEY = :SUBKEY        ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD = :UNIDADE     ';

        If Not (blnAtualizarUnidade) And Not (TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD <> :UNIDADE    ';

        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
        qryBases.ParamByName('PROKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;
        qryBases.ParamByName('SUBKEY').AsString := qryCadNfm.FieldByName('NFM_SUBKEY').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('UNIDADE').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If Not (blnAtualizarUnidade) And Not (TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.ParamByName('UNIDADE').AsString := strUnidadeMenor;

        qryBases.Open;
        qryBases.First;

        While Not qryBases.Eof Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadWeg.Insert;
          qryCadWeg.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('WEG_CADWEG', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadWeg.FieldByName('WEG_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadWeg.FieldByName('WEG_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
          qryCadWeg.FieldByName('WEG_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryCadNfm.FieldByName('NFM_CODPRO').AsString;
          qryCadWeg.FieldByName('WEG_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
          qryCadWeg.FieldByName('WEG_CODIG2').AsString := qryCadWeg.FieldByName('WEG_CODIGO').AsString;
          qryCadWeg.FieldByName('WEG_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadWeg.FieldByName('WEG_CODITE').AsString := qryBases.FieldByName('BAS_CODITE').AsString;
          qryCadWeg.FieldByName('WEG_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
          qryCadWeg.FieldByName('WEG_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
          qryCadWeg.FieldByName('WEG_PROKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;
          qryCadWeg.FieldByName('WEG_SUBKEY').AsString := qryCadNfm.FieldByName('NFM_SUBKEY').AsString;
          qryCadWeg.FieldByName('WEG_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
          qryCadWeg.FieldByName('WEG_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadWeg.FieldByName('WEG_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

          fltQtdOrigem := fRetQtdEmbalagem(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);
          fltQtdAtual  := fRetQtdEmbalagem(qryBases.FieldByName('BAS_UNIDAD').AsString);

          fltFatorUnd := fRetFatorUnidade(fltQtdAtual, fltQtdOrigem);

          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCadWeg.FieldByName('WEG_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString);

            qryCadWeg.FieldByName('WEG_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFatorUnd;
          End;

          qryCadWeg.FieldByName('WEG_MD5KEY').AsString := GetMD5(qryCadWeg.FieldByName('WEG_BASE__').AsString +
                                                                 qryCadWeg.FieldByName('WEG_UNIDAD').AsString +
                                                                 qryCadWeg.FieldByName('WEG_PROKEY').AsString +
                                                                 qryCadWeg.FieldByName('WEG_SUBKEY').AsString +
                                                                 qryCadWeg.FieldByName('WEG_DESCRI').AsString +
                                                                 qryCadWeg.FieldByName('WEG_CODIGO').AsString +
                                                                 qryCadWeg.FieldByName('WEG_CODIG2').AsString +
                                                                 qryCadWeg.FieldByName('WEG_NOMCOR').AsString);

          qryCadWeg.Post;
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
    Gravando.Texto := Format('Cadastro de %s processado com sucesso', ['Novas Fórmulas']);
  End;


End;

function TGravandoExecucaoWegNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;


function TGravandoExecucaoWegNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoWegNovasFormulas.fRetFatorUnidade(fltQtdAtual,
  fltQtdOrigem: Double): Double;
begin
  Result := fltQtdAtual / fltQtdOrigem;
end;

function TGravandoExecucaoWegNovasFormulas.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(WEG_CODSEQ), 0) + 1 AS MAXIMO FROM WEG_CADWEG; ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;

end;

function TGravandoExecucaoWegNovasFormulas.fRetQtdEmbalagem(
  strUnidade: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT EMB_QTDEMB AS QTD FROM WEG_CADEMB     ' +
                  '     WHERE EMB_UNIDAD = :UNIDADE         ' ;
    qryGen.ParamByName('UNIDADE').AsString := strUnidade;
    qryGen.Open;

    Result := qryGen.FieldByName('QTD').AsFloat;
  Except
    Raise;
  End;
end;

end.
