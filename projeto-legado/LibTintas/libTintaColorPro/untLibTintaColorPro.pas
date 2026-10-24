{******************************************-*********************}
{* Classe contendo as informações especificas da tinta ColorPro *}
{*******************************************-*****************AC*}
unit untLibTintaColorPro;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes,
  Math;

type
  TLibTintaColorPro = class(TAbstractLibTintaAutomotiva)
  private
    function fVerificaQuantidadeCamadas(strIteTin: String): Integer;
    function fRetFatVen(strLinha, strCatali: String; fltVolPro : Double): Double;

    function fRetIndiceAdicional(const strLinha: String; const strCatali: String): Integer;
    function fRet4Por1(const strLinha: String; const strCatali: String): Boolean;
    function fRetornaPorcento(strItetin: String; intIndexBase: Integer): Double;
    function fRetornaCodAkzo(strItetin: String): String;
  protected
    function GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva; override;
    function GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string; override;

    function GetVolumeOriginal(const dicRetorno: IDicionario): Double; override;
    function GetVolumeConcentrado: Double; override;
    function GetVolumeDiluido: Double; override;
    function GetVolumePro(const dicRetorno: IDicionario): Double; override;
    function GetCodFormul(const dicRetorno: IDicionario): string; override;

    procedure pProcessaFormulacaoTabelaPreco(Formula: TAbstractFormulaAutomotiva;
                                  const dicRetorno: IDicionario; const qryConsulta: IDataSet); override;
    procedure pProcessaFormulacaoGTinFor(Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet;
                                  dicBases: IDicionario; Const Formula: TAbstractFormulaAutomotiva;
                                  Const dicDados: IDicionario; Var strBases: String); override;

    function GetPrefixoTabela: String; override;

    procedure pLocalizaFormulacaoGTinFor(const dicDados: IDicionario; out qryGen: IDataSet); override;
    function fRetornaQuantidadeBaixaGTinFor(dicBases: IDicionario; qryBases: IDataSet): Double; override;
    function fRetornaFormulacaoParaTabelaPreco(const dicRetorno: IDicionario; out qryGen: IDataSet): Boolean; override;
  public
    function GetNomeTinta: String; override;
    function GetITintadeMaquina(): ITintadeMaquinaWrapper; override;
    function RetornaReferenciaTinta(const dtsTinta: IDataSet): String; override;
    function RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double; override;
    procedure RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario); override;
    function GetMenu: IAuttinMenuItem; override;
    function GetQuantidadeOncaPulsoMl(const fltPulsos: Double; var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String = ''): String ; override;
    function GetNomeTabelaFormulacao: String; override;
    function GetCampoComponenteDesComp(): String; override;
    function RetornaDescricaoTinta(const strDesCri: String; const dtsTinta: IDataSet; const strTipPre: String): String; override;
    function GetCampoComponenteCodComp: String; override;
    function GetWhereRetComponente(const strCodEmp: String): String; override;
    procedure SetaParametrosRetComponentes(const dataSet: IDataSet; const strCodComp: String); override;
    procedure pTintaRetornaTabelaPrecoGeneric(dicRetorno: IDicionario; fltFatorAcerto: Double); Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemColorPro,
{$ENDIF}
  untFormulaAutomotivaColorPro, untTintadeMaquinaWrapperColorPro, untAutcomTintaFactory,
  untVariantUtils, untMultiSelectLocalizadorFactory, untICalculadorFatVendasLibTintas, untModoVenda;

{ TColorProTintadeMaquina }

function TLibTintaColorPro.fRet4Por1(const strLinha,
  strCatali: String): Boolean;
begin
  Result := False;

  If Not TStrUtils.fEmptyStr(strCatali) Then
  Begin
    If Pos(TStrUtils.fStrZero(strLinha, 3), '008_013_') > 0 Then
    Begin
      If strCatali = '2:1' Then
        Result := False
      Else If strCatali = '4:1' Then
        Result := True;
    End
    Else If Pos(TStrUtils.fStrZero(strLinha, 3), '072_') > 0 Then
    Begin
      If strCatali = '9:2' Then
        Result := False;
    End
    Else If Pos(TStrUtils.fStrZero(strLinha, 3), '058_059_') > 0 Then
    Begin
      If strCatali = '4:1' Then
        Result := True;
    End;
  End;
end;

function TLibTintaColorPro.fRetFatVen(strLinha, strCatali: String; fltVolPro : Double): Double;
begin
  Result := fltVolPro;
  If (Pos(TStrUtils.fStrZero(strLinha,3), '008_058_059_') > 0) Then
  Begin
    If (strCatali = '4:1') Then
      Result := 0.750
    Else If (strCatali = '2:1') Then
      Result := 0.640
  End
  Else If (Pos(TStrUtils.fStrZero(strLinha,3), '013_') > 0) Then
  Begin
    If (strCatali = '4:1') Then
      Result := 0.750
    Else If (strCatali = '2:1') Then
      Result := 0.618
  End
  Else If (Pos(TStrUtils.fStrZero(strLinha, 3), '072_') > 0) Then
  Begin
    If (strCatali = '9:2') Then
      Result := 0.750;
  End;
