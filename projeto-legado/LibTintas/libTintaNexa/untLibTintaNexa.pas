{**************************************************************************}
{* Classe contendo as informações especificas da tinta Nex *}
{***********************************************************************MH*}
unit untLibTintaNexa;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes;



type
  TLibTintaNexa = class(TAbstractLibTintaAutomotiva)
  private
    function fSelectBasesEmpresa(strCodEmp: String): String;
  protected
    function GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva; override;
    function GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string; override;
    function GetSQLBasesEmpGTinFor(const strBases: String; Const dicDados: IDicionario): String; override;

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
    procedure pProcessaBaixaPigmentosGTinFor(qryBases: IDataSet; intPos: Integer; Var List: TStringList;
      arrBaixaPigmentos: TBaixaPigmentosArray; dicBases: IDicionario; Const dicDados: IDicionario; strBases: String); Override;

    function GetPrefixoTabela: String; override;
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
    function fArredondaNex(fltValor: Double): Double;
    procedure pRetItemColorante(const strColTinDet: String; Var strCodIte, strCodBas, strDesBas: String; const strCodEmp: String); Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemNexa,
{$ENDIF}
  untFormulaAutomotivaNexa, untTintadeMaquinaWrapperNexa, untAutcomTintaFactory, untVariantUtils;

{ TNexTintadeMaquina }

{function TLibTintaNexa.fValidarMd5Key(strIteTin: String): Boolean;
begin
  Result := True;
end;
 }
function TLibTintaNexa.fArredondaNex(fltValor: Double): Double;
Var
  strAux: String;
begin
  strAux := Format('%.2f', [fltValor]);
  strAux := Copy(strAux, 1, Length(strAux) - 1);

  If TAutcomTintaFactory.Get.fStrToFloat(strAux) = 0 Then
    strAux := Format('%.2f', [fltValor]);

  Result := TAutcomTintaFactory.Get.fStrToFloat(strAux);
end;


function TLibTintaNexa.fSelectBasesEmpresa(strCodEmp: String): String;
begin
  Result := ' SELECT              ';
  Result := Result + '    BAS_CODITE,     ';
  Result := Result + '    BAS_CODBAS      ';
  Result := Result + ' FROM       ';
  Result := Result + '    NEX_BASEMP      ';
  Result := Result + ' WHERE BAS_CODBAS = :BAS_CODBAS   ';
  Result := Result + '  AND BAS_CODEMP = "' + strCodEmp + '"  ';
end;

function TLibTintaNexa.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaNexa.GetCodFormul(const dicRetorno: IDicionario): string;
begin
   Result := dicRetorno['sistem'];
end;

function TLibTintaNexa.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaNexa.Create(strTabPre);
end;

function TLibTintaNexa.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperNexa.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaNexa.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemNexa.Create();
{$ENDIF}
end;

function TLibTintaNexa.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORNEXA';
end;

function TLibTintaNexa.GetNomeTinta: String;
begin
  Result := 'Nexa Autocolor';
end;

function TLibTintaNexa.GetPrefixoTabela: String;
begin
  Result := 'NEX';
end;

function TLibTintaNexa.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaNexa.GetSQLBasesEmpGTinFor(const strBases: String;
  const dicDados: IDicionario): String;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    BAS_CODBAS,       ';
  Result := Result + '    BAS_CODITE        ';
  Result := Result + '  FROM                ';
  Result := Result + '    NEX_BASEMP        ';
  Result := Result + '  WHERE               ';
  Result := Result + '    BAS_CODBAS IN (' + strBases + ') AND        ';
  Result := Result + '    BAS_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  AND       ';
  Result := Result + '    BAS_CODITE IS NOT NULL                      ';
end;

function TLibTintaNexa.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result := ' SELECT                                     ' +
            '    BAS_CODBAS                              ' +
            '  , BAS_CODITE                              ' +
            ' FROM                                       ' +
            '   NEX_CADBAS                               ' +
            ' WHERE BAS_CODBAS IN (' + strBases + ')     ';
end;

function TLibTintaNexa.GetVolumeConcentrado: Double;
begin
  Result := 1;
end;

function TLibTintaNexa.GetVolumeDiluido: Double;
begin
  Result := 1;
end;

function TLibTintaNexa.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 1;
end;

function TLibTintaNexa.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaNexa.pProcessaBaixaPigmentosGTinFor(qryBases: IDataSet;
  intPos: Integer; Var List: TStringList; arrBaixaPigmentos: TBaixaPigmentosArray;
  dicBases: IDicionario; Const dicDados: IDicionario; strBases: String);
Var
  qryBasEmp: IDataSet;
  strBasEmp: String;
