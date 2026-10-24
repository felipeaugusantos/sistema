unit untAutcomTintaBrazilianColor;

interface

uses
  untAbstractAutcomTintaAutomotiva, untIAutcomTinta, Classes, Uni, untIFormulaAutomotiva,
  untTintadeMaquina, untFuncoesSimples, SysUtils;

type
  TAutcomTintaBrazilianColor = class(TAbstractAutcomTintaAutomotiva, IAutcomTinta)
  protected
    procedure GetDesEmb(const stlDesEmb: TStringList); override;
    procedure GetProEmbLt(const stlProEmbLt: TStringList); override;
    procedure GetProEmbGl(const stlProEmbGl: TStringList); override;
    procedure GetProEmbLa(const stlProEmbLa: TStringList); override;
    function GetProEmbCo(): String; override;
    function GetProEmbSp(): String; override;
    function GetProEmbTb(): String; override;
    function GetProEmbBa(): String; override;
    function GetMontadora(const qryTinta: TUniQuery): string; override;
    function GetAno(const qryTinta: TUniQuery): string; override;
    function GetLinha(const qryTinta: TUniQuery): string; override;
    function GetChaFor(const qryTinta: TUniQuery): string; override;
    function GetIFormulaAutomotiva(): IFormulaAutomotiva; override;
    function GetDescri(const qryTinta: TUniQuery): string; override;
    function GetNomeClasseNovasFormulas: string; override;
  protected
    function GetIdePro(): string; override;
    function GetTintadeMaquinaClasse: TTintadeMaquinaClasse; override;
    function GetIteTin(qryTinta: TUniQuery): string; override;
    function fGetPrefixoNomeCampoFormulacao(): string; override;
    function fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre: string): string; override;
    function fGetSqlGTinFor: string; override;
    function fGetSqlComponentesGTinFor(const strComponente: string): string; override;
    procedure pPreencheDicionarioDadosTinta(qryTinta: TUniQuery; dicDados: TDicionario); override;
    function fGetNomeCampoAcrescimoMaoObra: String; override;
  public
    function fRetornaTabelaColoranteTinta(): String; override; stdcall;
    function fRetornaUniTraEmbTinta(strTipEmb, strTipPre: String): Double; override; stdcall;
  end;

implementation

uses
  untTintaMaquina, untFormulaAutomotivaBrazilianColor, untBrazilianColorConsulta;

{ TAutcomTintaBrazilianColor }

function TAutcomTintaBrazilianColor.fGetNomeCampoAcrescimoMaoObra: String;
begin
  Result := 'BZC_ACRMOB';
end;

function TAutcomTintaBrazilianColor.fGetPrefixoNomeCampoFormulacao: string;
begin
  Result := 'BZC_BASE';
end;

function TAutcomTintaBrazilianColor.fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre: string): string;
begin
  if strTipPre = 'C' then
    Result := 'BZC_QTDC'
  else if strTipPre = 'D' then
    Result := 'BZC_QTDD';  
end;

function TAutcomTintaBrazilianColor.fGetSqlComponentesGTinFor(const strComponente: string): string;
begin
  Result :=
    ' SELECT                     ' +
    '   BAS_CODBAS AS CODCOMP    ' +
    '   , BAS_CODITE AS CODITE   ' +
    ' FROM                       ' +
    '   BZC_CADBAS               ' +
    ' WHERE BAS_CODBAS IN (' + strComponente + ') ';
end;

function TAutcomTintaBrazilianColor.fGetSqlGTinFor: string;
begin
  Result :=
    ' SELECT                       ' +
    '   *                          ' +
    ' FROM                         ' +
    '   BZC_CADBZC                 ' +
    ' WHERE BZC_MD5KEY = :ITETIN   '; 
end;

function TAutcomTintaBrazilianColor.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'BZC_CADBAS';
end;

function TAutcomTintaBrazilianColor.fRetornaUniTraEmbTinta(strTipEmb, strTipPre: String): Double;
begin
  Result := fGetConfTinta('BZC').fGetDouble('FATTIN');
end;

function TAutcomTintaBrazilianColor.GetAno(const qryTinta: TUniQuery): string;
begin
  qryTinta.FieldByName('BZC_A_N_O_').AsString;
end;

function TAutcomTintaBrazilianColor.GetChaFor(const qryTinta: TUniQuery): string;
begin
  Result := '';
end;

function TAutcomTintaBrazilianColor.GetDescri(const qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('BZC_CODIGO').AsString + ' ' +
    qryTinta.FieldByName('BZC_DESCRI').AsString + ' ' +
    qryTinta.FieldByName('BZC_A_N_O_').AsString + ' ' +
    qryTinta.FieldByName('BZC_TIPO__').AsString;
end;

procedure TAutcomTintaBrazilianColor.GetDesEmb(const stlDesEmb: TStringList);
begin
  stlDesEmb.Text := 'POLIESTER';
end;

function TAutcomTintaBrazilianColor.GetIdePro: string;
begin
  Result := 'BZC';
end;

function TAutcomTintaBrazilianColor.GetIFormulaAutomotiva: IFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaBrazilianColor.Create;
end;

function TAutcomTintaBrazilianColor.GetIteTin(qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('BZC_MD5KEY').AsString;
end;

function TAutcomTintaBrazilianColor.GetLinha(const qryTinta: TUniQuery): string;
begin
  Result := '';
end;

function TAutcomTintaBrazilianColor.GetMontadora(const qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('MON_DESCRI').AsString;
end;

function TAutcomTintaBrazilianColor.GetNomeClasseNovasFormulas: string;
begin
  Result := 'TfrmBrazilianColorNovasFormulas';
end;

function TAutcomTintaBrazilianColor.GetProEmbBa: String;
begin
  Result := '';
end;

function TAutcomTintaBrazilianColor.GetProEmbCo: String;
begin
  Result := '';
end;

procedure TAutcomTintaBrazilianColor.GetProEmbGl(const stlProEmbGl: TStringList);
begin
  stlProEmbGl.Text := fGetConfTinta('BZC').fGet('EMBGAL');
end;

procedure TAutcomTintaBrazilianColor.GetProEmbLa(const stlProEmbLa: TStringList);
begin
  stlProEmbLa.Text := fGetConfTinta('BZC').fGet('EMBLAT');
end;

procedure TAutcomTintaBrazilianColor.GetProEmbLt(const stlProEmbLt: TStringList);
begin
  stlProEmbLt.Text := fGetConfTinta('BZC').fGet('EMBLIT');
end;

function TAutcomTintaBrazilianColor.GetProEmbSp: String;
begin
  Result := '';
end;

function TAutcomTintaBrazilianColor.GetProEmbTb: String;
begin
  Result := '';
end;

function TAutcomTintaBrazilianColor.GetTintadeMaquinaClasse: TTintadeMaquinaClasse;
begin
  Result := TBrazilianColorConsulta;
end;

procedure TAutcomTintaBrazilianColor.pPreencheDicionarioDadosTinta(qryTinta: TUniQuery; dicDados: TDicionario);
begin
  
end;

end.

