{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Lukscolor *}
{*******************************************************************************PH*}
unit untGravandoExecucaoLukscolorNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoLukscolorNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fRetProximoCodSeq(): Integer;
    function fFatorQtdEmb(fltQtdOrigem, fltQtdAtual:Double):Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade:String): String;
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

{ TGravandoExecucaoLukscolorNovasFormulas }

constructor TGravandoExecucaoLukscolorNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoLukscolorNovasFormulas.Executar(const gravando: IGravando);
var
  qryBases: IDataSet;
  qryCadNfm,qryCadLkd: IDataSet;
  intContador: Integer;
  fltFator:Double;
Begin
  Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';
  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadLkd := TAutcomTintaFactory.Get.fGetDataSet;

  qryCadNfm.SQL := '  SELECT * FROM LKD_CADNFM  ';
  qryCadLkd.SQL := '  DELETE FROM LKD_CADLKD  ';

  Gravando.Texto := 'Deletando Novas Fórmulas cadastrada...';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
  Begin
    qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODPRO = ' + QuotedStr(strCodNfm);
    qryCadLkd.SQL := qryCadLkd.SQL + '  WHERE LKD_CODIGO = ' + QuotedStr(strCodNfm);
  End
  Else
  Begin
    qryCadLkd.SQL := qryCadLkd.SQL + ' WHERE LKD_CODIGO LIKE ''%ESP%'' ';
  End;

  qryCadLkd.ExecSQL;
  qryCadLkd.SQL.Empty;
  qryCadLkd.SQL := '    SELECT * FROM LKD_CADLKD WHERE FALSE    ';
  qryCadLkd.Open;
  qryCadNfm.Open;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('LKD_CADLKD');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Try
    Try
      While Not qryCadNfm.Eof Do
      Begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;

        Begin
          qryBases.SQL := '   SELECT *       ' +
                          '     FROM LKD_CADBAS    ' +
                          '   INNER JOIN CADITE ON    ' +
                          '   ITE_CODITE = BAS_CODITE WHERE ' +
                          '   BAS_BASE__ = :BASE AND  ' +
                          '   BAS_PROKEY = :PKEY      ' ;
        End;

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '  AND BAS_UNIDAD  =  :UNIDADE   ';

        If Not (blnAtualizarUnidade) And Not (TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '  AND BAS_UNIDAD <> :UNIDADE    ';

        If TStrUtils.fEmptyStr(strCodNfm) Then
          qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('BASE').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
        qryBases.ParamByName('PKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;

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

          qryCadLkd.Insert;
          qryCadLkd.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LKD_CADLKD', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadLkd.FieldByName('LKD_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadLkd.FieldByName('LKD_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
          qryCadLkd.FieldByName('LKD_CODIG2').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
          qryCadLkd.FieldByName('LKD_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryCadNfm.FieldByName('NFM_CODPRO').AsString;
          qryCadLkd.FieldByName('LKD_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadLkd.FieldByName('LKD_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
          qryCadLkd.FieldByName('LKD_BASE__').AsString := qryBases.FieldByName('BAS_BASE__').AsString;
          qryCadLkd.FieldByName('LKD_PROKEY').AsString := qryBases.FieldByName('BAS_PROKEY').AsString;
          qryCadLkd.FieldByName('LKD_SUBKEY').AsString := qryBases.FieldByName('BAS_SUBKEY').AsString;
          qryCadLkd.FieldByName('LKD_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
          qryCadLkd.FieldByName('LKD_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

          qryCadLkd.FieldByName('LKD_MD5KEY').AsString := GetMD5(qryCadLkd.FieldByName('LKD_DESCRI').AsString +
                                                                 qryCadLkd.FieldByName('LKD_BASE__').AsString +
                                                                 qryCadLkd.FieldByName('LKD_CODIGO').AsString +
                                                                 qryCadLkd.FieldByName('LKD_CODIG2').AsString +
                                                                 qryCadLkd.FieldByName('LKD_UNIDAD').AsString +
                                                                 qryCadLkd.FieldByName('LKD_PROKEY').AsString +
                                                                 qryCadLkd.FieldByName('LKD_SUBKEY').AsString);

          fltFator := fFatorQtdEmb(qryCadNfm.FieldByName('NFM_QTDEMB').AsFloat, qryBases.FieldByName('BAS_QTDEMB').AsFloat);

          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCadLkd.FieldByName('LKD_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString);

            qryCadLkd.FieldByName('LKD_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat  :=
              qryCadNfm.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intContador , 2)).AsFloat * fltFator;



          End;

          qryCadLkd.Post;
          qryBases.Next;



        End;
        qryCadNfm.Next;
        Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Novas Fórmulas processado com sucesso...';
  End;

End;

function TGravandoExecucaoLukscolorNovasFormulas.fFatorQtdEmb(fltQtdOrigem,
  fltQtdAtual: Double): Double;
begin
  Result := fltQtdAtual / fltQtdOrigem;
end;

function TGravandoExecucaoLukscolorNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;





function TGravandoExecucaoLukscolorNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;


function TGravandoExecucaoLukscolorNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoLukscolorNovasFormulas.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(LKD_CODSEQ), 0) + 1 AS MAXIMO FROM LKD_CADLKD; ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;

end;

end.
