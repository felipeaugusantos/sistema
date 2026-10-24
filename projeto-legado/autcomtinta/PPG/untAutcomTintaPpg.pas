unit untAutcomTintaPpg;

interface

uses
  untIAutcomTinta, Classes, Uni, untIFormulaAutomotiva,
  untTintadeMaquina, untFuncoesSimples, SysUtils, Contnrs,
  untDigTintaAutomotiva, untFuncEspecificas,
 untIConfEmb, untAbstractAutcomTintaAutomotiva;

type
  TAutcomTintaPpg = class(TAbstractAutcomTintaAutomotiva, IAutcomTinta)
  private
    confEmb: IConfEmb;
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
    function GetfrmDigTinta(): TfrmDigTintaAutomotiva; override;
    function GetProduto(): string; override;  
  protected
    function GetIdePro(): string; override;
    function GetTintadeMaquinaClasse: TTintadeMaquinaClasse; override;
    function GetTintadeMaquinaConsultaClasse: TTintadeMaquinaClasse; override;
    function GetIteTin(qryTinta: TUniQuery): string; override;
    function fGetPrefixoNomeCampoFormulacao(): string; override;
    function fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre: string): string; override;
    function fGetSqlGTinFor: string; override;
    function fGetSqlComponentesGTinFor(const strComponente: string): string; override;
    procedure pPreencheDicionarioDadosTinta(qryTinta: TUniQuery; dicDados: TDicionario); override;
    function GetFormulaAutomotiva(const strTabPre: string; const formulaAutomotiva: IFormulaAutomotiva; strIdePro: String; blnRecalcularTabelas: Boolean = True): TFormulaAutomotiva; override;
  public
    function fRetornaTabelaColoranteTinta(): String; override; stdcall;
    function fRetornaUniTraEmbTinta(strTipEmb, strTipPre: String): Double; override; stdcall;
  public
    constructor Create(); override;
  end;

implementation

uses
  untFormulaAutomotivaPpg, untPpgConsultaEscolha, untPpgConsulta, untDigTintaAutomotivaPPG,untTintaMaquina,untPpgDinamica;

{ TAutcomTintaPpg }

constructor TAutcomTintaPpg.Create;
begin
  inherited Create();
  confEmb := fGetConfEmb('PPG');
end;

function TAutcomTintaPpg.fGetPrefixoNomeCampoFormulacao: string;
begin
  Result := 'PPG_CODB';
end;

function TAutcomTintaPpg.fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre: string): string;
begin
  Result := '';
  if strTipPre = 'C' then
    Result := 'PPG_QTDB'
end;

function TAutcomTintaPpg.fGetSqlComponentesGTinFor(const strComponente: string): string;
begin
  Result :=
    ' SELECT DISTINCT            ' +
    '   BAS_CODBAS AS CODCOMP    ' +
    '   , BAS_CODITE AS CODITE   ' +
    '   , BAS_TIPO__             ' +
    ' FROM                       ' +
    '   PPG_CADBAS               ' +
    ' WHERE BAS_CODBAS IN (' + strComponente + ') ';
end;

function TAutcomTintaPpg.fGetSqlGTinFor: string;
begin
  Result :=
    ' SELECT                      ' +
    '   *                         ' +
    ' FROM                        ' +
    '   PPG_CADPPG                ' +
    ' WHERE PPG_MD5KEY = :ITETIN  ';  
end;

function TAutcomTintaPpg.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'PPG_CADBAS';
end;

function TAutcomTintaPpg.fRetornaUniTraEmbTinta(strTipEmb, strTipPre: String): Double;
begin

  Result := conf.fGetDouble('FATPPG');
end;

