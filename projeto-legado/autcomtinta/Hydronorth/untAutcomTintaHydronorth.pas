unit untAutcomTintaHydronorth;

interface

uses
  untIAutcomTinta,  untFuncoesSimples, Uni, Classes, Forms, SysUtils, untAbstractAutcomTintaImobiliaria,
  untTintadeMaquina, untIFormulaImobiliaria;

type
  TAutcomTintaHydronorth = class(TAbstractAutcomTintaImobiliaria, IAutcomTinta)
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

implementation

uses
  untFormulaImobiliariaHydronorth, untHydronorthConsulta, Data.DB;

{ TAutcomTintaHydronorth }

function TAutcomTintaHydronorth.fGetDescri(qryCadTinta: TUniQuery): string;
begin
  Result := Format('%s %s %s %s %s %s', [
    qryCadTinta.FieldByName('HYD_COLECA').AsString,
    qryCadTinta.FieldByName('HYD_PRODUT').AsString,
    qryCadTinta.FieldByName('HYD_C_O_R_').AsString,
    qryCadTinta.FieldByName('HYD_CORLON').AsString,
    qryCadTinta.FieldByName('HYD_BASE__').AsString,
    qryCadTinta.FieldByName('HYD_CODEMB').AsString
  ]);
end;

function TAutcomTintaHydronorth.fGetFatorML: Double;
begin
  Result := 1;
end;

function TAutcomTintaHydronorth.fGetNomeCampoAcrescimoMaoObra: String;
begin
  Result := '';
end;

function TAutcomTintaHydronorth.fGetPrefixoNomeCampoFormulacao: string;
begin
  Result := 'HYD_FORM';                                        
end;

function TAutcomTintaHydronorth.fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre: string): string;
begin
  Result := 'HYD_QTDC';
end;

function TAutcomTintaHydronorth.fGetSqlComponentesGTinFor(const strComponente: string): string;
begin
  Result :=
    ' SELECT                        ' +
    '   COL_CODCOL AS CODCOMP       ' +
    '   , COL_CODITE AS CODITE      ' +
    ' FROM                          ' +
    '   HYD_CADCOL                  ' +
    ' WHERE COL_CODCOL IN (' + strComponente + ')';
end;

function TAutcomTintaHydronorth.fGetSqlGTinFor: string;
begin
  Result :=
    ' SELECT                       ' +
    '   *                          ' +
    ' FROM                         ' +
    '   HYD_CADHYD                 ' +
    ' WHERE HYD_MD5KEY = :ITETIN   ';
end;

function TAutcomTintaHydronorth.fGetUnidade(qryCadTinta: TUniQuery): string;
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
        '   HYD_CADEMB               ' +
        ' WHERE EMB_CODEMB = :CODEMB ';
      qryGen.ParamByName('CODEMB').AsString := qryCadTinta.FieldByName('HYD_CODEMB').AsString;
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

function TAutcomTintaHydronorth.fRetornaProdutoBase(qryCadTinta: TUniQuery): string;
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
        '   HYD_CADBAS               ' +
        ' WHERE BAS_PRODUT = :PRODUT ' +
        '   AND BAS_BASE__ = :BASE__ ' +
        '   AND BAS_CODEMB = :CODEMB ';
      qryGen.ParamByName('PRODUT').AsString := qryCadTinta.FieldByName('HYD_PRODUT').AsString;
      qryGen.ParamByName('BASE__').AsString := qryCadTinta.FieldByName('HYD_BASE__').AsString;
      qryGen.ParamByName('CODEMB').AsString := qryCadTinta.FieldByName('HYD_CODEMB').AsString;
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

function TAutcomTintaHydronorth.GetIdePro: string;
begin
  Result := 'HYD';
end;

function TAutcomTintaHydronorth.GetIFormulaImobiliaria: IFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaHydronorth.Create;
end;

function TAutcomTintaHydronorth.GetItemBaseOri(const strIteTin: String): string;
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
        '   HYD_CADHYD                    ' +
        '   INNER JOIN HYD_CADBAS         ' +
        '     ON HYD_PRODUT = BAS_PRODUT  ' +
        '     AND HYD_BASE__ = BAS_BASE__ ' +
        '     AND HYD_CODEMB = BAS_CODEMB ' +
        ' WHERE HYD_MD5KEY = :ITETIN      ';
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

function TAutcomTintaHydronorth.GetIteTin(qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('HYD_MD5KEY').AsString;
end;

function TAutcomTintaHydronorth.GetNomeClasseNovasFormulas: string;
begin
  Result := 'TfrmNovasFormulasHydronorth';  
end;

function TAutcomTintaHydronorth.GetNomeTabelaColorantes: string;
begin
  Result := 'HYD_CADCOL';
end;

function TAutcomTintaHydronorth.GetTintadeMaquinaClasse: TTintadeMaquinaClasse;
begin
  Result := THydronorthConsulta;
end;

procedure TAutcomTintaHydronorth.pPreencheDicionarioDadosTinta(qryTinta: TUniQuery; dicDados: TDicionario);
begin
  dicDados['codtin'] := qryTinta.FieldByName('HYD_CORLON').AsString;
end;

end.