Begin
  qryBasEmp := TAutcomTintaFactory.Get.fGetDataset;
  qryBasEmp.Close;
  qryBasEmp.SQL := GetSQLBasesEmpGTinFor(strBases, dicDados);
  qryBasEmp.Open;

  While (Not qryBasEmp.Eof) Do
  Begin

    If dicBases[qryBasEmp.FieldByName('BAS_CODBAS').AsString] <= 0 Then
    Begin
      qryBasEmp.Next;
      Continue;
    End;

    List.Add(qryBasEmp.FieldByName(GetNomeCampoBaseCodIte).AsString);
    arrBaixaPigmentos[intPos].strCodIte   := qryBasEmp.FieldByName(GetNomeCampoBaseCodIte).AsString;
    arrBaixaPigmentos[intPos].fltQtdBaixa := dicBases[qryBasEmp.FieldByName('BAS_CODBAS').AsString];
    arrBaixaPigmentos[intPos].strFormul   := GetFormulArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].strPesGra   := GetPesGraArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].fltEmbBas   := GetEmbalaArrBaixaPigmentos(qryBases);

    strBasEmp := strBasEmp + '"' + qryBasEmp.FieldByName('BAS_CODBAS').AsString + '", ';

    Inc(intPos);
    qryBasEmp.Next;
  End;

  While Not qryBases.Eof Do
  Begin

    If Pos(qryBases.FieldByName('BAS_CODBAS').AsString, strBasEmp) > 0 Then
    Begin
      qryBases.Next;
      Continue;
    End;

    If fRetornaQuantidadeBaixaGTinFor(dicBases, qryBases) <= 0 Then
    Begin
      qryBases.Next;
      Continue;
    End;

    List.Add(qryBases.FieldByName(GetNomeCampoBaseCodIte).AsString);
    arrBaixaPigmentos[intPos].strCodIte   := qryBases.FieldByName(GetNomeCampoBaseCodIte).AsString;
    arrBaixaPigmentos[intPos].fltQtdBaixa := fRetornaQuantidadeBaixaGTinFor(dicBases, qryBases);
    arrBaixaPigmentos[intPos].strFormul   := GetFormulArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].strPesGra   := GetPesGraArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].fltEmbBas   := GetEmbalaArrBaixaPigmentos(qryBases);

    Inc(intPos);
    qryBases.Next;
  End;
End;

procedure TLibTintaNexa.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  intCont              : Integer;
  Base                 : TBaseAutomotiva;
  qryBases             : IDataSet;
  fltQuantidade        : Double;
begin
  qryBases     := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := 'SELECT * '+
                  '  FROM NEX_CADBAS';
  qryBases.Open;


  For intCont := 1 to formula.GetQuantidadeFormulacao do
  begin
    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade('') + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      Break;

    Base := TBaseAutomotiva(Formula.Add);
    Base.CodigoBase            := qryConsulta.FieldByName('NEX_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString;
    Base.QuantidadeConcentrado := qryConsulta.FieldByName('NEX_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
    Base.TipoBase              := 'B';

    if qryBases.Locate('BAS_CODBAS', Base.CodigoBase, []) then
    begin
      Base.PesoEspecifico := qryBases.FieldByName('BAS_PESESP').AsFloat;
      Base.Embalagem      := qryBases.FieldByName('BAS_EMBALA').AsFloat;
    end;
  end;

  Formula.pCalcularDiluente(dicDados['coddil'], dicDados['pordil'], qryConsulta);

  For intCont := 0 To Formula.Count - 1 Do
  Begin
    If Pos('PERSONALIZ', qryConsulta.FieldByName('NEX_SISTEM').AsString) <= 0 Then
    Begin
      If dicDados['tippre']  = 'C' Then
        fltQuantidade := fArredondaNex(TFloatUtils.fFormataFloat(TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado, 1) * dicDados['volpro'])
      Else
        fltQuantidade := fArredondaNex(TFloatUtils.fFormataFloat(TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido, 1) * dicDados['volpro']);
    End
    Else
    Begin
      If dicDados['tippre']  = 'C' Then
        fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado * dicDados['volpro']
      Else
        fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido * dicDados['volpro'];
    End;

    if fltQuantidade <= 0 then
      Continue;

    arrFormul[intCont + 1].strFormul := TBaseAutomotiva(Formula.Items[intCont]).CodigoBase;
    arrFormul[intCont + 1].fltQtdbas := fltQuantidade;

    dicBases[arrFormul[intCont + 1].strFormul] := arrFormul[intCont + 1].fltQtdbas;
    strBases := strBases + '"' + arrFormul[intCont + 1].strFormul + '", ';
  End;


end;

procedure TLibTintaNexa.pProcessaFormulacaoTabelaPreco( Formula: TAbstractFormulaAutomotiva;
  const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intCont              : Integer;
  Base                 : TBaseAutomotiva;
begin
  dicRetorno['sistem'] := qryConsulta.FieldByName('NEX_SISTEM').AsString;

  For intCont := 1 To 20 Do
  Begin

    If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intCont, 2)], ''))) Then
      Break;

    Base := TBaseAutomotiva(Formula.Add);
    Base.CodigoBase := dicRetorno['base' + TStrUtils.fStrZero(intCont, 2)];

    If dicRetorno['tippre'] = 'C' Then
      Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intCont, 2)], 3) * Formula.VolumeOri  / Formula.VolumePro
    Else
      Base.QuantidadeDiluido     := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intCont, 2)], 3) * Formula.VolumeOri  / Formula.VolumePro;

    Base.TipoBase := 'B';
  End;


end;


