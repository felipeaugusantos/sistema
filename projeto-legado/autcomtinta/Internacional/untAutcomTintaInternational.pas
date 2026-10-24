unit untAutcomTintaInternational;

interface

uses
  untIAutcomTinta, untFuncoesSimples, Uni, Classes, Forms, SysUtils, untAbstractAutcomTintaImobiliaria,
  untTintadeMaquina, untIFormulaImobiliaria;

type
  TAutcomTintaInternational = class(TAbstractAutcomTintaImobiliaria, IAutcomTinta)
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
    function fGetNomeCampoAcrescimoMaoObra: String; override;
  public
    function fGetFatorML: Double; override;
  end;

  function fRetMlParaOnca(ftlValor : Double) : String;

implementation

uses
  untInternationalConsulta, untFormulaInternational, Data.DB;

{ TAutcomTintaInternational }

function TAutcomTintaInternational.fGetDescri(qryCadTinta: TUniQuery): string;
begin
  Result := Format('%s %s %s', [
    qryCadTinta.FieldByName('INT_DESCOR').AsString,
    qryCadTinta.FieldByName('INT_CODBAS').AsString,
    qryCadTinta.FieldByName('INT_CODEMB').AsString
  ]);
end;

function TAutcomTintaInternational.fGetFatorML: Double;
begin
  Result := 1;
end;

function TAutcomTintaInternational.fGetNomeCampoAcrescimoMaoObra: String;
begin
  Result := '';
end;

function TAutcomTintaInternational.fGetPrefixoNomeCampoFormulacao: string;
begin
  Result := 'INT_FORM';                                        
end;

function TAutcomTintaInternational.fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre: string): string;
begin
  Result := 'INT_QTDC';
end;

function TAutcomTintaInternational.fGetSqlComponentesGTinFor(const strComponente: string): string;
begin
  Result :=
    ' SELECT                        ' +
    '   COL_CODCOL AS CODCOMP       ' +
    '   , COL_CODITE AS CODITE      ' +
    ' FROM                          ' +
    '   INT_CADCOL                  ' +
    ' WHERE COL_CODCOL IN (' + strComponente + ')';
end;

function TAutcomTintaInternational.fGetSqlGTinFor: string;
begin
  Result :=
    ' SELECT                       ' +
    '   *                          ' +
    ' FROM                         ' +
    '   INT_CADINT                 ' +
    ' WHERE INT_MD5KEY = :ITETIN   ';
end;

function TAutcomTintaInternational.fGetUnidade(qryCadTinta: TUniQuery): string;
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
        '   INT_CADEMB               ' +
        ' WHERE EMB_CODEMB = :CODEMB ';
      qryGen.ParamByName('CODEMB').AsString := qryCadTinta.FieldByName('INT_CODEMB').AsString;
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

function fRetMlParaOnca(ftlValor: Double): String;
Var
  fltValor1 : Double;
  fltInteiro: Double;
  fltFracao : Double;

  fltVlrInt  : Double;
  fltVlrFrac : Double;

  strCalc : String;
begin
  { -> PARA ARRENDONDAMENTO CONSIDERAR ACIMA DE 0,25. EXEMPLO:

       - SE O NUMERO FOSSE = 1,26 O TOTAL SERIA: 1,5 (3y1,5)
       - SE O NUMERO FOSSE = 1,76 O TOTAL SERIA: 2,0 (3y2,0)}

  fltValor1  := (ftlValor / 29.57);
  fltInteiro := Trunc(fltValor1);
  fltFracao  := frac(fltValor1);

  fltValor1  := (fltFracao * 48);

  fltVlrInt  := Trunc(fltValor1);
  fltVlrFrac := Trunc((Frac(fltValor1 )) * 100);

  If(fltVlrFrac > 25) And (fltVlrFrac <= 50)  Then
     fltVlrFrac := 50
  Else
  If(fltVlrFrac > 75)Then
  Begin
    fltVlrFrac := 0;
    fltVlrInt  := fltVlrInt + 1;
  End;

  strCalc := (floatTostr(fltVlrInt) + ',' + floatToStr(fltVlrFrac));

  Result := floatTostr(fltInteiro) + 'Y' + strCalc;

//  Format('%dY%.1f', [(fltInteiro), strToFloat(strCalc)]);
end;

function TAutcomTintaInternational.fRetornaProdutoBase(qryCadTinta: TUniQuery): string;
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
        '   INT_CADBAS               ' +
        ' WHERE BAS_CODBAS = :BASE__ ' +
        '   AND BAS_CODEMB = :CODEMB ';
      qryGen.ParamByName('BASE__').AsString := qryCadTinta.FieldByName('INT_CODBAS').AsString;
      qryGen.ParamByName('CODEMB').AsString := qryCadTinta.FieldByName('INT_CODEMB').AsString;
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

function TAutcomTintaInternational.GetIdePro: string;
begin
  Result := 'INT';
end;

function TAutcomTintaInternational.GetIFormulaImobiliaria: IFormulaImobiliaria;
begin
  Result := TFormulaInternational.Create;
end;

function TAutcomTintaInternational.GetItemBaseOri(const strIteTin: String): string;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                         ' +
        '   BAS_CODITE                   ' +
        ' FROM                           ' +
        '   INT_CADINT                   ' +
        '   INNER JOIN INT_CADBAS        ' +
        '     ON INT_CODBAS = BAS_CODBAS ' +
        '    AND INT_CODEMB = BAS_CODEMB ' +
        ' WHERE INT_MD5KEY = :ITETIN      ';
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

function TAutcomTintaInternational.GetIteTin(qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('INT_MD5KEY').AsString;
end;

function TAutcomTintaInternational.GetNomeClasseNovasFormulas: string;
begin
  Result := 'TfrmNovasFormulasInternational';
end;

function TAutcomTintaInternational.GetNomeTabelaColorantes: string;
begin
  Result := 'INT_CADCOL';
end;

function TAutcomTintaInternational.GetTintadeMaquinaClasse: TTintadeMaquinaClasse;
begin
  Result := TInternationalConsulta;
end;

procedure TAutcomTintaInternational.pPreencheDicionarioDadosTinta(qryTinta: TUniQuery; dicDados: TDicionario);
begin

end;

end.