end;

function TLibTintaColorPro.fRetIndiceAdicional(const strLinha,
  strCatali: String): Integer;
begin
  Result := -1;

  If Not TStrUtils.fEmptyStr(strCatali) Then
  Begin
    If Pos(TStrUtils.fStrZero(strLinha, 3), '008_013_') > 0 Then
    Begin
      If strCatali = '2:1' Then
        Result := 0
      Else If strCatali = '4:1' Then
        Result := 1;
    End
    Else If Pos(TStrUtils.fStrZero(strLinha, 3), '072_') > 0 Then
    Begin
      If strCatali = '9:2' Then
        Result := 0;
    End
    Else If Pos(TStrUtils.fStrZero(strLinha, 3), '058_059_') > 0 Then
    Begin
      If strCatali = '4:1' Then
        Result := 0;
    End;
  End;
end;

function TLibTintaColorPro.fRetornaCodAkzo(strItetin: String): String;
Var
  qryAux: IDataSet;
Begin
  Result := '';

  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.Close;
  qryAux.SQL := ' SELECT          ' +
                '   WAN_CODAKZ    ' +
                ' FROM            ' +
                '   WANPRO_CADWAN ' +
                ' WHERE           ' +
                '   WAN_MD5KEY = :ITETIN';
  qryAux.ParamByName('ITETIN').AsString := strItetin;
  qryAux.Open;

  If qryAux.IsEmpty Then
  Begin
    qryAux.Close;
    qryAux.SQL := ' SELECT          ' +
                  '   WAN_CODAKZ    ' +
                  ' FROM            ' +
                  '   WANPRO_CADWAN ' +
                  ' WHERE           ' +
                  '   UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), ' +
                  '         		            IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), ' +
                  '                         IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ';
    qryAux.ParamByName('ITETIN').AsString := strItetin;
    qryAux.Open;
  End;

  Result := qryAux.FieldByName('WAN_CODAKZ').AsString;
end;

function TLibTintaColorPro.fRetornaFormulacaoParaTabelaPreco(
  const dicRetorno: IDicionario; out qryGen: IDataSet): Boolean;
begin
  Result := TMultiSelectLocalizadorFactory.GetLocalizador(dicRetorno['idepro']).
    Localizar(qryGen, ['ITETIN'], [TVariantUtils.IfNull(dicRetorno['itetin'], '')]);
end;

function TLibTintaColorPro.fRetornaPorcento(strItetin: String;
  intIndexBase: Integer): Double;
Var
  qryAux: IDataSet;
Begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.Close;
  qryAux.SQL := ' SELECT ' +
                '   WAN_PORC' + TStrUtils.fStrZero(intIndexBase,2) +
                ' FROM            ' +
                '   WANPRO_CADWAN ' +
                ' WHERE WAN_MD5KEY = :ITETIN';
  qryAux.ParamByName('ITETIN').AsString := strItetin;
  qryAux.Open;

  If qryAux.IsEmpty Then
  Begin
    qryAux.Close;
    qryAux.SQL := ' SELECT ' +
                  '     WAN_PORC'+ TStrUtils.fStrZero(intIndexBase,2) +
                  '   FROM ' +
                  '     WANPRO_CADWAN ' +
                  ' WHERE  ' +
                  '   UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), ' +
                  '   		                  IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), ' +
                  '                         IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN';
    qryAux.ParamByName('ITETIN').AsString := strItetin;
    qryAux.Open;
  End;

  Result := qryAux.FieldByName('WAN_PORC' + TStrUtils.fStrZero(intIndexBase,2)).AsFloat;
end;

function TLibTintaColorPro.fRetornaQuantidadeBaixaGTinFor(dicBases: IDicionario;
  qryBases: IDataSet): Double;
begin
  Result := dicBases[qryBases.FieldByName('BAS_LINHA_').AsString + '_' + qryBases.FieldByName('BAS_CODBAS').AsString];
end;

function TLibTintaColorPro.fVerificaQuantidadeCamadas(
  strIteTin: String): Integer;
Var
  qryGen: IDataSet;
  qryGen2: IDataSet;