procedure TLibTintaNexa.pRetItemColorante(const strColTinDet: String;
  var strCodIte, strCodBas, strDesBas: String; const strCodEmp: String);
var
  dataSet: IDataSet;
begin
  dataSet := nil;
  strCodIte := '';
  strCodBas := '';
  Try
    Try
      dataSet := TAutcomTintaFactory.Get().fGetDataSet;
      dataSet.SQL:= fSelectBasesEmpresa(strCodEmp);
      SetaParametrosRetComponentes(dataSet, strColTinDet);
      dataSet.Open;

      If Not DataSet.IsEmpty Then
      Begin
        strCodIte := dataSet.FieldByName(GetCampoComponenteCodIte).AsString;
        strCodBas := dataSet.FieldByName(GetCampoComponenteCodComp).AsString;
      End;

      dataSet.Close;
      DataSet.SQL := GetInstrucaoRetComponentes(strCodEmp);
      SetaParametrosRetComponentes(dataSet, strColTinDet);
      dataSet.Open;

      If TStrUtils.fEmptyStr(strCodIte) Then
        strCodIte := dataSet.FieldByName(GetCampoComponenteCodIte).AsString;

      If TStrUtils.fEmptyStr(strCodBas) Then
        strCodBas := dataSet.FieldByName(GetCampoComponenteCodComp).AsString;

      strDesBas := dataSet.FieldByName('DESBAS').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    dataSet := nil;
  End;
end;

procedure TLibTintaNexa.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
Var
  qryCadGen: IDataSet;
  strSQL   : String;
begin
  Try
    Try
      qryCadGen := TAutcomTintaFactory.Get.fGetDataSet;

      strSQL := '';
      strSQL := strSQL + ' SELECT *  ';
      strSQL := strSQL + ' FROM NEX_CADNEX  ';
      strSQL := strSQL + ' WHERE CONCAT( ';
      strSQL := strSQL + '    IFNULL(NEX_DESCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_VEICUL, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_MONTAD, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_TIPO__, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_A_N_O_, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODATC, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB01, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB01, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB02, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB02, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB03, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB03, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB04, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB04, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB05, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB05, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB06, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB06, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB07, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB07, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB08, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB08, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB09, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB09, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB10, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB10, "")) = :ITETIN;  ';

      qryCadGen.Close;
      qryCadGen.SQL := strSQL;
      qryCadGen.ParamByName('ITETIN').AsString := strIteTin;
      qryCadGen.Open;

      if qryCadGen.IsEmpty then
      begin
        strSQL := '';
        strSQL := strSQL + ' SELECT *  ';
        strSQL := strSQL + ' FROM NEX_CADNEX  ';
        strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
        strSQL := strSQL + '    IFNULL(NEX_DESCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_VEICUL, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_MONTAD, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_TIPO__, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_A_N_O_, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODATC, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODB01, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB01, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODB02, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB02, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODB03, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB03, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODB04, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB04, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODB05, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB05, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODB06, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB06, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODB07, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB07, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODB08, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB08, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODB09, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB09, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_CODB10, ""),   ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB10, ""))) AS CHAR) = :ITETIN;  ';

        qryCadGen.Close;
        qryCadGen.SQL := strSQL;
        qryCadGen.ParamByName('ITETIN').AsString := strIteTin;
        qryCadGen.Open;

        if (qryCadGen.IsEmpty) then
        begin
          strSQL := '';
          strSQL := strSQL + ' SELECT *  ';
          strSQL := strSQL + ' FROM NEX_CADNEX  ';
          strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
          strSQL := strSQL + '    IFNULL(NEX_DESCOR, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_VEICUL, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_MONTAD, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_TIPO__, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_A_N_O_, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODCOR, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODATC, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB01, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB01, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB02, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB02, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB03, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB03, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB04, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB04, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB05, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB05, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB06, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB06, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB07, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB07, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB08, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB08, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB09, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB09, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB10, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB10, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB11, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB11, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB12, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB12, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB13, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB13, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB14, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB14, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB15, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB15, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB16, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB16, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB17, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB17, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB18, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB18, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB19, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB19, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_CODB20, ""),   ';
          strSQL := strSQL + '    IFNULL(NEX_QTDB20, ""))) AS CHAR) = :ITETIN;  ';

          qryCadGen.Close;
          qryCadGen.SQL := strSQL;
          qryCadGen.ParamByName('ITETIN').AsString := strIteTin;
          qryCadGen.Open;

        end;
      end;

      if qryCadGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryCadGen.FieldByName('NEX_CODCOR').AsString;
      dicRetorno['montad'] := qryCadGen.FieldByName('NEX_MONTAD').AsString;
      dicRetorno['martin'] := qryCadGen.FieldByName('NEX_TIPO__').AsString;


    Except
      on E: Exception do
      begin
        raise;
      end;
    End;

  Finally

  End;
end;

function TLibTintaNexa.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaNexa.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraNex: String;
    fltTraNex: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('NEX');

  strTraNex := conf.fGet('TRANEX');
  fltTraNex := conf.fGetDouble('FATNEX');

  If (strTraNex = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraNex, 2);
end;

end.
