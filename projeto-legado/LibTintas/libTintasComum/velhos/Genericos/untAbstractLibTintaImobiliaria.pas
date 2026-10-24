{*********************************************************************************************}
{* Classe abstrata que representa a tinta Imobiliária ao todo, contendo todos os metodos que *}
{* serão acessados pelos outros modulos (Autcom/Auttin)                                      *}
{******************************************************************************************PH*}
unit untAbstractLibTintaImobiliaria;

interface

uses
  untAbstractLibTinta, untTipoTinta, untILibTinta, untIDataSet, SysUtils, untIDicionario,
  untAbstractFormulaImobiliaria, untITintadeMaquinaWrapper, untICalculadorPrecoTinta,
  untDigDadosTintometricosImobiliaria, untGTinForTipos, Classes, StrUtils,
  untIDigDadosTintometricos, untISaldosColorantes;

type
  TAbstractLibTintaImobiliaria = class abstract (TAbstractLibTinta, ILibTinta)
  protected
    function GetWhereRetComponente(): String; override;
    procedure SetaParametrosRetComponentes(const dataSet: IDataSet; const strCodComp: String); override;
    function GetCampoComponenteCodIte(): String; override;
    function GetCampoComponenteCodComp(): String; override;
    function GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria; overload; virtual; abstract;
    function GetFormulaImobiliaria(): TAbstractFormulaImobiliaria; overload;
    function GetFatorEstoque(): Double; override;
    function GetSQLColorantesGTinFor(const strColorantes: string): string; virtual; abstract;
    function GetNomeCampoColoranteCodIte(): String; virtual;
    function GetNomeCampoColoranteCodCol(): string; virtual;
  public
    function fTipoTinta: TTipoTinta; override;
    function fTintaBaixaProduto(): Boolean; override;
    function fTintaBaixaEmbalagem(const strTipEmb: String; Var strCodIte: String): Boolean; override;
    function fTravaQuantidadeTinta(const strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean; override;
    function fFormulacaoAcumulada(): Boolean; override;
    procedure pTintaRetornaTabelaPreco(const dicRetorno: IDicionario; fltFatorAcerto: Double); override;
    function GetIdePro: String; override;
    function fRetornaTabelaColoranteTinta(): String; override;
    destructor Destroy; override;
    function RetornaPreco(const Sender: TObject; const dtsTinta: IDataSet; const dicRetorno: IDicionario;
      var saldos: ISaldosColorantes): Boolean; override;
    function fGTinForGeral(var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray;
      const dicDados: IDicionario): Boolean; override;
    function GetDigDadosTintometricos(strTabPre: string): IDigDadosTintometricos; override;
  end;

implementation

uses
  untColorante, untStrUtils, untVariantUtils, untFloatUtils, untAutcomTintaFactory, untAbstractCalculadorPrecoTinta;

{ TAbstractLibTintaImobiliaria }

destructor TAbstractLibTintaImobiliaria.Destroy;
begin
  inherited Destroy;
end;

function TAbstractLibTintaImobiliaria.fFormulacaoAcumulada: Boolean;
begin
  Result := False;
end;

function TAbstractLibTintaImobiliaria.fGTinForGeral(var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray;
  const dicDados: IDicionario): Boolean;
var
  qryConsulta: IDataSet;
  intCont: Integer;
  formula: TAbstractFormulaImobiliaria;
  dicColorantes: IDicionario;
  strColorantes: string;
  qryColorantes: IDataSet;
  intPos: Integer;
  stlItensTraMl: TStringList;
begin
  Result := False;
  stlItensTraMl := nil;
  Try
    Try
      qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;

      qryConsulta.Close;
      qryConsulta.SQL :=
        ' SELECT           ' +
        '   *              ' +
        ' FROM             ' +
        '   SUV_CADSUV     ' +
        ' WHERE CONCAT(    ' +
        '     SUV_REFERE   ' +
        '     , " "        ' +
        '     , SUV_CODBAS ' +
        '     , " "        ' +
        '     , SUV_CODFML ' +
        '     , SUV_UNIDAD ' +
        '     , SUV_DESCRI ' +
        '   ) = :ITETIN    ';
      qryConsulta.ParamByName('ITETIN').AsString := TVariantUtils.IfNull(dicDados['itetin'], '');
      qryConsulta.Open;

      if qryConsulta.IsEmpty then
      begin
        qryConsulta.Close;
        qryConsulta.SQL :=
          ' SELECT           ' +
          '   *              ' +
          ' FROM             ' +
          '   SUV_CADSUV     ' +
          ' WHERE CONCAT(    ' +
          '     SUV_REFERE   ' +
          '     , SUV_UNIDAD ' +
          '     , SUV_DESCRI ' +
          '   ) = :ITETIN    ';
        qryConsulta.ParamByName('ITETIN').AsString := TVariantUtils.IfNull(dicDados['itetin'], '');
        qryConsulta.Open;

        if qryConsulta.IsEmpty then
        begin
          qryConsulta.Close;
          qryConsulta.SQL :=
            ' SELECT           ' +
            '   *              ' +
            ' FROM             ' +
            '   SUV_CADSUV     ' +
            ' WHERE CONCAT(    ' +
            '     SUV_DESCRI   ' +
            '     , " "        ' +
            '     , SUV_CODBAS ' +
            '     , " "        ' +
            '     , SUV_CODFML ' +
            '     , SUV_UNIDAD ' +
            '     , SUV_REFERE ' +
            '   ) = :ITETIN    ';
          qryConsulta.ParamByName('ITETIN').AsString := TVariantUtils.IfNull(dicDados['itetin'], '');
          qryConsulta.Open;
        end;
      end;

      Result := not qryConsulta.IsEmpty;
      if not Result then
        Exit;

      formula := GetFormulaImobiliaria();
      dicColorantes := TAutcomTintaFactory.Get.GetDicionario;

      for intCont := 1 to formula.GetQuantidadeFormulacao - 1 do
      begin
        arrFormul[intCont].strFormul := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;
        arrFormul[intCont].fltQtdbas := qryConsulta.FieldByName(formula.GetPrefixoQuantidade('') + TStrUtils.fStrZero(intCont, 2)).AsFloat * 0.154;
        dicColorantes[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

        strColorantes := strColorantes + QuotedStr(arrFormul[intCont].strFormul);
        If (Not TStrUtils.fEmptyStr(arrFormul[intCont].strFormul)) Then
          strColorantes := strColorantes + ', ';
      end;

      strColorantes := Trim(strColorantes);
      If (RightStr(strColorantes, 1) = ',') Then
        strColorantes := Copy(strColorantes, 1, Length(strColorantes)-1);

      qryColorantes := TAutcomTintaFactory.Get.fGetDataSet;
      qryColorantes.Close;
      qryColorantes.SQL := GetSQLColorantesGTinFor(strColorantes);
      qryColorantes.Open;

      intPos := 0;
      stlItensTraMl := TStringList.Create;
      SetLength(arrBaixaPigmentos, qryColorantes.RecordCount);

      while not qryColorantes.Eof do
      begin
        stlItensTraMl.Add(qryColorantes.FieldByName(GetNomeCampoColoranteCodIte).AsString);
        arrBaixaPigmentos[intPos].strCodIte   := qryColorantes.FieldByName(GetNomeCampoColoranteCodIte).AsString;
        arrBaixaPigmentos[intPos].fltQtdBaixa := dicColorantes[qryColorantes.FieldByName(GetNomeCampoColoranteCodCol).AsString];
        Inc(intPos);
        qryColorantes.Next;
      end;

      dicDados['stlItensTraMl'] := stlItensTraMl.Text;
      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlItensTraMl) then FreeAndNil(stlItensTraMl);
  End;
end;

function TAbstractLibTintaImobiliaria.fRetornaTabelaColoranteTinta: String;
begin
  Result := GetFormulaImobiliaria.fRetornaTabelaColoranteTinta;
end;

function TAbstractLibTintaImobiliaria.fTintaBaixaEmbalagem(const strTipEmb: String; var strCodIte: String): Boolean;
begin
  Result := False;
end;

function TAbstractLibTintaImobiliaria.fTintaBaixaProduto: Boolean;
begin
  Result := True;
end;

function TAbstractLibTintaImobiliaria.fTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TAbstractLibTintaImobiliaria.fTravaQuantidadeTinta(const strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean;
begin
  Result := False;
end;

function TAbstractLibTintaImobiliaria.GetCampoComponenteCodComp: String;
begin
  Result := 'COL_CODCOL';
end;

function TAbstractLibTintaImobiliaria.GetCampoComponenteCodIte: String;
begin
  Result := 'COL_CODITE';
end;

function TAbstractLibTintaImobiliaria.GetDigDadosTintometricos(strTabPre: string): IDigDadosTintometricos;
begin
  if TStrUtils.fEmptyStr(strTabPre) then
  begin
    strTabPre := TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString);
    if TStrUtils.fEmptyStr(strTabPre) then
    begin
      strTabPre := '1';
    end;
  end;

  Result := TDigDadosTintometricosImobiliaria.Create(GetFormulaImobiliaria(strTabPre));
end;

function TAbstractLibTintaImobiliaria.GetFatorEstoque: Double;
begin
  Result := GetFormulaImobiliaria.GetFatorEstoque;
end;

function TAbstractLibTintaImobiliaria.GetFormulaImobiliaria: TAbstractFormulaImobiliaria;
begin
  Result := GetFormulaImobiliaria(TVariantUtils.IfNull(TAutcomTintaFactory.Get.fCfgSis('TABPAD'), '1'));
end;

function TAbstractLibTintaImobiliaria.GetIdePro: String;
var
  formula: TAbstractFormulaImobiliaria;
begin
  formula := nil;
  Try
    Try
      formula := GetFormulaImobiliaria;
      Result := formula.GetIdePro;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(formula) then FreeAndNil(formula);
  End;
end;

function TAbstractLibTintaImobiliaria.GetNomeCampoColoranteCodCol: string;
begin
  Result := 'COL_CODCOL';
end;

function TAbstractLibTintaImobiliaria.GetNomeCampoColoranteCodIte: String;
begin
  Result := 'COL_CODITE';
end;

function TAbstractLibTintaImobiliaria.GetWhereRetComponente: String;
begin
  Result := Format('%s = :%0:s', [GetCampoComponenteCodComp]);
end;

procedure TAbstractLibTintaImobiliaria.pTintaRetornaTabelaPreco(const dicRetorno: IDicionario; fltFatorAcerto: Double);
var
  formula: TAbstractFormulaImobiliaria;
  intCols: Integer;
  colorante: TColorante;
begin
  Try
    Try
      formula := GetFormulaImobiliaria(TVariantUtils.IfNull(dicRetorno['tabpre'], '1'));
      formula.ItemBaseOriginal := formula.GetItemBaseOriginal(dicRetorno['itetin']);

      for intCols := 1 to formula.GetQuantidadeFormulacao do
      begin
        If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intCols, 2)], ''))) Then
          Break;

        colorante := TColorante(formula.Add);
        colorante.CodigoColorante := dicRetorno['base' + TStrUtils.fStrZero(intCols, 2)];
        colorante.Quantidade := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intCols, 2)] / formula.FatorEstoque, 3);
      end;
      
      formula.ItemBase := TVariantUtils.IfNull(dicRetorno['itebas'], '');
      formula.RecalcularTabelas(dicRetorno);
      
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TAbstractLibTintaImobiliaria.RetornaPreco(const Sender: TObject; const dtsTinta: IDataSet; const dicRetorno: IDicionario;
  var saldos: ISaldosColorantes): Boolean;
Var
  strTabPre: String;
  tintadeMaquinaWrapper: ITintadeMaquinaWrapper;
  calculador: ICalculadorPrecoTinta;
  digDados: IDigDadosTintometricos;
begin
  Result := False;
  saldos := nil;
  Try
    Try
      tintadeMaquinaWrapper := Self.GetITintadeMaquina;

      strTabPre    := TVariantUtils.IfNull(dicRetorno['tabpre'], '');
      if TStrUtils.fEmptyStr(strTabPre) then
      begin
        strTabPre := TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString);
        if TStrUtils.fEmptyStr(strTabPre) then
        begin
          strTabPre := '1';
        end;
      end;

      digDados := GetDigDadosTintometricos(strTabPre);
      calculador := TAbstractCalculadorPrecoTinta.Create(digDados);

      if not calculador.fRetornaPreco(Sender, dicRetorno, dtsTinta) then
        Exit;

      saldos := digDados.GetSaldos;
      Result := True;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

procedure TAbstractLibTintaImobiliaria.SetaParametrosRetComponentes(const dataSet: IDataSet; const strCodComp: String);
begin
  dataSet.ParamByName(GetCampoComponenteCodComp).AsString := strCodComp;
end;

end.