begin
  Result := 0;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := 'SELECT *             ' +
                '  FROM WANPRO_CADWAN ' +
                ' WHERE WAN_MD5KEY = :ITETIN ';
  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;

  if qryGen.IsEmpty then
  begin
    qryGen.Close;
    qryGen.SQL := 'SELECT ' +
                  '  *    ' +
                  'FROM   ' +
                  '  WANPRO_CADWAN ' +
                  'WHERE  ' +
                  ' 	 UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), ' +
                  ' 	  		                 IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), ' +
                  ' 		                     IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ';
    qryGen.ParamByName('ITETIN').AsString := strIteTin;
    qryGen.Open;

    if qryGen.IsEmpty then
      Exit;
  end;

  qryGen2 := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen2.Close;
  qryGen2.SQL := ' SELECT SQL_NO_CACHE ' +
                 '     COUNT(*)    QTD ' +
                 '  FROM WANPRO_CADWAN ' +
                 ' WHERE WAN_CAMADA IS NOT NULL ' +
                 '   AND WAN_LINHA_ = :LINHA_   ' +
                 '   AND WAN_CODAKZ = :CODAKZ   ' +
                 '   AND WAN_ALTERN = :ALTERN   ' +
                 '   AND WAN_DESCRI = :DESCRI   ' +
                 '   AND WAN_MONTAD = :MONTAD   ' +
                 '   AND WAN_VERCOR = :VERCOR   ' +
                 '   AND WAN_ANOINI = :ANOINI   ' +
                 '   AND WAN_ANOFIN = :ANOFIN   ';

  qryGen2.ParamByName('LINHA_').AsString := qryGen.FieldByName('WAN_LINHA_').AsString;
  qryGen2.ParamByName('CODAKZ').AsString := qryGen.FieldByName('WAN_CODAKZ').AsString;
  qryGen2.ParamByName('ALTERN').AsString := qryGen.FieldByName('WAN_ALTERN').AsString;
  qryGen2.ParamByName('DESCRI').AsString := qryGen.FieldByName('WAN_DESCRI').AsString;
  qryGen2.ParamByName('MONTAD').AsString := qryGen.FieldByName('WAN_MONTAD').AsString;
  qryGen2.ParamByName('VERCOR').AsString := qryGen.FieldByName('WAN_VERCOR').AsString;
  qryGen2.ParamByName('ANOINI').AsString := qryGen.FieldByName('WAN_ANOINI').AsString;
  qryGen2.ParamByName('ANOFIN').AsString := qryGen.FieldByName('WAN_ANOFIN').AsString;
  qryGen2.Open;

  Result := qryGen2.FieldByName('QTD').AsInteger;
end;

function TLibTintaColorPro.GetCampoComponenteCodComp: String;
begin
  Result := 'CONCAT(BAS_LINHA_, "_", BAS_CODBAS)';
end;

function TLibTintaColorPro.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaColorPro.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := fRetornaCodAkzo(dicRetorno['itetin']);
end;

function TLibTintaColorPro.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaColorPro.Create(strTabPre);
end;

function TLibTintaColorPro.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperColorPro.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaColorPro.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemColorPro.Create();
{$ENDIF}
end;

function TLibTintaColorPro.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORWCP';
end;

function TLibTintaColorPro.GetNomeTinta: String;
begin
  Result := 'Color Pro';
end;

function TLibTintaColorPro.GetPrefixoTabela: String;
begin
  Result := 'WAN';
end;

function TLibTintaColorPro.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaColorPro.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                 ' +
    '   BAS_LINHA_                           ' +
    '   , BAS_CODBAS                         ' +
    '   , BAS_CODITE                         ' +
    ' FROM                                   ' +
    '   WANPRO_CADBAS                        ' +
    ' WHERE                                  ' +
    '   CONCAT(BAS_LINHA_, "_", BAS_CODBAS) IN (' + strBases + ') ';
end;

function TLibTintaColorPro.GetVolumeConcentrado: Double;
begin
  Result := 1;
end;

function TLibTintaColorPro.GetVolumeDiluido: Double;
begin
  Result := 1;
end;

function TLibTintaColorPro.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := fRetFatVen(TVariantUtils.IfNull(dicRetorno['linha_'], ''), TVariantUtils.IfNull(dicRetorno['catali'], ''),  0.9);
end;

function TLibTintaColorPro.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

function TLibTintaColorPro.GetWhereRetComponente(
  const strCodEmp: String): String;
begin
  Result := GetCampoComponenteCodComp + ' = :CODBAS';
end;

procedure TLibTintaColorPro.pLocalizaFormulacaoGTinFor(
  const dicDados: IDicionario; out qryGen: IDataSet);
begin
  TMultiSelectLocalizadorFactory.GetLocalizador(dicDados['idepro']).
    Localizar(qryGen, ['ITETIN'], [TVariantUtils.IfNull(dicDados['itetin'], '')]);
end;


