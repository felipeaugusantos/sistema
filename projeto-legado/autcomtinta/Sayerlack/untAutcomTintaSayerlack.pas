unit untAutcomTintaSayerlack;

interface

uses
  untIAutcomTinta, untFuncoesSimples, Uni, Classes, Forms, SysUtils, untAbstractAutcomTintaImobiliaria,
  untTintadeMaquina, untIFormulaImobiliaria;

type
  TAutcomTintaSayerlack = class(TAbstractAutcomTintaImobiliaria, IAutcomTinta)
  protected
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
    function GetIFormulaImobiliaria(): IFormulaImobiliaria; override;
    function GetNomeClasseNovasFormulas: string; override;
    function GetItemBaseOri(const strIteTin: String): string; override;
    function fGetNomeCampoAcrescimoMaoObra: String; override;
  public
    function fGetFatorML: Double; override; stdcall; 
  end;

implementation

uses
  untFormulaImobiliariaSayerlack, untSayerlackConsulta, Data.DB;

{ TAutcomTintaSayerlack }

function TAutcomTintaSayerlack.fGetDescri(qryCadTinta: TUniQuery): string;
begin
  Result := Format('%s %s %s %s',
      [qryCadTinta.FieldByName('SAY_BASE__').AsString,
      qryCadTinta.FieldByName('SAY_CODBAS').AsString,
      qryCadTinta.FieldByName('SAY_PRODUT').AsString,
      qryCadTinta.FieldByName('SAY_DESEMB').AsString]);
end;

function TAutcomTintaSayerlack.fGetFatorML: Double;
begin
  Result := 29.574 / 384;
end;

function TAutcomTintaSayerlack.fGetNomeCampoAcrescimoMaoObra: String;
begin
  Result := '';
end;

function TAutcomTintaSayerlack.fGetPrefixoNomeCampoFormulacao: string;
begin
  Result := 'SAY_FORM';
end;

function TAutcomTintaSayerlack.fGetPrefixoNomeCampoFormulacaoQuantidade(strTipPre: string): string;
begin
  Result := 'SAY_QTDC';
end;

function TAutcomTintaSayerlack.fGetSqlGTinFor: string;
begin
  Result :=
    ' SELECT                       ' +
    '   *                          ' +
    ' FROM                         ' +
    '   SAY_CADSAY                 ' +
    ' WHERE SAY_MD5KEY = :ITETIN   ';
end;

function TAutcomTintaSayerlack.fGetUnidade(qryCadTinta: TUniQuery): string;
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
        '   UNI_SIGUNI                   ' +
        ' FROM                           ' +
        '   CADUNI                       ' +
        '   INNER JOIN SAY_CADEMB        ' +
        '     ON UNI_CODUNI = EMB_CODUNI ' +
        ' WHERE EMB_DESEMB = :DESEMB     ';
      qryGen.ParamByName('DESEMB').AsString := qryCadTinta.FieldByName('SAY_DESEMB').AsString;
      qryGen.Open;

      if not qryGen.IsEmpty then
        Result := qryGen.FieldByName('UNI_SIGUNI').AsString;
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

function TAutcomTintaSayerlack.fRetornaProdutoBase(qryCadTinta: TUniQuery): string;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                                   ' +
        '   BAS_CODITE                             ' +
        ' FROM                                     ' +
        '   SAY_CADBAS                             ' +
        ' WHERE IFNULL(BAS_BASE__, '''') = :BASE   ' +
        '   AND IFNULL(BAS_CODBAS, '''') = :CODBAS ' +
        '   AND IFNULL(BAS_PRODUT, '''') = :PRODUT ' +
        '   AND IFNULL(BAS_DESEMB, '''') = :DESEMB ';

      qryGen.ParamByName('BASE').AsString   := qryCadTinta.FieldByName('SAY_BASE__').AsString;
      qryGen.ParamByName('CODBAS').AsString := qryCadTinta.FieldByName('SAY_CODBAS').AsString;
      qryGen.ParamByName('PRODUT').AsString := qryCadTinta.FieldByName('SAY_PRODUT').AsString;
      qryGen.ParamByName('DESEMB').AsString := qryCadTinta.FieldByName('SAY_DESEMB').AsString;
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

function TAutcomTintaSayerlack.GetIdePro: string;
begin
  Result := 'SAY';
end;

function TAutcomTintaSayerlack.GetIFormulaImobiliaria: IFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaSayerlack.Create;
end;

function TAutcomTintaSayerlack.GetItemBaseOri(const strIteTin: String): string;
var
  qryGen: TUniQuery;
begin
  Result := '';
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                                                      ' +
        '   BAS_CODITE                                                ' +
        ' FROM                                                        ' +
        '   SAY_CADBAS                                                ' +
        '   INNER JOIN SAY_CADSAY                                     ' +
        '     ON IFNULL(BAS_BASE__, '''') = IFNULL(SAY_BASE__, '''')  ' +
        '     AND IFNULL(BAS_CODBAS, '''') = IFNULL(SAY_CODBAS, '''') ' +
        '     AND IFNULL(BAS_PRODUT, '''') = IFNULL(SAY_PRODUT, '''') ' +
        '     AND IFNULL(BAS_DESEMB, '''') = IFNULL(SAY_DESEMB, '''') ' +
        ' WHERE SAY_MD5KEY = :ITETIN                                  ';
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

function TAutcomTintaSayerlack.GetIteTin(qryTinta: TUniQuery): string;
begin
  Result := qryTinta.FieldByName('SAY_MD5KEY').AsString;
end;

function TAutcomTintaSayerlack.GetNomeClasseNovasFormulas: string;
begin
  Result := 'TfrmNovasFormulasSayerLack';
end;

function TAutcomTintaSayerlack.GetTintadeMaquinaClasse: TTintadeMaquinaClasse;
begin
  Result := TSayerlackConsulta;
end;

procedure TAutcomTintaSayerlack.pPreencheDicionarioDadosTinta(qryTinta: TUniQuery; dicDados: TDicionario);
begin
  inherited;
end;

end.