function TAutcomTintaPpg.GetAno(const qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('PPG_A_N_O_').AsString;
end;

function TAutcomTintaPpg.GetChaFor(const qryTinta: TUniQuery): string;
begin
  Result := '';
end;

function TAutcomTintaPpg.GetDescri(const qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('PPG_DESCOR').AsString + ' ' +
    qryTinta.FieldByName('PPG_TIPO__').AsString + ' ' +
    qryTinta.FieldByName('PPG_A_N_O_').AsString + ' ' +
    qryTinta.FieldByName('PPG_CODCOR').AsString;
end;

procedure TAutcomTintaPpg.GetDesEmb(const stlDesEmb: TStringList);
begin
  stlDesEmb.Clear;
  stlDesEmb.Add('DULON');
  stlDesEmb.Add('DELFLEET');
  stlDesEmb.Add('DELTRON');
  stlDesEmb.Add('ENVIROBASE HP')
end;

function TAutcomTintaPpg.GetFormulaAutomotiva(const strTabPre: string; const formulaAutomotiva: IFormulaAutomotiva; strIdePro: String; blnRecalcularTabelas: Boolean = True): TFormulaAutomotiva;
begin
  Result := TFormulaPpgDinamica.Create(strTabPre);
end;

function TAutcomTintaPpg.GetfrmDigTinta: TfrmDigTintaAutomotiva;
begin
  Result := TfrmDigTintaAutomotivaPPG.Create(nil);
  Result.rdbBalde.Visible := False;
end;

function TAutcomTintaPpg.GetIdePro: string;
begin
  Result := 'PPG';
end;

function TAutcomTintaPpg.GetIFormulaAutomotiva: IFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaPpg.Create;
end;

function TAutcomTintaPpg.GetIteTin(qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('PPG_MD5KEY').AsString;  
end;

function TAutcomTintaPpg.GetLinha(const qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('PPG_TIPO__').AsString;
end;

function TAutcomTintaPpg.GetMontadora(const qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('MON_DESCRI').AsString;
end;

function TAutcomTintaPpg.GetNomeClasseNovasFormulas: string;
begin
  Result := 'TfrmCadPpgNovasFormulas';
end;

function TAutcomTintaPpg.GetProduto: string;
begin
  Result := conf.fGet('PROPPG');
end;

function TAutcomTintaPpg.GetProEmbBa: String;
begin
  Result := confEmb.fGet('PPGPMLADU') + #13#10 +
    confEmb.fGet('PPGPMLADF') + #13#10 +
    confEmb.fGet('PPGPMLADT') + #13#10 +
    confEmb.fGet('PPGPMLAEB');
end;

function TAutcomTintaPpg.GetProEmbCo: String;
begin
  Result := confEmb.fGet('PPGCOP');
end;

procedure TAutcomTintaPpg.GetProEmbGl(const stlProEmbGl: TStringList);
begin
  stlProEmbGl.Clear;
  stlProEmbGl.Add(conf.fGet('PPGGDU'));
  stlProEmbGl.Add(conf.fGet('PPGGDF'));
  stlProEmbGl.Add(conf.fGet('PPGGDT'));
  stlProEmbGl.Add(conf.fGet('PPGGOM'));
end;

procedure TAutcomTintaPpg.GetProEmbLa(const stlProEmbLa: TStringList);
begin
  stlProEmbLa.Clear;
end;

procedure TAutcomTintaPpg.GetProEmbLt(const stlProEmbLt: TStringList);
begin
  stlProEmbLt.Clear;
  stlProEmbLt.Add(conf.fGet('PPGLDU'));
  stlProEmbLt.Add(conf.fGet('PPGLDF'));
  stlProEmbLt.Add(conf.fGet('PPGLDT'));
  stlProEmbLt.Add(conf.fGet('PPGLOM'));
end;

function TAutcomTintaPpg.GetProEmbSp: String;
begin
  Result := '';
end;

function TAutcomTintaPpg.GetProEmbTb: String;
begin
  Result := confEmb.fGet('PPGPMTDU') + #13#10 +
    confEmb.fGet('PPGPMTDF') + #13#10 +
    confEmb.fGet('PPGPMTDT') + #13#10 +
    confEmb.fGet('PPGPMTEB');
end;

function TAutcomTintaPpg.GetTintadeMaquinaClasse: TTintadeMaquinaClasse;
begin
  Result := TPpgConsulta;
end;

function TAutcomTintaPpg.GetTintadeMaquinaConsultaClasse: TTintadeMaquinaClasse;
begin
  Result := TPpgConsultaEscolha;
end;

procedure TAutcomTintaPpg.pPreencheDicionarioDadosTinta(qryTinta: TUniQuery; dicDados: TDicionario);
begin
  inherited;
end;

end.