procedure TLibTintaColorPro.pProcessaFormulacaoTabelaPreco(
  Formula: TAbstractFormulaAutomotiva; const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  bln4Por1: Boolean;
  strBasTmp: String;
  strCodBas: String;
  strLinBas: String;
begin
  strBasTmp := '';
  strCodBas := '';
  strLinBas := '';

  Formula.IndiceAdicional := fRetIndiceAdicional(TVariantUtils.IfNull(dicRetorno['linha_'], ''), TVariantUtils.IfNull(dicRetorno['catali'], ''));

  bln4Por1 := fRet4Por1(TVariantUtils.IfNull(dicRetorno['linha_'], ''), TVariantUtils.IfNull(dicRetorno['catali'], ''));

  For intContador := 1 To Formula.GetQuantidadeFormulacao Do
  Begin
    strBasTmp := TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)], '');
    strCodBas := Copy(strBasTmp, Pos('_', strBasTmp)+1, Length(strBasTmp));
    strLinBas := Copy(strBasTmp, 1, Pos('_', strBasTmp)-1);

    if TStrUtils.fEmptyStr(strBasTmp) then
    Begin
      If TStrUtils.fEmptyStr(qryConsulta.FieldByName('WAN_CODC' + TSTRUtils.fStrZero(intContador, 2)).AsString) Then
        Break;

      strBasTmp := TStrUtils.fStrZero(qryConsulta.FieldByName('WAN_LINC' + TStrUtils.fStrZero(intContador, 2)).AsString, 3) +
            '_' + qryConsulta.FieldByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString;
      strCodBas := qryConsulta.FieldByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString;
      strLinBas := qryConsulta.FieldByName('WAN_LINC' + TStrUtils.fStrZero(intContador, 2)).AsString;


    End;

    If (TStrUtils.fEmptyStr(strBasTmp)) Then
      Break;

    If (strBasTmp = '_') Then
      Break;

    Base := TBaseAutomotiva(Formula.Add);
    Base.LinhaBase  := strLinBas;
    Base.CodigoBase := strCodBas;

    If qryConsulta.RecordCount > 0 Then
    Begin
      If dicRetorno['tippre'] = 'C' Then
        Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(qryConsulta.FieldByName('WAN_QCON' + TStrUtils.fStrZero(intContador, 2)).AsFloat, 3){ * Formula.VolumeOri / Formula.VolumePro}
      Else
      begin
        If bln4Por1 Then
          Base.QuantidadeDiluido2 := TFloatUtils.fFormataFloat(qryConsulta.FieldByName('WAN_QD41'+ TStrUtils.fStrZero(intContador, 2)).AsFloat, 3){ * Formula.VolumeOri / Formula.VolumePro}
        Else If TStrUtils.fStrZero(strLinBas, 3) = '072' Then
          Base.QuantidadeDiluido := TFloatUtils.fFormataFloat(qryConsulta.FieldByName('WAN_QD92' + TStrUtils.fStrZero(intContador, 2)).AsFloat, 3)
        Else
          base.QuantidadeDiluido := TFloatUtils.fFormataFloat(qryConsulta.FieldByName('WAN_QD21' + TStrUtils.fStrZero(intContador, 2)).AsFloat, 3);{ * Formula.VolumeOri / Formula.VolumePro}
      end;
    End
    Else
    Begin
      If dicRetorno['tippre'] = 'C' Then
        Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(TVariantUtils.IfNull(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 0.0), 3){ * Formula.VolumeOri / Formula.VolumePro}
      Else
      begin
        If bln4Por1 Then
          Base.QuantidadeDiluido2 := TFloatUtils.fFormataFloat(TVariantUtils.IfNull(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 0.0), 3){ * Formula.VolumeOri / Formula.VolumePro}
        Else If TStrUtils.fStrZero(strLinBas, 3) = '072' Then
          Base.QuantidadeDiluido := TFloatUtils.fFormataFloat(TVariantUtils.IfNull(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 0.0), 3)
        Else
          base.QuantidadeDiluido := TFloatUtils.fFormataFloat(TVariantUtils.IfNull(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 0.0), 3);{ * Formula.VolumeOri / Formula.VolumePro}
      end;
    End;

    Base.TipoBase := 'B';
    Base.Porcen   := fRetornaPorcento(dicRetorno['itetin'],intContador);
  End;
end;

