{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta BrasimixImobiliaria *}
{*******************************************************************************PH*}
unit untGravandoExecucaoBrasimixImobiliariaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoBrasimixImobiliariaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;

    procedure RemoverNovasFormulas();
    function fRetPesoUnidade(fltBasEmb: Double; fltBasNfm: Double): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
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

{ TGravandoExecucaoBrasimixImobiliariaNovasFormulas }

constructor TGravandoExecucaoBrasimixImobiliariaNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoBrasimixImobiliariaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadBzi: IDataSet;
  qryBases : IDataSet;
  qryVolumeEspecifico: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM BZI_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadBzi := TAutcomTintaFactory.Get.fGetDataSet;
      qryVolumeEspecifico := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BZI_CADBZI');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT *                       ' +
                        '   FROM BZI_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_LINHA_ = :LINHA_    ' +
                        '    AND BAS_BASE__ = :CODBAS    ' +
                        '    AND BAS_DESCRI = :DESCRI    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
        qryBases.ParamByName('DESCRI').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        Try
          Try
            qryBases.First;
            While Not qryBases.Eof Do
            Begin

              qryCadBzi.SQL := TAutcomTintaFactory.Get.GetInsert('BZI_CADBZI');

              qryCadBzi.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BZI_CADBZI', qryCadNfm.FieldByName('NFM_CODEMP').AsString);
              qryCadBzi.ParamByName('BZI_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
              qryCadBzi.ParamByName('BZI_REFERE').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
              qryCadBzi.ParamByName('BZI_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
              qryCadBzi.ParamByName('BZI_EMBALA').AsFloat :=  qryBases.FieldByName('BAS_EMBALA').AsFloat;
              qryCadBzi.ParamByName('BZI_CODEMP').AsString := qryCadNfm.FieldByName('NFM_CODEMP').AsString;
              qryCadBzi.ParamByName('BZI_GRUPRO').AsString := 'PERSONALIZADA';

              for intCont := 1 to 20 do
              begin
                if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                  Break;

                qryCadBzi.ParamByName('BZI_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString);

                qryCadBzi.ParamByName('BZI_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                  qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat *
                    fRetPesoUnidade(qryBases.FieldByName('BAS_EMBALA').AsFloat, qryCadNfm.FieldByName('NFM_EMBALA').AsFloat);
              end;

              qryCadBzi.ParamByName('BZI_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
              qryCadBzi.ParamByName('BZI_CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
              qryCadBzi.ParamByName('BZI_DESCRI').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
              qryCadBzi.ParamByName('BZI_CODUNI').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString; //arrUnidades[intUnidades];
              qryCadBzi.ParamByName('BZI_MD5KEY').AsString := GetMD5(qryCadBzi.ParamByName('BZI_CODIGO').AsString +
                                                                     qryCadBzi.ParamByName('BZI_DESCRI').AsString +
                                                                     qryCadBzi.ParamByName('BZI_REFERE').AsString +
                                                                     qryCadBzi.ParamByName('BZI_UNIDAD').AsString +
                                                                     qryCadBzi.ParamByName('BZI_LINHA_').AsString +
                                                                     qryCadBzi.ParamByName('BZI_CODBAS').AsString +
                                                                     qryCadBzi.ParamByName('BZI_CODUNI').AsString +
                                                                     qryCadBzi.ParamByName('BZI_GRUPRO').AsString +
                                                                     qryCadBzi.ParamByName('BZI_EMBALA').AsString);

              qryCadBzi.ParamByName('BZI_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
              qryCadBzi.ParamByName('BZI_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
              qryCadBzi.ParamByName('BZI_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

              qryCadBzi.ExecSQL;

              if not (blnGerarUnidades) then
                Break;

              qryBases.Next;
            End;
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          qryCadNfm.Next;
          gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
        End;
      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoBrasimixImobiliariaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoBrasimixImobiliariaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoBrasimixImobiliariaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoBrasimixImobiliariaNovasFormulas.fRetPesoUnidade(fltBasEmb: Double; fltBasNfm: Double): Double;
begin
  Result := fltBasEmb / fltBasNfm;
end;

procedure TGravandoExecucaoBrasimixImobiliariaNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE                        ' +
          ' FROM                          ' +
          '   BZI_CADBZI                  ' +
          ' WHERE BZI_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODIGO                ' +
          '   FROM                        ' +
          '     BZI_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   BZI_CADBZI                           ' +
          ' WHERE BZI_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODIGO                         ' +
          '   FROM                                 ' +
          '     BZI_CADNFM                         ' +
          '   WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm) + ') ';
      end;

      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

end.
