unit untAutcomTintaCalamar;

interface

uses
  untIAutcomTinta, untFuncoesSimples, Uni, Classes, Forms, SysUtils, untAbstractAutcomTintaImobiliaria,
  untTintadeMaquina, untIFormulaImobiliaria;

type
  TAutcomTintaCalamar = class(TAbstractAutcomTintaImobiliaria, IAutcomTinta)
  protected
    function GetNomeTabelaColorantes(): string; override;
    function GetIdePro(): string; override;
    function fRetornaProdutoBase(qryCadTinta: TUniQuery): string; override;
    function fGetUnidade(qryCadTinta: TUniQuery): string; override;
    function fGetDescri(qryCadTinta: TUniQuery): string; override;
    procedure pPreencheDicionarioDadosTinta(qryTinta: TUniQuery; dicDados: TDicionario); override;
    function GetTintadeMaquinaClasse: TTintadeMaquinaClasse; override;
    function GetIteTin(qryTinta: TUniQuery): string; override;
    function fGetPrefixoNomeCampoFormulacao(): string; override;
    function fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre: string): string; override;
    function fGetSqlGTinFor: string; override;
    function fGetSqlComponentesGTinFor(const strComponente: string):string; override;
    function GetIFormulaImobiliaria(): IFormulaImobiliaria; override;
    function GetNomeClasseNovasFormulas: string; override;
    function GetItemBaseOri(const strIteTin: String): string; override;
    function fGetQtdBaixa(fltValor: Double; fltVolumePro: Double): Double; override;
    function fGetNomeCampoAcrescimoMaoObra: String; override;
  public
    Function fGetFatorML(): Double; override;   
  end;

implementation

uses
  untFormulaImobiliariaCalamar, untCalamarConsulta, untAutcomTintaFactory, Data.DB;

{ TAutcomTintaCalamar }

function TAutcomTintaCalamar.fGetDescri(qryCadTinta: TUniQuery): string;
begin
  Result := Format('%s %s %s %s %s', [
    qryCadTinta.FieldByName('CAL_CODBAS').AsString,
    qryCadTinta.FieldByName('CAL_CODEMB').AsString,
    qryCadTinta.FieldByName('CAL_KEY1__').AsString,
    qryCadTinta.FieldByName('CAL_KEY2__').AsString,
    qryCadTinta.FieldByName('CAL_KEY3__').AsString
  ]);
end;

function TAutcomTintaCalamar.fGetFatorML: Double;
begin
  Result := 0.3254;
end;

function TAutcomTintaCalamar.fGetNomeCampoAcrescimoMaoObra: String;
begin
  Result := '';
end;

function TAutcomTintaCalamar.fGetPrefixoNomeCampoFormulacao: string;
begin
  Result := 'CAL_CODC';
end;

function TAutcomTintaCalamar.fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre: string): string;
begin
  Result := 'CAL_QTDC';
end;

function TAutcomTintaCalamar.fGetQtdBaixa(fltValor,
  fltVolumePro: Double): Double;
begin
  Result := fltValor * fGetFatorML;
end;

function TAutcomTintaCalamar.fGetSqlComponentesGTinFor(const strComponente: string): string;
begin
  Result :=
    ' SELECT                     ' +
    '   COL_CODCOL AS CODCOMP    ' +
    '   , COL_CODITE AS CODITE   ' +
    ' FROM                       ' +
    '   CAL_CADCOL               ' +
    ' WHERE ' + GetInToOr('COL_CODCOL', strComponente);
end;

function TAutcomTintaCalamar.fGetSqlGTinFor: string;
begin
  Result :=
    ' SELECT                       ' +
    '   *                          ' +
    ' FROM                         ' +
    '   CAL_CADCAL                 ' +
    ' WHERE CAL_MD5KEY = :ITETIN   ';
end;

function TAutcomTintaCalamar.fGetUnidade(qryCadTinta: TUniQuery): string;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   EMB_CODUNI               ' +
        ' FROM                       ' +
        '   CAL_CADEMB               ' +
        ' WHERE EMB_CODEMB = :CODEMB ';
      qryGen.ParamByName('CODEMB').AsString := qryCadTinta.FieldByName('CAL_CODEMB').AsString;
      qryGen.Open;

      if not qryGen.IsEmpty then
        Result := qryGen.FieldByName('EMB_CODUNI').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TAutcomTintaCalamar.fRetornaProdutoBase(qryCadTinta: TUniQuery): string;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   BAS_CODITE               ' +
        ' FROM                       ' +
        '   CAL_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODEMB = :CODEMB ';
      qryGen.ParamByName('CODBAS').AsString := qryCadTinta.FieldByName('CAL_CODBAS').AsString;
      qryGen.ParamByName('CODEMB').AsString := qryCadTinta.FieldByName('CAL_CODEMB').AsString;
      qryGen.Open;

      if not qryGen.IsEmpty then
        Result := qryGen.FieldByName('BAS_CODITE').AsString;
      
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;  
end;

function TAutcomTintaCalamar.GetIdePro: string;
begin
  Result := 'CAL';
end;

function TAutcomTintaCalamar.GetIFormulaImobiliaria: IFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaCalamar.Create;
end;

function TAutcomTintaCalamar.GetItemBaseOri(const strIteTin: String): string;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                          ' +
        '   BAS_CODITE                    ' +
        ' FROM                            ' +
        '   CAL_CADCAL                    ' +
        '   INNER JOIN CAL_CADBAS         ' +
        '     ON CAL_CODBAS = BAS_CODBAS  ' +
        '     AND CAL_CODEMB = BAS_CODEMB ' +
        ' WHERE CAL_MD5KEY = :ITETIN      ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if not qryGen.IsEmpty then
        Result := qryGen.FieldByName('BAS_CODITE').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TAutcomTintaCalamar.GetIteTin(qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('CAL_MD5KEY').AsString;
end;

function TAutcomTintaCalamar.GetNomeClasseNovasFormulas: string;
begin
  Result := 'TfrmNovasFormulasCalamar';  
end;

function TAutcomTintaCalamar.GetNomeTabelaColorantes: string;
begin
  Result := 'CAL_CADCOL';
end;

function TAutcomTintaCalamar.GetTintadeMaquinaClasse: TTintadeMaquinaClasse;
begin
  Result := TCalamarConsulta;
end;

procedure TAutcomTintaCalamar.pPreencheDicionarioDadosTinta(qryTinta: TUniQuery; dicDados: TDicionario);
begin

end;

initialization
  TAutcomTintaFactory.Registrar('CAL', TAutcomTintaCalamar);

end.