procedure TLibTintaColorPro.pTintaRetornaTabelaPrecoGeneric(
  dicRetorno: IDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  Formula: TAbstractFormulaAutomotiva;
  intContador: Integer;
  strTabelaUnica: String;
  strTabelaAtual: String;
  calculadorFatVendas: ICalculadorFatVendasLibTintas;
  qryConsulta: IDataSet;
  strCodEmp: String;
begin
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendasLibTintas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      Formula := GetFormulaAutomotiva(TVariantUtils.IfNull(dicRetorno['tabpre'], '1'));
      formula.calculadorFatVendas := calculadorFatVendas;
      Formula.BlnCalculaUnitario := False;
      Formula.VolumeOri          := GetVolumeOriginal(dicRetorno);
      Formula.VolumeConcentrado  := GetVolumeConcentrado;
      Formula.VolumeDiluido      := GetVolumeDiluido;
      Formula.VolumePro          := GetVolumePro(dicRetorno);

      If dicRetorno['tippre'] = 'C' Then
        Formula.mveModoVenda     := mvConcentrado
      Else
        Formula.mveModoVenda     := mvDiluido;

      If (Not Formula.AcertoValor) And (fltFatorAcerto = 0) Then
        Formula.FatorAcerto        := 1
      Else
        Formula.FatorAcerto        := fltFatorAcerto;

      Formula.OpcDoc := TVariantUtils.IfNull(dicRetorno['opcdoc'], '');
      Formula.CodCli := TVariantUtils.IfNull(dicRetorno['codcli'], '');
      Formula.CodCnd := TVariantUtils.IfNull(dicRetorno['codcnd'], '');
      Formula.PrzMed := TVariantUtils.IfNull(dicRetorno['przmed'], 0);
      formula.OprFlj := TVariantUtils.IfNull(dicRetorno['oprflj'], '');
      formula.EmpresaProducao := TVariantUtils.IfNull(dicRetorno['empprd'], '');
      Formula.EmpCd_ := TVariantUtils.IfNull(dicRetorno['emp_cd'], '');
      Formula.CD_S_N := TVariantUtils.IfNull(dicRetorno['Cd_S_N'], '');
      Formula.EmpFat := TVariantUtils.IfNull(dicRetorno['empfat'], '');
      Formula.FatS_N := TVariantUtils.IfNull(dicRetorno['FatS_N'], '');

      strCodEmp := TAutcomTintaFactory.Get.GetCodEmp;
      TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(Formula.fVerificaEmpresaSetada);

      If Formula.AcertoValor Then
        dicRetorno['acerto'] := TAutcomTintaFactory.Get.IIF(Formula.FatorAcerto > 0, 'S', 'N')
      Else
        dicRetorno['acerto'] := TAutcomTintaFactory.Get.IIF(Formula.FatorAcerto > 1, 'S', 'N');

      If fRetornaFormulacaoParaTabelaPreco(dicRetorno, qryConsulta) Then
        Formula.AcrMob := qryConsulta.FieldByName(GetPrefixoTabela + '_ACRMOB').AsFloat
      Else
        dicRetorno['formula_nao_encontrada'] := 'S';

      Formula.CodEmb := dicRetorno['iteemb'];

      PreencherPesCorFor(Formula, qryConsulta);

      pProcessaFormulacaoTabelaPreco(Formula, dicRetorno, qryConsulta);

      Formula.CodFormul := GetCodFormul(dicRetorno);


      dicRetorno['desopetinta'] := TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGetDouble('DESOPE');

      strTabelaUnica := TVariantUtils.IfNull(dicRetorno['tabelaunica'], '');

      If (not TStrUtils.fEmptyStr(strTabelaUnica)) Then
      Begin
        Formula.TabPre := strTabelaUnica;

        Formula.CarregarBases(dicRetorno);
        Formula.CarregarBasesPorEmpresa(dicRetorno);

        Formula.CarregaPrecosBases;
        Formula.CarregaPrecosBasesPorEmpresa;

        Formula.CalcularPrecos;

        {Carrega preço da embalagem conforme tabela de preço!}
        Formula.pCarregaPrecoPromocaoEmbalagem(strTabelaUnica, TVariantUtils.IfNull(dicRetorno['opcdoc'], ''));

        If TVariantUtils.IfNull(dicRetorno['precus'], 0) <= 0 Then
        Begin
          If dicRetorno['tippre'] = 'C' Then
            dicRetorno['precus'] := Formula.PrecoCustoCon + Formula.EmbPrecoCusto
          Else
            dicRetorno['precus'] := Formula.PrecoCustoDil + Formula.EmbPrecoCusto;
        End;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['precu2'] := Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal;

          If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaCon + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
          Else
            dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaCon + Formula.EmbPrecoVenda) + Formula.AcrMob;

          dicRetorno['preve' + strTabelaUnica + '_original'] := dicRetorno['preve' + strTabelaUnica];
        End
        Else
        Begin
          dicRetorno['precu2'] := Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal;

          If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaDil + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
          Else
            dicRetorno['preve' + strTabelaUnica] := Formula.PrecoVendaDil + Formula.EmbPrecoVenda + Formula.AcrMob;

          dicRetorno['preve' + strTabelaUnica + '_original'] := dicRetorno['preve' + strTabelaUnica];
        End;

        Formula.pCalculaImpostosSaida(dicRetorno);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', Formula.tintaDeMaquina[Formula.mveModoVenda]);
        dicRetorno['promoc'] := Formula.Promoc;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos;
          dicRetorno['preult'] := Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra;
          dicRetorno['premed'] := Formula.PrecoMedioCon + Formula.EmbPrecoMedio;
          dicRetorno['prctin'] := Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido;
        End
        Else
        Begin
          dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos;
          dicRetorno['preult'] := Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra;
          dicRetorno['premed'] := Formula.PrecoMedioDil + Formula.EmbPrecoMedio;
          dicRetorno['prctin'] := Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido;
        end;

        If Formula.AcertoValor Then
        Begin
          dicRetorno['precus'] := dicRetorno['precus'] + Formula.FatorAcerto;
          dicRetorno['preve' + strTabelaUnica] := dicRetorno['preve' + strTabelaUnica] + Formula.FatorAcerto;
          dicRetorno['precu2'] := dicRetorno['precu2'] + Formula.FatorAcerto;
          dicRetorno['impult'] := dicRetorno['impult'] + Formula.FatorAcerto;
          dicRetorno['preult'] := dicRetorno['preult'] + Formula.FatorAcerto;
          dicRetorno['premed'] := dicRetorno['premed'] + Formula.FatorAcerto;
          dicRetorno['prctin'] := dicRetorno['prctin'] + Formula.FatorAcerto;
        End
        Else
        Begin
          dicRetorno['precus'] := dicRetorno['precus'] * Formula.FatorAcerto;
          dicRetorno['preve' + strTabelaUnica] := dicRetorno['preve' + strTabelaUnica] * Formula.FatorAcerto;
          dicRetorno['precu2'] := dicRetorno['precu2'] * Formula.FatorAcerto;
          dicRetorno['impult'] := dicRetorno['impult'] * Formula.FatorAcerto;
          dicRetorno['preult'] := dicRetorno['preult'] * Formula.FatorAcerto;
          dicRetorno['premed'] := dicRetorno['premed'] * Formula.FatorAcerto;
          dicRetorno['prctin'] := dicRetorno['prctin'] * Formula.FatorAcerto;
        End;
      End
      Else
      Begin
        strTabelas := TAutcomTintaFactory.Get.fCfgSis('TABPRC');
        If Length(strTabelas) < 7 Then
          strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

        strTabelaAtual := Formula.TabPre;
        For intContador := 1 To Length(strTabelas) Do
        Begin
          If strTabelas[intContador] = 'S' Then
          Begin
            Formula.TabPre := IntToStr(intContador);

            Formula.CarregarBases(dicRetorno);
            Formula.CarregarBasesPorEmpresa(dicRetorno);

            Formula.CarregaPrecosBases;
            Formula.CarregaPrecosBasesPorEmpresa;

            Formula.CalcularPrecos;

            {Carrega preço da embalagem conforme tabela de preço!}
            Formula.pCarregaPrecoPromocaoEmbalagem(Formula.TabPre, TVariantUtils.IfNull(dicRetorno['opcdoc'], ''));

            If TVariantUtils.IfNull(dicRetorno['precus'], 0) <= 0 Then
            Begin
              If dicRetorno['tippre'] = 'C' Then
              Begin
                If Formula.AcertoValor Then
                  dicRetorno['precus'] := Formula.PrecoCustoCon + Formula.EmbPrecoCusto + Formula.FatorAcerto
                Else
                  dicRetorno['precus'] := (Formula.PrecoCustoCon + Formula.EmbPrecoCusto) * Formula.FatorAcerto;
              End
              Else
              Begin
                If Formula.AcertoValor Then
                  dicRetorno['precus'] := Formula.PrecoCustoDil + Formula.EmbPrecoCusto + Formula.FatorAcerto
                Else
                  dicRetorno['precus'] := (Formula.PrecoCustoDil + Formula.EmbPrecoCusto) * Formula.FatorAcerto;
              End;
            End;

            If dicRetorno['tippre'] = 'C' Then
            Begin
              If Formula.AcertoValor Then
                dicRetorno['precu2'] := Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal + Formula.FatorAcerto
              Else
                dicRetorno['precu2'] := (Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal) * Formula.FatorAcerto;


              If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
                dicRetorno['preve' + IntToStr(intContador)] := (Formula.PrecoVendaCon + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
              Else
                dicRetorno['preve' + IntToStr(intContador)] := Formula.PrecoVendaCon + Formula.EmbPrecoVenda + Formula.AcrMob;

              dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];
            End
            Else
            Begin
              If Formula.AcertoValor Then
                dicRetorno['precu2'] := Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal + Formula.FatorAcerto
              Else
                dicRetorno['precu2'] := (Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal) * Formula.FatorAcerto;

              If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
                dicRetorno['preve' + IntToStr(intContador)] := (Formula.PrecoVendaDil + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
              Else
                dicRetorno['preve' + IntToStr(intContador)] := Formula.PrecoVendaDil + Formula.EmbPrecoVenda + Formula.AcrMob;

              dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];
            End;

            If intContador = TVariantUtils.IfNull(dicRetorno['tabpre'], 0) Then
            Begin
              Formula.pCalculaImpostosSaida(dicRetorno);
              dicRetorno.AdicionarObjeto('tintaDeMaquina', Formula.tintaDeMaquina[Formula.mveModoVenda]);
              dicRetorno['promoc'] := Formula.Promoc;

              If dicRetorno['tippre'] = 'C' Then
              Begin
                If Formula.AcertoValor Then
                Begin
                  dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos + Formula.FatorAcerto;
                  dicRetorno['preult'] := Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra + Formula.FatorAcerto;
                  dicRetorno['premed'] := Formula.PrecoMedioCon + Formula.EmbPrecoMedio + Formula.FatorAcerto;
                  dicRetorno['prctin'] := Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido + Formula.FatorAcerto;
                End
                Else
                Begin
                  dicRetorno['impult'] := (Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos) * Formula.FatorAcerto;
                  dicRetorno['preult'] := (Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra) * Formula.FatorAcerto;
                  dicRetorno['premed'] := (Formula.PrecoMedioCon + Formula.EmbPrecoMedio) * Formula.FatorAcerto;
                  dicRetorno['prctin'] := (Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido) * Formula.FatorAcerto;
                End;
              End
              Else
              Begin
                If Formula.AcertoValor Then
                Begin
                  dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos + Formula.FatorAcerto;
                  dicRetorno['preult'] := Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra + Formula.FatorAcerto;
                  dicRetorno['premed'] := Formula.PrecoMedioDil + Formula.EmbPrecoMedio + Formula.FatorAcerto;
                  dicRetorno['prctin'] := Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido + Formula.FatorAcerto;
                End
                Else
                Begin
                  dicRetorno['impult'] := (Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos) * Formula.FatorAcerto;
                  dicRetorno['preult'] := (Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra) * Formula.FatorAcerto;
                  dicRetorno['premed'] := (Formula.PrecoMedioDil + Formula.EmbPrecoMedio) * Formula.FatorAcerto;
                  dicRetorno['prctin'] := (Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido) * Formula.FatorAcerto;
                End;
              End;
            End;

            If Formula.AcertoValor Then
              dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] + Formula.FatorAcerto
            Else
              dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] * Formula.FatorAcerto;
          End;
        End;
        Formula.TabPre := strTabelaAtual;
      End;
    Except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    End;
  Finally
    TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(strCodEmp);
  End;
