unit untAutcomTintaVelutex;

interface

uses
  untIAutcomTinta,  untFuncoesSimples, Uni, Classes, Forms, SysUtils, untAbstractAutcomTintaImobiliaria,
  untTintadeMaquina,  untIFormulaImobiliaria;

type
  TAutcomTintaVelutex = class(TAbstractAutcomTintaImobiliaria, IAutcomTinta)
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
  untFormulaImobiliariaVelutex, Data.DB,untVelutexConsulta;

{ TAutcomTintaVelutex }

function TAutcomTintaVelutex.fGetDescri(qryCadTinta: TUniQuery): string;
begin
  Result := Format('%s %s %s %s %s', [
    qryCadTinta.FieldByName('VEL_CORCOD').AsString,
    qryCadTinta.FieldByName('VEL_CODBAS').AsString,
    qryCadTinta.FieldByName('VEL_COLECA').AsString,
    qryCadTinta.FieldByName('VEL_PRODUT').AsString,
    qryCadTinta.FieldByName('VEL_CODUNI').AsString]);
end;

function TAutcomTintaVelutex.fGetFatorML: Double;
begin
  Result := 0.154;
end;

function TAutcomTintaVelutex.fGetNomeCampoAcrescimoMaoObra: String;
begin
  Result := '';
end;

function TAutcomTintaVelutex.fGetPrefixoNomeCampoFormulacao: string;
begin
  Result := 'VEL_CODC';
end;

function TAutcomTintaVelutex.fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre: string): string;
begin
  Result := 'VEL_QTDC'
end;

function TAutcomTintaVelutex.fGetSqlComponentesGTinFor(const strComponente: string): string;
begin
  Result :=
    ' SELECT                        ' +
    '   COL_CODCOL AS CODCOMP       ' +
    '   , COL_CODITE AS CODITE      ' +
    ' FROM                          ' +
    '   VEL_CADCOL                  ' +
    ' WHERE COL_CODCOL IN (' + strComponente + ')';
end;

function TAutcomTintaVelutex.fGetSqlGTinFor: string;
begin
  Result :=
    ' SELECT                       ' +
    '   *                          ' +
    ' FROM                         ' +
    '   VEL_CADVEL                 ' +
    ' WHERE VEL_MD5KEY = :ITETIN   ';
end;

function TAutcomTintaVelutex.fGetUnidade(qryCadTinta: TUniQuery): string;
begin
  Result := '';
end;

function TAutcomTintaVelutex.fRetornaProdutoBase(qryCadTinta: TUniQuery): string;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                      ' +
        '   BAS_CODITE                ' +
        ' FROM                        ' +
        '   VEL_CADBAS                ' +
        ' WHERE BAS_CODBAS = :CODBAS  ' +
        '   AND BAS_PRODUT = :PRODUT  ' +
        '   AND BAS_CODUNI = :CODUNI  ';
      qryGen.ParamByName('CODBAS').AsString := qryCadTinta.FieldByName('VEL_CODBAS').AsString;
      qryGen.ParamByName('PRODUT').AsString := qryCadTinta.FieldByName('VEL_PRODUT').AsString;
      qryGen.ParamByName('CODUNI').AsString := qryCadTinta.FieldByName('VEL_CODUNI').AsString;
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

function TAutcomTintaVelutex.GetIdePro: string;
begin
  Result := 'VEL';
end;

function TAutcomTintaVelutex.GetIFormulaImobiliaria: IFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaVelutex.Create;
end;

function TAutcomTintaVelutex.GetItemBaseOri(const strIteTin: String): string;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                            ' +
        '   BAS_CODITE                      ' +
        ' FROM                              ' +
        '   VEL_CADVEL                      ' +
        '   INNER JOIN VEL_CADBAS           ' +
        '     ON VEL_CODBAS  = BAS_CODBAS   ' +
        '     AND VEL_PRODUT = BAS_PRODUT   ' +
        '     AND VEL_CODUNI = BAS_CODUNI   ' +
        ' WHERE VEL_MD5KEY = :ITETIN        ';
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

function TAutcomTintaVelutex.GetIteTin(qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('VEL_MD5KEY').AsString;
end;

function TAutcomTintaVelutex.GetNomeClasseNovasFormulas: string;
begin
  Result := 'TfrmNovasFormulasVelutex';
end;

function TAutcomTintaVelutex.GetNomeTabelaColorantes: string;
begin
  Result := 'VEL_CADCOL';
end;

function TAutcomTintaVelutex.GetTintadeMaquinaClasse: TTintadeMaquinaClasse;
begin
  Result := TVelutexConsulta;
end;

procedure TAutcomTintaVelutex.pPreencheDicionarioDadosTinta(qryTinta: TUniQuery; dicDados: TDicionario);
begin
  dicDados['codtin'] := qryTinta.FieldByName('VEL_CORCOD').AsString;
end;

end.