end;

procedure TLibTintaColorPro.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT *           ' +
                    '  FROM WANPRO_CADWAN  ' +
                    ' WHERE WAN_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
      begin
        qryGen.Close;
        qryGen.SQL := 'SELECT *             ' +
                      '  FROM WANPRO_CADWAN ' +
                      ' WHERE               ' +
                      ' 	 UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), ' +
                      ' 	  		                 IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), ' +
                      ' 		                     IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;

        if qryGen.IsEmpty then
          Exit;
      end;

      dicRetorno['codtin'] := qryGen.FieldByName('WAN_CODAKZ').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('WAN_MONTAD').AsString;
      dicRetorno['martin'] := qryGen.FieldByName('WAN_LINHA_').AsString;
      dicRetorno['catal_'] := qryGen.FieldByName('WAN_CATALI').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaColorPro.RetornaDescricaoTinta(const strDesCri: String;
  const dtsTinta: IDataSet; const strTipPre: String): String;
Var
  intCamadas: Integer;
begin
  Result := strDesCri;

  intCamadas := fVerificaQuantidadeCamadas(dtsTinta.FieldByName('WAN_MD5KEY').AsString);

  If intCamadas > 1 Then
    Result := Result + ' ' + dtsTinta.FieldByName('WAN_CAMADA').AsString + 'ª CAMADA';
end;

function TLibTintaColorPro.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

procedure TLibTintaColorPro.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
var
  intContador : Integer;
  Base        : TBaseAutomotiva;
  strLinFor   : String;
  strCamFor   : String;
  strCatalise : String;
  strCamBas   : String;
  strLinha    : String;
  strTippre   : String;
  fltVolPro   : Double;

begin
  strLinFor   := '';
  strCamFor   := '';
  strCamBas   := '';
  strLinha    := '';
  strTippre   := '';
  strCatalise := '';

  Formula.Descricao := qryConsulta.FieldByName('WAN_DESCRI').AsString + ' ' +
                       qryConsulta.FieldByName('WAN_CODAKZ').AsString + ' ' +
                       qryConsulta.FieldByName('WAN_LINHA_').AsString;

  Formula.VolumePro := dicDados['volpro'];
  strLinha          := dicDados['lintin'];
  strTippre         := dicDados['tippre'];
  strCatalise       := dicDados['catalize'];
  fltVolPro         := dicDados['volpro'];

  For intContador := 1 To formula.GetQuantidadeFormulacao Do
  Begin
    If (TStrUtils.fEmptyStr(qryConsulta.FieldByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    If (strTippre = 'C') And (qryConsulta.FieldByName('WAN_QCON' + TStrUtils.fStrZero(intContador, 2)).AsFloat <= 0) Then
      Break;

    Base := TBaseAutomotiva(Formula.Add);
    Base.LinhaBase             := qryConsulta.FieldByName('WAN_LINC' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.CodigoBase            := qryConsulta.FieldByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := qryConsulta.FieldByName('WAN_QCON' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

    If Base.LinhaBase = '72' Then
      Base.QuantidadeDiluido   := qryConsulta.FieldByName('WAN_QD92' + TStrUtils.fStrZero(intContador, 2)).AsFloat
    Else
      Base.QuantidadeDiluido   := qryConsulta.FieldByName('WAN_QD21' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

    Base.QuantidadeDiluido2    := qryConsulta.FieldByName('WAN_QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.Porcen                := qryConsulta.FieldByName('WAN_PORC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.TipoBase              := 'B';
  End;

  Formula.CarregarBases(dicDados);
  Formula.CarregaPrecosBases;

  strLinha := dicDados['lintin'];

  For intContador := 1 To formula.GetQuantidadeFormulacao Do
  Begin
    strLinFor := 'WAN_LINC' + TStrUtils.fStrZero(IntToStr(intContador), 2);
    strCamFor := 'WAN_CODC' + TStrUtils.fStrZero(IntToStr(intContador), 2);

    If (TStrUtils.fEmptyStr(qryConsulta.FieldByName(strCamFor).AsString)) Then
      Continue;

    If (Pos(TStrUtils.fStrZero(strLinha, 3), '072_') > 0) Then
    Begin
      If (strTipPre = 'C') Then
        arrFormul[intContador].fltQtdbas := (qryConsulta.FieldByName('WAN_QCON' + TStrUtils.fStrZero(intContador, 2)).AsFloat / fRetFatVen(strLinha, strCatalise, 0.9)) * fltVolPro
      Else
        arrFormul[intContador].fltQtdbas := (qryConsulta.FieldByName('WAN_QD92' + TStrUtils.fStrZero(intContador, 2)).AsFloat / fRetFatVen(strLinha, strCatalise, 0.9)) * fltVolPro;
    End
    Else If (Copy(qryConsulta.FieldByName('WAN_CODAKZ').AsString,1,3) = 'ESP')
      Or Not (Pos(TStrUtils.fStrZero(strLinha, 3), '004_001_014_013_011_027_008_058_009_006_') > 0) Then
    Begin
      If (strTippre = 'C') Then
        strCamBas := 'WAN_QCON' + TStrUtils.fStrZero(IntToStr(intContador), 2)
      Else If (Pos(TStrUtils.fStrZero(strLinha,3), '008_013_058_059_') > 0) And (strCatalise = '4:1') Then
        strCamBas := 'WAN_QD41' + TStrUtils.fStrZero(IntToStr(intContador), 2)
      Else
        strCamBas := 'WAN_QD21' + TStrUtils.fStrZero(IntToStr(intContador), 2);

      arrFormul[intContador].fltQtdBas := (qryConsulta.FieldByName(strCamBas).AsFloat / fRetFatVen(strLinha, strCatalise,0.9)) * fltVolpro;
    End
    Else
    Begin
      If (strTippre = 'C') Then
      Begin
        arrFormul[intContador].fltQtdbas := (qryConsulta.FieldByName('WAN_QCON' + TStrUtils.fStrZero(intContador, 2)).AsFloat / fRetFatVen(strLinha, strCatalise, 0.9)) * fltVolPro;
      End
      Else If strCatalise = '2:1' Then
      Begin
        arrFormul[intContador].fltQtdbas := (qryConsulta.FieldByName('WAN_QD21' + TStrUtils.fStrZero(intContador, 2)).AsFloat / fRetFatVen(strLinha, strCatalise, 0.9)) * fltVolPro;
      End
      Else
      Begin
        arrFormul[intContador].fltQtdbas := (qryConsulta.FieldByName('WAN_QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloat / fRetFatVen(strLinha, strCatalise, 0.9)) * fltVolPro;
      End;
    End;

    If (strTippre = 'C') And (arrFormul[intContador].fltQtdBas <= 0) Then
      Continue;

    arrFormul[intContador].strFormul := qryConsulta.FieldByName(strLinFor).AsString + '_' + qryConsulta.FieldByName(strCamFor).AsString;

    dicBases[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

    {*******************************************}
    {* GUARDA BASES PARA POSTERIOR BUSCA       *}
    {* DOS ITENS                               *}
    {****************************************MV*}
    strBases := strBases + QuotedStr(arrFormul[intContador].strFormul);
    If (Not TStrUtils.fEmptyStr(arrFormul[intContador].strFormul)) Then
      strBases := strBases + ', ';
  End;
end;

function TLibTintaColorPro.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraColorPro: String;
    fltFatColorPro: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('WCP');

  If (dicDados['tippre'] = 'C') Then
  Begin
    strTraColorPro := conf.fGet('TRAWAN');
    fltFatColorPro := conf.fGetDouble('FATWAN');
  End
  Else
  Begin
    strTraColorPro := conf.fGet('TRDWAN');
    fltFatColorPro := conf.fGetDouble('FADWAN');
  End;

  If strTraColorPro = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatColorPro;

  Result := TFloatUtils.fFormataFloat(Result, 2);
end;

procedure TLibTintaColorPro.SetaParametrosRetComponentes(
  const dataSet: IDataSet; const strCodComp: String);
begin
  dataSet.ParamByName('CODBAS').AsString := strCodComp;
end;

end.

